# doSwizzle 對記憶體排列的影響

說明 `SwizzleAGemmRunnerRDNA::doSwizzle` 做了哪些步驟，以及**原本的線性記憶體排列會變成什麼樣子**。以 A 為例，輸入 shape (K, M) = (32, 16)，512 個 fp16。

---

## 1. doSwizzle 的步驟摘要

```cpp
void doSwizzle(const TensorClass& inBuffer, TensorClass& swizzled)
{
    size_t MiM_N = 16, MiK = 16, MiKv = 4, PackK = 2;
    auto unrolledSize = inBuffer.getDesc().getShape()[0];  // K = 32
    auto tiledSize    = inBuffer.getDesc().getShape()[1];   // M = 16

    // paddedShape：必要時會 pad，這裡 (16,32) 已滿足，不變
    Shape paddedShape{ ((tiledSize/MiM_N) + !!(tiledSize%MiM_N)) * MiM_N,
                      (unrolledSize/(MiK*PackK) + !!(unrolledSize%(MiK*PackK))) * MiK * PackK };
    // = { 16, 32 }

    // Step 1: 用 (tiledSize, unrolledSize) 當 shape，純 memcpy（同一塊線性 buffer）
    TensorClass tmpTensor = TensorClass({tiledSize, unrolledSize}, ...);  // (16, 32)
    memcpy(tmpTensor.as<void>(), inBuffer.as<void>(), tmpTensor.getNumBytes());

    // Step 2: pad（這裡 shape 相同，等於沒 pad）
    auto paddedTensor = pad(tmpTensor, paddedShape, ...);  // 仍是 (16, 32)

    // Step 3: reshape 成 5D，方便做維度重排
    paddedTensor.reshape({
        paddedShape[0] / MiM_N,    // 1
        MiM_N,                     // 16
        paddedShape[1] / (MiK * PackK),  // 1
        MiK / MiKv,                // 4
        MiKv * PackK               // 8
    });  // shape = (1, 16, 1, 4, 8)

    // Step 4: permute 維度 → 真正改寫記憶體順序
    swizzled = permute(paddedTensor, {0, 2, 3, 1, 4});  // (1,1,4,16,8)
}
```

---

## 2. 各步驟的 shape 與「有沒有動到線性記憶體」

| 步驟 | 變數 | Shape | 線性記憶體 |
|------|------|--------|------------|
| 輸入 | inBuffer | (32, 16) | 原始 512 個 fp16，linear = i0×16 + i1 |
| Step 1 | tmpTensor | (16, 32) | **沒變**：同一段 buffer，只換一種「解讀」(16 行×32 欄) |
| Step 2 | paddedTensor | (16, 32) | **沒變**：pad 成 (16,32) 沒放大，內容同 tmpTensor |
| Step 3 | paddedTensor | (1, 16, 1, 4, 8) | **沒變**：reshape 只改多維索引公式，不搬資料 |
| Step 4 | swizzled | (1, 1, 4, 16, 8) | **會變**：permute 會依新維度順序**重寫**每個元素到新 buffer |

也就是說：**只有最後的 `permute` 會改變「線性記憶體排列」**；前面的 tmpTensor / pad / reshape 都是同一塊 512 個 element 的不同 view。

---

## 3. 原本的線性排列（permute 前）

- **inBuffer / tmpTensor / paddedTensor（reshape 後）** 都是同一段 buffer，只是 shape 不同：
  - inBuffer (32, 16)：linear = **i0×16 + i1**
  - tmpTensor (16, 32)：linear = **i0×32 + i1**
  - reshape 成 (1, 16, 1, 4, 8) 後，多維索引 (a, b, c, d, e) 對應的 linear 仍是：
    - **linear = 32×b + 8×d + e**（a=0, c=0 時）

所以「原本」的排列就是：  
buffer[0..7]=0..7, buffer[8..15]=8..15, …, buffer[32..39]=32..39, …，也就是你填的 (dimM, dimK) 順序：16 行×32 欄。

---

## 4. permute 後：新線性排列是怎麼來的

- **permute(..., {0, 2, 3, 1, 4})** 表示：新 tensor 的維度順序 = 舊的 (dim0, dim2, dim3, dim1, dim4)。
- 舊 shape (1, 16, 1, 4, 8) → 新 shape **(1, 1, 4, 16, 8)**。
- 對每個舊索引 (s0, s1, s2, s3, s4)，值會寫到新索引 **(s0, s2, s3, s1, s4)**。

用舊的 linear 與新 linear 對應（a,c 恆為 0，可只寫 (s1,s3,s4)）：

- 舊 linear（reshape 後）= **32×s1 + 8×s3 + s4**
- 新 tensor 的 linear（row-major, shape (1,1,4,16,8)）= **128×s3 + 8×s1 + s4**

所以同一個 (s1, s3, s4) 的這個值：

- **從舊 buffer 的 [32×s1 + 8×s3 + s4]**  
- **被寫到 swizzled buffer 的 [128×s3 + 8×s1 + s4]**  

也就是：**原本在線性位置 `old_linear` 的值，會出現在 swizzled 的線性位置 `new_linear`，兩者由 (s1,s3,s4) 的對應關係給出。**

---

## 5. 幾個具體例子（值 = linear index 時）

假設 inBuffer 裡存的是「自己的 linear index」0..511（和你現在填的 value 一致），則 permute 前後對照如下（只列部分，說明「誰搬到哪」）：

| 舊 linear (原位置) | (s1,s3,s4) | 新 linear (swizzled 位置) | 說明 |
|--------------------|------------|---------------------------|------|
| 0  | (0,0,0) | 0   | 不動 |
| 8  | (0,1,0) | 128 | 原 8 → 新 128 |
| 32 | (1,0,0) | 8   | 原 32 → 新 8 |
| 40 | (1,1,0) | 136 | 原 40 → 新 136 |
| 128| (4,0,0)| 32 | 原 128 → 新 32 |
| 256| (8,0,0)| 64 | 原 256 → 新 64 |

所以：**原本連續的一段（例如 0..31）在 swizzled 裡會被拆開，按 (s3, s1, s4) 的順序重新排**；反之，swizzled 裡連續的一段，對應的是原本不連續的一串位置。

---

## 6. 一句話總結

- **doSwizzle 之前**：就是現在這條 512 的線性 buffer，16 行×32 欄（或你說的 32×16 的 Tensor view），**連續、沒有重排**。
- **doSwizzle 之後**：**只有 `permute` 會真的改寫記憶體**；新 buffer 的線性排列由  
  **new_linear = 128×s3 + 8×s1 + s4**  
  決定（對應舊的 32×s1 + 8×s3 + s4），所以**原本的連續排列會被打散成「按 (s3, s1, s4) 分塊」的 swizzle 排列**，方便 kernel 用不同的向量寬 / 對齊方式讀取。

若你之後要對照 kernel 的讀取方式，只要記：**kernel 若吃的是「沒 swizzle 的 A」**，那它期望的就是「原本的 16×32 連續排列」；**若吃的是「swizzled A」**，則期望的是這份 permute 後的新線性排列。

---

## 7. 視覺化

同目錄下的 **`doSwizzle_memory_layout_visualization.html`** 用兩個 16×32 的表格畫出：

- **左：Original** — 原本 0～511 的連續排列（row-major，row×32+col）。
- **右：After doSwizzle** — 同一段 buffer 在 permute 後，每個新位置裡「放的是哪一個原始 index」；也就是「新 linear 位置 → 對應的舊 index」。

在瀏覽器裡直接打開該 HTML 即可對照兩種 layout。
