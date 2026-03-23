# 說明：GLOBAL_OFFSET_A 與 sgprScalarGlobalReadOffsetA（1205–1208）

對應 assembly 片段：

```asm
GLOBAL_OFFSET_A vgprGlobalReadOffsetA+0,  1,  0, 12 // gROA_0_0_0_0
s_mul_i32 s[sgprScalarGlobalReadOffsetA+0], s[sgprStrideA0I], 0 // compute offset diff (scaled tileDim)
s_add_u32 s[sgprScalarGlobalReadOffsetA+0], s[sgprScalarGlobalReadOffsetA+0], 16 // compute offset diff (unrollDim)
s_lshl_b32 s[sgprScalarGlobalReadOffsetA+0], s[sgprScalarGlobalReadOffsetA+0], 0x1 // scalar offset *= bytes/element
```

---

## 1. 這四行在做什麼

### 1.1 第一行：`GLOBAL_OFFSET_A`（per-lane 的 A 讀取 byte offset）

**Macro 定義（約 309–313）：**

```asm
.macro GLOBAL_OFFSET_A vgprAddr:req, vgprOffsetL:req, vgprOffset0I:req, vgprTmp:req
    v_mul_lo_u32 v[\vgprTmp+0], s[sgprStrideA0I], v[\vgprOffset0I] // tmp = strideA0I * v0
    v_add_co_u32 v[\vgprAddr+0], vcc_lo, v[\vgprOffsetL], v[\vgprTmp+0] // vAddr = v1 + tmp
    v_add_nc_u32 v[\vgprAddr+0], 0x8, v[\vgprAddr+0]   // +8 prepad (element)
    v_lshlrev_b32 v[\vgprAddr+0], 1, v[\vgprAddr+0]    // *2 → byte offset
.endm
```

**呼叫：** `GLOBAL_OFFSET_A vgprGlobalReadOffsetA+0, 1, 0, 12`

- `vgprAddr` = `vgprGlobalReadOffsetA` → 結果寫入 **v8**（per-lane 的 **byte** offset）。
- `vgprOffsetL` = **v1**，`vgprOffset0I` = **v0**，`vgprTmp` = v12。

在執行到這裡之前，前面已有（約 713–721，DirectToVgprA tile assignment）：

- **v1** = `(lane / 16) * 8`（lane 0–15 → 0，lane 16–31 → 8）
- **v0** = `lane % 16`（0–15）

因此：

- `element_offset = v1 + sgprStrideA0I * v0 + 8`  
  → **element_offset = (lane/16)*8 + strideA0I*(lane%16) + 8**
- `byte_offset = element_offset * 2`（fp16 = 2 bytes）  
  → 結果放在 **v8**，也就是後面 `buffer_load_b128` 用的 **v[vgprGlobalReadOffsetA+0]**。

也就是：**每個 lane 根據自己的 lane id 算出一份 A 的 element index，再加 prepad 8、再乘 2 得到 byte offset。**

### 1.2 第二～四行：`sgprScalarGlobalReadOffsetA`（第二筆 b128 的 scalar 差）

- `s[sgprScalarGlobalReadOffsetA+0] = (sgprStrideA0I * 0 + 16) * 2`
  - 第二行：`* 0` → 這裡 tileDim 貢獻為 0。
  - 第三行：`+ 16` → **unroll 維度 16 個 elements**。
  - 第四行：`* 2` → 換成 **bytes**（fp16）。

所以 **sgprScalarGlobalReadOffsetA = 16 * 2 = 32 bytes**。  
也就是：同一個 per-lane offset（v8）下，**第二筆** `buffer_load_b128` 會在 **第一筆的 base 上再加 32 bytes（16 個 fp16）**，對應後面：

- 第一筆 load：`..., null offen`（scalar = 0）
- 第二筆 load：`..., s[sgprScalarGlobalReadOffsetA+0] offen`（scalar = 32 bytes）

---

## 2. 為什麼要 prepad（+8 elements / 16 bytes）？

Assembly 註解寫的是 **"add prepad for pointer shift"**，和後面三處是一組設計：

1. **GLOBAL_OFFSET_A 裡**：per-lane 的 element offset 先 **+8**，再 `*2` 變成 byte → 等於在 offset 上 **+16 bytes**。
2. **SRD 設定前**（約 843–844）：  
   `s_sub_u32 s[sgprAddressA+0], s[sgprAddressA+0], 16`  
   → 把 A 的 **base 指標往前移 16 bytes**（指向「邏輯上的資料起點再往前 16 bytes」）。
3. **Shadow limit**（約 1119–1120）：  
   `s_add_u32 s[sgprShadowLimitA+0], ..., 16`  
   → 把 A 的 **合法範圍多延長 16 bytes**，允許從 base-16 開始算起的讀取。

合起來的效果是：

- **實際讀到的位址不變**：  
  SRD base = (user_A + tileStart) **− 16**，per-lane offset 最小 = **(0+8)*2 = 16** bytes  
  → 第一個 lane 的第一次 load 位址 = (base − 16) + 16 = **base**，仍是正確的 tensor 起點。
- **為什麼要這樣做？**
  - **給 pointer shift 留空間**：若之後有 stride/loop 更新 base 或 offset，或某些 lane 的 offset 公式會產生較小的值，base 已經退後 16 bytes，不會一上來就貼在「邏輯起點」，避免邊界或對齊問題。
  - **OOB / 邊界**：Descriptor 的合法範圍一開頭就多 16 bytes（shadow limit +16），而我們最小的有效 offset 是 16，所以所有 load 都在 descriptor 允許的範圍內，不會因為「剛好從 0 開始」被硬體或驅動當成越界。
  - **對齊與一致**：第一個有效讀取的 *offset* 固定是 16 bytes，所有 lane 的 offset 都是「正數且至少 16」，計算方式一致，方便與 buffer_load 的 offen 語意配合。

所以 prepad 不是「多讀一塊無用資料」，而是 **base 退 16、offset 加 16、limit 加 16** 的對稱設計，邏輯位址不變，但給 global read 的 pointer shift 和邊界檢查留空間。

---

## 3. 與 SwizzleAGemmRunnerRDNA.hpp / standalone 的對應

### 3.1 你設定的數值（HPP + config）

- **SwizzleAGemmRunnerRDNA.hpp** 裡：
  - `strideA0` 來自 **K**：`kernelArg.append("strideA0", K);`（A 為 K-major，leading dim = K）
  - `strideA1` = M*K（這裡用不到這四行）
- **program_config_gemm_swizzleA_rdna.ini**：`size_K=32`，`size_M=16`（以及 num-workgroups 等）
- **standalone.cpp** 預設：`size_M=16`, `size_N=16`, `size_K=32`（若沒覆寫）

因此 kernel 收到的 **strideA0 = K = 32**，對應 assembly 的 **s[sgprStrideA0I] = 32**。

### 3.2 具體數值範例（M=16, K=32, strideA0=32）

- **sgprStrideA0I** = 32  
- **Per-lane element offset（prepad 前）**  
  `elem = (lane/16)*8 + 32*(lane%16)`  
  例如：
  - Lane 0: 0 + 0 = **0**
  - Lane 1: 0 + 32 = **32**
  - Lane 15: 0 + 32*15 = **480**
  - Lane 16: 8 + 0 = **8**
  - Lane 31: 8 + 32*15 = **488**
- **Prepad + 轉 byte**：  
  `byte_offset = (elem + 8) * 2`  
  例如 lane 0：elem 0 → (0+8)*2 = **16** bytes；lane 1：(32+8)*2 = **80** bytes。

所以每個 lane 的 **v8** = 該 lane 要讀的 A 的 **byte offset**（相對於 SRD base）。

- **Scalar offset**：  
  `sgprScalarGlobalReadOffsetA = (0 + 16) * 2 = 32` bytes。  
  也就是：第一個 b128 從 v8 指向的位址讀 16 bytes；第二個 b128 從 **v8 + 32 bytes** 再讀 16 bytes，合起來每 lane 連續 32 bytes = 16 個 fp16。

---

## 4. 對應到 Matrix A 的 layout（你之前的 0–511 圖）

- A 在 host 是 **K-major**：`idx = dimK + K * dimM`，leading dimension = K = 32。
- 一個 wave 有 32 lanes，每個 lane 用 **v8** 算出自己的起始 byte，再依序做兩次 b128：
  - 第一次：8 個 fp16（16 bytes）
  - 第二次：再 8 個 fp16（+32 bytes）
- 因此每 lane 總共讀 **16 個 fp16**，對應到 A 的「一條帶狀」位置，由 `(lane/16)*8 + strideA0*(lane%16)` 決定起始 element，和 **strideA0=K=32** 一致，正好是 TN、K-major 下沿 K 方向交錯、沿 M 方向分 lane 的取法。

---

## 5. 簡短對照表（用你的設定）

| 項目 | 來源 | 數值（M=16, K=32） |
|------|------|---------------------|
| sgprStrideA0I | kernel arg strideA0 = K | 32 |
| v0 | lane % 16 | 0..15 |
| v1 | (lane/16)*8 | 0 或 8 |
| v8 (per-lane) | (v1 + strideA0I*v0 + 8)*2 bytes | 例：lane0 → 16, lane1 → 80 |
| sgprScalarGlobalReadOffsetA | (0 + 16)*2 bytes | 32 |

第一行：算每個 lane 的 A 讀取 byte offset（v8）。  
第二～四行：算第二筆 b128 相對第一筆的 **scalar 偏移 = 16 elements = 32 bytes**，與 HPP 的 strideA0=K 和 config 的 size_K=32 一致。
