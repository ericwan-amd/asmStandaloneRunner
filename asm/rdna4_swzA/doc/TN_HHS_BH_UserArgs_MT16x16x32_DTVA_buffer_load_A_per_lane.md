# buffer_load_b128 for A Matrix — Per-Lane Behavior

This note explains how each **buffer_load_b128** for the A matrix works **per lane** in `TN_HHS_BH_UserArgs_MT16x16x32_DTVA.s`.

---

## 1. The two loads

```text
buffer_load_b128 v[vgprG2LA+0:vgprG2LA+0+3], v[vgprGlobalReadOffsetA+0], s[sgprSrdA:sgprSrdA+3], null offen offset:0   // G -> Reg 0_0_0_0
buffer_load_b128 v[vgprG2LA+4:vgprG2LA+4+3], v[vgprGlobalReadOffsetA+0], s[sgprSrdA:sgprSrdA+3], s[sgprScalarGlobalReadOffsetA+0] offen offset:0 // G -> Reg 1_0_0_0
```

- **First load:** 4 VGPRs `v22..v25` (vgprG2LA+0..3). Per-lane offset from **v8** only (`null` scalar).
- **Second load:** 4 VGPRs `v26..v29` (vgprG2LA+4..7). Per-lane offset = **v8 + sgprScalarGlobalReadOffsetA** (same v8, plus a **scalar** add).

So for each lane you get **two** 128-bit (8 fp16) reads; the only difference is the scalar offset on the second.

Below we focus on **one** of these loads (e.g. the first) and “the 4 VGPRs” (v22..v25).

---

## 2. What buffer_load_b128 does per lane

- **Per lane:** the instruction loads **128 bits (16 bytes) = 4 × 32-bit = 8 × fp16** from the A buffer.
- **Address for lane L:**  
  `base_A + v[vgprGlobalReadOffsetA](L) + scalar_offset`  
  (in bytes). For the first load, `scalar_offset = 0`; for the second, `scalar_offset = sgprScalarGlobalReadOffsetA` (in bytes).
- **Destination:** the 4 consecutive VGPRs (e.g. v22, v23, v24, v25). For lane L, the 4 DWORDs are written into **v22[L], v23[L], v24[L], v25[L]**.

So **per lane**:

- 4 DWORDs are loaded from one contiguous 16-byte region.
- They are placed in order into the four registers for that lane:

| Bytes (in memory order) | DWORD        | VGPR   | Half (in register) |
|-------------------------|-------------|--------|---------------------|
| 0–3                     | 1st DWORD   | v22[L] | [15:0], [31:16]     |
| 4–7                     | 2nd DWORD   | v23[L] | [15:0], [31:16]     |
| 8–11                    | 3rd DWORD   | v24[L] | [15:0], [31:16]     |
| 12–15                   | 4th DWORD   | v25[L] | [15:0], [31:16]     |

So the **8 fp16** in memory order map to the 8 half-words in order:

- 1st fp16 → v22.[15:0], 2nd → v22.[31:16], 3rd → v23.[15:0], 4th → v23.[31:16],  
  5th → v24.[15:0], 6th → v24.[31:16], 7th → v25.[15:0], 8th → v25.[31:16].

**Summary:** For lane L, one **buffer_load_b128** reads **8 consecutive fp16** from `base_A + v8[L] (+ optional scalar)` and packs them into the four VGPRs for that lane as above.

---

## 3. Per-lane byte offset v8 = v[vgprGlobalReadOffsetA]

`vgprGlobalReadOffsetA` is **v8**. It is computed by **GLOBAL_OFFSET_A** (macro around 308–313):

```text
GLOBAL_OFFSET_A vgprGlobalReadOffsetA+0,  1,  0, 12   // gROA_0_0_0_0
```

Macro (this file’s parameter order): `GLOBAL_OFFSET_A vgprAddr, vgprOffsetL, vgprOffset0I, vgprTmp`:

- `element_offset = v[vgprOffsetL] + s[sgprStrideA0I] * v[vgprOffset0I]`  
  → **element_offset = v1 + strideA0I * v0**
- Then: add 8, then multiply by 2 (bytes per element) → **byte_offset** written to `v[vgprAddr]` (v8).

So for each lane L:

- **v0[L], v1[L]** come from the tile/lane assignment (see below).
- **v8[L] = (v1[L] + strideA0I * v0[L] + 8) * 2** (bytes).

So **each lane has its own byte offset** into the A buffer; the load is “per-lane” in both offset and destination.

---

## 4. Where v0 and v1 come from (tile assignment)

From the “TileAssignment for DirectToVgprA” block (around 479–484):

- **v1 = v[vgprSerial] & 31** → lane id in the wave: **0..31**.
- **v0 = v1 & 15** → **lane % 16** (0..15).

So:

- **v0[L] = L % 16** (used as row / first index in the offset).
- **v1[L] = L** (lane id).

Thus:

- **element_offset[L] = L + strideA0I * (L % 16)** (in elements).
- **byte_offset[L] = (element_offset[L] + 8) * 2**.

`sgprStrideA0I` is the A-matrix stride in the “0I” (first) dimension (from kernel args). So each lane’s offset is determined by its lane index and that stride.

---

## 5. Concretely: what each lane loads (first load, v22..v25)

- **Lane L** has:
  - **v0 = L % 16**, **v1 = L**.
  - **Byte offset**  
    `v8[L] = (L + strideA0I * (L % 16) + 8) * 2`.
- From the buffer at **base_A + v8[L]** it loads **16 bytes = 8 consecutive fp16**.
- Those 8 fp16 are written in order into the four VGPRs for lane L as in the table in section 2:
  - 1st fp16 → v22.[15:0], 2nd → v22.[31:16], …, 8th → v25.[31:16].

So **conceptually**, each lane reads one “slice” of 8 consecutive fp16 from the global A buffer at a lane-dependent offset. The **exact** mapping from (lane, register, half) to logical A[row][col] is the **RDNA4 WMMA A-matrix layout** (see `TN_HHS_BH_UserArgs_MT16x16x32_DTVA_A_matrix_layout.md`). The kernel’s choice of **strideA0I** and the **scalar offset** for the second load is what makes this pattern of 32 per-lane reads (and the second set of 32) fill the 16×16 A tile in the layout expected by **v_wmma_f32_16x16x16_f16**.

---

## 6. Short summary table (first load)

| Lane L | v0 (L%16) | v1 (L) | Element offset (example stride 16) | Loads 8 fp16 from A at…     | Into (this lane)      |
|--------|------------|--------|------------------------------------|-----------------------------|------------------------|
| 0      | 0          | 0      | 0 + 0 = 0                          | A base + 0                  | v22,v23,v24,v25 [15:0]/[31:16] |
| 1      | 1          | 1      | 1 + 16 = 17                        | A base + 17 elements        | v22..v25               |
| …      | …          | …      | …                                  | …                           | …                      |
| 15     | 15         | 15     | 15 + 240 = 255                     | A base + 255 elements       | v22..v25               |
| 16     | 0          | 16     | 16 + 0 = 16                        | A base + 16 elements        | v22..v25               |
| …      | …          | …      | …                                  | …                           | …                      |
| 31     | 15         | 31     | 31 + 240 = 271                     | A base + 271 elements       | v22..v25               |

(Exact element offsets depend on **strideA0I**; the formula is always **v1 + strideA0I * v0**.)

So: **each lane** gets **one 128-bit load** from a **lane-specific** byte offset, and that 128 bits is exactly the 4 DWORDs (8 fp16) written into **v22, v23, v24, v25** for that lane, in the order described above.
