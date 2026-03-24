# doSwizzle 時 A 的 Global Load 要改兩處

Kernel 結果錯通常是因為：**做完 doSwizzle 後只改了第二筆 b128 的 scalar offset，沒有改第一筆的 per-lane offset**。

---

## 1. 為什麼會錯？

- **沒 doSwizzle**：A 在 memory 是 16×32 row-major，linear = row×32+col。  
  - 目前 `GLOBAL_OFFSET_A` 算出的 per-lane offset 是給這種 layout 用的：  
    element = (lane/16)×8 + 32×(lane%16)，再 +8 prepad、×2 成 bytes。
  - 第二筆 b128 的 scalar = 16 elements = 32 bytes。

- **有 doSwizzle**：同一 512 個 element 被 permute 成新 linear。  
  - 在 swizzled buffer 裡，**lane L 的「第一筆 8 個」邏輯 element 會在新 linear 的 8×L .. 8×L+7**（連續）。
  - 所以第一筆的 **byte offset 應該是 16×(lane+1)**（含 prepad），而不是原本的 (v1+32×v0+8)×2。
  - 第二筆仍是「第一筆起點 + 一個 pre-shuffle chunk」：**+256 elements = 512 bytes**。

若只把 scalar 改成 512，per-lane 仍用舊公式，第一筆就會從錯的 linear 位置讀，kernel 結果就會錯。

---

## 2. Assembly 要改的兩處（swz 路徑）

在 `TN_HHS_BH_UserArgs_MT16x16x32_DTVA.s` 裡，**要跑 doSwizzle 的 A 時**請同時做下面兩組切換。

### 2.1 Per-lane offset（第一筆 b128 的 v8）

- **註解掉（不要用）：**  
  `GLOBAL_OFFSET_A vgprGlobalReadOffsetA+0,  1,  0, 12`
- **改成用（取消註解）：**  
  `GLOBAL_OFFSET_A_SWZ vgprGlobalReadOffsetA+0, 12`

這樣 v8 = 16×(lane+1) bytes，對應 swizzled 裡 lane L 的第一筆 8 個 element 在新 linear 8×L..8×L+7。

### 2.2 Scalar offset（第二筆 b128）

- **註解掉（不要用）：**  
  那三行 `s_mul_i32` / `s_add_u32` / `s_lshl_b32`（算出 32 bytes）
- **改成用（取消註解）：**  
  `s_mov_b32 s[sgprScalarGlobalReadOffsetA+0], 512  // swz: 256*2 bytes`

這樣第二筆 = 第一筆起點 + 512 bytes（一個 pre-shuffle chunk）。

---

## 3. 對照表

| 項目 | 沒 doSwizzle | 有 doSwizzle (swz) |
|------|----------------|---------------------|
| Per-lane (v8) | `GLOBAL_OFFSET_A ..., 1, 0, 12` | `GLOBAL_OFFSET_A_SWZ ..., 12` |
| Scalar (2nd b128) | 三行 → 32 bytes | `s_mov_b32 ..., 512` |

兩邊要一起切換，只改 scalar 會錯。
