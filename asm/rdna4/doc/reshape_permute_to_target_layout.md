# 怎麼用 reshape + permute 做到想要的 memory layout？

目標：從「現在 buffer 的線性排列」變成「kernel 期望的線性排列」。做法是：(1) 把 buffer 看成一個多維 tensor、(2) reshape 成方便重排的 5D、(3) 用 permute 重排維度順序，讓「新 tensor 的 row-major linear」剛好等於目標 linear。

---

## 1. 三步驟心法

| 步驟 | 在做什麼 |
|------|----------|
| **1. 目標** | 寫出 kernel 要的 **new_linear = f(邏輯維度)**（例如 new_linear = 8×lane + elem）。 |
| **2. 來源** | 寫出目前 buffer 的 **old_linear = g(邏輯維度)**（例如 32×m + k）。 |
| **3. 對維度** | 把 old_linear、new_linear 都拆成「多維 row-major」的形式，再決定 **reshape 成哪個 5D**、**permute 用哪個 {0,1,2,3,4} 的排列**，讓「舊的某組維度」對應到「新的某組維度」。 |

下面用 TN 的 A (K,M)=(32,16) 當例子，從頭推一遍。

---

## 2. 步驟 1：Kernel 要的 layout（目標）

TN kernel 有 doSwizzle 時：

- 32 個 lane，每個 lane 讀 **8 個連續 element**。
- Lane L 的 8 個要在 **新 buffer** 的 **8×L .. 8×L+7**（第一筆）以及 **256+8×L .. 256+8×L+7**（第二筆）。

所以我們要的「目標 layout」是：

- **new_linear = 8×L + i**，其中 L = 0..31（lane），i = 0..7（element 在 lane 內）。

也就是說：**新 buffer 的「最慢變的維度」是 lane L，「最快變的」是 i**。  
用 5D 表示的話，可以讓「32 個 lane」= 某兩維的乘積（例如 4×8 或 2×16），「8」= 最後一維：

- 例如 shape **(1, 1, 4, 16, 8)**，row-major：
  - linear = **128×d0 + 128×d1 + 32×d2 + 8×d3 + d4**  
  - 前兩維是 1，所以 = **32×d2 + 8×d3 + d4**。
  - 令 L = 4×d2 + d3（0..31），i = d4（0..7），則 **new_linear = 8×L + i** ✓

所以「目標」就是：**做完 permute 後，tensor 的 shape 要是 (1,1,4,16,8)，且 row-major 的 linear 公式 = 32×d2 + 8×d3 + d4 = 8×L + i**。

---

## 3. 步驟 2：目前 buffer 的 layout（來源）

TN 的 A 在 host 上：

- 邏輯上是 **(K, M) = (32, 16)**，但填數時是 **先變 M、再變 K**（16 行×32 欄）。
- 所以 **old_linear = 32×m + k**（m = 0..15, k = 0..31）。

我們把 k 拆成「高 4 維 × 低 8 維」：**k = 8×k_hi + k_lo**，k_hi = 0..3，k_lo = 0..7：

- **old_linear = 32×m + 8×k_hi + k_lo**。

要對應到「某個 5D tensor 的 row-major linear」，可以設：

- 形狀 **(1, 16, 1, 4, 8)**：
  - dim0=1, dim1=16(m), dim2=1, dim3=4(k_hi), dim4=8(k_lo)。
  - Row-major：**old_linear = 32×dim1 + 8×dim3 + dim4 = 32×m + 8×k_hi + k_lo** ✓

所以「來源」就是：**先把同一塊 buffer 用 reshape 看成 (1, 16, 1, 4, 8)**，不搬資料，只是換解讀。

---

## 4. 步驟 3：對維度 → 決定 permute

我們有：

- **舊** (1, 16, 1, 4, 8)：old_linear = **32×s1 + 8×s3 + s4**（s1=m, s3=k_hi, s4=k_lo）。
- **新** (1, 1, 4, 16, 8)：new_linear = **128×s3 + 8×s1 + s4**（新 dim2=4, 新 dim3=16, 新 dim4=8）。

同一個 logical element (m, k_hi, k_lo) 在舊 tensor 的索引是 **(0, s1, 0, s3, s4)**，在新 tensor 要放在 linear = 8×L + s4，其中 L = 4×? + s1。所以新索引要是 **(0, 0, s3, s1, s4)** 才會得到 new_linear = 128×s3 + 8×s1 + s4。

也就是：

- 新 dim0 = 舊 dim0 → 0  
- 新 dim1 = 舊 dim2 → 0  
- 新 dim2 = 舊 dim3 → k_hi (0..3)  
- 新 dim3 = 舊 dim1 → m (0..15)  
- 新 dim4 = 舊 dim4 → k_lo (0..7)  

所以 **新索引 = (舊 dim0, 舊 dim2, 舊 dim3, 舊 dim1, 舊 dim4)**，也就是 **permutation = {0, 2, 3, 1, 4}**。

- **reshape**：把 (M, K) 或 (16, 32) 先 pad 成 (16, 32)，再 **reshape 成 (1, 16, 1, 4, 8)**。  
- **permute**：**permute(tensor, {0, 2, 3, 1, 4})** → 得到 shape **(1, 1, 4, 16, 8)**，且 new_linear = 8×L + i。

---

## 5. 對照 code（TN doSwizzle）

```cpp
// 來源：(K,M)=(32,16)，但 tmp 用 (tiledSize=16, unrolledSize=32) 看同一塊 buffer
paddedTensor.reshape({
    paddedShape[0] / MiM_N,           // 1
    MiM_N,                            // 16  → 對應 m
    paddedShape[1] / (MiK * PackK),  // 2 或 1（依 MiK,PackK）
    MiK / MiKv,                       // 2 或 4 → 對應 k_hi
    MiKv * PackK                     // 8   → 對應 k_lo
});  // 例如 (1, 16, 2, 2, 8) 或 (1, 16, 1, 4, 8)

swizzled = permute(paddedTensor, {0, 2, 3, 1, 4});
```

- **reshape 的 5 個數字**：就是把「tiledSize × unrolledSize」拆成 (1, M, 1, K/8, 8) 這種形式，讓 **old_linear = 32×dim1 + 8×dim3 + dim4**。
- **permute {0, 2, 3, 1, 4}**：把「k_hi、m、k_lo」的順序改成「k_hi → m → k_lo」在 new shape 裡對應 (dim2, dim3, dim4)，這樣 new_linear = 128×k_hi + 8×m + k_lo = 8×L + k_lo（L = 16×(k_hi/2) + m 等，依你實際 shape 而定）。

若 MiKv=8, PackK=1，則 reshape 是 (1, 16, 2, 2, 8)，permute 後是 (1, 2, 2, 16, 8)；若 MiKv=4, PackK=2，則 (1, 16, 1, 4, 8) → (1, 1, 4, 16, 8)。**邏輯一樣**：都是讓「lane 對應的維度」在 permute 後變成 stride 8 的那一維，最後一維是連續 8 個。

---

## 6. 通則：自己要設計時怎麼做

1. **寫出目標 new_linear**  
   例如：new_linear = 8×lane + elem，或 new_linear = 256×chunk + 8×lane + elem。

2. **把 new_linear 拆成「多維 row-major」**  
   例如 8×L + i → shape (..., 32, 8) 或 (1, 1, 4, 16, 8)，讓 linear = 8×L + i。

3. **寫出來源 old_linear**  
   例如 32×m + k，再拆成 32×m + 8×k_hi + k_lo。

4. **選一個 5D reshape**  
   讓 old_linear = 某個 5D 的 row-major 公式（例如 32×s1 + 8×s3 + s4）。

5. **決定 permute**  
   讓「舊的 (s0,s1,s2,s3,s4)」對應到「新的 (s0, s2, s3, s1, s4)」這種順序，使得新 tensor 的 row-major 公式 = 你要的 new_linear。

6. **實作**  
   `reshape(選好的 5D)` → `permute(tensor, 算出來的 permutation)`。

這樣就能用 **reshape（只改解讀）+ permute（真的重寫記憶體）** 做到你要的 memory layout。

---

## 7. NN 的 A（col-major M×K）用同一套目標 layout

NN 的 A 是 **M×K col-major**：**old_linear = m + 16×k**（m 最快）。

- **來源 5D**：把同一塊 buffer 看成 **(1, 1, 4, 8, 16)**，即 (k_hi, k_lo, m)，則  
  **old_linear = 128×k_hi + 16×k_lo + m**。  
  做法：先把 inBuffer (M, K) 用 **tmpTensor (K, M)** 解讀（同一 buffer，row-major = 16×k + m），再 **reshape** 成 (1, 1, 4, 8, 16)。
- **permute**：**{0, 1, 2, 4, 3}** → 新 shape **(1, 1, 4, 16, 8)**，  
  **new_linear = 128×k_hi + 8×m + k_lo = 8×L + k_lo**，其中 L = 16×k_hi + m。

所以 NN 的 `doSwizzle` 也是：**reshape 成 (1, 1, 4, 8, 16)**，再 **permute(..., {0, 1, 2, 4, 3})**，就能得到與 TN 相同的「lane 連續 8 個」目標 layout；kernel 用 **GLOBAL_OFFSET_A_SWZ** 讀取即可。
