# Exact A-Matrix Layout Before WMMA — TN_HHS_BH_UserArgs_MT16x16x32_DTVA.s

This document describes how the **16×16 fp16 A matrix** is laid out in VGPRs **immediately before** each `v_wmma_f32_16x16x16_f16` in the kernel. The layout is the **RDNA4 v_wmma_f32_16x16x16_f16 A-matrix** layout; the kernel simply uses different VGPR indices (vgprG2LA) for the same logical layout.

---

## 1. Kernel VGPR assignment (from .s)

From the assembly (lines 200–216):

- `vgprBase = 12`
- `vgprG2LA_BASE = vgprBase+10 = 22`
- `vgprG2LA = vgprG2LA_BASE+0 = 22`
- `vgprG2LA2 = vgprG2LA_BASE+8 = 30`

So:

| Logical A operand in ISA | Kernel VGPRs | Usage in kernel |
|--------------------------|--------------|------------------|
| v0, v1, v2, v3           | **v22, v23, v24, v25** | First A block  (e.g. `v[vgprG2LA+0:vgprG2LA+0+3]`) |
| next 4                   | **v26, v27, v28, v29** | Second A block (`v[vgprG2LA+4:vgprG2LA+4+3]`)     |
| next 4                   | **v30, v31, v32, v33** | (`vgprG2LA+8`)  |
| next 4                   | **v34, v35, v36, v37** | (`vgprG2LA+12`) |

Each **block of 4 VGPRs** holds one full 16×16 A matrix in RDNA4 WMMA layout (32 lanes × 4 regs × 2 fp16 per lane = 256 fp16 = 16×16).

---

## 2. How A is loaded (before WMMA)

- **Loads:** Two `buffer_load_b128` per tile:
  - `v[vgprG2LA+0:vgprG2LA+0+3]` ← base offset 0 (**G → Reg 0_0_0_0**)
  - `v[vgprG2LA+4:vgprG2LA+4+3]` ← base + `sgprScalarGlobalReadOffsetA` (**G → Reg 1_0_0_0**)
- **No LDS for A:** This kernel is “DirectToVgpr” for A (no local memory); the same VGPRs are used directly as the A operand of WMMA.
- **First WMMA** (e.g. line 1547) uses **v22,v23,v24,v25** as the A input.

So “A matrix layout before WMMA” is exactly the layout in **v22..v25** (and similarly v26..v29, etc.) as defined below.

---

## 3. Exact A[M][K] → (VGPR, lane, half) mapping

Logical matrix: **A[M][K]** with **M = row, K = column**, both 0..15.

In the kernel the first A block is **v22, v23, v24, v25** (replacing ISA v0..v3). So:

- **v22** ↔ ISA v0  
- **v23** ↔ ISA v1  
- **v24** ↔ ISA v2  
- **v25** ↔ ISA v3  

RDNA4 layout (one 16×16 per block):

**A[M][K] is stored in:**

| K= | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 |
|----|----|----|----|----|----|----|----|----|----|-----|-----|-----|-----|-----|-----|-----|
| **Register (kernel)** | v22 | v22 | v23 | v23 | v22 | v22 | v23 | v23 | v24 | v24 | v25 | v25 | v24 | v24 | v25 | v25 |
| **Half**            | [15:0] | [31:16] | [15:0] | [31:16] | [15:0] | [31:16] | [15:0] | [31:16] | [15:0] | [31:16] | [15:0] | [31:16] | [15:0] | [31:16] | [15:0] | [31:16] |
| **Lane**            | M | M | M | M | M+16 | M+16 | M+16 | M+16 | M | M | M | M | M+16 | M+16 | M+16 | M+16 |

So:

- **K 0–3:**  v22.[15:0], v22.[31:16], v23.[15:0], v23.[31:16] in **lane M**
- **K 4–7:**  v22.[15:0], v22.[31:16], v23.[15:0], v23.[31:16] in **lane M+16**
- **K 8–11:** v24.[15:0], v24.[31:16], v25.[15:0], v25.[31:16] in **lane M**
- **K 12–15:** v24.[15:0], v24.[31:16], v25.[15:0], v25.[31:16] in **lane M+16**

---

## 4. Lane → which A elements (element layout)

Per lane, the same 4 VGPRs (v22..v25) hold 8 fp16 elements:

| Lane | v22.[15:0] | v22.[31:16] | v23.[15:0] | v23.[31:16] | v24.[15:0] | v24.[31:16] | v25.[15:0] | v25.[31:16] |
|------|------------|-------------|------------|-------------|------------|-------------|------------|-------------|
| 0..15  | A[M][0] | A[M][1] | A[M][2] | A[M][3] | A[M][8]  | A[M][9]  | A[M][10] | A[M][11] |
| 16..31 | A[M][4] | A[M][5] | A[M][6] | A[M][7] | A[M][12] | A[M][13] | A[M][14] | A[M][15] |

With **M = lane** for lanes 0–15 and **M = lane − 16** for lanes 16–31.

So:

- **Lanes 0–15:**  row M = lane; columns 0,1,2,3 in v22/v23 and 8,9,10,11 in v24/v25.
- **Lanes 16–31:** row M = lane−16; columns 4,5,6,7 in v22/v23 and 12,13,14,15 in v24/v25.

---

## 5. Summary

- **Before the first WMMA:** the 16×16 A tile is entirely in **v22, v23, v24, v25** (one 32-bit value per lane per VGPR; each 32-bit = two fp16: [15:0] and [31:16]).
- **Layout:** RDNA4 `v_wmma_f32_16x16x16_f16` A-matrix layout, with kernel VGPRs v22..v25 playing the role of ISA v0..v3.
- **K dimension** is grouped as (0–3), (4–7), (8–11), (12–15); within each group the low/high 16 bits of v22,v23 (or v24,v25) and lane vs lane+16 give the two K halves.
- **M dimension** is lane id for lanes 0–15, and lane−16 for lanes 16–31.

This is the exact A matrix layout in registers immediately before each WMMA in `TN_HHS_BH_UserArgs_MT16x16x32_DTVA.s`.
