# 為什麼 doSwizzle 後 printTensorData 和 printTensorDataMultiDims 看起來不同？

## 1. 兩種 print 在做什麼

| 函數 | 行為 |
|------|------|
| **printTensorData** | 不管 shape，依 **index 0, 1, 2, ..., 511** 依序讀 `data[i]` 並印出**該位置存的值**（不是印 index）。 |
| **printTensorDataMultiDims** | 依 tensor **目前的 shape** 與 **row-major** 順序，用 `getValue(idx)` 依多維索引走訪，印出**該索引對應的值**，並依維度加 `[`、`],` 做巢狀排版。 |

所以：**同一份 buffer**，兩種都是印「存在裡面的**數值**」；順序上，printTensorData 是「依物理位置 0～511 的順序」印出各位置的值，printTensorDataMultiDims 是「依 shape 的多維順序」印出，但對同一 shape 來說最後印到的也是同一組 512 個值（同一順序）。

### 1.1 為什麼 printTensorData 還是「線性 0～511」？連續記憶體配置沒變嗎？

要分兩件事看：

| 說法 | 意思 | 對不對？ |
|------|------|----------|
| 「印的時候還是依 index 0～511 讀」 | printTensorData 的迴圈是 `for (i=0..511) print data[i]`，所以**遍歷的仍是連續 512 個位置**。 | ✅ 對：讀的方式沒變，還是同一塊連續 buffer。 |
| 「印出來的數值還是 0, 1, 2, …, 511」 | 每個位置裡存的**值**還是 0, 1, 2, … 依序。 | ❌ 有 doSwizzle 時通常**不會**：permute 會把「誰在哪個 index」重排，所以印出來的**數列**會是重排後的順序（例如 0..7, 32..39, 16..23, …），不會再是單純 0..511。若你看到還是 0..511，要檢查是否印的是 **swizzled** 的那份 buffer。 |

**連續記憶體「配置」有沒有變？**

- **沒變**：還是同一塊、512 個連續的 slot（address 0, 1, 2, …, 511）。
- **有變**：每個 slot 裡放的**內容**被 permute 重排了——原本在 position 32 的 value 可能被搬到 position 8，所以「哪個 logical element 在哪個 physical position」的對應關係（layout）變了。

結論：**printTensorData 還是線性掃 0～511 的「位置」**，但 doSwizzle 後**每個位置裡存的值**已經不是「position i 存 value i」的對應，而是重排後的內容；餵給 kernel 的正是這份「重排後的內容」，所以 kernel 看到的 memory layout（誰在哪個 offset）已經改變。

---

## 2. doSwizzle 會改掉 shape（關鍵）

在 TN 的 `doSwizzle` 裡：

- 輸入 `inBuffer` 的 shape 是 **(K, M) = (32, 16)**。
- 中間會 **reshape** 成 **(1, 16, 1, 4, 8)**，再 **permute(..., {0, 2, 3, 1, 4})**。
- `permute` 回傳的是一個**新的 Tensor**，其 **shape 會一併被 permute**：
  - 舊 shape = (1, 16, 1, 4, 8)
  - 新 shape = (shape[0], shape[2], shape[3], shape[1], shape[4]) = **(1, 1, 4, 16, 8)**

因此：

- **doSwizzle 前**：`tensorA_h` 的 shape 是 **(32, 16)**。
- **doSwizzle 後**：`swizzledA_h` 被賦值成 `permute(...)` 的結果，所以 **shape 變成 (1, 1, 4, 16, 8)**，**不再是 (32, 16)**。

也就是說，swizzled 的 buffer 還是 512 個 element，但「邏輯形狀」已經從 2D 的 32×16 變成 5D 的 1×1×4×16×8。

---

## 3. 為什麼兩種印出來「預期不同」？

- **printTensorData(swizzledA_h)**  
  - 依**線性順序**印出同一個 buffer 的 512 個數。  
  - 沒有「行列」或「維度」的觀念，所以看起來就是**一長串數字**。  
  - 若你心裡預期的是「還是 32×16 的矩陣」，就會覺得「怎麼變成一條線」。

- **printTensorDataMultiDims(swizzledA_h)**  
  - 用的是 **swizzledA_h 現在的 shape = (1, 1, 4, 16, 8)**。  
  - 所以會依 **(1, 1, 4, 16, 8)** 做巢狀走訪並加上 `[`、`],`，印出來會像：
    - 1 層 → 1 層 → **4 個大塊**，每塊裡 **16 段**，每段 **8 個數**。  
  - 若你預期的是「還是 32 行 × 16 列」的 2D 矩陣，就會覺得「怎麼變成 4 大塊、每塊 16×8」，和預期不同。

所以「預期不同」主要來自兩點：

1. **Shape 被 permute 改掉了**：swizzled 不再用 (32, 16) 解讀，而是 (1, 1, 4, 16, 8)。  
2. **兩種 API 的職責不同**：一個只管線性順序（flat），一個依**目前 shape** 做多維排版，所以同一份資料會呈現成不同樣子。

---

## 4. 數值與順序是否一致？

- **是**。兩種函數印出的都是**同一塊 buffer**、**同一組 512 個 _Float16**、**同一順序**（permute 後的線性順序）。  
- 差別只有：
  - **printTensorData**：不帶維度，純 flat 列表。  
  - **printTensorDataMultiDims**：用 **(1, 1, 4, 16, 8)** 做巢狀排版，所以看起來是「4 組 × 16 段 × 8 個數」的結構。

---

## 5. 若希望 swizzled 仍用 32×16 來「看」

若你希望 swizzled 的**顯示**仍是 32×16（例如用 `print_row_by_row`），有兩種做法：

- **做法 A**：不要用 `printTensorDataMultiDims` 解讀 swizzled，改用 **printTensorData** 看線性順序，或自己用 **print_row_by_row(ptr, 32, 16, true)** 把同一塊 buffer **強制**當成 32×16 row-major 來印（僅顯示用，不改變資料）。  
- **做法 B**：doSwizzle 之後**不**改 swizzled 的 shape，只改 buffer 內容（例如自己寫一個「同 shape (32,16)、只做 permute 寫入」的版本），這樣 `printTensorDataMultiDims` 仍會用 (32, 16) 排版，但 buffer 裡已經是 permute 後的順序。

目前實作是 **permute 會一併改 shape**，所以 `printTensorDataMultiDims` 一定會用 (1, 1, 4, 16, 8) 來排版，和「還是 32×16」的直覺預期不同；**printTensorData** 則只是同一順序的 flat 列表，不會有 32×16 的結構感。

---

## 6. 一句話總結

- **printTensorData**：依**線性順序**印出 buffer，不管 shape → 一長串數字。  
- **printTensorDataMultiDims**：依**目前 shape**（doSwizzle 後是 **(1, 1, 4, 16, 8)**）做多維巢狀印出 → 看起來是 4×16×8 的結構，不是 32×16。  
- 所以兩者「預期不同」是因為：**doSwizzle 透過 permute 把 shape 從 (32,16) 改成了 (1,1,4,16,8)**，而兩種 print 一個不看 shape（flat）、一個看 shape（巢狀），呈現方式就不一樣；**數值與順序則是一致的**。
