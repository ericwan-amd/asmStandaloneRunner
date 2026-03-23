# Tensor 表示、Buffer 連續性、與 Kernel 裡的 A 的對應關係

同一塊 **Matrix A** 在 host 上有三種「看法」：**填數的邏輯**、**Tensor 的 shape**、以及 **送進 kernel 的 buffer**。Kernel 裡再用 **stride** 解讀成 16×32。這份說明把這幾件事對齊。

---

## 1. 同一塊 buffer：只有一段連續記憶體

- Host 上：`inputA_h` 是一個 `vector<_Float16>`，長度 **512**。
- 填完後 `memcpy` 到 `tensorA_h`，再 `hipMemcpy` 到 `inputA_d`。
- **從頭到尾都是同一段 512 個 fp16 的連續記憶體**，沒有複製時重排，只是：
  - CPU 填數時用一種「邏輯形狀」去填；
  - Tensor 用另一個 shape 去「解讀」同一段 buffer；
  - Kernel 收到同一個指標，用 stride 解讀成 16×32。

---

## 2. 三種「看法」對同一段 buffer 的對應（M=16, K=32）

### 2.1 填數的邏輯（SwizzleAGemmRunnerRDNA 的 loop）

```cpp
TensorClass tensorA_h = TensorClass({K, M}, sizeof(_Float16));  // shape (32, 16)
// ...
for (dimM = 0; dimM < M; ++dimM)      // 0..15
    for (dimK = 0; dimK < K; ++dimK)   // 0..31
        inputA_h.push_back((K * linearM + dimK) * scale);  // value = 32*dimM + dimK
memcpy(tensorA_h.as<void>(), inputA_h.data(), ...);
```

- 邏輯上你在填的是 **「先變 dimM、再變 dimK」**：  
  先填 dimM=0 的 32 個，再 dimM=1 的 32 個，…，共 **16 組 × 32 = 512**。
- 所以若用 **(dimM, dimK)** 當 (row, col)，等價於：
  - **16 行（dimM）、每行 32 個（dimK）**
  - linear index = **dimM * 32 + dimK**（row-major，leading dimension = 32）。

也就是說，**填進 buffer 的順序** 是：

- buffer[0..31]   = 第 0 行：0, 1, …, 31  
- buffer[32..63]  = 第 1 行：32, …, 63  
- …  
- buffer[480..511] = 第 15 行：480, …, 511  

所以 **buffer 的連續性** 就是：**16 行 × 32 欄，行優先、一行 32 個連續**。這和 kernel 的預期一致（見下）。

---

### 2.2 Tensor 的表示：為什麼是 (K, M) = (32, 16)？

- Tensor 的 **shape 是 `{K, M} = {32, 16}`**，只是「怎麼解釋這 512 個數」的約定，**沒有改動 buffer 內容**。
- `TensorDesc` 對 shape (32, 16) 算出來的 stride 是 **row-major**：
  - dim0 的 stride = 16，dim1 的 stride = 1
  - linear_index = **idx0 * 16 + idx1**
- 因此：
  - 當 (idx0, idx1) = (0, 0)..(0, 15) → linear 0..15 → buffer[0..15] → 值 0..15
  - (1, 0)..(1, 15) → linear 16..31 → buffer[16..31] → 16..31
  - …
  - (31, 0)..(31, 15) → linear 496..511 → 496..511

所以 **Tensor 的「表示」** 是：  
**32 個「列」（dim0）× 每列 16 個（dim1）**。  
`printTensorDataMultiDims` 就照這個 shape 一列一列印，所以你會看到 32 個 `[ ..., ],`，每個裡面 16 個數。

- **為什麼用 (K, M) 而不是 (M, K)？**  
  這裡的 Tensor 只是 host 端的一種「標註」：維度名稱是 (K, M)，但 **實際寫入 buffer 的順序** 是由上面的 **dimM / dimK 迴圈** 決定的，是 16×32（M×K）。也就是說：**Tensor 的 shape (32,16) 和「誰是行／誰是列」的命名，和 kernel 的 (M,K)=(16,32) 是兩套不同視角**；真正和 kernel 一致的是 **buffer 的線性順序**（16 行，每行 32）。

小結：  
- **Tensor 這樣表示**：只是選了 shape (32, 16)，用 row-major 把同一段 buffer 切成 32 段、每段 16 個來印。  
- **Buffer 連續性**：沒被破壞，就是 512 個 fp16 從 0 到 511 連續；只是「第幾維是 16、第幾維是 32」在 Tensor 和 kernel 裡不同。

---

### 2.3 Kernel 的表示：stride 與 16×32

- Kernel 收到的是 **同一個 A 的 base 指標**，以及 **strideA0 = K = 32**（你傳的是 `kernelArg.append("strideA0", K)`）。
- Assembly 裡 **sgprStrideA0I = 32**，表示「沿著第 0 維走 1 格，要跨過 32 個 element」。
- 所以 kernel 的「邏輯形狀」是：
  - **第 0 維（例如對應 M）**：16 格，stride 32 → 共 16×32 個 element。
  - **第 1 維（對應 K）**：32 格，stride 1（連續）。
- 也就是 **16 行 × 32 欄，row-major，leading dimension = 32**：
  - linear_index = **row * 32 + col**（row 0..15, col 0..31）。

這和 **2.1 填數的順序** 完全一致：  
buffer 就是 16 行、每行 32 個連續，kernel 用 stride 32 解讀成 16×32，所以 **進 kernel 後的表示** 就是這張 16×32 的矩陣，linear 0..511 對應 (row, col) = (0,0)..(15,31)。

---

## 3. 對照表（同一段 buffer，三種解讀）

| 視角           | 「形狀」   | 線性指標公式           | 和 buffer 的對應                    |
|----------------|------------|------------------------|-------------------------------------|
| 填數 (dimM,dimK) | 16 行×32 欄 | dimM*32 + dimK         | buffer 順序 = 0..31, 32..63, …      |
| Tensor (K,M)   | 32×16      | idx0*16 + idx1         | 同一 buffer，切成 32 段每段 16 個   |
| Kernel (strideA0=32) | 16×32 (M×K) | row*32 + col           | 與填數一致，row 0..15, col 0..31   |

- **Buffer 連續性**：從頭到尾都是 **同一段 512 個 fp16**；沒有因為 Tensor 的 (32,16) 而重排或打斷連續性。
- **Tensor 那樣表示**：只是用 (32, 16) 這組 shape 做「多維索引 → 線性 index」的對應，方便你印成 32 列×16 行；和 kernel 的 16×32 是同一 buffer 的兩種解讀。
- **進 kernel 後的表示**：就是 **base + byte_offset**，其中 element 的邏輯是 **row*32 + col**（16×32），和填數的 (dimM, dimK) 一致。

---

## 4. 一句話對照

- **為什麼 tensor 要這樣表示？**  
  因為 Tensor 的 shape 被設成 (K, M) = (32, 16)，只是用另一種「切法」看同一段 buffer（32 段、每段 16），方便除錯／列印；不影響 kernel。
- **和 buffer 連續性的關係？**  
  Buffer 從頭到尾都是 512 個連續 fp16；Tensor 和 kernel 只是用不同 stride/shape 去索引這同一段。
- **進 kernel 後的表示？**  
  同一個 A 的指標 + strideA0=32，被解讀成 **16 行 × 32 欄**（M×K），linear = row*32+col，和你在 host 上填的 (dimM, dimK) 順序一致。
