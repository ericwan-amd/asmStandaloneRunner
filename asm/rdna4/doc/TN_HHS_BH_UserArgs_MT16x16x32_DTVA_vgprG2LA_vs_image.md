# vgprG2LA+0 / +4 / +8 / +12 與 Matrix A 0～511 對應說明

你的圖是 **Matrix A 的 0～511 layout（row-major）**：**16 行 × 32 欄**，row 0 為 0–31，row 1 為 32–63，…，row 15 為 480–511。共 512 個 elements。

---

## 1. v[vgprG2LA+0]、+4、+8、+12 都有用到嗎？ → **有，四個都有**

Assembly 裡 **v[vgprG2LA+0]、v[vgprG2LA+4]、v[vgprG2LA+8]、v[vgprG2LA+12]** 都有被使用，對應關係如下。

| Offset | VGPR 區塊 | 用途 | 在 assembly 裡的角色 |
|--------|-----------|------|----------------------|
| **vgprG2LA+0** | v22..v25 | Load + WMMA | `buffer_load_b128` 寫入；多處 `v_wmma_...` 當 A 輸入 |
| **vgprG2LA+4** | v26..v29 | Load + WMMA | 同上（第二筆 b128）；多處 WMMA |
| **vgprG2LA+8** | v30..v33 (= vgprG2LA2+0) | WMMA（資料來自 prefetch） | 不直接 load 到「當前」tile，由 **vgprG2LA2** 的 load 填滿；用在 WMMA |
| **vgprG2LA+12** | v34..v37 (= vgprG2LA2+4) | WMMA（資料來自 prefetch） | 同上，由 vgprG2LA2 的第二次 load 填滿；用在 WMMA |

- **+0、+4**：每個 K block 都會用 `buffer_load_b128` 直接載入到 v22..v29，並在 **同一個 tile（0～511）** 的 WMMA 中使用。
- **+8、+12**：在 assembly 裡就是 **vgprG2LA2**（v30..v37），由 **上一個 iteration 的 prefetch load** 填滿（讀的是 **下一個** K block）；在 **當前** iteration 的 WMMA 中被當成 A 的輸入使用。

所以：**四個 offset 都有在 kernel 裡被使用**（+0、+4 直接 load 並參與 WMMA；+8、+12 以 vgprG2LA2 的身份被 load 並參與 WMMA）。

---

## 2. 和你這張 0～511 的圖的對應

- 你這張圖是 **單一 K block 的 512 個 elements，linear 0～511，16×32 row-major**。

- **v[vgprG2LA+0]（v22..v25）**  
  - 由 **第一個** `buffer_load_b128`（per-lane offset v8，無 scalar）寫入。  
  - 每 lane 讀 **8 個 fp16**，32 lanes → 共 **256 個 elements**。  
  - 這 256 個在 linear 0～511 裡是「每個 lane 的前 8 個」：依 per-lane start 分散在圖上（不是整齊的一整塊），對應圖裡 **第一組 8 欄（col 0–7）與第二組 8 欄（col 16–23）** 等 8 欄一組的 **其中一半** 來源。

- **v[vgprG2LA+4]（v26..v29）**  
  - 由 **第二個** `buffer_load_b128`（同一 v8 + scalar +16 elements）寫入。  
  - 同樣 32×8 = **256 個 elements**。  
  - 對應同一個 0～511 tile 裡「每個 lane 的後 8 個」，分散在圖上，對應圖裡 **col 8–15、24–31** 等 8 欄一組的來源。

因此：**整張 0～511 的圖** = 當前 K block 的 512 elements，**全部** 都由 **vgprG2LA+0 與 vgprG2LA+4 一起覆蓋**（兩次 load，各 256，合起來 512）。圖上的 **黃 / 淺藍 8 欄一組** 就是一次 `buffer_load_b128` 的 8 個 fp16 的邊界。

- **v[vgprG2LA+8]、v[vgprG2LA+12]**（即 vgprG2LA2）  
  - 讀的是 **下一個 K block**：linear **512～1023**。  
  - **不會出現在你這張 0～511 的圖裡**；若畫「下一塊」16×32（512～1023），那整塊就是 +8 與 +12 的資料。

---

## 3. 簡表（對你這張 0～511 圖）

| 寫法 | VGPR | 讀的 linear index | 在你這張 0～511 圖裡？ |
|------|------|-------------------|-------------------------|
| v[vgprG2LA+0] | v22..v25 | 當前 tile 的前半（256 elements） | ✅ 是，圖上一部分 8 欄組 |
| v[vgprG2LA+4] | v26..v29 | 當前 tile 的後半（256 elements） | ✅ 是，圖上另一部分 8 欄組 |
| v[vgprG2LA+8] | v30..v33 (vgprG2LA2+0) | **下一塊** 512～1023 的前半 | ❌ 否，在下一張 16×32 |
| v[vgprG2LA+12] | v34..v37 (vgprG2LA2+4) | **下一塊** 512～1023 的後半 | ❌ 否，在下一張 16×32 |

---

## 4. Assembly 出處（證明四個都有用）

- **+0：**  
  - Load：1342, 1592；另 tail 路徑 2038–2052。  
  - WMMA：1547, 1740, 1874, 2210。
- **+4：**  
  - Load：1343, 1593；tail 2054–2068。  
  - WMMA：1563, 1750, 1884, 2325。
- **+8：**  
  - 以 **vgprG2LA2** 身份被 load：1503（buffer_load 寫入 v30..v33）。  
  - WMMA：1636, 1711, 1845。
- **+12：**  
  - 以 **vgprG2LA2** 身份被 load：1504（寫入 v34..v37）。  
  - WMMA：1652, 1721, 1855。

**結論：**  
- **v[vgprG2LA+0]、+4、+8、+12 四個在 assembly 裡都有被使用。**  
- 你這張 **0～511 的 Matrix A 圖** 全部來自 **+0 與 +4**（當前 tile）；**+8 與 +12** 對應的是下一塊 512～1023，不在這張圖裡。
