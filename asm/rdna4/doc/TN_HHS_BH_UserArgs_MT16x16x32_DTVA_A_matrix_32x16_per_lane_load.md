# Where Each Lane Loads in the A Matrix (32×16, Transpose, Row-Major)

For **TN_HHS_BH_UserArgs_MT16x16x32_DTVA.s**, A is a **32×16** matrix stored **row-major** (transpose from the GEMM perspective). This document maps each of the **32 lanes** to the **(row, col)** region of A that lane loads with the **first** `buffer_load_b128` (v22..v25). The second load uses the same lane mapping with a fixed scalar offset (next 16 elements).

---

## Assumptions

- **A dimensions:** 32 rows × 16 columns (row index 0..31, column index 0..15).
- **Storage:** row-major → linear index = **row × 16 + col** (0-based).
- **strideA0I = 16** (elements per row).
- **Per-lane offset (elements):** `start[L] = v1[L] + strideA0I × v0[L] = L + 16×(L % 16)`.
- **Per lane:** 8 consecutive fp16 from that start → indices **start[L] .. start[L]+7**.

---

## Per-lane load map (first buffer_load_b128)

Each lane loads **8 consecutive elements** in linear (row-major) order. Below: 0-based (row, col); 1-based linear index matches your grid (1..512).

| Lane L | v0 (L%16) | v1 (L) | Start (elem) | Linear indices | (Row, Col) — 0-based | Description |
|--------|------------|--------|--------------|----------------|----------------------|-------------|
| 0  | 0  | 0  | 0   | 0..7    | (0,0)..(0,7)   | Row 0, cols 0–7 (first half of row 0) |
| 1  | 1  | 1  | 17  | 17..24  | (1,1)..(1,8)   | Row 1, cols 1–8 |
| 2  | 2  | 2  | 34  | 34..41  | (2,2)..(2,9)   | Row 2, cols 2–9 |
| 3  | 3  | 3  | 51  | 51..58  | (3,3)..(3,10)  | Row 3, cols 3–10 |
| 4  | 4  | 4  | 68  | 68..75  | (4,4)..(4,11)  | Row 4, cols 4–11 |
| 5  | 5  | 5  | 85  | 85..92  | (5,5)..(5,12)  | Row 5, cols 5–12 |
| 6  | 6  | 6  | 102 | 102..109| (6,6)..(6,13)  | Row 6, cols 6–13 |
| 7  | 7  | 7  | 119 | 119..126| (7,7)..(7,14)  | Row 7, cols 7–14 |
| 8  | 8  | 8  | 136 | 136..143| (8,8)..(8,15)  | Row 8, cols 8–15 (second half of row 8) |
| 9  | 9  | 9  | 153 | 153..160| (9,9)..(9,15),(10,0) | Row 9 cols 9–15 + row 10 col 0 |
| 10 | 10 | 10 | 170 | 170..177| (10,10)..(10,15),(11,0)..(11,1) | Straddles row 10/11 |
| 11 | 11 | 11 | 187 | 187..194| (11,11)..(11,15),(12,0)..(12,2) | Straddles row 11/12 |
| 12 | 12 | 12 | 204 | 204..211| (12,12)..(12,15),(13,0)..(13,3) | Straddles row 12/13 |
| 13 | 13 | 13 | 221 | 221..228| (13,13)..(13,15),(14,0)..(14,3) | Straddles row 13/14 |
| 14 | 14 | 14 | 238 | 238..245| (14,14)..(14,15),(15,0)..(15,4) | Straddles row 14/15 |
| 15 | 15 | 15 | 255 | 255..262| (15,15),(16,0)..(16,6) | Row 15 col 15 + row 16 cols 0–6 |
| 16 | 0  | 16 | 16  | 16..23  | (1,0)..(1,7)   | Row 1, cols 0–7 (first half of row 1) |
| 17 | 1  | 17 | 33  | 33..40  | (2,1)..(2,8)   | Row 2, cols 1–8 |
| 18 | 2  | 18 | 50  | 50..57  | (3,2)..(3,9)   | Row 3, cols 2–9 |
| 19 | 3  | 19 | 67  | 67..74  | (4,3)..(4,10)  | Row 4, cols 3–10 |
| 20 | 4  | 20 | 84  | 84..91  | (5,4)..(5,11)  | Row 5, cols 4–11 |
| 21 | 5  | 21 | 101 | 101..108| (6,5)..(6,12)  | Row 6, cols 5–12 |
| 22 | 6  | 22 | 118 | 118..125| (7,6)..(7,13)  | Row 7, cols 6–13 |
| 23 | 7  | 23 | 135 | 135..142| (8,7)..(8,14)  | Row 8, cols 7–14 |
| 24 | 8  | 24 | 152 | 152..159| (9,8)..(9,15),(10,0) | Row 9 cols 8–15 + row 10 col 0 |
| 25 | 9  | 25 | 169 | 169..176| (10,9)..(10,15),(11,0)..(11,1) | Straddles row 10/11 |
| 26 | 10 | 26 | 186 | 186..193| (11,10)..(11,15),(12,0)..(12,2) | Straddles row 11/12 |
| 27 | 11 | 27 | 203 | 203..210| (12,11)..(12,15),(13,0)..(13,3) | Straddles row 12/13 |
| 28 | 12 | 28 | 220 | 220..227| (13,12)..(13,15),(14,0)..(14,3) | Straddles row 13/14 |
| 29 | 13 | 29 | 237 | 237..244| (14,13)..(14,15),(15,0)..(15,4) | Straddles row 14/15 |
| 30 | 14 | 30 | 254 | 254..261| (15,14),(15,15),(16,0)..(16,5) | Straddles row 15/16 |
| 31 | 15 | 31 | 271 | 271..278| (16,15),(17,0)..(17,6) | Row 16 col 15 + row 17 cols 0–6 |

---

## Pattern summary

- **Lanes 0–15:** Start index = **L + 16×L = 17×L** (0, 17, 34, …, 255). So lane L (0..15) reads a **diagonal band**: row L, cols L..L+7 (when L+7 ≤ 15), or that band plus the start of the next row when it crosses the column boundary (e.g. lanes 9–15).
- **Lanes 16–31:** Start index = **L + 16×0 = L** (16, 17, …, 31). So lane 16 reads row 1 cols 0–7; lane 17 row 2 cols 1–8; …; lane 31 reads row 16 col 15 and row 17 cols 0–6.

So:

- **Columns 0–7 (first half of each row):** Loaded by lane 0 (row 0), lane 16 (row 1), lane 17 (row 2, offset by 1), … — i.e. a mix of lanes 0 and 16–23 (and straddles).
- **Columns 8–15 (second half of each row):** Loaded by lanes 1–8 (rows 1–8), then lanes 9–15 and 24–31 with straddles.

Your image’s **yellow/orange (cols 1–8)** and **blue/green (cols 9–16)** match this: the first 8 columns are the “first half” of rows and the next 8 columns the “second half,” with each lane contributing one 8-element segment (possibly straddling two rows) in row-major order.

---

## Second buffer_load_b128 (v26..v29)

The second load uses the **same** per-lane offset **v8[L]** plus a **scalar** add: `sgprScalarGlobalReadOffsetA` = 16 elements (32 bytes). So each lane loads the **next** 8 elements in row-major order after the first 8:

- Lane 0: indices **8..15** → row 0, cols 8–15.
- Lane 1: indices **25..32** → row 1, col 9 through row 2, col 0.
- … and so on for all 32 lanes.

Together, the two loads cover **16 fp16 per lane** (32×16 = 512 elements across the wave), matching the 32×16 A tile used for the WMMA pipeline.

---

## 1-based linear index (to match your grid)

If the grid uses 1-based linear index (1..512):

- **Linear index** = row×16 + col + 1.
- So (row 0, col 0) = 1, (row 0, col 15) = 16, (row 1, col 0) = 17, …, (row 31, col 15) = 512.

Then for each lane, add 1 to the 0-based linear indices above to get the 1-based numbers in your picture (e.g. lane 0 loads 1..8, lane 16 loads 17..24).
