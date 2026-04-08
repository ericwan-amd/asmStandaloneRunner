# TN F8F8S：`A` 的 global read 改為 `buffer_load_b128`（SwizzleA 版）

適用組譯：`asm/rdna4_swzA/TN_F8F8S_BH_UserArgs_MT16x16x32_DTVA.s`
對照基準：`asm/rdna4_no_swizzle/TN_F8F8S_BH_UserArgs_MT16x16x32_DTVA.s`（未 swizzle 版）
Host 端搭配：`SwizzleRdna4::tnSlabDoSwizzleF8`（custom scatter，**非** FP16 的 `permute({0,2,3,1,4})`）

---

## 1. 背景：FP8 TN 無 swizzle 時 A 的讀法

在 **no-swizzle** kernel 中，每條 lane（wave32 = 32 threads）讀 A 矩陣時：

- `nIdx = lane % 16`（M 方向），`kIdx = lane / 16`（K 方向，0 或 1）
- 每條 lane 用 **兩次 `buffer_load_b64`** 讀取 8 fp8 elements：
  1. 第 1 次：`buffer_load_b64 ... null offen`（base offset = `nIdx × strideA0I + kIdx×8 + 8`）
  2. 第 2 次：`buffer_load_b64 ... s[sgprScalarGlobalReadOffsetA] offen`（base offset + **scalar 16**）
- 這兩段 8 bytes 在原始 TN layout 中**不連續**（相距 `ScalarGlobalReadOffsetA = 16` bytes）
- 之後分別對 `G2LA[0:1]` 與 `G2LA[2:3]` 各做一次 `v_wmma_f32_16x16x16_fp8_fp8`

---

## 2. Swizzle 後的目標：1×`buffer_load_b128` 取代 2×`buffer_load_b64`

### 2.1 Host 端 swizzle 做了什麼

`tnSlabDoSwizzleF8` 把 TN layout 的 A 矩陣按 **512-byte slabs**（16 rows × 32 cols fp8 = 16×32 = 512 bytes）重排。
scatter 公式（每個 slab 內 512 bytes，source index `i` → destination `o`）：

```
seg = i / 8
eis = i % 8
g   = seg / 8
row = (seg % 2 == 0) ? g : (g + 8)
col = (seg % 8) / 2 * 8 + eis
o   = row * 32 + col
```

**效果**：原本每條 lane 的兩段不連續 8-byte chunks，在 swizzled buffer 中被排成**連續 16 bytes**。

### 2.2 Swizzle 後每條 lane 的 byte offset

Python 驗證結果：

| Lane | nIdx | kIdx | 原始位置（不連續） | Swizzled offset |
|------|------|------|--------------------|-----------------|
| 0 | 0 | 0 | [0:7] + [16:23] | **0 – 15** |
| 1 | 1 | 0 | [32:39] + [48:55] | **16 – 31** |
| 2 | 2 | 0 | [64:71] + [80:87] | **32 – 47** |
| ... | | | | |
| 16 | 0 | 1 | [8:15] + [24:31] | **256 – 271** |
| ... | | | | |
| 31 | 15 | 1 | [488:495] + [504:511] | **496 – 511** |

**公式：lane `L` 的 16 bytes 起始位置 = `L × 16`**

32 條 lanes × 16 bytes = 512 bytes = 一個完整 slab。

### 2.3 為什麼不能沿用 FP16 的 `tnSlabDoSwizzle`

FP16 與 FP8 的 swizzle 目標本質不同：

| | FP16 | FP8 |
|--|------|-----|
| **每條 lane 的 global read** | 兩次 `buffer_load_b64`（各 8 個 fp16 = 16 bytes），中間跳一個 slab | 一次 `buffer_load_b128`（16 個 fp8 = 16 bytes，連續） |
| **Host swizzle 函式** | `tnSlabDoSwizzle`（`reshape` + `permute({0,2,3,1,4})`） | `tnSlabDoSwizzleF8`（custom scatter loop） |
| **每條 lane 讀取量** | 2 × 16 bytes = 32 bytes | 1 × 16 bytes |

兩者 byte layout 差 496/512 bytes（Python 驗證），**不可互用**。

---

## 3. Kernel assembly 修改明細

### 3.1 新增 `GLOBAL_OFFSET_A_SWZ` macro

```asm
.macro GLOBAL_OFFSET_A_SWZ vgprAddr:req, vgprTmp:req
    v_and_b32 v[\vgprTmp+0], 31, v[vgprSerial]        // lane = tid % 32
    v_lshlrev_b32 v[\vgprAddr+0], 4, v[\vgprTmp+0]    // byte offset = lane × 16
    v_add_nc_u32 v[\vgprAddr+0], 0x8, v[\vgprAddr+0]  // + 8 (prepad)
.endm
```

- **原 `GLOBAL_OFFSET_A`**：`offset = nIdx × strideA0I + kIdx×8 + 8`（需要 `v0`, `v1` 等 tile 參數）
- **新 `GLOBAL_OFFSET_A_SWZ`**：`offset = lane × 16 + 8`（只依賴 `vgprSerial`）
- Prepad +8 與原版一致（SRD base 比實際資料起始位址提前 8 bytes）

### 3.2 Offset 初始化（global read addresses: final offsets a）

| | No-swizzle | Swizzle |
|--|-----------|---------|
| Macro 呼叫 | `GLOBAL_OFFSET_A vgprGlobalReadOffsetA+0, 1, 0, 12` | `GLOBAL_OFFSET_A_SWZ vgprGlobalReadOffsetA+0, 12` |
| ScalarGlobalReadOffsetA | `strideA0I × 0 + 16 = 16` | `0`（不需要第二段 scalar offset） |

### 3.3 主迴圈 A loads：2×`b64` → 1×`b128`

三處皆改：

| 位置 | No-swizzle（2 instructions） | Swizzle（1 instruction） |
|------|-----|-----|
| **Prefetch** | `buffer_load_b64 G2LA[0:1] ... null` + `buffer_load_b64 G2LA[2:3] ... ScalarOffsetA` | `buffer_load_b128 G2LA[0:3] ... null` |
| **Unroll 1/2** | `buffer_load_b64 G2LA2[0:1] ... null` + `buffer_load_b64 G2LA2[2:3] ... ScalarOffsetA` | `buffer_load_b128 G2LA2[0:3] ... null` |
| **Unroll 2/2** | `buffer_load_b64 G2LA[0:1] ... null` + `buffer_load_b64 G2LA[2:3] ... ScalarOffsetA` | `buffer_load_b128 G2LA[0:3] ... null` |

`buffer_load_b128` 的 little-endian dword 排列與兩次 `b64` 先填 `[0:1]` 再填 `[2:3]` 的結果一致。

### 3.4 `s_wait_loadcnt` 調整

每處 A load 從 2 筆減為 1 筆，outstanding load count 少 1：

| 位置 | 說明 | 原值 | 新值 |
|------|------|------|------|
| Prefetch 後 B 的 ds_store 前 | 等 B 到齊（outstanding: ~~2B+2A=4~~ → 2B+1A=3，wait 完 B 後剩 1A） | `2` | `1` |
| Unroll 1/2 B ds_store_b64 第 1 筆前 | outstanding: ~~2B+2A=4~~ → 2B+1A=3，wait 到剩 B1+A | `3` | `2` |
| Unroll 1/2 B ds_store_b64 第 2 筆前 | wait 到只剩 A | `2` | `1` |
| Unroll 2/2 B ds_store_b64 第 1 筆前 | 同 unroll 1/2 | `3` | `2` |
| Unroll 2/2 B ds_store_b64 第 2 筆前 | 同 unroll 1/2 | `2` | `1` |

### 3.5 Tail loop 第二批 A byte-reads

Tail 仍使用 `buffer_load_d16_u8` / `buffer_load_d16_hi_u8` 逐 byte load + pack（與 Tensile codegen 保持最大相容性）。

改動僅針對**第二段 8 bytes**（`G2LA+2`）的定址方式：

| | No-swizzle | Swizzle |
|--|-----------|---------|
| 第 1 段 (G2LA+0) | `null offen offset:0..7` | **不變** |
| 第 2 段 (G2LA+2) | `s[sgprScalarGlobalReadOffsetA] offen offset:0..7` | `null offen offset:8..15` |

- No-swizzle 時，第二段 8 bytes 在 `vgpr + ScalarOffset(16) + 0..7` 的位置
- Swizzle 後，16 bytes 連續，所以第二段就在 `vgpr + 8..15`（inst offset 直接給 8–15）

### 3.6 未改動（刻意保留）

- **B 的 loads**：仍為 2×`buffer_load_b64`（B 的 swizzle 不在本次範圍）
- **`v_wmma_f32_16x16x16_fp8_fp8` 的 register pair**：仍使用 `G2LA[+0:+1]` / `[+2:+3]`、`[+4:+5]` / `[+6:+7]`；`b128` 填入 `[+0:+3]` 後 WMMA 分兩次取 pair 與原 2×`b64` 等價
- **`GlobalReadIncsA`**：保持 `DepthU×BpeAGR = 32`。對目前測試 M=16, K=32 (numIter=1) 不影響；若 K > 32 需另案處理 slab-aligned increment (= 512)
- **SRD base / tileStart / ShadowLimitA**：計算邏輯不變。M=16, K=32 時 `ShadowLimitA = 520`，max accessed byte = `31×16+8+15 = 519 < 520` ✓

---

## 4. SRD limit 驗證

```
ShadowLimitA = 1 + strideAL×(sizeL-1) + strideA0I×(sizeI-1) - tileStart + 8 (prepad)
             = 1 + 1×31 + 32×15 - 0 + 8
             = 520

Lane 31 max byte = 31×16 + 8 + 15 = 519 < 520  ✓
```

---

## 5. 與 host / code object 的流程

1. **Host**：`tnSlabDoSwizzleF8`（custom scatter）產生每 lane 連續 16B 的 global buffer
2. **Assemble**：用更新後的 `.s` 產生 `.co`（`GLOBAL_OFFSET_A_SWZ` + `b128`）
3. **Config**：`program_config_gemm_swizzleA_rdna_tn_f8.ini` 必須設 `do-swizzle=1`
4. **驗證**：`run_swizzleA_tn_f8.sh` 執行並比對 CPU reference

> ⚠️ host `do-swizzle` flag 與 kernel 版本必須一致，否則結果錯誤。

---

## 6. 後續工作

- **K > 32（多 iteration）**：需確認 `GlobalReadIncsA` 改為 slab size (512) 而非 DepthU×Bpe (32)，以及 host swizzle 的 slab 切分是否與 kernel 的 tile iteration 對齊
- **Tail `b128` 化**：目前 tail 保留逐 byte load + pack 以維持通用性；若確認 swizzle 永遠保證連續性，可進一步簡化為 `buffer_load_b128` + `s_wait_loadcnt 0`
- **B 的 swizzle**：獨立議題，不在本次範圍

---

## 7. 相關檔案

| 檔案 | 說明 |
|------|------|
| `../TN_F8F8S_BH_UserArgs_MT16x16x32_DTVA.s` | Swizzle 版 kernel（本文對應） |
| `../../rdna4_no_swizzle/TN_F8F8S_BH_UserArgs_MT16x16x32_DTVA.s` | No-swizzle 版 kernel（對照基準） |
| `../../../src/SwizzleRdna4Common.hpp` | `tnSlabDoSwizzleF8`（host 端 custom scatter） |
| `../../../src/SwizzleAGemmRunnerRDNATN.hpp` | Runner（呼叫 swizzle、設定 SRD、發 kernel） |
| `../../../program_config_gemm_swizzleA_rdna_tn_f8.ini` | Swizzle 測試 config（`do-swizzle=1`） |

---

## 8. 版本備註

- 本說明對應 **RDNA4 gfx1201、DTVA、DirectToVgpr、MT16×16、DepthU=32、fp8 A（`hipblaslt_f8_fnuz`）** 此一 kernel 組態
- 測試尺寸：M=16, N=16, K=32（single iteration, single workgroup）
- 其他 tile size / 資料型別 / multi-WG 請勿直接套用
