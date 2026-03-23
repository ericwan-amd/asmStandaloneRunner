# NN doSwizzle: Coalesced A and Assembly Changes

## 1. Goal

- **doSwizzle** in `SwizzleAGemmRunnerRDNANN.hpp`: pre-shuffle A (M×K col-major) so that after the shuffle, **each lane reads a contiguous 8-element block** and **all lanes’ first 8 elements are stored contiguously** (lane 0, then lane 1, …), then the next 256 elements in the same lane order. That gives **coalesced** global memory access.
- **NN assembly** `NN_HHS_BH_UserArgs_MT16x16x32_DTVA.s`: when A is swizzled, use **GLOBAL_OFFSET_A_SWZ** so the kernel loads from the new layout (lane-order) correctly.

## 2. Swizzled layout (512 elements)

**Host A matrix** in `SwizzleAGemmRunnerRDNANN` is stored **column-major** with leading dimension **M=16**:

`linear = m + M*k` → column `k=0` holds rows `m=0..15` at indices `0..15`, column `k=1` at `16..31`, etc.

`SwizzleAGemmRunnerRDNANN::doSwizzle` fills a **16×32** tile in **row-major** order (`dst[r*32+c]`). Each cell’s **source** is `src[V]` where `V` is that element’s col-major linear index:

`V(r,c) = (r/4)*128 + (r%4)*4 + (c/8) + (c%8)*16`

So `dst[r*32+c] = src[V]` with **no** extra remap — `src` is already col-major.

This matches the spreadsheet layout (stride +16 along 8-wide groups, +4 down within a 4-row band, +128 every 4 rows, +1 per 8-column group).

- **Lane packing:** for M=16,K=32, this row-major order matches **32×8 + 32×8** lane-interleaved packing (`new[8*L+i]` / `new[256+8*L+i]`).

See also **NN_doSwizzle_A_layout_visualization.html** (older v0/v1 derivation; host now follows the explicit `V(r,c)` grid above).

**Why NN cannot use a generic reshape+permute:** The kernel’s (v0, v1) is not a simple L = 16\*k_hi + m. E.g. lane 0 reads A(m=0..7, k=0), lane 1 reads A(0..7, k=1), lane 8 reads A(8..15, k=8). A reshape+permute with L = 16\*k_hi + m would give lane 0 = A(0, 0..7), lane 1 = A(1, 0..7), which does not match. So NN doSwizzle must use the **explicit loop** with `nnLaneToV0V1` so that `new[8*L..8*L+7]` = original `[start_L..start_L+7]` with start_L = v0 + M\*v1.

## 3. Lane → (v0, v1) in NN kernel

The NN kernel computes:

- `start_L = v0(L) + M*v1(L)` (M=16)
- First load: bytes at `(start_L + 8)*2` (with prepad)
- Second load: same base + 256 elements → +512 bytes

`(v0, v1)` per lane in the NN assembly (single wave):

- **v0** = `bfe(lane, 3, 1) * 8` → 0 for lane 0..7, 16..23; 8 for 8..15, 24..31
- **v1** = `(lane/16)*8 + (lane%8)` → 0..7 for lane 0..7 and 8..15; 8..15 for lane 16..23 and 24..31 (matches .s: v4 = v1/16; v4*=8; v1 = (v1&7)+v4)

`doSwizzle` uses the same mapping so that **original** `[start_L .. start_L+7]` and `[start_L+256 .. start_L+263]` are copied to **new** `[L*8 .. L*8+7]` and `[256+L*8 .. 256+L*8+7]`.

## 4. Host: enable doSwizzle

In `SwizzleAGemmRunnerRDNANN::SetupKernelArgs`:

1. **Uncomment**  
   `doSwizzle(tensorA_h, swizzledA_h);`
2. **Switch copy to device** to swizzled:  
   Use  
   `hipMemcpy(inputA_d.data(), swizzledA_h.as<void>(), swizzledA_h.getNumBytes(), hipMemcpyHostToDevice);`  
   and comment out the copy from `tensorA_h`.

CPU reference still uses non-swizzled `tensorA_h` (and same `inputA_h` fill), so validation remains correct.

## 5. Assembly: use SWZ path when A is swizzled

In `NN_HHS_BH_UserArgs_MT16x16x32_DTVA.s`:

- **Swizzled A (default):** use `GLOBAL_OFFSET_A_SWZ vgprGlobalReadOffsetA+0, 20` and **`s_mov_b32 s[sgprGlobalReadIncsA+0], 0`** so the A base is never advanced (swizzled A is one 512-element buffer).
- **Non-swizzled A:** comment out the SWZ line and the `s_mov_b32 ... 0` line, and uncomment the two `GLOBAL_OFFSET_A` lines.

Effect:

- **v8** = `16*(lane+1)` bytes (first load: lane’s first 8 elements in new buffer, with prepad).
- **v9** = `v8 + 512` bytes (second load: lane’s next 8 elements in new buffer).

So both `global_load_tr_b128` (v8 and v9) read from the coalesced, lane-ordered layout.

## 6. global_load_tr_b128 vs buffer_load_b128 for A

- **global_load_tr_b128** (current): uses flat/global address from `s[sgprSrdA:sgprSrdA+1]` (2 SGPRs) + VGPR offset. The `_tr` variant distributes the 128-bit load across threads.
- **buffer_load_b128**: uses a buffer resource from `s[sgprSrdX:sgprSrdX+3]` (4 SGPRs), like B.

**Can A use buffer_load_b128?** Yes: (1) host passes A as a buffer resource (or kernel builds a 4-SGPR descriptor), (2) set sgprSrdA to that descriptor, (3) use `buffer_load_b128 v[vgprG2LA+...], v[vgprGlobalReadOffsetA+...], s[sgprSrdA:sgprSrdA+3], null offen offset:0`. The same v8/v9 offsets work for the swizzled layout.

## 7. Summary

| Component | No doSwizzle | With doSwizzle (coalesced) |
|-----------|----------------|-----------------------------|
| Host A to device | `tensorA_h` (col-major) | `swizzledA_h` (lane-order) |
| Assembly A offsets | `GLOBAL_OFFSET_A` ×2 (v6,v18 and v6,v19) | `GLOBAL_OFFSET_A_SWZ` (v8=16*(lane+1), v9=v8+512) |

Assembly is currently set to the SWZ path (doSwizzle). To disable, comment `GLOBAL_OFFSET_A_SWZ` and uncomment the two `GLOBAL_OFFSET_A` lines.
