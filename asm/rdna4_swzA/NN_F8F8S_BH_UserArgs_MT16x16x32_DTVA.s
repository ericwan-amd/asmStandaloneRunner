
/******************************************/
/* Begin Kernel                           */
/******************************************/
.amdgcn_target "amdgcn-amd-amdhsa--gfx1201"
.text
.protected Cijk_Ailk_Bljk_F8F8S_BH_UserArgs_MT16x16x32_MI16x16x1_SN_LDSB0_AFC0_AG0_AFEM1_AFEM1_ASEM1_CLR1_CADS0_DTLA0_DTLB0_DTVA1_DTVB0_DTVSM0_DPLB0_EPS0_ELFLR0_EMLLn1_FDSI0_GRPM1_GRVWA8_GRVWB8_GSUAMB_GLS0_ISA1201_IU1_K1_LDSTI0_LBSPPA0_LBSPPB128_LBSPPM0_LPA0_LPB8_LPM0_LRVW8_LWPMn1_MIAV1_MIWT1_1_MO40_MGRIPM1_NTn1_NTA0_NTB0_NTC0_NTD0_NTM0_NEPBS0_NLCA1_NLCB1_ONLL1_PGR1_PLR1_PKA0_SGROB0_SIA3_SS0_SPO0_SRVW0_SSO0_SVW8_SK0_SKFTR0_SKXCCM0_SGRO0_TIN0_TLDS1_TLDSMn1_ULSGRO0_USL1_UIOFGRO0_UPLRP0_USFGROn1_VSn1_VWA1_VWB1_WSGRA0_WSGRB0_WS32_WG16_2_1
.globl Cijk_Ailk_Bljk_F8F8S_BH_UserArgs_MT16x16x32_MI16x16x1_SN_LDSB0_AFC0_AG0_AFEM1_AFEM1_ASEM1_CLR1_CADS0_DTLA0_DTLB0_DTVA1_DTVB0_DTVSM0_DPLB0_EPS0_ELFLR0_EMLLn1_FDSI0_GRPM1_GRVWA8_GRVWB8_GSUAMB_GLS0_ISA1201_IU1_K1_LDSTI0_LBSPPA0_LBSPPB128_LBSPPM0_LPA0_LPB8_LPM0_LRVW8_LWPMn1_MIAV1_MIWT1_1_MO40_MGRIPM1_NTn1_NTA0_NTB0_NTC0_NTD0_NTM0_NEPBS0_NLCA1_NLCB1_ONLL1_PGR1_PLR1_PKA0_SGROB0_SIA3_SS0_SPO0_SRVW0_SSO0_SVW8_SK0_SKFTR0_SKXCCM0_SGRO0_TIN0_TLDS1_TLDSMn1_ULSGRO0_USL1_UIOFGRO0_UPLRP0_USFGROn1_VSn1_VWA1_VWB1_WSGRA0_WSGRB0_WS32_WG16_2_1
.p2align 8
.type Cijk_Ailk_Bljk_F8F8S_BH_UserArgs_MT16x16x32_MI16x16x1_SN_LDSB0_AFC0_AG0_AFEM1_AFEM1_ASEM1_CLR1_CADS0_DTLA0_DTLB0_DTVA1_DTVB0_DTVSM0_DPLB0_EPS0_ELFLR0_EMLLn1_FDSI0_GRPM1_GRVWA8_GRVWB8_GSUAMB_GLS0_ISA1201_IU1_K1_LDSTI0_LBSPPA0_LBSPPB128_LBSPPM0_LPA0_LPB8_LPM0_LRVW8_LWPMn1_MIAV1_MIWT1_1_MO40_MGRIPM1_NTn1_NTA0_NTB0_NTC0_NTD0_NTM0_NEPBS0_NLCA1_NLCB1_ONLL1_PGR1_PLR1_PKA0_SGROB0_SIA3_SS0_SPO0_SRVW0_SSO0_SVW8_SK0_SKFTR0_SKXCCM0_SGRO0_TIN0_TLDS1_TLDSMn1_ULSGRO0_USL1_UIOFGRO0_UPLRP0_USFGROn1_VSn1_VWA1_VWB1_WSGRA0_WSGRB0_WS32_WG16_2_1,@function
.section .rodata,#alloc
.p2align 6
.amdhsa_kernel Cijk_Ailk_Bljk_F8F8S_BH_UserArgs_MT16x16x32_MI16x16x1_SN_LDSB0_AFC0_AG0_AFEM1_AFEM1_ASEM1_CLR1_CADS0_DTLA0_DTLB0_DTVA1_DTVB0_DTVSM0_DPLB0_EPS0_ELFLR0_EMLLn1_FDSI0_GRPM1_GRVWA8_GRVWB8_GSUAMB_GLS0_ISA1201_IU1_K1_LDSTI0_LBSPPA0_LBSPPB128_LBSPPM0_LPA0_LPB8_LPM0_LRVW8_LWPMn1_MIAV1_MIWT1_1_MO40_MGRIPM1_NTn1_NTA0_NTB0_NTC0_NTD0_NTM0_NEPBS0_NLCA1_NLCB1_ONLL1_PGR1_PLR1_PKA0_SGROB0_SIA3_SS0_SPO0_SRVW0_SSO0_SVW8_SK0_SKFTR0_SKXCCM0_SGRO0_TIN0_TLDS1_TLDSMn1_ULSGRO0_USL1_UIOFGRO0_UPLRP0_USFGROn1_VSn1_VWA1_VWB1_WSGRA0_WSGRB0_WS32_WG16_2_1
  .amdhsa_user_sgpr_kernarg_segment_ptr 1
  .amdhsa_next_free_vgpr 48 // vgprs
  .amdhsa_next_free_sgpr 70 // sgprs
  .amdhsa_group_segment_fixed_size 1638 // lds bytes
  .amdhsa_wavefront_size32 1 // 32-thread wavefronts
  .amdhsa_private_segment_fixed_size 0
  .amdhsa_system_sgpr_workgroup_id_x 1
  .amdhsa_system_sgpr_workgroup_id_y 1
  .amdhsa_system_sgpr_workgroup_id_z 1
  .amdhsa_system_vgpr_workitem_id 0
  .amdhsa_float_denorm_mode_32 3
  .amdhsa_float_denorm_mode_16_64 3
.end_amdhsa_kernel
.text
/* Num VGPR   =48 */
/* Num AccVGPR=0 */
/* Num SGPR   =70 */

/******************************************/
/* Optimizations and Config:              */
/******************************************/
/* ThreadTile= 8 x 1 */
/* SubGroup= 2 x 16 */
/* VectorWidthA=1 */
/* VectorWidthB=1 */
/* GlobalReadVectorWidthA=8, GlobalReadVectorWidthB=8 */
/* DirectToLdsA=False */
/* DirectToLdsB=False */
/* UseSgprForGRO=False */
.amdgpu_metadata
---
custom.config:
  InternalSupportParams:
    KernArgsVersion: 2
amdhsa.version:
  - 1
  - 1
amdhsa.kernels:
  - .name: Cijk_Ailk_Bljk_F8F8S_BH_UserArgs_MT16x16x32_MI16x16x1_SN_LDSB0_AFC0_AG0_AFEM1_AFEM1_ASEM1_CLR1_CADS0_DTLA0_DTLB0_DTVA1_DTVB0_DTVSM0_DPLB0_EPS0_ELFLR0_EMLLn1_FDSI0_GRPM1_GRVWA8_GRVWB8_GSUAMB_GLS0_ISA1201_IU1_K1_LDSTI0_LBSPPA0_LBSPPB128_LBSPPM0_LPA0_LPB8_LPM0_LRVW8_LWPMn1_MIAV1_MIWT1_1_MO40_MGRIPM1_NTn1_NTA0_NTB0_NTC0_NTD0_NTM0_NEPBS0_NLCA1_NLCB1_ONLL1_PGR1_PLR1_PKA0_SGROB0_SIA3_SS0_SPO0_SRVW0_SSO0_SVW8_SK0_SKFTR0_SKXCCM0_SGRO0_TIN0_TLDS1_TLDSMn1_ULSGRO0_USL1_UIOFGRO0_UPLRP0_USFGROn1_VSn1_VWA1_VWB1_WSGRA0_WSGRB0_WS32_WG16_2_1
    .symbol: 'Cijk_Ailk_Bljk_F8F8S_BH_UserArgs_MT16x16x32_MI16x16x1_SN_LDSB0_AFC0_AG0_AFEM1_AFEM1_ASEM1_CLR1_CADS0_DTLA0_DTLB0_DTVA1_DTVB0_DTVSM0_DPLB0_EPS0_ELFLR0_EMLLn1_FDSI0_GRPM1_GRVWA8_GRVWB8_GSUAMB_GLS0_ISA1201_IU1_K1_LDSTI0_LBSPPA0_LBSPPB128_LBSPPM0_LPA0_LPB8_LPM0_LRVW8_LWPMn1_MIAV1_MIWT1_1_MO40_MGRIPM1_NTn1_NTA0_NTB0_NTC0_NTD0_NTM0_NEPBS0_NLCA1_NLCB1_ONLL1_PGR1_PLR1_PKA0_SGROB0_SIA3_SS0_SPO0_SRVW0_SSO0_SVW8_SK0_SKFTR0_SKXCCM0_SGRO0_TIN0_TLDS1_TLDSMn1_ULSGRO0_USL1_UIOFGRO0_UPLRP0_USFGROn1_VSn1_VWA1_VWB1_WSGRA0_WSGRB0_WS32_WG16_2_1.kd'
    .language:                   OpenCL C
    .language_version:
      - 2
      - 0
    .args:
      - .name:            Gemm info
        .size:            4
        .offset:          0
        .value_kind:      by_value
        .value_type:      u32
      - .name:            kernel info0
        .size:            4
        .offset:          4
        .value_kind:      by_value
        .value_type:      u32
      - .name:            kernel info1
        .size:            4
        .offset:          8
        .value_kind:      by_value
        .value_type:      u32
      - .name:            numWG
        .size:            4
        .offset:          12
        .value_kind:      by_value
        .value_type:      u32
      - .name:            SizesFree0
        .size:            4
        .offset:          16
        .value_kind:      by_value
        .value_type:      u32
      - .name:            SizesFree1
        .size:            4
        .offset:          20
        .value_kind:      by_value
        .value_type:      u32
      - .name:            SizesFree2
        .size:            4
        .offset:          24
        .value_kind:      by_value
        .value_type:      u32
      - .name:            SizesSum0
        .size:            4
        .offset:          28
        .value_kind:      by_value
        .value_type:      u32
      - .name:            D
        .size:            8
        .offset:          32
        .value_kind:      global_buffer
        .value_type:      fp8_fp8
        .address_space:   generic
      - .name:            C
        .size:            8
        .offset:          40
        .value_kind:      global_buffer
        .value_type:      fp8_fp8
        .address_space:   generic
      - .name:            A
        .size:            8
        .offset:          48
        .value_kind:      global_buffer
        .value_type:      fp8
        .address_space:   generic
      - .name:            B
        .size:            8
        .offset:          56
        .value_kind:      global_buffer
        .value_type:      fp8
        .address_space:   generic
      - .name:            strideD0
        .size:            4
        .offset:          64
        .value_kind:      by_value
        .value_type:      u32
      - .name:            strideD1
        .size:            4
        .offset:          68
        .value_kind:      by_value
        .value_type:      u32
      - .name:            strideC0
        .size:            4
        .offset:          72
        .value_kind:      by_value
        .value_type:      u32
      - .name:            strideC1
        .size:            4
        .offset:          76
        .value_kind:      by_value
        .value_type:      u32
      - .name:            strideA0
        .size:            4
        .offset:          80
        .value_kind:      by_value
        .value_type:      u32
      - .name:            strideA1
        .size:            4
        .offset:          84
        .value_kind:      by_value
        .value_type:      u32
      - .name:            strideB0
        .size:            4
        .offset:          88
        .value_kind:      by_value
        .value_type:      u32
      - .name:            strideB1
        .size:            4
        .offset:          92
        .value_kind:      by_value
        .value_type:      u32
      - .name:            alpha
        .size:            4
        .offset:          96
        .value_kind:      by_value
        .value_type:      f32
      - .name:            beta
        .size:            4
        .offset:          100
        .value_kind:      by_value
        .value_type:      f32
    .group_segment_fixed_size:   1638
    .kernarg_segment_align:      8
    .kernarg_segment_size:       104
    .max_flat_workgroup_size:    32
    .private_segment_fixed_size: 0
    .sgpr_count:                 70
    .sgpr_spill_count:           0
    .vgpr_count:                 48
    .vgpr_spill_count:           0
    .wavefront_size:             32
...
.end_amdgpu_metadata
Cijk_Ailk_Bljk_F8F8S_BH_UserArgs_MT16x16x32_MI16x16x1_SN_LDSB0_AFC0_AG0_AFEM1_AFEM1_ASEM1_CLR1_CADS0_DTLA0_DTLB0_DTVA1_DTVB0_DTVSM0_DPLB0_EPS0_ELFLR0_EMLLn1_FDSI0_GRPM1_GRVWA8_GRVWB8_GSUAMB_GLS0_ISA1201_IU1_K1_LDSTI0_LBSPPA0_LBSPPB128_LBSPPM0_LPA0_LPB8_LPM0_LRVW8_LWPMn1_MIAV1_MIWT1_1_MO40_MGRIPM1_NTn1_NTA0_NTB0_NTC0_NTD0_NTM0_NEPBS0_NLCA1_NLCB1_ONLL1_PGR1_PLR1_PKA0_SGROB0_SIA3_SS0_SPO0_SRVW0_SSO0_SVW8_SK0_SKFTR0_SKXCCM0_SGRO0_TIN0_TLDS1_TLDSMn1_ULSGRO0_USL1_UIOFGRO0_UPLRP0_USFGROn1_VSn1_VWA1_VWB1_WSGRA0_WSGRB0_WS32_WG16_2_1:
label_ASM_Start:  /// Main body of the asm kernel
.macro V_MAGIC_DIV vgprDstIdx:req, dividend:req, magicNumber:req, magicShift:req, magicA:req
    v_mul_hi_u32 v[\vgprDstIdx+1], \dividend, \magicNumber
    v_mul_lo_u32 v[\vgprDstIdx+0], \dividend, \magicA
    v_add_nc_u32 v[\vgprDstIdx+0], v[\vgprDstIdx+0], v[\vgprDstIdx+1]
    v_lshrrev_b32 v[\vgprDstIdx+0], \magicShift, v[\vgprDstIdx+0]
.endm

/******************************************/
/* VGPR Assignments                       */
/******************************************/
/* ValuC range: [0-8), serializedStore enabled */
.set vgprValuC, 0
/* ValuA/B   Xn=PLR buffer idx,  In=InnerUnroll idx */
.set vgprBase, 16
.set vgprLocalWriteAddrB, 12
.set vgprGlobalReadOffsetA, 8
.set vgprGlobalReadOffsetB, 10
.set vgprLocalReadAddrB, 13
.set vgprSerial, 34

/******************************************/
/* VGPR Macro Assignments                 */
/******************************************/
.set vgprValuB_X0_I0_BASE, vgprBase+1
.set vgprG2LA_BASE, vgprBase+6
.set vgprG2LB_BASE, vgprBase+14
.set vgprPackTemp, vgprBase+5
.set vgprValuB_X0_I0, vgprValuB_X0_I0_BASE+0
.set vgprValuB_X1_I0, vgprValuB_X0_I0_BASE+2
.set vgprG2LA, vgprG2LA_BASE+0
.set vgprG2LA2, vgprG2LA_BASE+4
.set vgprG2LB, vgprG2LB_BASE+0

/******************************************/
/* SGPR Assignments                       */
/******************************************/
.set sgprKernArgAddress, 0
.set sgprWorkGroup0, 2
.set sgprWorkGroup1, 3
.set sgprWorkGroup2, 4
.set sgprArgType, 5
.set sgprGSUSumIdx, 6
.set sgprGSULog2BpeC, 8
.set sgprGSULog2BpeD, 9
.set sgprStaggerU, 10
.set sgprWGM, 11
.set sgprLoopCounterL, 12
.set sgprOrigLoopCounter, 13
.set sgprSrdD, 16
.set sgprSrdC, 20
.set sgprNumWorkGroups0, 14
.set sgprNumWorkGroups1, 15
.set sgprSizesFree, 24
.set sgprSizesSum, 27
.set sgprAddressD, 28
.set sgprAddressC, 30
.set sgprAddressA, 32
.set sgprAddressB, 34
.set sgprStridesD, 36
.set sgprStridesC, 38
.set sgprStridesA, 40
.set sgprStridesB, 42
.set sgprAlpha, 44
.set sgprBeta, 45
.set sgprGSU, 46

/* Size Assignments */
.set sgprSizeI, sgprSizesFree+0
.set sgprSizeJ, sgprSizesFree+1
.set sgprSizeK, sgprSizesFree+2
.set sgprSizeL, sgprSizesSum+0

/* Stride Assignments */
.set constStrideD0I, 1
.set sgprStrideD1J, sgprStridesD+0
.set sgprStrideDK, sgprStridesD+1
.set constStrideC0I, 1
.set sgprStrideC1J, sgprStridesC+0
.set sgprStrideCK, sgprStridesC+1
.set constStrideA0I, 1
.set sgprStrideAL, sgprStridesA+0
.set sgprStrideAK, sgprStridesA+1
.set constStrideBL, 1
.set sgprStrideB1J, sgprStridesB+0
.set sgprStrideBK, sgprStridesB+1

.set MT0, 16
.set MT1, 16
.set DepthU, 32
.set BpeA, 1
.set BpeALog2, 0
.set BpeB, 1
.set BpeBLog2, 0
.set BpeAGR, 1
.set BpeAGRLog2, 0
.set BpeBGR, 1
.set BpeBGRLog2, 0
/* Number of elements to shift-left SRD */
.set SrdShiftLeftA, 8
.set SrdShiftLeftB, 8
/* 2GB limit - set offsets to -1 to exceed this and clamp */
.set BufferLimit, 0xffffffff
.set BufferOOB, 0x80000000

/******************************************/
/* Bits 127:96 of SRD.                    */
/* hex: 0x30020000                        */
/* dst_sel_x (3b): 0                      */
/* dst_sel_y (3b): 0                      */
/* dst_sel_z (3b): 0                      */
/* dst_sel_w (3b): 0                      */
/* format (7b): 32                        */
/* _unusedA (2b): 0                       */
/* index_stride (2b): 0                   */
/* add_tid_enable (1b): 0                 */
/* resource_level (1b): 0                 */
/* _unusedB (3b): 0                       */
/* oob_select (2b): 3                     */
/* type (2b): 0                           */
/******************************************/
.set Srd127_96, 0x30020000

/* Global Offset A */
.macro GLOBAL_OFFSET_A vgprAddr:req, vgprOffset0I:req, vgprOffsetL:req, vgprTmp:req
    v_mul_lo_u32 v[\vgprTmp+0], s[sgprStrideAL], v[\vgprOffsetL] // mul d1 lower
    v_add_co_u32 v[\vgprAddr+0], vcc_lo, v[\vgprOffset0I], v[\vgprTmp+0] // accumulate K lower
    v_add_nc_u32 v[\vgprAddr+0], 0x8, v[\vgprAddr+0]   // add prepad for pointer shift
                                                       // offset *= bytes/element (multiplier is 1, do nothing)
.endm

/* Global Offset B */
.macro GLOBAL_OFFSET_B vgprAddr:req, vgprOffsetL:req, vgprOffset1J:req, vgprTmp:req
    v_mul_lo_u32 v[\vgprTmp+0], s[sgprStrideB1J], v[\vgprOffset1J] // mul d1 lower
    v_add_co_u32 v[\vgprAddr+0], vcc_lo, v[\vgprOffsetL], v[\vgprTmp+0] // accumulate K lower
    v_add_nc_u32 v[\vgprAddr+0], 0x8, v[\vgprAddr+0]   // add prepad for pointer shift
                                                       // offset *= bytes/element (multiplier is 1, do nothing)
.endm

/******************************************/
/* Allocate Resources                     */
/******************************************/

/* Init workgroup id from ttmp */
s_mov_b32 s[sgprWorkGroup0], ttmp9
s_and_b32 s[sgprWorkGroup1], 0xffff, ttmp7
s_lshr_b32 s[sgprWorkGroup2], ttmp7, 0x10

/* Load num of Gemms */
s_load_b32 s20, s[sgprKernArgAddress:sgprKernArgAddress+1], 0

/* Load packed kernel args (StaggerU/GSU) */
s_load_b32 s22, s[sgprKernArgAddress:sgprKernArgAddress+1], 4

/* Load WGM data */
s_load_b32 s[sgprWGM], s[sgprKernArgAddress:sgprKernArgAddress+1], 8

/* Load num of WGs */
s_load_b32 s23, s[sgprKernArgAddress:sgprKernArgAddress+1], 12
s_wait_kmcnt 0                                     // load args
s_lshr_b32 s21, s20, 0x1e                          // Get arg type
s_and_b32 s20, 0x3fffffff, s20                     // Get nums of gemm
s_cmp_eq_u32 s21, 0                                // Is kernel args
s_cbranch_scc0 label_HBMArgs
s_add_u32 s[sgprKernArgAddress], s[sgprKernArgAddress], 0x10 // Shift common args
s_addc_u32 s[sgprKernArgAddress+1], s[sgprKernArgAddress+1], 0

/* Load Kernel Args */
s_load_b512 s[24:39], s[sgprKernArgAddress:sgprKernArgAddress+1], 0 // 0
s_load_b128 s[40:43], s[sgprKernArgAddress:sgprKernArgAddress+1], 64 // 64
s_load_b64 s[44:45], s[sgprKernArgAddress:sgprKernArgAddress+1], 80 // 80
s_branch label_LoadArgsEnd
label_HBMArgs:

/* Load address of kernel arguments */
s_load_b64 s[sgprKernArgAddress:sgprKernArgAddress+1], s[sgprKernArgAddress:sgprKernArgAddress+1], 16
s_wait_kmcnt 0                                     // wait for args to load
label_LoadArgsEnd:
s_and_b32 s[sgprStaggerU], s22, 0xffff0000         // Restore StaggerU related vars
s_lshr_b32 s[sgprStaggerU], s[sgprStaggerU], 0x10
s_and_b32 s[sgprGSU], s22, 0xffff                  // Restore GSUConfig and GSU
s_mov_b32 s[sgprArgType], s21
s_mov_b32 m0, 0x666                                // LDS clamp at 1638 bytes
v_mov_b32 v[vgprSerial], v0                        // thread serial id
s_mov_b32 vcc_hi, 0                                // Ensure hi bits are zero

/* remap workgroup to XCCs */
s_lshr_b32 s52, s[sgprWGM], 0x10                   // Get WGMXCC
s_ff1_i32_b32 s52, s52                             // Get log(WGMXCC)
s_lshr_b32 s53, s[sgprWGM], 0x16                   // Get CU_Count
/* remap WGs if WGMXCC > 1 ( log(WGMXCC) > 0 ) */
s_cmp_gt_i32 s52, 0
s_cbranch_scc0 label_skip_WGMXCC
/* only remap WGs in the range */
s_lshr_b32 s49, s23, s52
s_lshl_b32 s49, s49, s52
s_cmp_ge_u32 s[sgprWorkGroup0], s49
s_cbranch_scc1 label_skip_WGMXCC
s_cmp_eq_u32 s53, 0                                // CU_Count == 0 ?
s_cbranch_scc0 label_XCCG_nonzero
s_lshr_b32 s49, s[sgprWorkGroup0], s52
s_bfm_b32 s50, s52, 0
s_and_b32 s50, s[sgprWorkGroup0], s50
s_lshr_b32 s51, s23, s52
s_mul_i32 s50, s50, s51
s_add_u32 s[sgprWorkGroup0], s49, s50
s_branch label_skip_WGMXCC
label_XCCG_nonzero:
/* temp0 = (wg//CU_Count)*CU_Count */
v_cvt_f64_u32 v[16:17], s53                        // s49 = s[sgprWorkGroup0] / s53
v_rcp_f64 v[16:17], v[16:17]                       // s49 = s[sgprWorkGroup0] / s53
v_cvt_f64_u32 v[18:19], s[sgprWorkGroup0]          // s49 = s[sgprWorkGroup0] / s53
v_mul_f64 v[16:17], v[16:17], v[18:19]             // s49 = s[sgprWorkGroup0] / s53
v_cvt_u32_f64 v16, v[16:17]                        // s49 = s[sgprWorkGroup0] / s53
v_mul_lo_u32 v17, v16, s53                         // s49 = s[sgprWorkGroup0] / s53
v_sub_nc_u32 v18, s[sgprWorkGroup0], v17           // s49 = s[sgprWorkGroup0] / s53
v_cmp_ge_u32 vcc_lo, v18, s53                      // s49 = s[sgprWorkGroup0] / s53
s_mov_b32 exec_lo vcc_lo                           // s49 = s[sgprWorkGroup0] / s53
v_add_nc_u32 v16, v16, 1                           // s49 = s[sgprWorkGroup0] / s53
s_mov_b32 exec_lo, -1                              // Reset exec
v_mul_lo_u32 v17, v16, s53                         // s49 = s[sgprWorkGroup0] / s53
v_sub_nc_u32 v18, s[sgprWorkGroup0], v17           // s49 = s[sgprWorkGroup0] / s53
v_readfirstlane_b32 s49, v16                       // quotient
v_readfirstlane_b32 s50, v18                       // remainder
s_mul_i32 s49, s49, s53
/* temp1 = (wg%CU_Count)//WGMXCC */
s_lshr_b32 s50, s50, s52
/* temp0 = temp0 + temp1 */
s_add_u32 s49, s49, s50
/* temp1 = (wg%WGMXCC) * ((WGs - (WGs//CU_Count) * CU_Count) if (wg > (WGs//CU_Count) * CU_Count) else CU_Count)//WGMXCC */
v_cvt_f64_u32 v[16:17], s53                        // s50 = s23 / s53
v_rcp_f64 v[16:17], v[16:17]                       // s50 = s23 / s53
v_cvt_f64_u32 v[18:19], s23                        // s50 = s23 / s53
v_mul_f64 v[16:17], v[16:17], v[18:19]             // s50 = s23 / s53
v_cvt_u32_f64 v16, v[16:17]                        // s50 = s23 / s53
v_mul_lo_u32 v17, v16, s53                         // s50 = s23 / s53
v_sub_nc_u32 v18, s23, v17                         // s50 = s23 / s53
v_cmp_ge_u32 vcc_lo, v18, s53                      // s50 = s23 / s53
s_mov_b32 exec_lo vcc_lo                           // s50 = s23 / s53
v_add_nc_u32 v16, v16, 1                           // s50 = s23 / s53
s_mov_b32 exec_lo, -1                              // Reset exec
v_readfirstlane_b32 s50, v16                       // quotient
s_mul_i32 s50, s50, s53
s_sub_u32 s51, s23, s50
s_cmp_gt_u32 s[sgprWorkGroup0], s50
s_cselect_b32 s50, s51, s53
s_lshr_b32 s50, s50, s52
s_bfm_b32 s51, s52, 0
s_and_b32 s51, s[sgprWorkGroup0], s51
s_mul_i32 s50, s50, s51
/* WorkGroup0 = temp0 + temp1 */
s_add_u32 s[sgprWorkGroup0], s49, s50
label_skip_WGMXCC:  /// skip WGMXCC if no enough WGs to remap
s_cmp_eq_u32 s21, 0
s_cbranch_scc0 label_MultiGemm
/* init: add vgpr [16...38) to pool */
/* init: add vgpr [0...8) to pool */
/* init: add agpr [0...0) to pool */

/******************************************/
/* Local Read Addresses                   */
/******************************************/

/* local read addresses: tile assignments a/b */
/* lr1J */
v_and_b32 v1, 31, v[vgprSerial]                    // 0. thread id in wave: wtid = tid % wavelength(32)
v_and_b32 v0, 15, v1                               // 1. N offset: nIdx = wtid % MI_N(16)
v_lshlrev_b32 v0, 5, v0                            // 1. N offset: nOffset = nIdx * nStride(32)
/* Skip. 2. block offset: bnOffset = 0 when num1DBlocks = 1 */
                                                   // 4. apply VectorWidth: bnOffset = bnOffset * vw(1) (multiplier is 1, do nothing)
v_lshrrev_b32 v1, 4, v1                            // 5. K offset: kIdx = wtid / (MIN(16) * MIBB(1))
v_lshl_add_u32 v0, v1, 3, v0                       // 5. K offset: lrKOffset = kIdx * mStride(8); 6. offset in wave: lrOffset = bnOffset + lrKOffset

/* local read addresses: final offsets a */

/* local read addresses: final offsets b */
v_lshrrev_b32 v1, 5, v[vgprSerial]                 // 1 = Serial / 32
v_lshrrev_b32 v1, 0, v1                            // LSU offset: Get LSU wave_id
s_mov_b32 s16, 32                                  // LSU offset: stride = lsuStride(32) when umlds==True
v_mul_lo_u32 v1, s16, v1                           // LSU offset: lsuoffset = wave_id*lsuStride*(MT1+PAD)
v_add_nc_u32 v[vgprLocalReadAddrB], v1, v0         // Final Offset: offset = (lro1+lsuoffset)*bpeDS(1)
v_lshrrev_b32 v2, 7, v[vgprLocalReadAddrB]         // Final Offset: padding 8 per block 128
v_lshl_add_u32 v[vgprLocalReadAddrB], v2, 3, v[vgprLocalReadAddrB] // Final Offset: padding 8 per block 128

/* local read addresses: declare addresses a */
/* N/A */

/* local read addresses: declare addresses b */

/******************************************/
/* Local Write Addresses                  */
/******************************************/
/* LVCA = 2 */
/* v1 = A-unroll = serial%LVCA */
/* TileAssignment for DirectToVgprA and GLTrA */
v_lshrrev_b32 v0, 5, v[vgprSerial]                 // 0 = Serial / 32
v_and_b32 v1, 31, v[vgprSerial]                    // 1 = Serial % 32
v_lshrrev_b32 v4, 3, v1                            // GLTrA: v4 = v1 / 8
v_lshlrev_b32 v4, 2, v4                            // GLTrA: v4 = v4 * 4
v_and_b32 v1, 3, v1                                // GLTrA: v4 = v1 % 4
v_add_nc_u32 v1, v4, v1                            // GLTrA: v1 = v1 + v4
v_and_b32 v0, 0x0, v0                              // GLTrA: wave_id (along_M) %= MIWG[0]
v_mul_u32_u24 v0, 2, v0                            // GLTrA: wave_id (along_M) *= numKr
v_bfe_u32 v4, v[vgprSerial], 2, 1                  // GLTrA: offset for the right half of the tile
v_add_nc_u32 v0, v4, v0                            // GLTrA: wave_id += offset for the right half of the tile
/* tile *= glvw */
v_lshlrev_b32 v0, 3, v0                            // v0 = v0 * 8
v_mov_b32 v4, v1                                   // copy for GlobalSplitU
/* LVCB = 4 */
/* v3 = B-unroll = serial%LVCB */
v_lshrrev_b32 v2, 2, v[vgprSerial]                 // 2 = Serial / 4
v_and_b32 v3, 3, v[vgprSerial]                     // 3 = Serial % 4
/* unroll *= glvw */
v_lshlrev_b32 v3, 3, v3                            // v3 = v3 * 8
v_mov_b32 v5, v3                                   // copy for GlobalSplitU
/* lwaUnrollAssignmentA = v4 */
/* lwaUnrollAssignmentB = v5 */

/* local write addresses: first offset a */

/* local write addresses: first offset b */
v_mul_u32_u24 v[vgprLocalWriteAddrB], 0x20, v2     // lwBL**(DepthU_Compute + PAD)
v_add_nc_u32 v[vgprLocalWriteAddrB], v5, v[vgprLocalWriteAddrB] // lwFOB = (lwBB + lwBL*(DepthU+PAD))*bpeDS(1)
v_lshrrev_b32 v6, 7, v[vgprLocalWriteAddrB]        // padding 8 per block 128
v_lshl_add_u32 v[vgprLocalWriteAddrB], v6, 3, v[vgprLocalWriteAddrB] // padding 8 per block 128
s_wait_kmcnt 0                                     // wait for 88/0 bytes of kern args
v_mov_b32 v18, MT0                                 // set MT0 into sgpr
v_mov_b32 v17, s[sgprSizesFree+0]                  // set Free0 size
v_cvt_f32_u32 v16, v18                             // v16 = ceil(v17 / v18)
v_rcp_iflag_f32 v16, v16                           // v16 = ceil(v17 / v18)
v_cvt_f32_u32 v19, v17                             // v16 = ceil(v17 / v18)
v_mul_f32 v16, v16, v19                            // v16 = ceil(v17 / v18)
v_cvt_u32_f32 v16, v16                             // v16 = ceil(v17 / v18)
v_mul_u32_u24 v19, v16, v18                        // v16 = ceil(v17 / v18)
v_sub_nc_u32 v19, v17, v19                         // v16 = ceil(v17 / v18)
v_cmp_ne_u32 vcc_lo, v19, 0                        // v16 = ceil(v17 / v18)
v_add_co_ci_u32 v16, vcc_lo, v16, 0, vcc_lo        // ceil
v_mov_b32 v18, MT1                                 // set MT1 into sgpr
v_mov_b32 v17, s[sgprSizesFree+1]                  // set Free1 size
v_readfirstlane_b32 s[sgprNumWorkGroups0], v16     // set back to numWorkGroup0
v_cvt_f32_u32 v16, v18                             // v16 = ceil(v17 / v18)
v_rcp_iflag_f32 v16, v16                           // v16 = ceil(v17 / v18)
v_cvt_f32_u32 v19, v17                             // v16 = ceil(v17 / v18)
v_mul_f32 v16, v16, v19                            // v16 = ceil(v17 / v18)
v_cvt_u32_f32 v16, v16                             // v16 = ceil(v17 / v18)
v_mul_u32_u24 v19, v16, v18                        // v16 = ceil(v17 / v18)
v_sub_nc_u32 v19, v17, v19                         // v16 = ceil(v17 / v18)
v_cmp_ne_u32 vcc_lo, v19, 0                        // v16 = ceil(v17 / v18)
v_add_co_ci_u32 v16, vcc_lo, v16, 0, vcc_lo        // ceil
v_readfirstlane_b32 s[sgprNumWorkGroups1], v16     // set back to numWorkGroup1

/* remap wg from 1D(idxWG012) to 3D(wg2,wg1,wg0) */
/* wg2 = idxWG012 * smallMagicNumber(1/(numWG0*numWG1)) */
s_mul_i32 s16, s[sgprNumWorkGroups0], s[sgprNumWorkGroups1]
s_and_b32 s17, s[sgprGSU], 0x3fff                  // Restore GSU
s_mul_i32 s16, s16, s17
v_cvt_f32_u32 v6, s16                              // s16 = s[sgprWorkGroup0] / s16
v_rcp_iflag_f32 v6, v6                             // s16 = s[sgprWorkGroup0] / s16
v_cvt_f32_u32 v7, s[sgprWorkGroup0]                // s16 = s[sgprWorkGroup0] / s16
v_mul_f32 v6, v6, v7                               // s16 = s[sgprWorkGroup0] / s16
v_cvt_u32_f32 v6, v6                               // s16 = s[sgprWorkGroup0] / s16
v_mul_u32_u24 v7, v6, s16                          // s16 = s[sgprWorkGroup0] / s16
v_sub_nc_u32 v7, s[sgprWorkGroup0], v7             // s16 = s[sgprWorkGroup0] / s16
v_cmp_eq_u32 vcc_lo, v7, s16                       // s16 = s[sgprWorkGroup0] / s16
s_mov_b32 exec_lo vcc_lo                           // s16 = s[sgprWorkGroup0] / s16
v_add_nc_u32 v6, 1, v6                             // s16 = s[sgprWorkGroup0] / s16
s_mov_b32 exec_lo, -1                              // Reset exec
v_cmp_gt_u32 vcc_lo, v7, s16                       // overflow happened in remainder
s_mov_b32 exec_lo vcc_lo                           // overflow happened in remainder
v_sub_nc_u32 v6, v6, 1                             // quotient - 1
s_mov_b32 exec_lo, -1                              // Reset exec
v_readfirstlane_b32 s16, v6                        // quotient
s_mov_b32 s[sgprWorkGroup2], s16
/* idxWG01 = idxWG012 - wg2 * numWG0 * numWG1 */
s_mul_i32 s16, s[sgprNumWorkGroups1], s[sgprNumWorkGroups0]
s_mul_i32 s16, s16, s[sgprWorkGroup2]
s_mul_i32 s16, s16, s17
s_sub_u32 s[sgprWorkGroup0], s[sgprWorkGroup0], s16
/* wg1 = idxWG01 * smallMagicNumber(1/numWG0) */
v_cvt_f32_u32 v6, s[sgprNumWorkGroups0]            // s16 = s[sgprWorkGroup0] / s[sgprNumWorkGroups0]
v_rcp_iflag_f32 v6, v6                             // s16 = s[sgprWorkGroup0] / s[sgprNumWorkGroups0]
v_cvt_f32_u32 v7, s[sgprWorkGroup0]                // s16 = s[sgprWorkGroup0] / s[sgprNumWorkGroups0]
v_mul_f32 v6, v6, v7                               // s16 = s[sgprWorkGroup0] / s[sgprNumWorkGroups0]
v_cvt_u32_f32 v6, v6                               // s16 = s[sgprWorkGroup0] / s[sgprNumWorkGroups0]
v_mul_u32_u24 v7, v6, s[sgprNumWorkGroups0]        // s16 = s[sgprWorkGroup0] / s[sgprNumWorkGroups0]
v_sub_nc_u32 v7, s[sgprWorkGroup0], v7             // s16 = s[sgprWorkGroup0] / s[sgprNumWorkGroups0]
v_cmp_eq_u32 vcc_lo, v7, s[sgprNumWorkGroups0]     // s16 = s[sgprWorkGroup0] / s[sgprNumWorkGroups0]
s_mov_b32 exec_lo vcc_lo                           // s16 = s[sgprWorkGroup0] / s[sgprNumWorkGroups0]
v_add_nc_u32 v6, 1, v6                             // s16 = s[sgprWorkGroup0] / s[sgprNumWorkGroups0]
s_mov_b32 exec_lo, -1                              // Reset exec
v_cmp_gt_u32 vcc_lo, v7, s[sgprNumWorkGroups0]     // overflow happened in remainder
s_mov_b32 exec_lo vcc_lo                           // overflow happened in remainder
v_sub_nc_u32 v6, v6, 1                             // quotient - 1
s_mov_b32 exec_lo, -1                              // Reset exec
v_readfirstlane_b32 s16, v6                        // quotient
s_mov_b32 s[sgprWorkGroup1], s16
/* wg0 = idxWG01 - wg1 * numWG0 */
s_mul_i32 s16, s[sgprWorkGroup1], s[sgprNumWorkGroups0]
s_sub_u32 s[sgprWorkGroup0], s[sgprWorkGroup0], s16
s_branch label_MultiGemmEnd
label_MultiGemm:

/* Check if custom structure pointer is null */
s_cmp_eq_u32 s[sgprArgType], 2                     // ArgType == 2 ?
s_cbranch_scc1 label_IsExternalValid               // branch if ArgType == 2
s_mov_b32 s15, 88
s_mul_i32 s54, s20, 4
s_mov_b64 s[48:49], s[sgprKernArgAddress:sgprKernArgAddress+1]
s_branch label_IsExternalValidEnd
label_IsExternalValid:
s_mov_b32 s15, 196
s_mov_b32 s54, 0
s_mov_b64 s[48:49], s[sgprKernArgAddress:sgprKernArgAddress+1]
label_IsExternalValidEnd:

/* Grouped Gemm:: prefetch 1 arg load */
s_mov_b32 s14, 1
s_mov_b32 s55, 0
s_load_b128 s[24:27], s[48:49], s54
s_mov_b32 s16, 1
s_cmp_eq_u32 s20, s16                              // if gemm_count is 1?
s_cbranch_scc1 label_wgTable_noLoadLoop

/* Grouped Gemm:: accumulate numTiles for each gemm */
/* Grouped Gemm:: loop start */
label_Loop_GemmCount:
s_wait_kmcnt 0
s_lshr_b32 s52, s24, 4                             // s52 = s24 / 16
s_and_b32 s50, 15, s24                             // s50 = s24 % 16
s_addc_u32 s52, s52, 0
s_lshr_b32 s53, s25, 4                             // s53 = s25 / 16
s_and_b32 s50, 15, s25                             // s50 = s25 % 16
s_addc_u32 s53, s53, 0
s_mul_i32 s52, s52, s53
s_mul_i32 s52, s52, s26
s_and_b32 s53, s[sgprGSU], 0x3fff                  // Restore GSU
s_mul_i32 s52, s52, s53
s_add_u32 s55, s55, s52
s_cmp_lt_u32 s[sgprWorkGroup0], s55
s_cbranch_scc1 label_FOUND
s_add_u32 s54, s54, s15
s_load_b128 s[24:27], s[48:49], s54
s_add_u32 s14, s14, 1
s_cmp_lt_u32 s14, s20
s_cbranch_scc1 label_Loop_GemmCount

/* Grouped Gemm:: noLoadLoop */
label_wgTable_noLoadLoop:
s_wait_kmcnt 0
s_lshr_b32 s52, s24, 4                             // s52 = s24 / 16
s_and_b32 s50, 15, s24                             // s50 = s24 % 16
s_addc_u32 s52, s52, 0
s_lshr_b32 s53, s25, 4                             // s53 = s25 / 16
s_and_b32 s50, 15, s25                             // s50 = s25 % 16
s_addc_u32 s53, s53, 0
s_mul_i32 s52, s52, s53
s_mul_i32 s52, s52, s26
s_and_b32 s48, s[sgprGSU], 0x3fff                  // Restore GSU
s_mul_i32 s52, s52, s48
s_add_u32 s55, s55, s52

/* Grouped Gemm:: gemmIndex found */
label_FOUND:
s_sub_u32 s49, s14, 1
s_sub_u32 s48, s55, s52
s_sub_u32 s[sgprWorkGroup0], s[sgprWorkGroup0], s48
/* Check if custom structure pointer is null */
s_cmp_eq_u32 s[sgprArgType], 2                     // ArgType == 2 ?
s_cbranch_scc1 label_LoadExternalStruct            // branch if ArgType == 2

/* Grouped Gemm: offset argument address to gemm */
/* Grouped Gemm: offset address from wg_table_start to args_start */
s_lshl2_add_u32 s[sgprKernArgAddress], s20, s[sgprKernArgAddress]
s_addc_u32 s[sgprKernArgAddress+1], s[sgprKernArgAddress+1], 0
/* Grouped Gemm: offset address from args_start to gemm_start */
s_mul_i32 s49, s49, 88
s_add_u32 s[sgprKernArgAddress], s[sgprKernArgAddress], s49
s_addc_u32 s[sgprKernArgAddress+1], s[sgprKernArgAddress+1], 0

/* Load Kernel Args */
s_load_b512 s[28:43], s[sgprKernArgAddress:sgprKernArgAddress+1], 16 // 16
s_load_b64 s[44:45], s[sgprKernArgAddress:sgprKernArgAddress+1], 80 // 80
s_branch label_LoadExternalStructEnd
label_LoadExternalStruct:
/* Grouped Gemm: offset address from args_start to gemm_start */
s_mul_i32 s49, s49, 196
s_add_u32 s[sgprKernArgAddress], s[sgprKernArgAddress], s49
s_addc_u32 s[sgprKernArgAddress+1], s[sgprKernArgAddress+1], 0
s_load_b512 s[28:43], s[sgprKernArgAddress:sgprKernArgAddress+1], 16 // 16
s_load_b32 s44, s[sgprKernArgAddress:sgprKernArgAddress+1], 80 // 80
// Read Beta
s_load_b32 s45, s[sgprKernArgAddress:sgprKernArgAddress+1], 96 // 96
label_LoadExternalStructEnd:
/* init: add vgpr [16...38) to pool */
/* init: add vgpr [0...8) to pool */
/* init: add agpr [0...0) to pool */

/******************************************/
/* Local Read Addresses                   */
/******************************************/

/* local read addresses: tile assignments a/b */
/* lr1J */
v_and_b32 v1, 31, v[vgprSerial]                    // 0. thread id in wave: wtid = tid % wavelength(32)
v_and_b32 v0, 15, v1                               // 1. N offset: nIdx = wtid % MI_N(16)
v_lshlrev_b32 v0, 5, v0                            // 1. N offset: nOffset = nIdx * nStride(32)
/* Skip. 2. block offset: bnOffset = 0 when num1DBlocks = 1 */
                                                   // 4. apply VectorWidth: bnOffset = bnOffset * vw(1) (multiplier is 1, do nothing)
v_lshrrev_b32 v1, 4, v1                            // 5. K offset: kIdx = wtid / (MIN(16) * MIBB(1))
v_lshl_add_u32 v0, v1, 3, v0                       // 5. K offset: lrKOffset = kIdx * mStride(8); 6. offset in wave: lrOffset = bnOffset + lrKOffset

/* local read addresses: final offsets a */

/* local read addresses: final offsets b */
v_lshrrev_b32 v1, 5, v[vgprSerial]                 // 1 = Serial / 32
v_lshrrev_b32 v1, 0, v1                            // LSU offset: Get LSU wave_id
s_mov_b32 s16, 32                                  // LSU offset: stride = lsuStride(32) when umlds==True
v_mul_lo_u32 v1, s16, v1                           // LSU offset: lsuoffset = wave_id*lsuStride*(MT1+PAD)
v_add_nc_u32 v[vgprLocalReadAddrB], v1, v0         // Final Offset: offset = (lro1+lsuoffset)*bpeDS(1)
v_lshrrev_b32 v2, 7, v[vgprLocalReadAddrB]         // Final Offset: padding 8 per block 128
v_lshl_add_u32 v[vgprLocalReadAddrB], v2, 3, v[vgprLocalReadAddrB] // Final Offset: padding 8 per block 128

/* local read addresses: declare addresses a */
/* N/A */

/* local read addresses: declare addresses b */

/******************************************/
/* Local Write Addresses                  */
/******************************************/
/* LVCA = 2 */
/* v1 = A-unroll = serial%LVCA */
/* TileAssignment for DirectToVgprA and GLTrA */
v_lshrrev_b32 v0, 5, v[vgprSerial]                 // 0 = Serial / 32
v_and_b32 v1, 31, v[vgprSerial]                    // 1 = Serial % 32
v_lshrrev_b32 v4, 3, v1                            // GLTrA: v4 = v1 / 8
v_lshlrev_b32 v4, 2, v4                            // GLTrA: v4 = v4 * 4
v_and_b32 v1, 3, v1                                // GLTrA: v4 = v1 % 4
v_add_nc_u32 v1, v4, v1                            // GLTrA: v1 = v1 + v4
v_and_b32 v0, 0x0, v0                              // GLTrA: wave_id (along_M) %= MIWG[0]
v_mul_u32_u24 v0, 2, v0                            // GLTrA: wave_id (along_M) *= numKr
v_bfe_u32 v4, v[vgprSerial], 2, 1                  // GLTrA: offset for the right half of the tile
v_add_nc_u32 v0, v4, v0                            // GLTrA: wave_id += offset for the right half of the tile
/* tile *= glvw */
v_lshlrev_b32 v0, 3, v0                            // v0 = v0 * 8
v_mov_b32 v4, v1                                   // copy for GlobalSplitU
/* LVCB = 4 */
/* v3 = B-unroll = serial%LVCB */
v_lshrrev_b32 v2, 2, v[vgprSerial]                 // 2 = Serial / 4
v_and_b32 v3, 3, v[vgprSerial]                     // 3 = Serial % 4
/* unroll *= glvw */
v_lshlrev_b32 v3, 3, v3                            // v3 = v3 * 8
v_mov_b32 v5, v3                                   // copy for GlobalSplitU
/* lwaUnrollAssignmentA = v4 */
/* lwaUnrollAssignmentB = v5 */

/* local write addresses: first offset a */

/* local write addresses: first offset b */
v_mul_u32_u24 v[vgprLocalWriteAddrB], 0x20, v2     // lwBL**(DepthU_Compute + PAD)
v_add_nc_u32 v[vgprLocalWriteAddrB], v5, v[vgprLocalWriteAddrB] // lwFOB = (lwBB + lwBL*(DepthU+PAD))*bpeDS(1)
v_lshrrev_b32 v6, 7, v[vgprLocalWriteAddrB]        // padding 8 per block 128
v_lshl_add_u32 v[vgprLocalWriteAddrB], v6, 3, v[vgprLocalWriteAddrB] // padding 8 per block 128
s_wait_kmcnt 0                                     // wait for 88/0 bytes of kern args
v_mov_b32 v18, MT0                                 // set MT0 into sgpr
v_mov_b32 v17, s[sgprSizesFree+0]                  // set Free0 size
v_cvt_f32_u32 v16, v18                             // v16 = ceil(v17 / v18)
v_rcp_iflag_f32 v16, v16                           // v16 = ceil(v17 / v18)
v_cvt_f32_u32 v19, v17                             // v16 = ceil(v17 / v18)
v_mul_f32 v16, v16, v19                            // v16 = ceil(v17 / v18)
v_cvt_u32_f32 v16, v16                             // v16 = ceil(v17 / v18)
v_mul_u32_u24 v19, v16, v18                        // v16 = ceil(v17 / v18)
v_sub_nc_u32 v19, v17, v19                         // v16 = ceil(v17 / v18)
v_cmp_ne_u32 vcc_lo, v19, 0                        // v16 = ceil(v17 / v18)
v_add_co_ci_u32 v16, vcc_lo, v16, 0, vcc_lo        // ceil
v_mov_b32 v18, MT1                                 // set MT1 into sgpr
v_mov_b32 v17, s[sgprSizesFree+1]                  // set Free1 size
v_readfirstlane_b32 s[sgprNumWorkGroups0], v16     // set back to numWorkGroup0
v_cvt_f32_u32 v16, v18                             // v16 = ceil(v17 / v18)
v_rcp_iflag_f32 v16, v16                           // v16 = ceil(v17 / v18)
v_cvt_f32_u32 v19, v17                             // v16 = ceil(v17 / v18)
v_mul_f32 v16, v16, v19                            // v16 = ceil(v17 / v18)
v_cvt_u32_f32 v16, v16                             // v16 = ceil(v17 / v18)
v_mul_u32_u24 v19, v16, v18                        // v16 = ceil(v17 / v18)
v_sub_nc_u32 v19, v17, v19                         // v16 = ceil(v17 / v18)
v_cmp_ne_u32 vcc_lo, v19, 0                        // v16 = ceil(v17 / v18)
v_add_co_ci_u32 v16, vcc_lo, v16, 0, vcc_lo        // ceil
v_readfirstlane_b32 s[sgprNumWorkGroups1], v16     // set back to numWorkGroup1

/* Early stop if N(SizeFreeJ) == 0 */
s_cmp_eq_u32 s[sgprSizeJ], 0
s_cbranch_scc0 label_NoEarlyStop_N0
label_EarlyStop_if_N_is_0:
s_endpgm
label_NoEarlyStop_N0:

/* remap wg from 1D(idxWG012) to 3D(wg2,wg1,wg0) */
/* wg2 = idxWG012 * smallMagicNumber(1/(numWG0*numWG1)) */
s_mul_i32 s16, s[sgprNumWorkGroups0], s[sgprNumWorkGroups1]
s_and_b32 s17, s[sgprGSU], 0x3fff                  // Restore GSU
s_mul_i32 s16, s16, s17
v_cvt_f32_u32 v6, s16                              // s16 = s[sgprWorkGroup0] / s16
v_rcp_iflag_f32 v6, v6                             // s16 = s[sgprWorkGroup0] / s16
v_cvt_f32_u32 v7, s[sgprWorkGroup0]                // s16 = s[sgprWorkGroup0] / s16
v_mul_f32 v6, v6, v7                               // s16 = s[sgprWorkGroup0] / s16
v_cvt_u32_f32 v6, v6                               // s16 = s[sgprWorkGroup0] / s16
v_mul_u32_u24 v7, v6, s16                          // s16 = s[sgprWorkGroup0] / s16
v_sub_nc_u32 v7, s[sgprWorkGroup0], v7             // s16 = s[sgprWorkGroup0] / s16
v_cmp_eq_u32 vcc_lo, v7, s16                       // s16 = s[sgprWorkGroup0] / s16
s_mov_b32 exec_lo vcc_lo                           // s16 = s[sgprWorkGroup0] / s16
v_add_nc_u32 v6, 1, v6                             // s16 = s[sgprWorkGroup0] / s16
s_mov_b32 exec_lo, -1                              // Reset exec
v_cmp_gt_u32 vcc_lo, v7, s16                       // overflow happened in remainder
s_mov_b32 exec_lo vcc_lo                           // overflow happened in remainder
v_sub_nc_u32 v6, v6, 1                             // quotient - 1
s_mov_b32 exec_lo, -1                              // Reset exec
v_readfirstlane_b32 s16, v6                        // quotient
s_mov_b32 s[sgprWorkGroup2], s16
/* idxWG01 = idxWG012 - wg2 * numWG0 * numWG1 */
s_mul_i32 s16, s[sgprNumWorkGroups1], s[sgprNumWorkGroups0]
s_mul_i32 s16, s16, s[sgprWorkGroup2]
s_mul_i32 s16, s16, s17
s_sub_u32 s[sgprWorkGroup0], s[sgprWorkGroup0], s16
/* wg1 = idxWG01 * smallMagicNumber(1/numWG0) */
v_cvt_f32_u32 v6, s[sgprNumWorkGroups0]            // s16 = s[sgprWorkGroup0] / s[sgprNumWorkGroups0]
v_rcp_iflag_f32 v6, v6                             // s16 = s[sgprWorkGroup0] / s[sgprNumWorkGroups0]
v_cvt_f32_u32 v7, s[sgprWorkGroup0]                // s16 = s[sgprWorkGroup0] / s[sgprNumWorkGroups0]
v_mul_f32 v6, v6, v7                               // s16 = s[sgprWorkGroup0] / s[sgprNumWorkGroups0]
v_cvt_u32_f32 v6, v6                               // s16 = s[sgprWorkGroup0] / s[sgprNumWorkGroups0]
v_mul_u32_u24 v7, v6, s[sgprNumWorkGroups0]        // s16 = s[sgprWorkGroup0] / s[sgprNumWorkGroups0]
v_sub_nc_u32 v7, s[sgprWorkGroup0], v7             // s16 = s[sgprWorkGroup0] / s[sgprNumWorkGroups0]
v_cmp_eq_u32 vcc_lo, v7, s[sgprNumWorkGroups0]     // s16 = s[sgprWorkGroup0] / s[sgprNumWorkGroups0]
s_mov_b32 exec_lo vcc_lo                           // s16 = s[sgprWorkGroup0] / s[sgprNumWorkGroups0]
v_add_nc_u32 v6, 1, v6                             // s16 = s[sgprWorkGroup0] / s[sgprNumWorkGroups0]
s_mov_b32 exec_lo, -1                              // Reset exec
v_cmp_gt_u32 vcc_lo, v7, s[sgprNumWorkGroups0]     // overflow happened in remainder
s_mov_b32 exec_lo vcc_lo                           // overflow happened in remainder
v_sub_nc_u32 v6, v6, 1                             // quotient - 1
s_mov_b32 exec_lo, -1                              // Reset exec
v_readfirstlane_b32 s16, v6                        // quotient
s_mov_b32 s[sgprWorkGroup1], s16
/* wg0 = idxWG01 - wg1 * numWG0 */
s_mul_i32 s16, s[sgprWorkGroup1], s[sgprNumWorkGroups0]
s_sub_u32 s[sgprWorkGroup0], s[sgprWorkGroup0], s16

/* Early stop if wg exceed */
s_cmp_ge_u32 s[sgprWorkGroup2], s[sgprSizesFree+2]
s_cbranch_scc0 label_NoEarlyStop_wgExceed
label_EarlyStop_if_wg_exceed:
s_endpgm
label_NoEarlyStop_wgExceed:

label_MultiGemmEnd:
.set sgprSrdA, 48
.set sgprSrdB, 52
.set sgprShadowLimitA, 56
.set sgprShadowLimitB, 58
.set sgprStaggerUIter, 47
.set sgprWrapUA, 60
.set sgprWrapUB, 62
.set sgprGlobalReadIncsA, 64
.set sgprGlobalReadIncsB, 65
s_sub_u32 s[sgprAddressA+0], s[sgprAddressA+0], 8  // pre-pad to make room for possible pointer shift
s_subb_u32 s[sgprAddressA+1], s[sgprAddressA+1], 0 // pre-pad to make room for possible pointer shift
s_sub_u32 s[sgprAddressB+0], s[sgprAddressB+0], 8  // pre-pad to make room for possible pointer shift
s_subb_u32 s[sgprAddressB+1], s[sgprAddressB+1], 0 // pre-pad to make room for possible pointer shift

/* Short circuit condition if Alpha == 0, then sumDims=0 */
v_cmp_eq_f32 vcc_lo, s[sgprAlpha], 0.0             // s[Alpha] == 0.0f ?
s_cbranch_vccz label_AlphaNonZero                  // branch if s[Alpha] != 0
s_mov_b32 s[sgprSizesSum+0], 0                     // Set summation dim=0 if Alpha == 0
label_AlphaNonZero:

/******************************************/
/* Begin setupNewTile                     */
/******************************************/

/* global read addresses: work-group */
/* graWorkGroup mapping */
s_and_b32 s16, s[sgprGSU], 0x3fff                  // Restore GSU
s_cmp_eq_u32 s16, 1                                // GSU == 1 ?
s_cbranch_scc1 label_GSU                           // branch if GSU == 1
// GSU-not-WGMapRR :nwg1 = (size1J + MT1J - 1) / MT1J;
s_and_b32 s16, s[sgprGSU], 0x4000                  // SCC = (GSUWGMRR == 1) ?
s_cbranch_scc1 label_GSUWGMRR                      // branch if GSUWGMRR == 1
s_and_b32 s16, s[sgprGSU], 0x3fff                  // Restore GSU
v_cvt_f32_u32 v6, s16                              // s[sgprWorkGroup1] = s[sgprWorkGroup1] / s16
v_rcp_iflag_f32 v6, v6                             // s[sgprWorkGroup1] = s[sgprWorkGroup1] / s16
v_cvt_f32_u32 v7, s[sgprWorkGroup1]                // s[sgprWorkGroup1] = s[sgprWorkGroup1] / s16
v_mul_f32 v6, v6, v7                               // s[sgprWorkGroup1] = s[sgprWorkGroup1] / s16
v_cvt_u32_f32 v6, v6                               // s[sgprWorkGroup1] = s[sgprWorkGroup1] / s16
v_mul_u32_u24 v7, v6, s16                          // s[sgprWorkGroup1] = s[sgprWorkGroup1] / s16
v_sub_nc_u32 v7, s[sgprWorkGroup1], v7             // s[sgprWorkGroup1] = s[sgprWorkGroup1] / s16
v_cmp_eq_u32 vcc_lo, v7, s16                       // s[sgprWorkGroup1] = s[sgprWorkGroup1] / s16
s_mov_b32 exec_lo vcc_lo                           // s[sgprWorkGroup1] = s[sgprWorkGroup1] / s16
v_add_nc_u32 v6, 1, v6                             // s[sgprWorkGroup1] = s[sgprWorkGroup1] / s16
v_mov_b32 v7, 0                                    // s[sgprGSUSumIdx] = s[sgprWorkGroup1] % s16
s_mov_b32 exec_lo, -1                              // Reset exec
v_cmp_gt_u32 vcc_lo, v7, s16                       // overflow happened in remainder
s_mov_b32 exec_lo vcc_lo                           // overflow happened in remainder
v_sub_nc_u32 v6, v6, 1                             // quotient - 1
v_mul_u32_u24 v7, v6, s16                          // re-calculate remainder
v_sub_nc_u32 v7, s[sgprWorkGroup1], v7             // re-calculate remainder
s_mov_b32 exec_lo, -1                              // Reset exec
v_readfirstlane_b32 s[sgprWorkGroup1], v6          // quotient
v_readfirstlane_b32 s[sgprGSUSumIdx], v7           // remainder
s_branch label_GSUWGMRR_End
label_GSUWGMRR:
v_cvt_f32_u32 v6, s[sgprNumWorkGroups1]            // s[sgprGSUSumIdx] = s[sgprWorkGroup1] / s[sgprNumWorkGroups1]
v_rcp_iflag_f32 v6, v6                             // s[sgprGSUSumIdx] = s[sgprWorkGroup1] / s[sgprNumWorkGroups1]
v_cvt_f32_u32 v7, s[sgprWorkGroup1]                // s[sgprGSUSumIdx] = s[sgprWorkGroup1] / s[sgprNumWorkGroups1]
v_mul_f32 v6, v6, v7                               // s[sgprGSUSumIdx] = s[sgprWorkGroup1] / s[sgprNumWorkGroups1]
v_cvt_u32_f32 v6, v6                               // s[sgprGSUSumIdx] = s[sgprWorkGroup1] / s[sgprNumWorkGroups1]
v_mul_u32_u24 v7, v6, s[sgprNumWorkGroups1]        // s[sgprGSUSumIdx] = s[sgprWorkGroup1] / s[sgprNumWorkGroups1]
v_sub_nc_u32 v7, s[sgprWorkGroup1], v7             // s[sgprGSUSumIdx] = s[sgprWorkGroup1] / s[sgprNumWorkGroups1]
v_cmp_eq_u32 vcc_lo, v7, s[sgprNumWorkGroups1]     // s[sgprGSUSumIdx] = s[sgprWorkGroup1] / s[sgprNumWorkGroups1]
s_mov_b32 exec_lo vcc_lo                           // s[sgprGSUSumIdx] = s[sgprWorkGroup1] / s[sgprNumWorkGroups1]
v_add_nc_u32 v6, 1, v6                             // s[sgprGSUSumIdx] = s[sgprWorkGroup1] / s[sgprNumWorkGroups1]
v_mov_b32 v7, 0                                    // s[sgprWorkGroup1] = s[sgprWorkGroup1] % s[sgprNumWorkGroups1]
s_mov_b32 exec_lo, -1                              // Reset exec
v_cmp_gt_u32 vcc_lo, v7, s[sgprNumWorkGroups1]     // overflow happened in remainder
s_mov_b32 exec_lo vcc_lo                           // overflow happened in remainder
v_sub_nc_u32 v6, v6, 1                             // quotient - 1
v_mul_u32_u24 v7, v6, s[sgprNumWorkGroups1]        // re-calculate remainder
v_sub_nc_u32 v7, s[sgprWorkGroup1], v7             // re-calculate remainder
s_mov_b32 exec_lo, -1                              // Reset exec
v_readfirstlane_b32 s[sgprGSUSumIdx], v6           // quotient
v_readfirstlane_b32 s[sgprWorkGroup1], v7          // remainder
label_GSUWGMRR_End:
s_mov_b32 s[sgprGSULog2BpeC], 0
s_mov_b32 s[sgprGSULog2BpeD], 2
s_branch label_GSU_End
label_GSU:
s_mov_b64 s[sgprGSUSumIdx:sgprGSUSumIdx+1], 0      // Set GSUSumIdx to 0
s_mov_b32 s[sgprGSULog2BpeC], 0
s_mov_b32 s[sgprGSULog2BpeD], 0
label_GSU_End:
/* WGM Calculation */
s_mov_b32 s16, s[sgprWGM]                          // Restore WGM
s_sext_i32_i16 s16, s16                            // Restore WGM
s_cmp_gt_i32 s16, 1                                // WGM > 1 ?
s_cbranch_scc1 label_WGMPositive                   // branch if WGM > 1
s_cmp_ge_i32 s16, 0                                // WGM >= 0 ?
s_cbranch_scc1 label_WGM                           // branch if WGM >= 0
s_abs_i32 s16, s16                                 // abs(WGM)
v_cvt_f64_u32 v[16:17], s16                        // s17 = s[sgprWorkGroup0] / s16
v_rcp_f64 v[16:17], v[16:17]                       // s17 = s[sgprWorkGroup0] / s16
v_cvt_f64_u32 v[18:19], s[sgprWorkGroup0]          // s17 = s[sgprWorkGroup0] / s16
v_mul_f64 v[16:17], v[16:17], v[18:19]             // s17 = s[sgprWorkGroup0] / s16
v_cvt_u32_f64 v16, v[16:17]                        // s17 = s[sgprWorkGroup0] / s16
v_mul_lo_u32 v17, v16, s16                         // s17 = s[sgprWorkGroup0] / s16
v_sub_nc_u32 v18, s[sgprWorkGroup0], v17           // s17 = s[sgprWorkGroup0] / s16
v_cmp_ge_u32 vcc_lo, v18, s16                      // s17 = s[sgprWorkGroup0] / s16
s_mov_b32 exec_lo vcc_lo                           // s17 = s[sgprWorkGroup0] / s16
v_add_nc_u32 v16, v16, 1                           // s17 = s[sgprWorkGroup0] / s16
s_mov_b32 exec_lo, -1                              // Reset exec
v_readfirstlane_b32 s17, v16                       // quotient
s_mul_i32 s20, s17, s16                            // quotient * non-magic divisor
s_sub_u32 s20, s[sgprWorkGroup0], s20              // WorkGroup0=remainder
s_mul_i32 s20, s20, s[sgprNumWorkGroups1]          // (wg1 % WGM)*NumWorkGroups1
s_add_u32 s20, s20, s[sgprWorkGroup1]              // wgSerial = wg0 + (wg1 % WGM)*NumWorkGroups1
v_cvt_f64_u32 v[16:17], s16                        // s18 = s[sgprNumWorkGroups0] / s16
v_rcp_f64 v[16:17], v[16:17]                       // s18 = s[sgprNumWorkGroups0] / s16
v_cvt_f64_u32 v[18:19], s[sgprNumWorkGroups0]      // s18 = s[sgprNumWorkGroups0] / s16
v_mul_f64 v[16:17], v[16:17], v[18:19]             // s18 = s[sgprNumWorkGroups0] / s16
v_cvt_u32_f64 v16, v[16:17]                        // s18 = s[sgprNumWorkGroups0] / s16
v_mul_lo_u32 v17, v16, s16                         // s18 = s[sgprNumWorkGroups0] / s16
v_sub_nc_u32 v18, s[sgprNumWorkGroups0], v17       // s18 = s[sgprNumWorkGroups0] / s16
v_cmp_ge_u32 vcc_lo, v18, s16                      // s18 = s[sgprNumWorkGroups0] / s16
s_mov_b32 exec_lo vcc_lo                           // s18 = s[sgprNumWorkGroups0] / s16
v_add_nc_u32 v16, v16, 1                           // s18 = s[sgprNumWorkGroups0] / s16
s_mov_b32 exec_lo, -1                              // Reset exec
v_readfirstlane_b32 s18, v16                       // quotient
s_mul_i32 s19, s16, s18                            // quotient * non-magic divisor
s_sub_u32 s19, s[sgprNumWorkGroups0], s19          // NumWorkGroups0=remainder
s_cmp_eq_u32 s19, 0                                // remainder == 0 ?
s_cmov_b32 s19, s16                                // remainder = WGM if remainder == 0
s_cmp_ge_u32 s17, s18                              // blockId >= numFullBlocks ?
s_cselect_b32 s18, s19, s16
v_cvt_f64_u32 v[16:17], s18                        // s[sgprWorkGroup1] = s20 / s18
v_rcp_f64 v[16:17], v[16:17]                       // s[sgprWorkGroup1] = s20 / s18
v_cvt_f64_u32 v[18:19], s20                        // s[sgprWorkGroup1] = s20 / s18
v_mul_f64 v[16:17], v[16:17], v[18:19]             // s[sgprWorkGroup1] = s20 / s18
v_cvt_u32_f64 v16, v[16:17]                        // s[sgprWorkGroup1] = s20 / s18
v_mul_lo_u32 v17, v16, s18                         // s[sgprWorkGroup1] = s20 / s18
v_sub_nc_u32 v18, s20, v17                         // s[sgprWorkGroup1] = s20 / s18
v_cmp_ge_u32 vcc_lo, v18, s18                      // s[sgprWorkGroup1] = s20 / s18
s_mov_b32 exec_lo vcc_lo                           // s[sgprWorkGroup1] = s20 / s18
v_add_nc_u32 v16, v16, 1                           // s[sgprWorkGroup1] = s20 / s18
s_mov_b32 exec_lo, -1                              // Reset exec
v_mul_lo_u32 v17, v16, s18                         // s[sgprWorkGroup1] = s20 / s18
v_sub_nc_u32 v18, s20, v17                         // s[sgprWorkGroup1] = s20 / s18
v_readfirstlane_b32 s[sgprWorkGroup1], v16         // quotient
v_readfirstlane_b32 s[sgprWorkGroup0], v18         // remainder
s_mul_i32 s[sgprWorkGroup0], s[sgprWorkGroup1], s18 // quotient * non-magic divisor
s_sub_u32 s[sgprWorkGroup0], s20, s[sgprWorkGroup0] // WorkGroup0=remainder
s_mul_i32 s17, s17, s16                            // blockId * WGM
s_add_u32 s[sgprWorkGroup0], s[sgprWorkGroup0], s17 // wg1 += blockId * WGM
s_branch label_WGM
label_WGMPositive:
s_mov_b32 s16, s16                                 // WGM
v_cvt_f64_u32 v[16:17], s16                        // s17 = s[sgprWorkGroup1] / s16
v_rcp_f64 v[16:17], v[16:17]                       // s17 = s[sgprWorkGroup1] / s16
v_cvt_f64_u32 v[18:19], s[sgprWorkGroup1]          // s17 = s[sgprWorkGroup1] / s16
v_mul_f64 v[16:17], v[16:17], v[18:19]             // s17 = s[sgprWorkGroup1] / s16
v_cvt_u32_f64 v16, v[16:17]                        // s17 = s[sgprWorkGroup1] / s16
v_mul_lo_u32 v17, v16, s16                         // s17 = s[sgprWorkGroup1] / s16
v_sub_nc_u32 v18, s[sgprWorkGroup1], v17           // s17 = s[sgprWorkGroup1] / s16
v_cmp_ge_u32 vcc_lo, v18, s16                      // s17 = s[sgprWorkGroup1] / s16
s_mov_b32 exec_lo vcc_lo                           // s17 = s[sgprWorkGroup1] / s16
v_add_nc_u32 v16, v16, 1                           // s17 = s[sgprWorkGroup1] / s16
s_mov_b32 exec_lo, -1                              // Reset exec
v_readfirstlane_b32 s17, v16                       // quotient
s_mul_i32 s20, s17, s16                            // quotient * non-magic divisor
s_sub_u32 s20, s[sgprWorkGroup1], s20              // WorkGroup1=remainder
s_mul_i32 s20, s20, s[sgprNumWorkGroups0]          // (wg1 % WGM)*NumWorkGroups0
s_add_u32 s20, s20, s[sgprWorkGroup0]              // wgSerial = wg0 + (wg1 % WGM)*NumWorkGroups0
v_cvt_f64_u32 v[16:17], s16                        // s18 = s[sgprNumWorkGroups1] / s16
v_rcp_f64 v[16:17], v[16:17]                       // s18 = s[sgprNumWorkGroups1] / s16
v_cvt_f64_u32 v[18:19], s[sgprNumWorkGroups1]      // s18 = s[sgprNumWorkGroups1] / s16
v_mul_f64 v[16:17], v[16:17], v[18:19]             // s18 = s[sgprNumWorkGroups1] / s16
v_cvt_u32_f64 v16, v[16:17]                        // s18 = s[sgprNumWorkGroups1] / s16
v_mul_lo_u32 v17, v16, s16                         // s18 = s[sgprNumWorkGroups1] / s16
v_sub_nc_u32 v18, s[sgprNumWorkGroups1], v17       // s18 = s[sgprNumWorkGroups1] / s16
v_cmp_ge_u32 vcc_lo, v18, s16                      // s18 = s[sgprNumWorkGroups1] / s16
s_mov_b32 exec_lo vcc_lo                           // s18 = s[sgprNumWorkGroups1] / s16
v_add_nc_u32 v16, v16, 1                           // s18 = s[sgprNumWorkGroups1] / s16
s_mov_b32 exec_lo, -1                              // Reset exec
v_readfirstlane_b32 s18, v16                       // quotient
s_mul_i32 s19, s16, s18                            // quotient * non-magic divisor
s_sub_u32 s19, s[sgprNumWorkGroups1], s19          // NumWorkGroups1=remainder
s_cmp_eq_u32 s19, 0                                // remainder == 0 ?
s_cmov_b32 s19, s16                                // remainder = WGM if remainder == 0
s_cmp_ge_u32 s17, s18                              // blockId >= numFullBlocks ?
s_cselect_b32 s18, s19, s16
v_cvt_f64_u32 v[16:17], s18                        // s[sgprWorkGroup0] = s20 / s18
v_rcp_f64 v[16:17], v[16:17]                       // s[sgprWorkGroup0] = s20 / s18
v_cvt_f64_u32 v[18:19], s20                        // s[sgprWorkGroup0] = s20 / s18
v_mul_f64 v[16:17], v[16:17], v[18:19]             // s[sgprWorkGroup0] = s20 / s18
v_cvt_u32_f64 v16, v[16:17]                        // s[sgprWorkGroup0] = s20 / s18
v_mul_lo_u32 v17, v16, s18                         // s[sgprWorkGroup0] = s20 / s18
v_sub_nc_u32 v18, s20, v17                         // s[sgprWorkGroup0] = s20 / s18
v_cmp_ge_u32 vcc_lo, v18, s18                      // s[sgprWorkGroup0] = s20 / s18
s_mov_b32 exec_lo vcc_lo                           // s[sgprWorkGroup0] = s20 / s18
v_add_nc_u32 v16, v16, 1                           // s[sgprWorkGroup0] = s20 / s18
s_mov_b32 exec_lo, -1                              // Reset exec
v_mul_lo_u32 v17, v16, s18                         // s[sgprWorkGroup0] = s20 / s18
v_sub_nc_u32 v18, s20, v17                         // s[sgprWorkGroup0] = s20 / s18
v_readfirstlane_b32 s[sgprWorkGroup0], v16         // quotient
v_readfirstlane_b32 s[sgprWorkGroup1], v18         // remainder
s_mul_i32 s[sgprWorkGroup1], s[sgprWorkGroup0], s18 // quotient * non-magic divisor
s_sub_u32 s[sgprWorkGroup1], s20, s[sgprWorkGroup1] // WorkGroup1=remainder
s_mul_i32 s17, s17, s16                            // blockId * WGM
s_add_u32 s[sgprWorkGroup1], s[sgprWorkGroup1], s17 // wg1 += blockId * WGM
label_WGM:

/* global read addresses: tile offset assignment a */
/* graTileAssignmentA = v0 */

/* global read addresses: tile offset assignment b */
/* graTileAssignmentB = v2 */

/* global read addresses: unroll assignment a */
/* v1 */

/* global read addresses: unroll assignment b */
/* v3 */

/* global read addresses: other free assignments */
/* s[sgprWorkGroup2] */

/* global read addresses: tile offsets a */
v_mov_b32 v6, v0                                   // groA0I_0

/* global read addresses: tile offsets b */
v_mov_b32 v16, v2                                  // groB1J_0
v_add_co_u32 v17, vcc_lo, 8, v16                   // groB1J_1 += LSPB

/* global read addresses: unroll offsets a */
v_mov_b32 v18, v1                                  // groAL_0
v_add_co_u32 v19, vcc_lo, 16, v18                  // groAL_1 + LSPA

/* global read addresses: unroll offsets b */
v_mov_b32 v7, v3                                   // groBL_0

/* global read addresses: shift a */
s_mul_i32 s16, s[sgprWorkGroup0], 16               // WorkGroup[01] * MT
s_sub_u32 s16, s[sgprSizeI], s16                   // edge = Size0I - WG*MT
s_sub_u32 s16, s16, 8                              // edge -= margin(8)
v_mov_b32 v20, s16                                 // edge vgpr = Size0I- WG*MT - margin(8)
v_min_i32 v6, v20, v6                              // offset = (offset < edge) ? offset(v6) : edge(v20)

/* global read addresses: addresses a */
/* max read offset = size[n] * stride[n-1] */
s_mul_hi_u32 s19, s[sgprWorkGroup0], 16            // WorkGroup[01] * MT
s_mul_i32 s18, s[sgprWorkGroup0], 16               // WorkGroup[01] * MT
s_and_b32 s16, s[sgprGSU], 0x8000                  // SCC = (GSUC == 1) ?
s_cbranch_scc1 label_GSUC_A                        // branch if GSUC == 1
s_mul_hi_u32 s17, 32, s[sgprGSUSumIdx]             // gsuOffset = DepthU*GSUSumIdx
s_mul_i32 s16, 32, s[sgprGSUSumIdx]                // gsuOffset = DepthU*GSUSumIdx
s_branch label_GSUC_A_End
label_GSUC_A:
s_lshr_b32 s[sgprLoopCounterL], s[sgprSizesSum], 5 // s[LoopCounterL] = s[sgprSizesSum] / 32
s_and_b32 s[sgprGSUSumIdx+1], s[sgprGSU], 0x3fff   // Restore GSU
v_cvt_f32_u32 v20, s[sgprGSUSumIdx+1]              // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
v_rcp_iflag_f32 v20, v20                           // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
v_cvt_f32_u32 v21, s[sgprLoopCounterL]             // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
v_mul_f32 v20, v20, v21                            // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
v_cvt_u32_f32 v20, v20                             // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
v_mul_u32_u24 v21, v20, s[sgprGSUSumIdx+1]         // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
v_sub_nc_u32 v21, s[sgprLoopCounterL], v21         // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
v_cmp_eq_u32 vcc_lo, v21, s[sgprGSUSumIdx+1]       // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
s_mov_b32 exec_lo vcc_lo                           // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
v_add_nc_u32 v20, 1, v20                           // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
v_mov_b32 v21, 0                                   // s[sgprGSUSumIdx+1] = s[sgprLoopCounterL] % s[sgprGSUSumIdx+1]
s_mov_b32 exec_lo, -1                              // Reset exec
v_cmp_gt_u32 vcc_lo, v21, s[sgprGSUSumIdx+1]       // overflow happened in remainder
s_mov_b32 exec_lo vcc_lo                           // overflow happened in remainder
v_sub_nc_u32 v20, v20, 1                           // quotient - 1
v_mul_u32_u24 v21, v20, s[sgprGSUSumIdx+1]         // re-calculate remainder
v_sub_nc_u32 v21, s[sgprLoopCounterL], v21         // re-calculate remainder
s_mov_b32 exec_lo, -1                              // Reset exec
v_readfirstlane_b32 s[sgprLoopCounterL], v20       // quotient
v_readfirstlane_b32 s[sgprGSUSumIdx+1], v21        // remainder
s_mul_i32 s17, s[sgprLoopCounterL], s[sgprGSUSumIdx] // quotient*GSUSumIdx
s_add_u32 s16, 1, s[sgprLoopCounterL]              // quotient+1
s_add_u32 s17, s17, s[sgprGSUSumIdx+1]             // quotient*GSUSumIdx+remainder
s_mul_i32 s16, s16, s[sgprGSUSumIdx]               // (quotient+1)*GSUSumIdx
s_cmp_lt_u32 s[sgprGSUSumIdx], s[sgprGSUSumIdx+1]  // gsuSumIdx < numIterPerWgRemainder
s_cselect_b32 s16, s16, s17                        // (quotient+1)*GSUSumIdx if needed
s_mul_hi_u32 s17, s16, 32                          // gsuOffset = DepthU*accumulatedNumOfLoopCounterL
s_mul_i32 s16, s16, 32                             // gsuOffset = DepthU*accumulatedNumOfLoopCounterL
label_GSUC_A_End:
s_mul_hi_u32 s17, s16, s[sgprStrideAL]             // tlu=1, scaled unroll-offset by stride
s_mul_i32 s16, s16, s[sgprStrideAL]                // tlu=1, scaled unroll-offset by stride
s_add_u32 s18, s18, s16                            // accum GsuOffset term to tilestart
s_addc_u32 s19, s19, s17                           // accum GsuOffset term to tilestart
s_mov_b64 s[sgprShadowLimitA+0:sgprShadowLimitA+0+1], 1 // Init tensor size
s_sub_u32 s16, s[sgprSizeI], 1                     // (size-1)
s_mul_hi_u32 s17, constStrideA0I, s16              // stride x (size-1)
s_mul_i32 s16, constStrideA0I, s16                 // stride x (size-1)
s_add_u32 s[sgprShadowLimitA+0], s[sgprShadowLimitA+0], s16 // sum tensor size
s_addc_u32 s[sgprShadowLimitA+1], s[sgprShadowLimitA+1], s17 // sum tensor size
s_sub_u32 s16, s[sgprSizeL], 1                     // (size-1)
s_mul_hi_u32 s17, s[sgprStrideAL], s16             // stride x (size-1)
s_mul_i32 s16, s[sgprStrideAL], s16                // stride x (size-1)
s_add_u32 s[sgprShadowLimitA+0], s[sgprShadowLimitA+0], s16 // sum tensor size
s_addc_u32 s[sgprShadowLimitA+1], s[sgprShadowLimitA+1], s17 // sum tensor size
s_sub_u32 s[sgprShadowLimitA+0], s[sgprShadowLimitA+0], s18 // sub tileStart
s_subb_u32 s[sgprShadowLimitA+1], s[sgprShadowLimitA+1], s19 // sub tileStart
                                                   // Set limit to use bytes (byte is 1, do nothing)
s_add_u32 s[sgprShadowLimitA+0], s[sgprShadowLimitA+0], 8 // extend limit for pre-pad
s_addc_u32 s[sgprShadowLimitA+1], s[sgprShadowLimitA+1], 0 // extend limit for pre-pad
s_cmp_eq_u32 s[sgprShadowLimitA+1], 0              // are we within 2^32?
s_cselect_b32 s[sgprSrdA+2], s[sgprShadowLimitA+0], BufferLimit // Move shadow to real if we are within 2^32
s_mul_hi_u32 s17, s[sgprStrideAK], s[sgprWorkGroup2] // Stride*WG
s_mul_i32 s16, s[sgprStrideAK], s[sgprWorkGroup2]  // Stride*WG
s_add_u32 s18, s18, s16                            // accum wg term to tilestart
s_addc_u32 s19, s19, s17                           // accum wg term to tilestart
                                                   // tileStart *= BPE (multiplier is 1, do nothing)
s_add_u32 s[sgprSrdA+0], s[sgprAddressA+0], s18    // SRD base = Address+ tileStart0
s_addc_u32 s[sgprSrdA+1], s[sgprAddressA+1], s19   // SRD base = Address+ tileStart1
s_mov_b32 s[sgprSrdA+3], Srd127_96                 // Set bits 127_96 in SRD

/* global read addresses: addresses b */
/* max read offset = size[n] * stride[n-1] */
s_mul_hi_u32 s19, s[sgprWorkGroup1], 16            // WorkGroup[01] * MT
s_mul_i32 s18, s[sgprWorkGroup1], 16               // WorkGroup[01] * MT
s_mul_hi_u32 s19, s18, s[sgprStrideB1J]            // tlu=0, scaled tile-offset by stride
s_mul_i32 s18, s18, s[sgprStrideB1J]               // tlu=0, scaled tile-offset by stride
s_and_b32 s16, s[sgprGSU], 0x8000                  // SCC = (GSUC == 1) ?
s_cbranch_scc1 label_GSUC_B                        // branch if GSUC == 1
s_mul_hi_u32 s17, 32, s[sgprGSUSumIdx]             // gsuOffset = DepthU*GSUSumIdx
s_mul_i32 s16, 32, s[sgprGSUSumIdx]                // gsuOffset = DepthU*GSUSumIdx
s_branch label_GSUC_B_End
label_GSUC_B:
s_lshr_b32 s[sgprLoopCounterL], s[sgprSizesSum], 5 // s[LoopCounterL] = s[sgprSizesSum] / 32
s_and_b32 s[sgprGSUSumIdx+1], s[sgprGSU], 0x3fff   // Restore GSU
v_cvt_f32_u32 v20, s[sgprGSUSumIdx+1]              // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
v_rcp_iflag_f32 v20, v20                           // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
v_cvt_f32_u32 v21, s[sgprLoopCounterL]             // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
v_mul_f32 v20, v20, v21                            // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
v_cvt_u32_f32 v20, v20                             // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
v_mul_u32_u24 v21, v20, s[sgprGSUSumIdx+1]         // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
v_sub_nc_u32 v21, s[sgprLoopCounterL], v21         // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
v_cmp_eq_u32 vcc_lo, v21, s[sgprGSUSumIdx+1]       // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
s_mov_b32 exec_lo vcc_lo                           // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
v_add_nc_u32 v20, 1, v20                           // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
v_mov_b32 v21, 0                                   // s[sgprGSUSumIdx+1] = s[sgprLoopCounterL] % s[sgprGSUSumIdx+1]
s_mov_b32 exec_lo, -1                              // Reset exec
v_cmp_gt_u32 vcc_lo, v21, s[sgprGSUSumIdx+1]       // overflow happened in remainder
s_mov_b32 exec_lo vcc_lo                           // overflow happened in remainder
v_sub_nc_u32 v20, v20, 1                           // quotient - 1
v_mul_u32_u24 v21, v20, s[sgprGSUSumIdx+1]         // re-calculate remainder
v_sub_nc_u32 v21, s[sgprLoopCounterL], v21         // re-calculate remainder
s_mov_b32 exec_lo, -1                              // Reset exec
v_readfirstlane_b32 s[sgprLoopCounterL], v20       // quotient
v_readfirstlane_b32 s[sgprGSUSumIdx+1], v21        // remainder
s_mul_i32 s17, s[sgprLoopCounterL], s[sgprGSUSumIdx] // quotient*GSUSumIdx
s_add_u32 s16, 1, s[sgprLoopCounterL]              // quotient+1
s_add_u32 s17, s17, s[sgprGSUSumIdx+1]             // quotient*GSUSumIdx+remainder
s_mul_i32 s16, s16, s[sgprGSUSumIdx]               // (quotient+1)*GSUSumIdx
s_cmp_lt_u32 s[sgprGSUSumIdx], s[sgprGSUSumIdx+1]  // gsuSumIdx < numIterPerWgRemainder
s_cselect_b32 s16, s16, s17                        // (quotient+1)*GSUSumIdx if needed
s_mul_hi_u32 s17, s16, 32                          // gsuOffset = DepthU*accumulatedNumOfLoopCounterL
s_mul_i32 s16, s16, 32                             // gsuOffset = DepthU*accumulatedNumOfLoopCounterL
label_GSUC_B_End:
s_add_u32 s18, s18, s16                            // accum GsuOffset term to tilestart
s_addc_u32 s19, s19, s17                           // accum GsuOffset term to tilestart
s_mov_b64 s[sgprShadowLimitB+0:sgprShadowLimitB+0+1], 1 // Init tensor size
s_sub_u32 s16, s[sgprSizeL], 1                     // (size-1)
s_mul_hi_u32 s17, constStrideBL, s16               // stride x (size-1)
s_mul_i32 s16, constStrideBL, s16                  // stride x (size-1)
s_add_u32 s[sgprShadowLimitB+0], s[sgprShadowLimitB+0], s16 // sum tensor size
s_addc_u32 s[sgprShadowLimitB+1], s[sgprShadowLimitB+1], s17 // sum tensor size
s_sub_u32 s16, s[sgprSizeJ], 1                     // (size-1)
s_mul_hi_u32 s17, s[sgprStrideB1J], s16            // stride x (size-1)
s_mul_i32 s16, s[sgprStrideB1J], s16               // stride x (size-1)
s_add_u32 s[sgprShadowLimitB+0], s[sgprShadowLimitB+0], s16 // sum tensor size
s_addc_u32 s[sgprShadowLimitB+1], s[sgprShadowLimitB+1], s17 // sum tensor size
s_sub_u32 s[sgprShadowLimitB+0], s[sgprShadowLimitB+0], s18 // sub tileStart
s_subb_u32 s[sgprShadowLimitB+1], s[sgprShadowLimitB+1], s19 // sub tileStart
                                                   // Set limit to use bytes (byte is 1, do nothing)
s_add_u32 s[sgprShadowLimitB+0], s[sgprShadowLimitB+0], 8 // extend limit for pre-pad
s_addc_u32 s[sgprShadowLimitB+1], s[sgprShadowLimitB+1], 0 // extend limit for pre-pad
s_cmp_eq_u32 s[sgprShadowLimitB+1], 0              // are we within 2^32?
s_cselect_b32 s[sgprSrdB+2], s[sgprShadowLimitB+0], BufferLimit // Move shadow to real if we are within 2^32
s_mul_hi_u32 s17, s[sgprStrideBK], s[sgprWorkGroup2] // Stride*WG
s_mul_i32 s16, s[sgprStrideBK], s[sgprWorkGroup2]  // Stride*WG
s_add_u32 s18, s18, s16                            // accum wg term to tilestart
s_addc_u32 s19, s19, s17                           // accum wg term to tilestart
                                                   // tileStart *= BPE (multiplier is 1, do nothing)
s_add_u32 s[sgprSrdB+0], s[sgprAddressB+0], s18    // SRD base = Address+ tileStart0
s_addc_u32 s[sgprSrdB+1], s[sgprAddressB+1], s19   // SRD base = Address+ tileStart1
s_mov_b32 s[sgprSrdB+3], Srd127_96                 // Set bits 127_96 in SRD

/* global read addresses: final offsets a */
/* ============================================================= */
GLOBAL_OFFSET_A vgprGlobalReadOffsetA+0,  6, 18, 35 // gROA_0_0_0_0
GLOBAL_OFFSET_A vgprGlobalReadOffsetA+1,  6, 19, 35 // gROA_0_0_1_0
/* ============================================================= */

/* global read addresses: final offsets b */
/* ============================================================= */
GLOBAL_OFFSET_B vgprGlobalReadOffsetB+0,  7, 16, 18 // gROB_0_0_0_0
GLOBAL_OFFSET_B vgprGlobalReadOffsetB+1,  7, 17, 18 // gROB_0_0_1_0
/* ============================================================= */

/* global read addresses: increments a */
s_and_b32 s17, s[sgprGSU], 0x3fff                  // Restore GSU
s_mul_i32 s17, s17, DepthU*BpeAGR                  // GSU*DepthU*Bpe
s_and_b32 s16, s[sgprGSU], 0x8000                  // SCC = (GSUC == 1) ?
s_cmov_b32 s17, DepthU*BpeAGR                      // DepthU*Bpe if GSUC = 1
s_mul_i32 s[sgprGlobalReadIncsA+0], s17, s[sgprStrideAL] // incrA unrollIdx)

/* global read addresses: increments b */
s_and_b32 s17, s[sgprGSU], 0x3fff                  // Restore GSU
s_mul_i32 s17, s17, DepthU*BpeBGR                  // GSU*DepthU*Bpe
s_and_b32 s16, s[sgprGSU], 0x8000                  // SCC = (GSUC == 1) ?
s_cselect_b32 s[sgprGlobalReadIncsB+0], DepthU*BpeBGR, s17 // incrB (unrollIdx)
/* declare loop num iterations */
s_lshr_b32 s[sgprLoopCounterL], s[sgprSizesSum+0], 5 // s[sgprLoopCounterL] = s[sgprSizesSum+0] / 32
s_and_b32 s16, s[sgprGSU], 0x3fff                  // Restore GSU
s_cmp_eq_u32 s16, 1                                // GSU == 1 ?
s_cbranch_scc1 label_GSU_1                         // branch if GSU == 1
s_and_b32 s[sgprGSUSumIdx+1], s[sgprGSU], 0x3fff   // Restore GSU
v_cvt_f32_u32 v0, s[sgprGSUSumIdx+1]               // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
v_rcp_iflag_f32 v0, v0                             // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
v_cvt_f32_u32 v1, s[sgprLoopCounterL]              // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
v_mul_f32 v0, v0, v1                               // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
v_cvt_u32_f32 v0, v0                               // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
v_mul_u32_u24 v1, v0, s[sgprGSUSumIdx+1]           // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
v_sub_nc_u32 v1, s[sgprLoopCounterL], v1           // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
v_cmp_eq_u32 vcc_lo, v1, s[sgprGSUSumIdx+1]        // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
s_mov_b32 exec_lo vcc_lo                           // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
v_add_nc_u32 v0, 1, v0                             // s[sgprLoopCounterL] = s[sgprLoopCounterL] / s[sgprGSUSumIdx+1]
v_mov_b32 v1, 0                                    // s[sgprGSUSumIdx+1] = s[sgprLoopCounterL] % s[sgprGSUSumIdx+1]
s_mov_b32 exec_lo, -1                              // Reset exec
v_cmp_gt_u32 vcc_lo, v1, s[sgprGSUSumIdx+1]        // overflow happened in remainder
s_mov_b32 exec_lo vcc_lo                           // overflow happened in remainder
v_sub_nc_u32 v0, v0, 1                             // quotient - 1
v_mul_u32_u24 v1, v0, s[sgprGSUSumIdx+1]           // re-calculate remainder
v_sub_nc_u32 v1, s[sgprLoopCounterL], v1           // re-calculate remainder
s_mov_b32 exec_lo, -1                              // Reset exec
v_readfirstlane_b32 s[sgprLoopCounterL], v0        // quotient
v_readfirstlane_b32 s[sgprGSUSumIdx+1], v1         // remainder
s_add_u32 s16, 1, s[sgprLoopCounterL]              // tmp<-numIterMyWg+1
s_cmp_lt_u32 s[sgprGSUSumIdx], s[sgprGSUSumIdx+1]  // gsuSumIdx < numIterPerWgRemainder
s_cmov_b32 s[sgprLoopCounterL], s16                // numIterMyWg++ if needed
label_GSU_1:
s_mov_b32 s[sgprOrigLoopCounter], s[sgprLoopCounterL] // copy loop counter
s_and_b32 s18, s[sgprStaggerU], 0x1f00
s_lshr_b32 s18, s18, 0x8
s_and_b32 s19, s[sgprStaggerU], 0xe000
s_and_b32 s[sgprStaggerU], s[sgprStaggerU], 0xff
s_mov_b32 s16, s[sgprStaggerU]                     // init staggerU
label_beginStaggerUIter:
s_lshl_b32 s17, s16, s18                           // shift by StaggerUStride
s_cmp_ge_u32 s[sgprOrigLoopCounter], s17           // loopCount >= current shift Count
s_cbranch_scc1 label_endStaggerUIter               // jump to end
s_lshr_b32 s16, s16, 1                             // step down to smaller stagger
s_branch label_beginStaggerUIter                   // jump to begin
label_endStaggerUIter:
s_sub_u32 s17, s16, 1                              // staggerU mask
s_cmp_ge_u32 s16, 1                                // if current staggerU >= 1
s_cselect_b32 s[sgprStaggerUIter], s17, 0          // set Mask
s_cmp_eq_u32 s19, 0x0
s_cbranch_scc0 label_StaggerUMapping_1
s_mov_b32 s16, s[sgprWorkGroup0]
s_branch label_staggerInputEnd
label_StaggerUMapping_1:
s_cmp_eq_u32 s19, 0x2000
s_cbranch_scc0 label_StaggerUMapping_2
s_mov_b32 s16, s[sgprWorkGroup1]
s_branch label_staggerInputEnd
label_StaggerUMapping_2:
s_cmp_eq_u32 s19, 0x4000
s_cbranch_scc0 label_StaggerUMapping_3
s_mov_b32 s16, -0x1
s_branch label_staggerInputEnd
label_StaggerUMapping_3:
s_cmp_eq_u32 s19, 0x6000
s_cbranch_scc0 label_StaggerUMapping_4
s_mul_i32 s17, s[sgprNumWorkGroups0], s[sgprWorkGroup1]
s_add_u32 s16, s16, s17
s_add_u32 s16, s16, s[sgprWorkGroup0]
s_branch label_staggerInputEnd
label_StaggerUMapping_4:
s_cmp_eq_u32 s19, 0x8000
s_cbranch_scc0 label_staggerInputEnd
s_mov_b32 s16, -0x1
s_branch label_staggerInputEnd
label_staggerInputEnd:
s_and_b32 s[sgprStaggerUIter], s[sgprStaggerUIter], s16 // Compute actual stagger start for this tile
s_lshl_b32 s[sgprStaggerUIter], s[sgprStaggerUIter], s18 // shift by StaggerUStride

/* SRDs += (StaggerUIter) * GlobalReadIncsA+0 */
s_mul_hi_i32 s17, s[sgprStaggerUIter], s[sgprGlobalReadIncsA+0] //  stagger byte offset
s_mul_i32 s16, s[sgprStaggerUIter], s[sgprGlobalReadIncsA+0] //  stagger byte offset
s_mul_hi_i32 s[sgprWrapUA+1], s[sgprLoopCounterL], s[sgprGlobalReadIncsA+0] // Number of bytes accessed by the unroll loop
s_mul_i32 s[sgprWrapUA+0], s[sgprLoopCounterL], s[sgprGlobalReadIncsA+0] // Number of bytes accessed by the unroll loop
s_sub_u32 s[sgprWrapUA+0], s[sgprGlobalReadIncsA+0], s[sgprWrapUA+0] // remove one iteration
s_subb_u32 s[sgprWrapUA+1], 0, s[sgprWrapUA+1]     // remove one iteration
s_add_u32 s[sgprSrdA+0], s[sgprSrdA+0], s16        // gra SRD += inc(lower)
s_addc_u32 s[sgprSrdA+1], s[sgprSrdA+1], s17       // gra SRD += inc(upper)
s_sub_u32 s[sgprShadowLimitA+0], s[sgprShadowLimitA+0], s16 // limit -= inc)
s_subb_u32 s[sgprShadowLimitA+1], s[sgprShadowLimitA+1], s17 // limit -= inc)
s_cmp_eq_u32 s[sgprShadowLimitA+1], 0              // are we within 2^32?
s_cselect_b32 s[sgprSrdA+2], s[sgprShadowLimitA+0], BufferLimit // Move shadow to real if we are within 2^32

/* SRDs += (StaggerUIter) * GlobalReadIncsB+0 */
s_mul_hi_i32 s17, s[sgprStaggerUIter], s[sgprGlobalReadIncsB+0] //  stagger byte offset
s_mul_i32 s16, s[sgprStaggerUIter], s[sgprGlobalReadIncsB+0] //  stagger byte offset
s_mul_hi_i32 s[sgprWrapUB+1], s[sgprLoopCounterL], s[sgprGlobalReadIncsB+0] // Number of bytes accessed by the unroll loop
s_mul_i32 s[sgprWrapUB+0], s[sgprLoopCounterL], s[sgprGlobalReadIncsB+0] // Number of bytes accessed by the unroll loop
s_sub_u32 s[sgprWrapUB+0], s[sgprGlobalReadIncsB+0], s[sgprWrapUB+0] // remove one iteration
s_subb_u32 s[sgprWrapUB+1], 0, s[sgprWrapUB+1]     // remove one iteration
s_add_u32 s[sgprSrdB+0], s[sgprSrdB+0], s16        // gra SRD += inc(lower)
s_addc_u32 s[sgprSrdB+1], s[sgprSrdB+1], s17       // gra SRD += inc(upper)
s_sub_u32 s[sgprShadowLimitB+0], s[sgprShadowLimitB+0], s16 // limit -= inc)
s_subb_u32 s[sgprShadowLimitB+1], s[sgprShadowLimitB+1], s17 // limit -= inc)
s_cmp_eq_u32 s[sgprShadowLimitB+1], 0              // are we within 2^32?
s_cselect_b32 s[sgprSrdB+2], s[sgprShadowLimitB+0], BufferLimit // Move shadow to real if we are within 2^32
s_add_u32 s[sgprStaggerUIter], s[sgprStaggerUIter], 2 // Subtract (PGR-1); StaggerUIter now contains target iteration to wrap
/* local read addresses: init pointers a */
/* local read addresses: init pointers b */

/* localReadInitPointers */

/* prefetch: global -> local */
s_cmp_eq_u32 s[sgprLoopCounterL], 0                // at last iteration?
s_cbranch_scc1 label_ShadowInitStart               // skip to ShadowInitStart iter b/c numIter==0
buffer_load_b64 v[vgprG2LB+0:vgprG2LB+0+1], v[vgprGlobalReadOffsetB+0], s[sgprSrdB:sgprSrdB+3], null offen offset:0 // G -> Reg 0_0_0_0
buffer_load_b64 v[vgprG2LB+2:vgprG2LB+2+1], v[vgprGlobalReadOffsetB+1], s[sgprSrdB:sgprSrdB+3], null offen offset:0 // G -> Reg 0_0_1_0
global_load_tr_b64 v[vgprG2LA+0:vgprG2LA+0+1], v[vgprGlobalReadOffsetA+0], s[sgprSrdA:sgprSrdA+1] // G -> Reg 0_0_0_0
global_load_tr_b64 v[vgprG2LA+2:vgprG2LA+2+1], v[vgprGlobalReadOffsetA+1], s[sgprSrdA:sgprSrdA+1] // G -> Reg 0_0_1_0

/* global read inc A loopL */
s_add_u32 s18, s[sgprLoopCounterL], 1              // remove pf(1)
s_cmp_eq_u32 s[sgprStaggerUIter], s18              // Is this wrapIter? (pf)
s_cselect_b32 s16, s[sgprWrapUA+0], s[sgprGlobalReadIncsA+0] // incLower <- ?
s_cselect_b32 s17, s[sgprWrapUA+1], 0              // incUpper <- ?
s_add_u32 s[sgprSrdA+0], s[sgprSrdA+0], s16        // gra SRD += inc(lower)
s_addc_u32 s[sgprSrdA+1], s[sgprSrdA+1], s17       // gra SRD += inc(upper)
s_sub_u32 s[sgprShadowLimitA+0], s[sgprShadowLimitA+0], s16 // limit -= inc)
s_subb_u32 s[sgprShadowLimitA+1], s[sgprShadowLimitA+1], s17 // limit -= inc)
s_cmp_eq_u32 s[sgprShadowLimitA+1], 0              // are we within 2^32?
s_cselect_b32 s[sgprSrdA+2], s[sgprShadowLimitA+0], BufferLimit // Move shadow to real if we are within 2^32

/* global read inc B loopL */
s_add_u32 s18, s[sgprLoopCounterL], 1              // remove pf(1)
s_cmp_eq_u32 s[sgprStaggerUIter], s18              // Is this wrapIter? (pf)
s_cselect_b32 s16, s[sgprWrapUB+0], s[sgprGlobalReadIncsB+0] // incLower <- ?
s_cselect_b32 s17, s[sgprWrapUB+1], 0              // incUpper <- ?
s_add_u32 s[sgprSrdB+0], s[sgprSrdB+0], s16        // gra SRD += inc(lower)
s_addc_u32 s[sgprSrdB+1], s[sgprSrdB+1], s17       // gra SRD += inc(upper)
s_sub_u32 s[sgprShadowLimitB+0], s[sgprShadowLimitB+0], s16 // limit -= inc)
s_subb_u32 s[sgprShadowLimitB+1], s[sgprShadowLimitB+1], s17 // limit -= inc)
s_cmp_eq_u32 s[sgprShadowLimitB+1], 0              // are we within 2^32?
s_cselect_b32 s[sgprSrdB+2], s[sgprShadowLimitB+0], BufferLimit // Move shadow to real if we are within 2^32

/******************************************/
/* End setupNewTile                       */
/******************************************/
label_ShadowInitStart:
s_mov_b64 s[sgprSrdD+0:sgprSrdD+0+1], s[sgprAddressD+0:sgprAddressD+0+1] // init SRD base address
s_mov_b32 s[sgprSrdD+2], BufferOOB
s_mov_b32 s[sgprSrdD+3], Srd127_96                 // Set bits 127_96 in post-loop SRD

s_mov_b64 s[sgprSrdC+0:sgprSrdC+0+1], s[sgprAddressC+0:sgprAddressC+0+1] // init SRD base address
s_mov_b32 s[sgprSrdC+2], BufferOOB
s_mov_b32 s[sgprSrdC+3], Srd127_96                 // Set bits 127_96 in post-loop SRD


s_mul_i32 s68, MT1, s[sgprWorkGroup1]              // <- wg1*MT1
s_mul_hi_u32 s67, s68, s[sgprStrideC1J]            // ScaleC s68 by Stride
s_mul_i32 s66, s68, s[sgprStrideC1J]               // ScaleC s68 by Stride
s_lshl_b64 s[66:67], s[66:67], s[sgprGSULog2BpeC]  // scale by bpe
s_add_u32 s[sgprSrdC+0], s[sgprAddressC+0], s66    // add lo to SRD
s_addc_u32 s[sgprSrdC+1], s[sgprAddressC+1], s67   // add hi to SRD
s_mul_hi_u32 s67, s68, s[sgprStrideD1J]            // ScaleD s68 by Stride
s_mul_i32 s66, s68, s[sgprStrideD1J]               // ScaleD s68 by Stride
s_lshl_b64 s[66:67], s[66:67], s[sgprGSULog2BpeD]  // scale by bpe
s_add_u32 s[sgprSrdD+0], s[sgprAddressD+0], s66    // add lo to SRD
s_addc_u32 s[sgprSrdD+1], s[sgprAddressD+1], s67   // add hi to SRD

s_mul_hi_u32 s67, s[sgprWorkGroup2], s[sgprStrideCK] // ScaleC s[sgprWorkGroup2] by Stride
s_mul_i32 s66, s[sgprWorkGroup2], s[sgprStrideCK]  // ScaleC s[sgprWorkGroup2] by Stride
s_lshl_b64 s[66:67], s[66:67], s[sgprGSULog2BpeC]  // scale by bpe
s_add_u32 s[sgprSrdC+0], s[sgprSrdC+0], s66        // add lo to SRD
s_addc_u32 s[sgprSrdC+1], s[sgprSrdC+1], s67       // add hi to SRD
s_mul_hi_u32 s67, s[sgprWorkGroup2], s[sgprStrideDK] // ScaleD s[sgprWorkGroup2] by Stride
s_mul_i32 s66, s[sgprWorkGroup2], s[sgprStrideDK]  // ScaleD s[sgprWorkGroup2] by Stride
s_lshl_b64 s[66:67], s[66:67], s[sgprGSULog2BpeD]  // scale by bpe
s_add_u32 s[sgprSrdD+0], s[sgprSrdD+0], s66        // add lo to SRD
s_addc_u32 s[sgprSrdD+1], s[sgprSrdD+1], s67       // add hi to SRD

s_and_b32 s66, s[sgprGSU], 0x3fff                  // Restore GSU
s_cmp_eq_u32 s66, 1                                // GSU == 1 ?
s_cbranch_scc1 label_GSU_2                         // branch if GSU == 1
// GSU Output Buffer offset: Free0 + (Free1-1)*StrideC1J + (Free2-1)*StrideCK * GSUIdx * bpe%s
s_mul_hi_u32 s67, s[sgprSizesFree+0], s[sgprGSUSumIdx] // Free0
s_mul_i32 s66, s[sgprSizesFree+0], s[sgprGSUSumIdx] // Free0
s_sub_u32 s68, s[sgprSizesFree+1], 1               // Free1
s_mul_i32 s68, s68, s[sgprGSUSumIdx]               // Free1
s_mul_hi_u32 s69, s68, s[sgprStrideC1J]            // Free1
s_mul_i32 s68, s68, s[sgprStrideC1J]               // Free1
s_add_u32 s66, s66, s68                            // Free1
s_addc_u32 s67, s67, s69                           // Free1
s_sub_u32 s68, s[sgprSizesFree+2], 1               // Free2
s_mul_i32 s68, s68, s[sgprGSUSumIdx]               // Free2
s_mul_hi_u32 s69, s68, s[sgprStrideCK]             // Free2
s_mul_i32 s68, s68, s[sgprStrideCK]                // Free2
s_add_u32 s66, s66, s68                            // Free2
s_addc_u32 s67, s67, s69                           // Free2
s_lshl_b64 s[66:67], s[66:67], 2                   // scale by bpe
s_add_u32 s[sgprSrdD+0], s[sgprSrdD+0], s66        // add lo GSU offset to SRD
s_addc_u32 s[sgprSrdD+1], s[sgprSrdD+1], s67       // add hi GSU offset to SRD
label_GSU_2:
.set sgprGSULog2BpeC, UNDEF
.set sgprAddressC, UNDEF

/* initC: remove ValuC vgpr buffer [0...8) from pool */

/* initC: remove acc vgpr buffer [0...0) from pool */

/* initC: remove ValuA/B vgpr buffer [16...22) from pool */
v_mov_b32 v[vgprValuC+0], 0                        // initC
v_mov_b32 v[vgprValuC+1], 0                        // initC
v_mov_b32 v[vgprValuC+2], 0                        // initC
v_mov_b32 v[vgprValuC+3], 0                        // initC
v_mov_b32 v[vgprValuC+4], 0                        // initC
v_mov_b32 v[vgprValuC+5], 0                        // initC
v_mov_b32 v[vgprValuC+6], 0                        // initC
v_mov_b32 v[vgprValuC+7], 0                        // initC
s_cmp_eq_u32 s[sgprLoopCounterL], 0                // at last iteration?

/* after InitC, skip to end of prefetch last iter if numIter==0 */
s_cbranch_scc0 label_NoBranch_T8JHFHKM7BO5OHXW     // Only branch on scc1
s_getpc_b64 s[66:67]                               // addr of next instr
s_add_i32 s68, label_PrefetchGlobalLastIterEnd, 4  // target branch offset
s_add_u32 s66, s66, s68                            // add target branch offset
s_addc_u32 s67, s67, 0                             // add high and carry
s_setpc_b64 s[66:67]                               // branch to label_PrefetchGlobalLastIterEnd
label_NoBranch_T8JHFHKM7BO5OHXW:
s_wait_loadcnt 2                                   // wait for global read

/* local write a */

/* local write b */
ds_store_b64 v[vgprLocalWriteAddrB], v[vgprG2LB+0:vgprG2LB+0+1] offset:0 // lwoB_0_0_0_0 = (0*LSCB)*(MT1J+PAD) + (0*LSPB) = 0
ds_store_b64 v[vgprLocalWriteAddrB], v[vgprG2LB+2:vgprG2LB+2+1] offset:272 // lwoB_0_0_1_0 = (0*LSCB)*(MT1J+PAD) + (1*LSPB) = 272

/* local write swap a */

/* local write swap b */
v_xor_b32 v[vgprLocalWriteAddrB], 0x400, v[vgprLocalWriteAddrB] // swap Red Blk
s_wait_dscnt 0                                     // 0prefetch wait for local write
// Skip barrier: NumThreads=32

/* local read prefetch a */

/* local read prefetch b */
ds_load_b64 v[vgprValuB_X0_I0+0:vgprValuB_X0_I0+0+1], v[vgprLocalReadAddrB] offset:0 // L -> Reg lro=0 swapByteOffset=0 ti=16 vIdx=0 eIdx=0 rIdx=0 oIdx=0 buffer=0 iui=0

/* local read inc a */

/* local read inc b */
/* N/A, lro->16 */
/* self.localReadDoCntA 1 self.localReadDoCntB 1 */

/******************************************/
/* Unrolled Loop(s) - Begin               */
/******************************************/
label_openLoopL:
s_cmp_le_u32 s[sgprLoopCounterL], 0x1              // LoopCounterL < EndCounter
s_cbranch_scc1 label_LoopEndL                      // do not enter LoopL
.align 16
label_LoopBeginL:

/******************************************/
/* Unrolled Loop 1/2 - Begin              */
/******************************************/

/* Begin Each Unroll: Check VGPR.checkin for INT8 LW */

/* iter 0 (reset local read pointers iteration)  (swap and reset local write pointers iteration)  (swap local read pointers iteration)  */
s_wait_loadcnt 1                                   // global read wait for DirectToVgpr
/*  grEndMfmaIndex:0, lwStartMfmaIndex:0, lwEndMfmaIndex:0  */
/*  numMfmaForLR:0, syncPlrMfmaIndex:1  */
/*  mfmaIndex:0  */
ds_load_b64 v[vgprValuB_X1_I0+0:vgprValuB_X1_I0+0+1], v[vgprLocalReadAddrB] offset:16 // L -> Reg lro=16 swapByteOffset=0 ti=16 vIdx=0 eIdx=0 rIdx=0 oIdx=0 buffer=1 iui=0
/* localReadsVacancy: latencyLeft 3 */
buffer_load_b64 v[vgprG2LB+0:vgprG2LB+0+1], v[vgprGlobalReadOffsetB+0], s[sgprSrdB:sgprSrdB+3], null offen offset:0 // G -> Reg 0_0_0_0
buffer_load_b64 v[vgprG2LB+2:vgprG2LB+2+1], v[vgprGlobalReadOffsetB+1], s[sgprSrdB:sgprSrdB+3], null offen offset:0 // G -> Reg 0_0_1_0
global_load_tr_b64 v[vgprG2LA2+0:vgprG2LA2+0+1], v[vgprGlobalReadOffsetA+0], s[sgprSrdA:sgprSrdA+1] // G -> Reg 0_0_0_0
global_load_tr_b64 v[vgprG2LA2+2:vgprG2LA2+2+1], v[vgprGlobalReadOffsetA+1], s[sgprSrdA:sgprSrdA+1] // G -> Reg 0_0_1_0

/* global read inc A loopL */
s_cmp_eq_u32 s[sgprLoopCounterL], s[sgprStaggerUIter] // Is this the wrapIter?
s_cselect_b32 s66, s[sgprWrapUA+0], s[sgprGlobalReadIncsA+0] // incLower <- ?
s_cselect_b32 s67, s[sgprWrapUA+1], 0              // incUpper <- ?
s_add_u32 s[sgprSrdA+0], s[sgprSrdA+0], s66        // gra SRD += inc(lower)
s_addc_u32 s[sgprSrdA+1], s[sgprSrdA+1], s67       // gra SRD += inc(upper)
s_sub_u32 s[sgprShadowLimitA+0], s[sgprShadowLimitA+0], s66 // limit -= inc)
s_subb_u32 s[sgprShadowLimitA+1], s[sgprShadowLimitA+1], s67 // limit -= inc)
s_cmp_eq_u32 s[sgprShadowLimitA+1], 0              // are we within 2^32?
s_cselect_b32 s[sgprSrdA+2], s[sgprShadowLimitA+0], BufferLimit // Move shadow to real if we are within 2^32

/* global read inc B loopL */
s_cmp_eq_u32 s[sgprLoopCounterL], s[sgprStaggerUIter] // Is this the wrapIter?
s_cselect_b32 s66, s[sgprWrapUB+0], s[sgprGlobalReadIncsB+0] // incLower <- ?
s_cselect_b32 s67, s[sgprWrapUB+1], 0              // incUpper <- ?
s_add_u32 s[sgprSrdB+0], s[sgprSrdB+0], s66        // gra SRD += inc(lower)
s_addc_u32 s[sgprSrdB+1], s[sgprSrdB+1], s67       // gra SRD += inc(upper)
s_sub_u32 s[sgprShadowLimitB+0], s[sgprShadowLimitB+0], s66 // limit -= inc)
/* sched write - iter 0 writesPerItem=1 */
s_wait_loadcnt 3                                   // wait for global read before writing to local
ds_store_b64 v[vgprLocalWriteAddrB], v[vgprG2LB+0:vgprG2LB+0+1] offset:0 // lwoB_0_0_0_0 = (0*LSCB)*(MT1J+PAD) + (0*LSPB) = 0
/* sched write - iter 0 writesPerItem=1 */
s_wait_loadcnt 2                                   // wait for global read before writing to local
ds_store_b64 v[vgprLocalWriteAddrB], v[vgprG2LB+2:vgprG2LB+2+1] offset:272 // lwoB_0_0_1_0 = (0*LSCB)*(MT1J+PAD) + (1*LSPB) = 272

/* local write swap offsets a */

/* local write swap offsets b */
v_xor_b32 v[vgprLocalWriteAddrB], 0x400, v[vgprLocalWriteAddrB] // swap Red Blk

/* local read swap offsets a */

/* local read swap offsets b */
v_xor_b32 v[vgprLocalReadAddrB], 0x400, v[vgprLocalReadAddrB] // swap Red Blk

/* local read init pointers a */

/* local read init pointers b */

/* localReadInitPointers */
s_wait_dscnt 3                                     // wait for prior local read local write old=0, new=3 newLW=2 newLR=1 for iteration == 0
v_wmma_f32_16x16x16_fp8_fp8 v[0:7], v[vgprG2LA+0+0:vgprG2LA+0+0+1], v[vgprValuB_X0_I0+0+0+0:vgprValuB_X0_I0+0+0+0+1], v[0:7] // left value = v[0+0:7+0]
/* numPrefetchIter=0 */
/* dataAtIterA=-1 numReadsIterA=1 skipReadsIterA=1 readsPerIterA=0 */
/* dataAtIterB=-1 numReadsIterB=1 skipReadsIterB=1 readsPerIterB=1 */

/* iter 1 */
s_wait_loadcnt 4                                   // global read wait for DirectToVgpr
/*  grEndMfmaIndex:0, lwStartMfmaIndex:0, lwEndMfmaIndex:0  */
/*  numMfmaForLR:0, syncPlrMfmaIndex:1  */
/*  mfmaIndex:1  */
s_subb_u32 s[sgprShadowLimitB+1], s[sgprShadowLimitB+1], s67 // limit -= inc)
s_cmp_eq_u32 s[sgprShadowLimitB+1], 0              // are we within 2^32?
s_cselect_b32 s[sgprSrdB+2], s[sgprShadowLimitB+0], BufferLimit // Move shadow to real if we are within 2^32
s_wait_dscnt 0                                     // 3wait for local write
// Skip barrier: NumThreads=32
ds_load_b64 v[vgprValuB_X0_I0+0:vgprValuB_X0_I0+0+1], v[vgprLocalReadAddrB] offset:0 // L -> Reg lro=0 swapByteOffset=0 ti=16 vIdx=0 eIdx=0 rIdx=0 oIdx=0 buffer=0 iui=0
s_wait_dscnt 3                                     // wait for prior local read local write old=0, new=3 newLW=2 newLR=1
v_wmma_f32_16x16x16_fp8_fp8 v[0:7], v[vgprG2LA+2+0:vgprG2LA+2+0+1], v[vgprValuB_X1_I0+0+0+0:vgprValuB_X1_I0+0+0+0+1], v[0:7] // left value = v[0+0:7+0]
/* numPrefetchIter=1 */
/* dataAtIterA=0 numReadsIterA=1 skipReadsIterA=1 readsPerIterA=0 */
/* dataAtIterB=0 numReadsIterB=1 skipReadsIterB=1 readsPerIterB=1 */

/******************************************/
/* Unrolled Loop - End 1/2                */
/******************************************/

/* closeLoop loopL finalLoop=0 tailLoop=0 */
s_sub_u32 s[sgprLoopCounterL], s[sgprLoopCounterL], 1 // dec counterL
s_cmp_eq_i32 s[sgprLoopCounterL], 0x1              // counterL==1
s_cbranch_scc1 label_LoopEndL                      // exit LoopL

/******************************************/
/* Unrolled Loop 2/2 - Begin              */
/******************************************/

/* Begin Each Unroll: Check VGPR.checkin for INT8 LW */

/* iter 0 (reset local read pointers iteration)  (swap and reset local write pointers iteration)  (swap local read pointers iteration)  */
s_wait_loadcnt 1                                   // global read wait for DirectToVgpr
/*  grEndMfmaIndex:0, lwStartMfmaIndex:0, lwEndMfmaIndex:0  */
/*  numMfmaForLR:0, syncPlrMfmaIndex:1  */
/*  mfmaIndex:0  */
ds_load_b64 v[vgprValuB_X1_I0+0:vgprValuB_X1_I0+0+1], v[vgprLocalReadAddrB] offset:16 // L -> Reg lro=16 swapByteOffset=0 ti=16 vIdx=0 eIdx=0 rIdx=0 oIdx=0 buffer=1 iui=0
/* localReadsVacancy: latencyLeft 3 */
buffer_load_b64 v[vgprG2LB+0:vgprG2LB+0+1], v[vgprGlobalReadOffsetB+0], s[sgprSrdB:sgprSrdB+3], null offen offset:0 // G -> Reg 0_0_0_0
buffer_load_b64 v[vgprG2LB+2:vgprG2LB+2+1], v[vgprGlobalReadOffsetB+1], s[sgprSrdB:sgprSrdB+3], null offen offset:0 // G -> Reg 0_0_1_0
global_load_tr_b64 v[vgprG2LA+0:vgprG2LA+0+1], v[vgprGlobalReadOffsetA+0], s[sgprSrdA:sgprSrdA+1] // G -> Reg 0_0_0_0
global_load_tr_b64 v[vgprG2LA+2:vgprG2LA+2+1], v[vgprGlobalReadOffsetA+1], s[sgprSrdA:sgprSrdA+1] // G -> Reg 0_0_1_0

/* global read inc A loopL */
s_cmp_eq_u32 s[sgprLoopCounterL], s[sgprStaggerUIter] // Is this the wrapIter?
s_cselect_b32 s66, s[sgprWrapUA+0], s[sgprGlobalReadIncsA+0] // incLower <- ?
s_cselect_b32 s67, s[sgprWrapUA+1], 0              // incUpper <- ?
s_add_u32 s[sgprSrdA+0], s[sgprSrdA+0], s66        // gra SRD += inc(lower)
s_addc_u32 s[sgprSrdA+1], s[sgprSrdA+1], s67       // gra SRD += inc(upper)
s_sub_u32 s[sgprShadowLimitA+0], s[sgprShadowLimitA+0], s66 // limit -= inc)
s_subb_u32 s[sgprShadowLimitA+1], s[sgprShadowLimitA+1], s67 // limit -= inc)
s_cmp_eq_u32 s[sgprShadowLimitA+1], 0              // are we within 2^32?
s_cselect_b32 s[sgprSrdA+2], s[sgprShadowLimitA+0], BufferLimit // Move shadow to real if we are within 2^32

/* global read inc B loopL */
s_cmp_eq_u32 s[sgprLoopCounterL], s[sgprStaggerUIter] // Is this the wrapIter?
s_cselect_b32 s66, s[sgprWrapUB+0], s[sgprGlobalReadIncsB+0] // incLower <- ?
s_cselect_b32 s67, s[sgprWrapUB+1], 0              // incUpper <- ?
s_add_u32 s[sgprSrdB+0], s[sgprSrdB+0], s66        // gra SRD += inc(lower)
s_addc_u32 s[sgprSrdB+1], s[sgprSrdB+1], s67       // gra SRD += inc(upper)
s_sub_u32 s[sgprShadowLimitB+0], s[sgprShadowLimitB+0], s66 // limit -= inc)
/* sched write - iter 0 writesPerItem=1 */
s_wait_loadcnt 3                                   // wait for global read before writing to local
ds_store_b64 v[vgprLocalWriteAddrB], v[vgprG2LB+0:vgprG2LB+0+1] offset:0 // lwoB_0_0_0_0 = (0*LSCB)*(MT1J+PAD) + (0*LSPB) = 0
/* sched write - iter 0 writesPerItem=1 */
s_wait_loadcnt 2                                   // wait for global read before writing to local
ds_store_b64 v[vgprLocalWriteAddrB], v[vgprG2LB+2:vgprG2LB+2+1] offset:272 // lwoB_0_0_1_0 = (0*LSCB)*(MT1J+PAD) + (1*LSPB) = 272

/* local write swap offsets a */

/* local write swap offsets b */
v_xor_b32 v[vgprLocalWriteAddrB], 0x400, v[vgprLocalWriteAddrB] // swap Red Blk

/* local read swap offsets a */

/* local read swap offsets b */
v_xor_b32 v[vgprLocalReadAddrB], 0x400, v[vgprLocalReadAddrB] // swap Red Blk

/* local read init pointers a */

/* local read init pointers b */

/* localReadInitPointers */
s_wait_dscnt 3                                     // wait for prior local read local write old=0, new=3 newLW=2 newLR=1 for iteration == 0
v_wmma_f32_16x16x16_fp8_fp8 v[0:7], v[vgprG2LA+4+0:vgprG2LA+4+0+1], v[vgprValuB_X0_I0+0+0+0:vgprValuB_X0_I0+0+0+0+1], v[0:7] // left value = v[0+0:7+0]
/* numPrefetchIter=0 */
/* dataAtIterA=-1 numReadsIterA=1 skipReadsIterA=1 readsPerIterA=0 */
/* dataAtIterB=-1 numReadsIterB=1 skipReadsIterB=1 readsPerIterB=1 */

/* iter 1 */
s_wait_loadcnt 4                                   // global read wait for DirectToVgpr
/*  grEndMfmaIndex:0, lwStartMfmaIndex:0, lwEndMfmaIndex:0  */
/*  numMfmaForLR:0, syncPlrMfmaIndex:1  */
/*  mfmaIndex:1  */
s_subb_u32 s[sgprShadowLimitB+1], s[sgprShadowLimitB+1], s67 // limit -= inc)
s_cmp_eq_u32 s[sgprShadowLimitB+1], 0              // are we within 2^32?
s_cselect_b32 s[sgprSrdB+2], s[sgprShadowLimitB+0], BufferLimit // Move shadow to real if we are within 2^32
s_wait_dscnt 0                                     // 3wait for local write
// Skip barrier: NumThreads=32
ds_load_b64 v[vgprValuB_X0_I0+0:vgprValuB_X0_I0+0+1], v[vgprLocalReadAddrB] offset:0 // L -> Reg lro=0 swapByteOffset=0 ti=16 vIdx=0 eIdx=0 rIdx=0 oIdx=0 buffer=0 iui=0
s_wait_dscnt 3                                     // wait for prior local read local write old=0, new=3 newLW=2 newLR=1
v_wmma_f32_16x16x16_fp8_fp8 v[0:7], v[vgprG2LA+6+0:vgprG2LA+6+0+1], v[vgprValuB_X1_I0+0+0+0:vgprValuB_X1_I0+0+0+0+1], v[0:7] // left value = v[0+0:7+0]
/* numPrefetchIter=1 */
/* dataAtIterA=0 numReadsIterA=1 skipReadsIterA=1 readsPerIterA=0 */
/* dataAtIterB=0 numReadsIterB=1 skipReadsIterB=1 readsPerIterB=1 */

/******************************************/
/* Unrolled Loop - End 2/2 (final)        */
/******************************************/

/* closeLoop loopL finalLoop=1 tailLoop=0 */
s_sub_u32 s[sgprLoopCounterL], s[sgprLoopCounterL], 1 // dec counterL
s_cmp_eq_i32 s[sgprLoopCounterL], 0x1              // counterL==1
s_cbranch_scc0 label_LoopBeginL                    // restart LoopL
label_LoopEndL:

/* Before NLL: Check VGPR.checkin for INT8 LW */
s_and_b32 s8, s[sgprGSU], 0x3fff                   // Restore GSU
s_cmp_eq_u32 s8, 1                                 // GSU == 1 ?
s_cbranch_scc0 label_GSU_3                         // branch if GSU != 1

/******************************************/
/* Opt. NoLoadLoop - Begin 1/2            */
/******************************************/
s_mov_b32 s8, 0
s_cmp_eq_u32 s[sgprBeta], s8                       // Beta == 0
s_cbranch_scc0 label_OptNLL_End                    // Branch if Beta is not zero

s_cmp_eq_u32 s[sgprAlpha], 1.0                     // Alpha == 1.0 ?
s_cbranch_scc0 label_OptNLL_End                    // branch if alpha != 1

s_and_b32 s66, 15, s[sgprSizeI]                    // s66 = s[sgprSizeI] % 16
s_add_u32 s67, -0x1, s[sgprNumWorkGroups0]
s_cmp_ge_u32 s[sgprWorkGroup0], s67                // wg0 >= nwg0-1 ?
s_cselect_b32 s66, s66, 0                          // set rem
s_mov_b32 s8, 0
s_cmp_gt_u32 s66, s8                               // rem > 0
s_cbranch_scc1 label_OptNLL_End                    // jump if edges required
s_and_b32 s66, 15, s[sgprSizeJ]                    // s66 = s[sgprSizeJ] % 16
s_add_u32 s67, -0x1, s[sgprNumWorkGroups1]
s_cmp_ge_u32 s[sgprWorkGroup1], s67                // wg1 >= nwg1-1
s_cselect_b32 s66, s66, 0                          // set rem
s_mov_b32 s8, 0
s_cmp_gt_u32 s66, s8                               // rem > 0
s_cbranch_scc1 label_OptNLL_End                    // jump if edges required

s_and_b32 s67, 31, s[sgprSizesSum+0]               // s67 = s[sgprSizesSum+0] % 32
s_cmp_eq_u32 s67, 0                                // numIterL == 0
s_cbranch_scc0 label_OptNLL_End                    // skip if tail loop required
s_bitcmp1_b32 s[sgprOrigLoopCounter], 0            // test if OrigLoopCounter is Odd ?
s_cbranch_scc1 label_OptNLL_second                 // jump to second NoLoadLoop

/* iter 0 (last unrolled loop) */
s_wait_loadcnt 1                                   // global read wait for DirectToVgpr
/*  grEndMfmaIndex:0, lwStartMfmaIndex:0, lwEndMfmaIndex:0  */
/*  numMfmaForLR:0, syncPlrMfmaIndex:1  */
/*  mfmaIndex:0  */
ds_load_b64 v[vgprValuB_X1_I0+0:vgprValuB_X1_I0+0+1], v[vgprLocalReadAddrB] offset:16 // L -> Reg lro=16 swapByteOffset=0 ti=16 vIdx=0 eIdx=0 rIdx=0 oIdx=0 buffer=1 iui=0
/* localReadsVacancy: latencyLeft 3 */
s_wait_dscnt 1                                     // wait for prior local read local write old=0, new=1 newLW=0 newLR=1 for iteration == 0
v_wmma_f32_16x16x16_fp8_fp8 v[0:7], v[vgprG2LA+4+0:vgprG2LA+4+0+1], v[vgprValuB_X0_I0+0+0+0:vgprValuB_X0_I0+0+0+0+1], v[0:7] // left value = v[0+0:7+0]
/* numPrefetchIter=0 */
/* dataAtIterA=-1 numReadsIterA=1 skipReadsIterA=1 readsPerIterA=0 */
/* dataAtIterB=-1 numReadsIterB=1 skipReadsIterB=1 readsPerIterB=1 */

/* iter 1 (last unrolled loop) */
s_wait_loadcnt 0                                   // global read wait for DirectToVgpr
/*  grEndMfmaIndex:0, lwStartMfmaIndex:0, lwEndMfmaIndex:0  */
/*  numMfmaForLR:0, syncPlrMfmaIndex:1  */
/*  mfmaIndex:1  */
s_wait_dscnt 0                                     // wait for prior local read local write old=0, new=0 newLW=0 newLR=0
v_wmma_f32_16x16x16_fp8_fp8 v[0:7], v[vgprG2LA+6+0:vgprG2LA+6+0+1], v[vgprValuB_X1_I0+0+0+0:vgprValuB_X1_I0+0+0+0+1], v[0:7] // left value = v[0+0:7+0]
/* numPrefetchIter=0 */
/* dataAtIterA=0 numReadsIterA=1 skipReadsIterA=0 readsPerIterA=0 */
/* dataAtIterB=0 numReadsIterB=1 skipReadsIterB=0 readsPerIterB=1 */
s_branch label_toPGR1end_OptNLL                    // Branch to toPGR1end

/******************************************/
/* Opt. NoLoadLoop - Begin 2/2            */
/******************************************/
label_OptNLL_second:  /// second Opt NoLoadLoop entry

/* iter 0 (last unrolled loop) */
s_wait_loadcnt 1                                   // global read wait for DirectToVgpr
/*  grEndMfmaIndex:0, lwStartMfmaIndex:0, lwEndMfmaIndex:0  */
/*  numMfmaForLR:0, syncPlrMfmaIndex:1  */
/*  mfmaIndex:0  */
ds_load_b64 v[vgprValuB_X1_I0+0:vgprValuB_X1_I0+0+1], v[vgprLocalReadAddrB] offset:16 // L -> Reg lro=16 swapByteOffset=0 ti=16 vIdx=0 eIdx=0 rIdx=0 oIdx=0 buffer=1 iui=0
/* localReadsVacancy: latencyLeft 3 */
s_wait_dscnt 1                                     // wait for prior local read local write old=0, new=1 newLW=0 newLR=1 for iteration == 0
v_wmma_f32_16x16x16_fp8_fp8 v[0:7], v[vgprG2LA+0+0:vgprG2LA+0+0+1], v[vgprValuB_X0_I0+0+0+0:vgprValuB_X0_I0+0+0+0+1], v[0:7] // left value = v[0+0:7+0]
/* numPrefetchIter=0 */
/* dataAtIterA=-1 numReadsIterA=1 skipReadsIterA=1 readsPerIterA=0 */
/* dataAtIterB=-1 numReadsIterB=1 skipReadsIterB=1 readsPerIterB=1 */

/* iter 1 (last unrolled loop) */
s_wait_loadcnt 0                                   // global read wait for DirectToVgpr
/*  grEndMfmaIndex:0, lwStartMfmaIndex:0, lwEndMfmaIndex:0  */
/*  numMfmaForLR:0, syncPlrMfmaIndex:1  */
/*  mfmaIndex:1  */
s_wait_dscnt 0                                     // wait for prior local read local write old=0, new=0 newLW=0 newLR=0
v_wmma_f32_16x16x16_fp8_fp8 v[0:7], v[vgprG2LA+2+0:vgprG2LA+2+0+1], v[vgprValuB_X1_I0+0+0+0:vgprValuB_X1_I0+0+0+0+1], v[0:7] // left value = v[0+0:7+0]
/* numPrefetchIter=0 */
/* dataAtIterA=0 numReadsIterA=1 skipReadsIterA=0 readsPerIterA=0 */
/* dataAtIterB=0 numReadsIterB=1 skipReadsIterB=0 readsPerIterB=1 */
label_toPGR1end_OptNLL:
/* Stores for OptNLL */
label_Summation_End_OptNLL:
/* endSummation: add vgpr [8...34) to pool */
/* load store sgprs */

/* Mapping of Acc register -> C Vgpr register */

/* Multiply MI out register with Alpha -> C Vgpr register */
/* computeStoreVgprs */
v_lshrrev_b32 v12, 5, v[vgprSerial]                // 12 = Serial / 32
v_lshrrev_b32 v13, 0, v12                          // 13 = 12 / 1
v_mul_lo_u32 v9, 0x10, v13                         // wave coordination offset 1
v_and_b32 v13, 15, v[vgprSerial]                   // v13 = v[vgprSerial] % 16
v_add_lshl_u32 v9, v13, v9, 0                      // coordination 1 = vwB *(wave_id1 + tid1)
v_mul_lo_u32 v10, v9, s[sgprStrideC1J]             //  offset 1
v_mul_lo_u32 v11, v9, s[sgprStrideD1J]             //  offset 1
v_and_b32 v13, 0, v12                              // v13 = v12 % 1
v_mul_lo_u32 v13, 0x10, v13                        // wave coordination offset 0
v_and_b32 v8, 31, v[vgprSerial]                    // v8 = v[vgprSerial] % 32
v_lshrrev_b32 v8, 4, v8                            // 8 = 8 / 16
v_lshlrev_b32 v8, 3, v8                            // thread0 * continuous_output
v_add_lshl_u32 v8, v13, v8, 0                      // coordination 0 = vwA *(wave_id0 + tid0)
s_mul_i32 s8, 16, s[sgprWorkGroup0]                // wgp0 * MT0
v_add_nc_u32 v8, s8, v8                            // coord 0 = (tid0/MI_m)*4 + waveG0*MIB_m + MT0*SG0
s_mul_i32 s8, 16, s[sgprWorkGroup1]                // wgp1 * MT1
v_add_nc_u32 v9, s8, v9                            // coord 1 = (tid0%MI_m) + waveG1*MIB_n + MT1*SG1

/******************************************/
/* Global Write Elements                  */
/******************************************/
label_GW_B0:
label_GW_B0_FD0:
label_GW_B0_FD0_VW8_Then:

/* edge=0, allocate 1 sgpr. perBatchTmpS=1 perBatchMaskS=0 perElementMaskS=0 elementsPerBatch=2 */
/* optSingleColVgpr=1 optSharedColVgpr=0 optSGPRUsage=BufferLoad_Mask optSrdIncForRow=1 factorDim=0 */

/******************************************/
/* Global Write Batch #0 (d1,d0,vc1,vc0) = */
/*    (0,0,0,0:vw8)                       */
/******************************************/

/* calc coords, apply mask, and issue loads (if necessary) */
/* (d1,vc1,d0,vc0)=(0,0,0,0) */
v_add_lshl_u32 v19, v11, v8, 0x0                   // optSingleColVgpr scaleToBpe: sharedAddrVgpr <- cinRowPtr + coord0, scaled by BPE. BSHERE:coord0=8, coord0Vgpr=8
v_mov_b32 v[vgprValuC+24], v[vgprValuC+0]          // copy MI out reg to vreg[0]
v_mov_b32 v[vgprValuC+25], v[vgprValuC+1]          // copy MI out reg to vreg[1]
v_mov_b32 v[vgprValuC+26], v[vgprValuC+2]          // copy MI out reg to vreg[2]
v_mov_b32 v[vgprValuC+27], v[vgprValuC+3]          // copy MI out reg to vreg[3]
v_mov_b32 v[vgprValuC+28], v[vgprValuC+4]          // copy MI out reg to vreg[4]
v_mov_b32 v[vgprValuC+29], v[vgprValuC+5]          // copy MI out reg to vreg[5]
v_mov_b32 v[vgprValuC+30], v[vgprValuC+6]          // copy MI out reg to vreg[6]
v_mov_b32 v[vgprValuC+31], v[vgprValuC+7]          // copy MI out reg to vreg[7]

/* apply mask, calc new C and issue writes */
v_mov_b32 v16, 0x207                               // Nan and +/- inf
v_mov_b32 v18, 0x43E00000                          // Fp8 Max value 448 as float32
v_mov_b32 v17, 0xc3E00000                          // Fp8 Min value -448 as float32
v_cmp_class_f32 s8, v[vgprValuC+24], v16           // Nan and +/- inf
v_med3_f32 v15, v[vgprValuC+24], v17, v18
v_cndmask_b32 v[vgprValuC+24], v15, v[vgprValuC+24], s8
v_cmp_class_f32 s8, v[vgprValuC+25], v16           // Nan and +/- inf
v_med3_f32 v15, v[vgprValuC+25], v17, v18
v_cndmask_b32 v[vgprValuC+25], v15, v[vgprValuC+25], s8
v_cvt_pk_fp8_f32 v24, v[vgprValuC+24], v[vgprValuC+25] op_sel:[0,0,0]
v_cmp_class_f32 s8, v[vgprValuC+26], v16           // Nan and +/- inf
v_med3_f32 v15, v[vgprValuC+26], v17, v18
v_cndmask_b32 v[vgprValuC+26], v15, v[vgprValuC+26], s8
v_cmp_class_f32 s8, v[vgprValuC+27], v16           // Nan and +/- inf
v_med3_f32 v15, v[vgprValuC+27], v17, v18
v_cndmask_b32 v[vgprValuC+27], v15, v[vgprValuC+27], s8
v_cvt_pk_fp8_f32 v24, v[vgprValuC+26], v[vgprValuC+27] op_sel:[0,0,1]
v_cmp_class_f32 s8, v[vgprValuC+28], v16           // Nan and +/- inf
v_med3_f32 v15, v[vgprValuC+28], v17, v18
v_cndmask_b32 v[vgprValuC+28], v15, v[vgprValuC+28], s8
v_cmp_class_f32 s8, v[vgprValuC+29], v16           // Nan and +/- inf
v_med3_f32 v15, v[vgprValuC+29], v17, v18
v_cndmask_b32 v[vgprValuC+29], v15, v[vgprValuC+29], s8
v_cvt_pk_fp8_f32 v25, v[vgprValuC+28], v[vgprValuC+29] op_sel:[0,0,0]
v_cmp_class_f32 s8, v[vgprValuC+30], v16           // Nan and +/- inf
v_med3_f32 v15, v[vgprValuC+30], v17, v18
v_cndmask_b32 v[vgprValuC+30], v15, v[vgprValuC+30], s8
v_cmp_class_f32 s8, v[vgprValuC+31], v16           // Nan and +/- inf
v_med3_f32 v15, v[vgprValuC+31], v17, v18
v_cndmask_b32 v[vgprValuC+31], v15, v[vgprValuC+31], s8
v_cvt_pk_fp8_f32 v25, v[vgprValuC+30], v[vgprValuC+31] op_sel:[0,0,1]
buffer_store_b64 v[24:25], v19, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
s_nop 0                                            // 1 wait state required when next inst writes vgprs held by previous dwordx4 store inst
s_branch label_GW_End                              // jump to end
label_GW_End:

s_endpgm                                           // Kernel End
label_OptNLL_End:
label_GSU_3:

/******************************************/
/* Ord. NoLoadLoop - Begin 1/2            */
/******************************************/
s_bitcmp1_b32 s[sgprOrigLoopCounter], 0            // test if OrigLoopCounter is Odd ?
s_cbranch_scc1 label_OrdNLL_second                 // jump to second NoLoadLoop

/* iter 0 (last unrolled loop) */
s_wait_loadcnt 1                                   // global read wait for DirectToVgpr
/*  grEndMfmaIndex:0, lwStartMfmaIndex:0, lwEndMfmaIndex:0  */
/*  numMfmaForLR:0, syncPlrMfmaIndex:1  */
/*  mfmaIndex:0  */
ds_load_b64 v[vgprValuB_X1_I0+0:vgprValuB_X1_I0+0+1], v[vgprLocalReadAddrB] offset:16 // L -> Reg lro=16 swapByteOffset=0 ti=16 vIdx=0 eIdx=0 rIdx=0 oIdx=0 buffer=1 iui=0
/* localReadsVacancy: latencyLeft 3 */
s_wait_dscnt 1                                     // wait for prior local read local write old=0, new=1 newLW=0 newLR=1 for iteration == 0
v_wmma_f32_16x16x16_fp8_fp8 v[0:7], v[vgprG2LA+4+0:vgprG2LA+4+0+1], v[vgprValuB_X0_I0+0+0+0:vgprValuB_X0_I0+0+0+0+1], v[0:7] // left value = v[0+0:7+0]
/* numPrefetchIter=0 */
/* dataAtIterA=-1 numReadsIterA=1 skipReadsIterA=1 readsPerIterA=0 */
/* dataAtIterB=-1 numReadsIterB=1 skipReadsIterB=1 readsPerIterB=1 */

/* iter 1 (last unrolled loop) */
s_wait_loadcnt 0                                   // global read wait for DirectToVgpr
/*  grEndMfmaIndex:0, lwStartMfmaIndex:0, lwEndMfmaIndex:0  */
/*  numMfmaForLR:0, syncPlrMfmaIndex:1  */
/*  mfmaIndex:1  */
s_wait_dscnt 0                                     // wait for prior local read local write old=0, new=0 newLW=0 newLR=0
v_wmma_f32_16x16x16_fp8_fp8 v[0:7], v[vgprG2LA+6+0:vgprG2LA+6+0+1], v[vgprValuB_X1_I0+0+0+0:vgprValuB_X1_I0+0+0+0+1], v[0:7] // left value = v[0+0:7+0]
/* numPrefetchIter=0 */
/* dataAtIterA=0 numReadsIterA=1 skipReadsIterA=0 readsPerIterA=0 */
/* dataAtIterB=0 numReadsIterB=1 skipReadsIterB=0 readsPerIterB=1 */
s_branch label_toPGR1end_OrdNLL                    // Branch to toPGR1end

/******************************************/
/* Ord. NoLoadLoop - Begin 2/2            */
/******************************************/
label_OrdNLL_second:  /// second Ord NoLoadLoop entry

/* iter 0 (last unrolled loop) */
s_wait_loadcnt 1                                   // global read wait for DirectToVgpr
/*  grEndMfmaIndex:0, lwStartMfmaIndex:0, lwEndMfmaIndex:0  */
/*  numMfmaForLR:0, syncPlrMfmaIndex:1  */
/*  mfmaIndex:0  */
ds_load_b64 v[vgprValuB_X1_I0+0:vgprValuB_X1_I0+0+1], v[vgprLocalReadAddrB] offset:16 // L -> Reg lro=16 swapByteOffset=0 ti=16 vIdx=0 eIdx=0 rIdx=0 oIdx=0 buffer=1 iui=0
/* localReadsVacancy: latencyLeft 3 */
s_wait_dscnt 1                                     // wait for prior local read local write old=0, new=1 newLW=0 newLR=1 for iteration == 0
v_wmma_f32_16x16x16_fp8_fp8 v[0:7], v[vgprG2LA+0+0:vgprG2LA+0+0+1], v[vgprValuB_X0_I0+0+0+0:vgprValuB_X0_I0+0+0+0+1], v[0:7] // left value = v[0+0:7+0]
/* numPrefetchIter=0 */
/* dataAtIterA=-1 numReadsIterA=1 skipReadsIterA=1 readsPerIterA=0 */
/* dataAtIterB=-1 numReadsIterB=1 skipReadsIterB=1 readsPerIterB=1 */

/* iter 1 (last unrolled loop) */
s_wait_loadcnt 0                                   // global read wait for DirectToVgpr
/*  grEndMfmaIndex:0, lwStartMfmaIndex:0, lwEndMfmaIndex:0  */
/*  numMfmaForLR:0, syncPlrMfmaIndex:1  */
/*  mfmaIndex:1  */
s_wait_dscnt 0                                     // wait for prior local read local write old=0, new=0 newLW=0 newLR=0
v_wmma_f32_16x16x16_fp8_fp8 v[0:7], v[vgprG2LA+2+0:vgprG2LA+2+0+1], v[vgprValuB_X1_I0+0+0+0:vgprValuB_X1_I0+0+0+0+1], v[0:7] // left value = v[0+0:7+0]
/* numPrefetchIter=0 */
/* dataAtIterA=0 numReadsIterA=1 skipReadsIterA=0 readsPerIterA=0 */
/* dataAtIterB=0 numReadsIterB=1 skipReadsIterB=0 readsPerIterB=1 */
label_toPGR1end_OrdNLL:
label_PrefetchGlobalLastIterEnd:

/* Tail: add ValuA/B vgpr buffer [16...22) to pool */

/* Tail: add address/G2L vgpr [22...34) to pool */

/******************************************/
/* Tail Loop                              */
/******************************************/

/* local write reset offsets a */

/* local write reset offsets b */
v_and_b32 v[vgprLocalWriteAddrB], 0xf003ff, v[vgprLocalWriteAddrB] // reset to Red
.set vgprG2LA_BASE, 16
.set vgprG2LA, vgprG2LA_BASE+0
.set vgprG2LA2, vgprG2LA_BASE+4
/* Check out VGPR (numG2LA,numG2LB,numG2LMetadata) = (0,4,0) */
.set vgprG2LB_BASE, 24
.set vgprG2LB, vgprG2LB_BASE+0

// numIterL = LOCAL_SPLITU * min(sizeL % LOCAL_DEPTHU, DEPTHU / LOCAL_SPLITU)
s_and_b32 s[sgprLoopCounterL], 31, s[sgprSizesSum+0] // s[sgprLoopCounterL] = s[sgprSizesSum+0] % 32
s_and_b32 s66, s[sgprGSU], 0x8000                  // SCC = (GSUC == 1) ?
s_cbranch_scc1 label_GSUC_TL                       // branch if GSUC == 1
s_cmp_lg_u32 s[sgprGSUSumIdx], s[sgprGSUSumIdx+1]  // gsuSumIdx == numIterPerWgRemainder
s_cmov_b32 s[sgprLoopCounterL], 0                  // numIter=0 if gsuSimIdx != numIterPerWgRemainder
s_branch label_GSUC_TL_End
label_GSUC_TL:
s_lshr_b32 s67, s[sgprSizesSum], 5                 // s67 = s[sgprSizesSum] / 32
s_and_b32 s68, s[sgprGSU], 0x3fff                  // Restore GSU
v_cvt_f32_u32 v28, s68                             // s66 = s67 / s68
v_rcp_iflag_f32 v28, v28                           // s66 = s67 / s68
v_cvt_f32_u32 v29, s67                             // s66 = s67 / s68
v_mul_f32 v28, v28, v29                            // s66 = s67 / s68
v_cvt_u32_f32 v28, v28                             // s66 = s67 / s68
v_mul_u32_u24 v29, v28, s68                        // s66 = s67 / s68
v_sub_nc_u32 v29, s67, v29                         // s66 = s67 / s68
v_cmp_eq_u32 vcc_lo, v29, s68                      // s66 = s67 / s68
s_mov_b32 exec_lo vcc_lo                           // s66 = s67 / s68
v_add_nc_u32 v28, 1, v28                           // s66 = s67 / s68
v_mov_b32 v29, 0                                   // s[sgprGSUSumIdx+1] = s67 % s68
s_mov_b32 exec_lo, -1                              // Reset exec
v_cmp_gt_u32 vcc_lo, v29, s68                      // overflow happened in remainder
s_mov_b32 exec_lo vcc_lo                           // overflow happened in remainder
v_sub_nc_u32 v28, v28, 1                           // quotient - 1
v_mul_u32_u24 v29, v28, s68                        // re-calculate remainder
v_sub_nc_u32 v29, s67, v29                         // re-calculate remainder
s_mov_b32 exec_lo, -1                              // Reset exec
v_readfirstlane_b32 s66, v28                       // quotient
v_readfirstlane_b32 s[sgprGSUSumIdx+1], v29        // remainder
s_sub_u32 s67, s68, 1                              // GSU-1
s_cmp_eq_u32 s66, 0                                // quotient == 0
s_cselect_b32 s66, s[sgprGSUSumIdx+1], s67         // lastWg = (quotient==0) ? numIterPerWgRemainder : GSU-1
s_cmp_lg_u32 s[sgprGSUSumIdx], s66                 // gsuSumIdx == lastWg
s_cmov_b32 s[sgprLoopCounterL], 0                  // numIter=0 if gsuSumIdx != lastWg
label_GSUC_TL_End:
s_cmp_eq_u32 s[sgprLoopCounterL], 0                // numIterL == 0
s_mov_b32 s[sgprOrigLoopCounter], 0                // repurpose to count each localRead increment
s_cbranch_scc1 label_SkipTailLoopL                 // skip to end of tail loop b/c numIter==0

/* remove stagger offsets for tail loop */
s_sub_i32 s66, 3, s[sgprStaggerUIter]
s_cmp_ge_i32 s66, 0
s_cbranch_scc0 label_Negative_S4FDBQ587JJL6NOU
s_mul_hi_u32 s67, s66, s[sgprGlobalReadIncsA+0]    // start offset S in bytes
s_mul_i32 s66, s66, s[sgprGlobalReadIncsA+0]       // start offset S in bytes
s_branch label_MultiplyDone_L43KTIIJOOEN7J6P
label_Negative_S4FDBQ587JJL6NOU:
s_abs_i32 s66, s66
s_mul_hi_u32 s67, s66, s[sgprGlobalReadIncsA+0]    // start offset S in bytes
s_mul_i32 s66, s66, s[sgprGlobalReadIncsA+0]       // start offset S in bytes
s_xor_b32 s66, s66, 0xffffffff
s_xor_b32 s67, s67, 0xffffffff
s_add_u32 s66, s66, 0x1
s_addc_u32 s67, s67, 0
label_MultiplyDone_L43KTIIJOOEN7J6P:
s_sub_u32 s66, s66, s[sgprWrapUA]                  // S - WrapU
s_subb_u32 s67, s67, s[sgprWrapUA+1]               // S - WrapU
s_add_u32 s[sgprSrdA+0], s[sgprSrdA+0], s66        // gra SRD += inc(lower)
s_addc_u32 s[sgprSrdA+1], s[sgprSrdA+1], s67       // gra SRD += inc(upper)
s_sub_u32 s[sgprShadowLimitA+0], s[sgprShadowLimitA+0], s66 // limit -= inc)
s_subb_u32 s[sgprShadowLimitA+1], s[sgprShadowLimitA+1], s67 // limit -= inc)
s_cmp_eq_u32 s[sgprShadowLimitA+1], 0              // are we within 2^32?
s_cselect_b32 s[sgprSrdA+2], s[sgprShadowLimitA+0], BufferLimit // Move shadow to real if we are within 2^32
s_sub_i32 s66, 3, s[sgprStaggerUIter]
s_cmp_ge_i32 s66, 0
s_cbranch_scc0 label_Negative_UR8VN3A1SJCPC6PO
s_mul_hi_u32 s67, s66, s[sgprGlobalReadIncsB+0]    // start offset S in bytes
s_mul_i32 s66, s66, s[sgprGlobalReadIncsB+0]       // start offset S in bytes
s_branch label_MultiplyDone_HYY06MPL0TYYIAT2
label_Negative_UR8VN3A1SJCPC6PO:
s_abs_i32 s66, s66
s_mul_hi_u32 s67, s66, s[sgprGlobalReadIncsB+0]    // start offset S in bytes
s_mul_i32 s66, s66, s[sgprGlobalReadIncsB+0]       // start offset S in bytes
s_xor_b32 s66, s66, 0xffffffff
s_xor_b32 s67, s67, 0xffffffff
s_add_u32 s66, s66, 0x1
s_addc_u32 s67, s67, 0
label_MultiplyDone_HYY06MPL0TYYIAT2:
s_sub_u32 s66, s66, s[sgprWrapUB]                  // S - WrapU
s_subb_u32 s67, s67, s[sgprWrapUB+1]               // S - WrapU
s_add_u32 s[sgprSrdB+0], s[sgprSrdB+0], s66        // gra SRD += inc(lower)
s_addc_u32 s[sgprSrdB+1], s[sgprSrdB+1], s67       // gra SRD += inc(upper)
s_sub_u32 s[sgprShadowLimitB+0], s[sgprShadowLimitB+0], s66 // limit -= inc)
s_subb_u32 s[sgprShadowLimitB+1], s[sgprShadowLimitB+1], s67 // limit -= inc)
s_cmp_eq_u32 s[sgprShadowLimitB+1], 0              // are we within 2^32?
s_cselect_b32 s[sgprSrdB+2], s[sgprShadowLimitB+0], BufferLimit // Move shadow to real if we are within 2^32

/* Update M0 for DTLDS */

/* Tail global read B */
/* g2l=0, load component 0 */
v_mov_b32 v[vgprG2LB+0+0], 0                       // set to zero to avoid unexpected value
buffer_load_d16_u8 v[vgprG2LB+0+0], v[vgprGlobalReadOffsetB+0], s[sgprSrdB:sgprSrdB+3], null offen offset:0 // load one buffer value
/* g2l=0, load component 1 */
v_mov_b32 v35, 0                                   // set to zero to avoid unexpected value
buffer_load_d16_u8 v35, v[vgprGlobalReadOffsetB+0], s[sgprSrdB:sgprSrdB+3], null offen offset:1 // load one buffer value
/* g2l=0, load component 2 */
v_mov_b32 v36, 0                                   // set to zero to avoid unexpected value
buffer_load_d16_hi_u8 v36, v[vgprGlobalReadOffsetB+0], s[sgprSrdB:sgprSrdB+3], null offen offset:2 // load one buffer value
/* g2l=0, load component 3 */
v_mov_b32 v37, 0                                   // set to zero to avoid unexpected value
buffer_load_d16_hi_u8 v37, v[vgprGlobalReadOffsetB+0], s[sgprSrdB:sgprSrdB+3], null offen offset:3 // load one buffer value
/* g2l=0, load component 4 */
v_mov_b32 v[vgprG2LB+0+1], 0                       // set to zero to avoid unexpected value
buffer_load_d16_u8 v[vgprG2LB+0+1], v[vgprGlobalReadOffsetB+0], s[sgprSrdB:sgprSrdB+3], null offen offset:4 // load one buffer value
/* g2l=0, load component 5 */
v_mov_b32 v39, 0                                   // set to zero to avoid unexpected value
buffer_load_d16_u8 v39, v[vgprGlobalReadOffsetB+0], s[sgprSrdB:sgprSrdB+3], null offen offset:5 // load one buffer value
/* g2l=0, load component 6 */
v_mov_b32 v40, 0                                   // set to zero to avoid unexpected value
buffer_load_d16_hi_u8 v40, v[vgprGlobalReadOffsetB+0], s[sgprSrdB:sgprSrdB+3], null offen offset:6 // load one buffer value
/* g2l=0, load component 7 */
v_mov_b32 v41, 0                                   // set to zero to avoid unexpected value
buffer_load_d16_hi_u8 v41, v[vgprGlobalReadOffsetB+0], s[sgprSrdB:sgprSrdB+3], null offen offset:7 // load one buffer value
s_wait_loadcnt 6
v_lshlrev_b32 v35, 0x8, v35                        // shift left to higher 8 bits
v_or_b32 v[vgprG2LB+0+0], v[vgprG2LB+0+0], v35     // pack a sub 8-bit with dest
s_wait_loadcnt 5
v_or_b32 v[vgprG2LB+0+0], v[vgprG2LB+0+0], v36     // pack a sub 8-bit with dest
s_wait_loadcnt 4
v_lshlrev_b32 v37, 0x8, v37                        // shift left to higher 8 bits
v_or_b32 v[vgprG2LB+0+0], v[vgprG2LB+0+0], v37     // pack a sub 8-bit with dest
s_wait_loadcnt 2
v_lshlrev_b32 v39, 0x8, v39                        // shift left to higher 8 bits
v_or_b32 v[vgprG2LB+0+1], v[vgprG2LB+0+1], v39     // pack a sub 8-bit with dest
s_wait_loadcnt 1
v_or_b32 v[vgprG2LB+0+1], v[vgprG2LB+0+1], v40     // pack a sub 8-bit with dest
s_wait_loadcnt 0
v_lshlrev_b32 v41, 0x8, v41                        // shift left to higher 8 bits
v_or_b32 v[vgprG2LB+0+1], v[vgprG2LB+0+1], v41     // pack a sub 8-bit with dest
/* g2l=2, load component 0 */
v_mov_b32 v[vgprG2LB+2+0], 0                       // set to zero to avoid unexpected value
buffer_load_d16_u8 v[vgprG2LB+2+0], v[vgprGlobalReadOffsetB+1], s[sgprSrdB:sgprSrdB+3], null offen offset:0 // load one buffer value
/* g2l=2, load component 1 */
v_mov_b32 v35, 0                                   // set to zero to avoid unexpected value
buffer_load_d16_u8 v35, v[vgprGlobalReadOffsetB+1], s[sgprSrdB:sgprSrdB+3], null offen offset:1 // load one buffer value
/* g2l=2, load component 2 */
v_mov_b32 v36, 0                                   // set to zero to avoid unexpected value
buffer_load_d16_hi_u8 v36, v[vgprGlobalReadOffsetB+1], s[sgprSrdB:sgprSrdB+3], null offen offset:2 // load one buffer value
/* g2l=2, load component 3 */
v_mov_b32 v37, 0                                   // set to zero to avoid unexpected value
buffer_load_d16_hi_u8 v37, v[vgprGlobalReadOffsetB+1], s[sgprSrdB:sgprSrdB+3], null offen offset:3 // load one buffer value
/* g2l=2, load component 4 */
v_mov_b32 v[vgprG2LB+2+1], 0                       // set to zero to avoid unexpected value
buffer_load_d16_u8 v[vgprG2LB+2+1], v[vgprGlobalReadOffsetB+1], s[sgprSrdB:sgprSrdB+3], null offen offset:4 // load one buffer value
/* g2l=2, load component 5 */
v_mov_b32 v39, 0                                   // set to zero to avoid unexpected value
buffer_load_d16_u8 v39, v[vgprGlobalReadOffsetB+1], s[sgprSrdB:sgprSrdB+3], null offen offset:5 // load one buffer value
/* g2l=2, load component 6 */
v_mov_b32 v40, 0                                   // set to zero to avoid unexpected value
buffer_load_d16_hi_u8 v40, v[vgprGlobalReadOffsetB+1], s[sgprSrdB:sgprSrdB+3], null offen offset:6 // load one buffer value
/* g2l=2, load component 7 */
v_mov_b32 v41, 0                                   // set to zero to avoid unexpected value
buffer_load_d16_hi_u8 v41, v[vgprGlobalReadOffsetB+1], s[sgprSrdB:sgprSrdB+3], null offen offset:7 // load one buffer value
s_wait_loadcnt 6
v_lshlrev_b32 v35, 0x8, v35                        // shift left to higher 8 bits
v_or_b32 v[vgprG2LB+2+0], v[vgprG2LB+2+0], v35     // pack a sub 8-bit with dest
s_wait_loadcnt 5
v_or_b32 v[vgprG2LB+2+0], v[vgprG2LB+2+0], v36     // pack a sub 8-bit with dest
s_wait_loadcnt 4
v_lshlrev_b32 v37, 0x8, v37                        // shift left to higher 8 bits
v_or_b32 v[vgprG2LB+2+0], v[vgprG2LB+2+0], v37     // pack a sub 8-bit with dest
s_wait_loadcnt 2
v_lshlrev_b32 v39, 0x8, v39                        // shift left to higher 8 bits
v_or_b32 v[vgprG2LB+2+1], v[vgprG2LB+2+1], v39     // pack a sub 8-bit with dest
s_wait_loadcnt 1
v_or_b32 v[vgprG2LB+2+1], v[vgprG2LB+2+1], v40     // pack a sub 8-bit with dest
s_wait_loadcnt 0
v_lshlrev_b32 v41, 0x8, v41                        // shift left to higher 8 bits
v_or_b32 v[vgprG2LB+2+1], v[vgprG2LB+2+1], v41     // pack a sub 8-bit with dest

/* Update M0 for DTLDS */

/* Tail global read A */

/* Max read address offset for GLTrA */
/* calc last tile offset */
v_lshrrev_b32 v28, 5, v[vgprSerial]                // 28 = Serial / 32
v_and_b32 v28, 0x0, v28                            // GLTrA: wave_id (along_M) mod MIWG[0]
v_mul_u32_u24 v28, 2, v28                          // GLTrA: wave_id (along_M) *= numKr
v_bfe_u32 v32, v[vgprSerial], 2, 1                 // GLTrA: offset for the right half of the tile
v_add_nc_u32 v28, v32, v28                         // GLTrA: wave_id += offset for the right half of the tile
v_lshlrev_b32 v28, 3, v28                          // GLTrA: tile * glvw(8)
v_add_nc_u32 v28, v28, 0
/* calc last unroll offset */
v_mov_b32 v29, s[sgprSizesSum+0]
v_and_b32 v32, 31, v29                             // v32 = v29 % 32
/* final offset */
v_sub_nc_u32 v32, v32, 1                           // GLTrA: unroll idx - 1
GLOBAL_OFFSET_A 28, 28, 32, 29

/* g2l=0, load component 0 */
v_min_i32 v[vgprGlobalReadOffsetA+0], v28, v[vgprGlobalReadOffsetA+0] // truncated load: clamp GRO to legal range
global_load_tr_b64 v[vgprG2LA+0+0:vgprG2LA+0+0+1], v[vgprGlobalReadOffsetA+0], s[sgprSrdA:sgprSrdA+1] // load one buffer value
/* g2l=2, load component 0 */
v_min_i32 v[vgprGlobalReadOffsetA+1], v28, v[vgprGlobalReadOffsetA+1] // truncated load: clamp GRO to legal range
global_load_tr_b64 v[vgprG2LA+2+0:vgprG2LA+2+0+1], v[vgprGlobalReadOffsetA+1], s[sgprSrdA:sgprSrdA+1] // load one buffer value
s_wait_loadcnt 0                                   // 2wait for global read
// Skip barrier: NumThreads=32

/* local write a */

/* local write b */
ds_store_b64 v[vgprLocalWriteAddrB], v[vgprG2LB+0:vgprG2LB+0+1] offset:0 // lwoB_0_0_0_0 = (0*LSCB)*(MT1J+PAD) + (0*LSPB) = 0
ds_store_b64 v[vgprLocalWriteAddrB], v[vgprG2LB+2:vgprG2LB+2+1] offset:272 // lwoB_0_0_1_0 = (0*LSCB)*(MT1J+PAD) + (1*LSPB) = 272
s_wait_dscnt 0                                     // 5wait for local write
// Skip barrier: NumThreads=32
.set vgprG2LB_BASE, UNDEF
.set vgprG2LB, UNDEF
.set vgprValuB_X0_I0_BASE, 24
.set vgprValuB_X0_I0, vgprValuB_X0_I0_BASE+0
.set vgprValuB_X1_I0, vgprValuB_X0_I0_BASE+2
.set vgprPackTemp, 28

/* Tail: local read reset offsets a */

/* Tail: local read reset offsets b */

/* localReadResetOffsets */
/* handled internally */
v_and_b32 v[vgprLocalReadAddrB+0], 0x3ff, v[vgprLocalReadAddrB+0] // reset Red,Blk -> Red

/* Tail: local read init pointers a */

/* Tail: local read init pointers b */

/* localReadInitPointers */

/* tail loop: macs */
.align 16
label_TailLoopBeginL:

/* tail loop unroll iter 0 */

/* local read a */

/* local read b */
ds_load_b64 v[vgprValuB_X0_I0+0:vgprValuB_X0_I0+0+1], v[vgprLocalReadAddrB] offset:0 // L -> Reg lro=0 swapByteOffset=0 ti=16 vIdx=0 eIdx=0 rIdx=0 oIdx=0 buffer=0 iui=0

/* local read inc a */

/* local read inc b */
s_mov_b32 s8, 16                                   // inc
v_add_co_u32 v[vgprLocalReadAddrB+0], vcc_lo, s8, v[vgprLocalReadAddrB+0] // lrB += 16 (bpeDS)
s_wait_dscnt 0                                     // 4wait for local read
v_and_b32 v29, 31, v[vgprSerial]                   // v29 = v[vgprSerial] % 32
v_lshrrev_b32 v29, 4, v29                          // 29 = 29 / 16
v_lshlrev_b32 v29, 3, v29                          // v29 = v29 * 8
v_cmp_ge_i32 s66, v29, s[sgprLoopCounterL]         // check K index >= Size L
v_cndmask_b32 v[vgprG2LA+0+0+0], v[vgprG2LA+0+0+0], 0, s66 // set 0 if K_idx >= sizeL
v_cndmask_b32 v[vgprG2LA+0+0+1], v[vgprG2LA+0+0+1], 0, s66 // set 0 if K_idx >= sizeL
v_cndmask_b32 v[vgprValuB_X0_I0+0+0+0+0], v[vgprValuB_X0_I0+0+0+0+0], 0, s66 // set 0 if K_idx >= sizeL
v_cndmask_b32 v[vgprValuB_X0_I0+0+0+0+1], v[vgprValuB_X0_I0+0+0+0+1], 0, s66 // set 0 if K_idx >= sizeL
v_sub_nc_u32 v30, s[sgprLoopCounterL], v29         // get distance between size and k index
v_cmp_lt_i32 s66, v30, 8                           // set partial 0 if distance less than input per thread
s_and_b32 s68, s[sgprSizeL], 7                     // if summation is multiple of 8, skip masking
s_cmp_eq_u32 s68, 0
s_cbranch_scc1 label_TailLoop_SkipZeroOutMask_8S4L1KCK9VFC7AQU // skip mask
s_and_b32 s68, s[sgprLoopCounterL], 7              // get inputs for edge thread
s_sub_u32 s68, 8, s68                              // use shift to fill 0 for outside element
s_lshl_b32 s68, s68, 3                             // use shift to fill 0 for outside element
v_lshlrev_b64 v[32:33], s68, v[vgprG2LA+0+0:vgprG2LA+0+0+1]
v_cndmask_b32 v[vgprG2LA+0+0+0], v[vgprG2LA+0+0+0], v32, s66
v_cndmask_b32 v[vgprG2LA+0+0+1], v[vgprG2LA+0+0+1], v33, s66
v_lshlrev_b64 v[32:33], s68, v[vgprValuB_X0_I0+0+0+0:vgprValuB_X0_I0+0+0+0+1]
v_cndmask_b32 v[vgprValuB_X0_I0+0+0+0+0], v[vgprValuB_X0_I0+0+0+0+0], v32, s66
v_cndmask_b32 v[vgprValuB_X0_I0+0+0+0+1], v[vgprValuB_X0_I0+0+0+0+1], v33, s66
label_TailLoop_SkipZeroOutMask_8S4L1KCK9VFC7AQU:
s_nop 1
v_wmma_f32_16x16x16_fp8_fp8 v[0:7], v[vgprG2LA+0+0:vgprG2LA+0+0+1], v[vgprValuB_X0_I0+0+0+0:vgprValuB_X0_I0+0+0+0+1], v[0:7] // left value = v[0+0:7+0]

/* closeLoop loopL finalLoop=0 tailLoop=1 */
s_sub_i32 s[sgprLoopCounterL], s[sgprLoopCounterL], 0x10 // dec counterL (tailLoop)
s_add_u32 s[sgprOrigLoopCounter], s[sgprOrigLoopCounter], 0x10 // inc counterL
s_cmp_le_i32 s[sgprLoopCounterL], 0x0              // counterL<=0
s_cbranch_scc1 label_TailLoopEndL                  // exit LoopL

/* tail loop unroll iter 1 */

/* local read a */

/* local read b */
ds_load_b64 v[vgprValuB_X1_I0+0:vgprValuB_X1_I0+0+1], v[vgprLocalReadAddrB] offset:0 // L -> Reg lro=0 swapByteOffset=0 ti=16 vIdx=0 eIdx=0 rIdx=0 oIdx=0 buffer=1 iui=0

/* local read inc a */

/* local read inc b */
s_mov_b32 s8, 16                                   // inc
v_add_co_u32 v[vgprLocalReadAddrB+0], vcc_lo, s8, v[vgprLocalReadAddrB+0] // lrB += 16 (bpeDS)
s_wait_dscnt 0                                     // 4wait for local read
v_and_b32 v29, 31, v[vgprSerial]                   // v29 = v[vgprSerial] % 32
v_lshrrev_b32 v29, 4, v29                          // 29 = 29 / 16
v_lshlrev_b32 v29, 3, v29                          // v29 = v29 * 8
v_cmp_ge_i32 s66, v29, s[sgprLoopCounterL]         // check K index >= Size L
v_cndmask_b32 v[vgprG2LA+2+0+0], v[vgprG2LA+2+0+0], 0, s66 // set 0 if K_idx >= sizeL
v_cndmask_b32 v[vgprG2LA+2+0+1], v[vgprG2LA+2+0+1], 0, s66 // set 0 if K_idx >= sizeL
v_cndmask_b32 v[vgprValuB_X1_I0+0+0+0+0], v[vgprValuB_X1_I0+0+0+0+0], 0, s66 // set 0 if K_idx >= sizeL
v_cndmask_b32 v[vgprValuB_X1_I0+0+0+0+1], v[vgprValuB_X1_I0+0+0+0+1], 0, s66 // set 0 if K_idx >= sizeL
v_sub_nc_u32 v30, s[sgprLoopCounterL], v29         // get distance between size and k index
v_cmp_lt_i32 s66, v30, 8                           // set partial 0 if distance less than input per thread
s_and_b32 s68, s[sgprSizeL], 7                     // if summation is multiple of 8, skip masking
s_cmp_eq_u32 s68, 0
s_cbranch_scc1 label_TailLoop_SkipZeroOutMask_ZU0B7F2XE71N7LVL // skip mask
s_and_b32 s68, s[sgprLoopCounterL], 7              // get inputs for edge thread
s_sub_u32 s68, 8, s68                              // use shift to fill 0 for outside element
s_lshl_b32 s68, s68, 3                             // use shift to fill 0 for outside element
v_lshlrev_b64 v[32:33], s68, v[vgprG2LA+2+0:vgprG2LA+2+0+1]
v_cndmask_b32 v[vgprG2LA+2+0+0], v[vgprG2LA+2+0+0], v32, s66
v_cndmask_b32 v[vgprG2LA+2+0+1], v[vgprG2LA+2+0+1], v33, s66
v_lshlrev_b64 v[32:33], s68, v[vgprValuB_X1_I0+0+0+0:vgprValuB_X1_I0+0+0+0+1]
v_cndmask_b32 v[vgprValuB_X1_I0+0+0+0+0], v[vgprValuB_X1_I0+0+0+0+0], v32, s66
v_cndmask_b32 v[vgprValuB_X1_I0+0+0+0+1], v[vgprValuB_X1_I0+0+0+0+1], v33, s66
label_TailLoop_SkipZeroOutMask_ZU0B7F2XE71N7LVL:
s_nop 1
v_wmma_f32_16x16x16_fp8_fp8 v[0:7], v[vgprG2LA+2+0:vgprG2LA+2+0+1], v[vgprValuB_X1_I0+0+0+0:vgprValuB_X1_I0+0+0+0+1], v[0:7] // left value = v[0+0:7+0]

/* closeLoop loopL finalLoop=1 tailLoop=1 */
s_sub_i32 s[sgprLoopCounterL], s[sgprLoopCounterL], 0x10 // dec counterL (tailLoop)
s_add_u32 s[sgprOrigLoopCounter], s[sgprOrigLoopCounter], 0x10 // inc counterL
s_cmp_le_i32 s[sgprLoopCounterL], 0x0              // counterL<=0
s_cbranch_scc0 label_TailLoopBeginL                // restart LoopL
label_TailLoopEndL:
label_SkipTailLoopL:
.set vgprValuB_X0_I0_BASE, UNDEF
.set vgprValuB_X0_I0, UNDEF
.set vgprValuB_X1_I0, UNDEF
.set vgprPackTemp, UNDEF
.set vgprG2LA_BASE, UNDEF
.set vgprG2LA, UNDEF
.set vgprG2LA2, UNDEF
label_Summation_End_J5DQFVGFWLXU2DUR:
.set sgprWGM, UNDEF
.set sgprLoopCounterL, UNDEF
.set sgprOrigLoopCounter, UNDEF
.set sgprAddressA, UNDEF
.set sgprAddressB, UNDEF
.set sgprStridesA, UNDEF
.set sgprStridesB, UNDEF
.set sgprStaggerUIter, UNDEF
.set sgprSrdA, UNDEF
.set sgprSrdB, UNDEF
.set sgprShadowLimitA, UNDEF
.set sgprShadowLimitB, UNDEF
.set sgprWrapUA, UNDEF
.set sgprWrapUB, UNDEF
.set sgprGlobalReadIncsA, UNDEF
.set sgprGlobalReadIncsB, UNDEF
/* load store sgprs */

/* Mapping of Acc register -> C Vgpr register */

/* Multiply MI out register with Alpha -> C Vgpr register */

/* shift vector components d0 */
v_mov_b32 v19, s[sgprWorkGroup0]
v_mul_i32_i24 v19, -0x10, v19                      // wg*MT
v_add_co_u32 v19, vcc_lo, s[sgprSizesFree+0], v19  // wgMT = Size - wg*MT
v_mov_b32 v20, 0x10                                // MT
v_cmp_lt_u32 s8, v19, v20                          // wgMT < MT
v_cndmask_b32 v19, v20, v19, s8                    // wgMT = (wgMT < MT) ? wgMT : MT
v_lshrrev_b32 v21, 5, v[vgprSerial]                // 21 = Serial / 32
v_and_b32 v21, 0, v21                              // v21 = v21 % 1
v_lshrrev_b32 v22, 4, v19                          // 22 = 19 / 16
v_and_b32 v22, 0, v22                              // v22 = v22 % 1
v_cmp_eq_u32 s8, v22, v21                          // wave_id == block_belong_to_wave?
v_cndmask_b32 v19, v20, v19, s8                    // wgMT = (wgMT < MT) ? wgMT : MT

/* mbReg: which mb block need to shift, mb(matrixInstCoal(16) * VectorWidth(1)) */
v_lshrrev_b32 v20, 4, v19                          // 20 = 19 / 16
v_lshlrev_b32 v22, 0, v21                          // v22 = v21 * 1
v_sub_nc_u32 v20, v20, v22

/* gbReg: glvw block id */
v_lshrrev_b32 v22, 3, v19                          // 22 = 19 / 8

/* tgbReg: glvw block id */
v_lshrrev_b32 v23, 4, v[vgprSerial]                // 23 = Serial / 16
v_and_b32 v23, 1, v23                              // v23 = v23 % 2
v_lshlrev_b32 v23, 3, v23                          // v23 = v23 * 8
v_lshrrev_b32 v23, 3, v23                          // 23 = 23 / 8
v_lshlrev_b32 v21, 1, v21                          // v21 = v21 * 2
v_add_co_u32 v23, vcc_lo, v21, v23                 // tgbReg = (tid_coal * continOut) / GLVW
v_sub_nc_u32 v22, v22, v23

/* vwReg: glvw in which vw block? */
v_and_b32 v21, 7, v19                              // permute register between threads
v_lshrrev_b32 v21, 3, v21                          // permute register between threads

/* rReg : reminder of M_size % GlobalReadVectorWidth */
v_and_b32 v23, 7, v19                              // v23 = v19 % 8
v_cmp_eq_u32 vcc_lo, v23, 0x1                      // wgMT%VW == 1
s_cbranch_vccnz label_ShiftVectorComponents0_GLVW1 // branch to shift d0 r=1
v_cmp_eq_u32 vcc_lo, v23, 0x2                      // wgMT%VW == 2
s_cbranch_vccnz label_ShiftVectorComponents0_GLVW2 // branch to shift d0 r=2
v_cmp_eq_u32 vcc_lo, v23, 0x3                      // wgMT%VW == 3
s_cbranch_vccnz label_ShiftVectorComponents0_GLVW3 // branch to shift d0 r=3
v_cmp_eq_u32 vcc_lo, v23, 0x4                      // wgMT%VW == 4
s_cbranch_vccnz label_ShiftVectorComponents0_GLVW4 // branch to shift d0 r=4
v_cmp_eq_u32 vcc_lo, v23, 0x5                      // wgMT%VW == 5
s_cbranch_vccnz label_ShiftVectorComponents0_GLVW5 // branch to shift d0 r=5
v_cmp_eq_u32 vcc_lo, v23, 0x6                      // wgMT%VW == 6
s_cbranch_vccnz label_ShiftVectorComponents0_GLVW6 // branch to shift d0 r=6
v_cmp_eq_u32 vcc_lo, v23, 0x7                      // wgMT%VW == 7
s_cbranch_vccnz label_ShiftVectorComponents0_GLVW7 // branch to shift d0 r=7

/* no shifting */
s_branch label_ShiftVectorComponents0_GLVW0

/******************************************/
/* shift d0 r=1                           */
/******************************************/
label_ShiftVectorComponents0_GLVW1:
v_cmp_eq_u32 vcc_lo, v20, 0x0

/* branch to shift d0 r1 mb0 */
s_cbranch_vccnz label_ShiftVectorComponents0_GLVW1_BM0

/******************************************/
/* shift d0 r=2                           */
/******************************************/
label_ShiftVectorComponents0_GLVW2:
v_cmp_eq_u32 vcc_lo, v20, 0x0

/* branch to shift d0 r2 mb0 */
s_cbranch_vccnz label_ShiftVectorComponents0_GLVW2_BM0

/******************************************/
/* shift d0 r=3                           */
/******************************************/
label_ShiftVectorComponents0_GLVW3:
v_cmp_eq_u32 vcc_lo, v20, 0x0

/* branch to shift d0 r3 mb0 */
s_cbranch_vccnz label_ShiftVectorComponents0_GLVW3_BM0

/******************************************/
/* shift d0 r=4                           */
/******************************************/
label_ShiftVectorComponents0_GLVW4:
v_cmp_eq_u32 vcc_lo, v20, 0x0

/* branch to shift d0 r4 mb0 */
s_cbranch_vccnz label_ShiftVectorComponents0_GLVW4_BM0

/******************************************/
/* shift d0 r=5                           */
/******************************************/
label_ShiftVectorComponents0_GLVW5:
v_cmp_eq_u32 vcc_lo, v20, 0x0

/* branch to shift d0 r5 mb0 */
s_cbranch_vccnz label_ShiftVectorComponents0_GLVW5_BM0

/******************************************/
/* shift d0 r=6                           */
/******************************************/
label_ShiftVectorComponents0_GLVW6:
v_cmp_eq_u32 vcc_lo, v20, 0x0

/* branch to shift d0 r6 mb0 */
s_cbranch_vccnz label_ShiftVectorComponents0_GLVW6_BM0

/******************************************/
/* shift d0 r=7                           */
/******************************************/
label_ShiftVectorComponents0_GLVW7:
v_cmp_eq_u32 vcc_lo, v20, 0x0

/* branch to shift d0 r7 mb0 */
s_cbranch_vccnz label_ShiftVectorComponents0_GLVW7_BM0

/******************************************/
/* shift d0 r=1 mb=0                      */
/******************************************/
label_ShiftVectorComponents0_GLVW1_BM0:  /// r1 mb0
v_cmp_eq_u32 vcc_lo, v21, 0x0

/* branch to shift d0 r1 mb0 vw0 */
s_cbranch_vccnz label_ShiftVectorComponents0_GLVW1_BM0_VW0

/******************************************/
/* shift d0 r=2 mb=0                      */
/******************************************/
label_ShiftVectorComponents0_GLVW2_BM0:  /// r2 mb0
v_cmp_eq_u32 vcc_lo, v21, 0x0

/* branch to shift d0 r2 mb0 vw0 */
s_cbranch_vccnz label_ShiftVectorComponents0_GLVW2_BM0_VW0

/******************************************/
/* shift d0 r=3 mb=0                      */
/******************************************/
label_ShiftVectorComponents0_GLVW3_BM0:  /// r3 mb0
v_cmp_eq_u32 vcc_lo, v21, 0x0

/* branch to shift d0 r3 mb0 vw0 */
s_cbranch_vccnz label_ShiftVectorComponents0_GLVW3_BM0_VW0

/******************************************/
/* shift d0 r=4 mb=0                      */
/******************************************/
label_ShiftVectorComponents0_GLVW4_BM0:  /// r4 mb0
v_cmp_eq_u32 vcc_lo, v21, 0x0

/* branch to shift d0 r4 mb0 vw0 */
s_cbranch_vccnz label_ShiftVectorComponents0_GLVW4_BM0_VW0

/******************************************/
/* shift d0 r=5 mb=0                      */
/******************************************/
label_ShiftVectorComponents0_GLVW5_BM0:  /// r5 mb0
v_cmp_eq_u32 vcc_lo, v21, 0x0

/* branch to shift d0 r5 mb0 vw0 */
s_cbranch_vccnz label_ShiftVectorComponents0_GLVW5_BM0_VW0

/******************************************/
/* shift d0 r=6 mb=0                      */
/******************************************/
label_ShiftVectorComponents0_GLVW6_BM0:  /// r6 mb0
v_cmp_eq_u32 vcc_lo, v21, 0x0

/* branch to shift d0 r6 mb0 vw0 */
s_cbranch_vccnz label_ShiftVectorComponents0_GLVW6_BM0_VW0

/******************************************/
/* shift d0 r=7 mb=0                      */
/******************************************/
label_ShiftVectorComponents0_GLVW7_BM0:  /// r7 mb0
v_cmp_eq_u32 vcc_lo, v21, 0x0

/* branch to shift d0 r7 mb0 vw0 */
s_cbranch_vccnz label_ShiftVectorComponents0_GLVW7_BM0_VW0

/******************************************/
/* shift d0 r=1 mb=0 vw0                  */
/******************************************/
label_ShiftVectorComponents0_GLVW1_BM0_VW0:  /// r1 mb0 vw0
s_mov_b32 s8, 0
v_cmp_eq_u32 s8, v22, s8                           // is thread in edge glvw region
s_mov_b32 exec_lo s8                               // is thread in edge glvw region
v_and_b32 v16, 31, v[vgprSerial]                   // permute register between threads
v_lshlrev_b32 v16, 2, v16                          // permute register between threads
v_mov_b32 v23, v7                                  // glvw 1 mb 0 tt1 0 r 0
v_mov_b32 v0, v23
s_mov_b32 s8, 0xFFFFFFFF                           // to restore all threads active
s_or_saveexec_b32 vcc_lo, s8                       // all threads active

/* no shifting */
s_branch label_ShiftVectorComponents0_GLVW0


/******************************************/
/* shift d0 r=2 mb=0 vw0                  */
/******************************************/
label_ShiftVectorComponents0_GLVW2_BM0_VW0:  /// r2 mb0 vw0
s_mov_b32 s8, 0
v_cmp_eq_u32 s8, v22, s8                           // is thread in edge glvw region
s_mov_b32 exec_lo s8                               // is thread in edge glvw region
v_and_b32 v16, 31, v[vgprSerial]                   // permute register between threads
v_lshlrev_b32 v16, 2, v16                          // permute register between threads
v_mov_b32 v23, v6                                  // glvw 2 mb 0 tt1 0 r 0
v_mov_b32 v24, v7                                  // glvw 2 mb 0 tt1 0 r 0
v_mov_b32 v0, v23
v_mov_b32 v1, v24
s_mov_b32 s8, 0xFFFFFFFF                           // to restore all threads active
s_or_saveexec_b32 vcc_lo, s8                       // all threads active

/* no shifting */
s_branch label_ShiftVectorComponents0_GLVW0


/******************************************/
/* shift d0 r=3 mb=0 vw0                  */
/******************************************/
label_ShiftVectorComponents0_GLVW3_BM0_VW0:  /// r3 mb0 vw0
s_mov_b32 s8, 0
v_cmp_eq_u32 s8, v22, s8                           // is thread in edge glvw region
s_mov_b32 exec_lo s8                               // is thread in edge glvw region
v_and_b32 v16, 31, v[vgprSerial]                   // permute register between threads
v_lshlrev_b32 v16, 2, v16                          // permute register between threads
v_mov_b32 v23, v5                                  // glvw 3 mb 0 tt1 0 r 0
v_mov_b32 v24, v6                                  // glvw 3 mb 0 tt1 0 r 0
v_mov_b32 v25, v7                                  // glvw 3 mb 0 tt1 0 r 0
v_mov_b32 v0, v23
v_mov_b32 v1, v24
v_mov_b32 v2, v25
s_mov_b32 s8, 0xFFFFFFFF                           // to restore all threads active
s_or_saveexec_b32 vcc_lo, s8                       // all threads active

/* no shifting */
s_branch label_ShiftVectorComponents0_GLVW0


/******************************************/
/* shift d0 r=4 mb=0 vw0                  */
/******************************************/
label_ShiftVectorComponents0_GLVW4_BM0_VW0:  /// r4 mb0 vw0
s_mov_b32 s8, 0
v_cmp_eq_u32 s8, v22, s8                           // is thread in edge glvw region
s_mov_b32 exec_lo s8                               // is thread in edge glvw region
v_and_b32 v16, 31, v[vgprSerial]                   // permute register between threads
v_lshlrev_b32 v16, 2, v16                          // permute register between threads
v_mov_b32 v23, v4                                  // glvw 4 mb 0 tt1 0 r 0
v_mov_b32 v24, v5                                  // glvw 4 mb 0 tt1 0 r 0
v_mov_b32 v25, v6                                  // glvw 4 mb 0 tt1 0 r 0
v_mov_b32 v26, v7                                  // glvw 4 mb 0 tt1 0 r 0
v_mov_b32 v0, v23
v_mov_b32 v1, v24
v_mov_b32 v2, v25
v_mov_b32 v3, v26
s_mov_b32 s8, 0xFFFFFFFF                           // to restore all threads active
s_or_saveexec_b32 vcc_lo, s8                       // all threads active

/* no shifting */
s_branch label_ShiftVectorComponents0_GLVW0


/******************************************/
/* shift d0 r=5 mb=0 vw0                  */
/******************************************/
label_ShiftVectorComponents0_GLVW5_BM0_VW0:  /// r5 mb0 vw0
s_mov_b32 s8, 0
v_cmp_eq_u32 s8, v22, s8                           // is thread in edge glvw region
s_mov_b32 exec_lo s8                               // is thread in edge glvw region
v_and_b32 v16, 31, v[vgprSerial]                   // permute register between threads
v_lshlrev_b32 v16, 2, v16                          // permute register between threads
v_mov_b32 v23, v3                                  // glvw 5 mb 0 tt1 0 r 0
v_mov_b32 v24, v4                                  // glvw 5 mb 0 tt1 0 r 0
v_mov_b32 v25, v5                                  // glvw 5 mb 0 tt1 0 r 0
v_mov_b32 v26, v6                                  // glvw 5 mb 0 tt1 0 r 0
v_mov_b32 v27, v7                                  // glvw 5 mb 0 tt1 0 r 0
v_mov_b32 v0, v23
v_mov_b32 v1, v24
v_mov_b32 v2, v25
v_mov_b32 v3, v26
v_mov_b32 v4, v27
s_mov_b32 s8, 0xFFFFFFFF                           // to restore all threads active
s_or_saveexec_b32 vcc_lo, s8                       // all threads active

/* no shifting */
s_branch label_ShiftVectorComponents0_GLVW0


/******************************************/
/* shift d0 r=6 mb=0 vw0                  */
/******************************************/
label_ShiftVectorComponents0_GLVW6_BM0_VW0:  /// r6 mb0 vw0
s_mov_b32 s8, 0
v_cmp_eq_u32 s8, v22, s8                           // is thread in edge glvw region
s_mov_b32 exec_lo s8                               // is thread in edge glvw region
v_and_b32 v16, 31, v[vgprSerial]                   // permute register between threads
v_lshlrev_b32 v16, 2, v16                          // permute register between threads
v_mov_b32 v23, v2                                  // glvw 6 mb 0 tt1 0 r 0
v_mov_b32 v24, v3                                  // glvw 6 mb 0 tt1 0 r 0
v_mov_b32 v25, v4                                  // glvw 6 mb 0 tt1 0 r 0
v_mov_b32 v26, v5                                  // glvw 6 mb 0 tt1 0 r 0
v_mov_b32 v27, v6                                  // glvw 6 mb 0 tt1 0 r 0
v_mov_b32 v28, v7                                  // glvw 6 mb 0 tt1 0 r 0
v_mov_b32 v0, v23
v_mov_b32 v1, v24
v_mov_b32 v2, v25
v_mov_b32 v3, v26
v_mov_b32 v4, v27
v_mov_b32 v5, v28
s_mov_b32 s8, 0xFFFFFFFF                           // to restore all threads active
s_or_saveexec_b32 vcc_lo, s8                       // all threads active

/* no shifting */
s_branch label_ShiftVectorComponents0_GLVW0


/******************************************/
/* shift d0 r=7 mb=0 vw0                  */
/******************************************/
label_ShiftVectorComponents0_GLVW7_BM0_VW0:  /// r7 mb0 vw0
s_mov_b32 s8, 0
v_cmp_eq_u32 s8, v22, s8                           // is thread in edge glvw region
s_mov_b32 exec_lo s8                               // is thread in edge glvw region
v_and_b32 v16, 31, v[vgprSerial]                   // permute register between threads
v_lshlrev_b32 v16, 2, v16                          // permute register between threads
v_mov_b32 v23, v1                                  // glvw 7 mb 0 tt1 0 r 0
v_mov_b32 v24, v2                                  // glvw 7 mb 0 tt1 0 r 0
v_mov_b32 v25, v3                                  // glvw 7 mb 0 tt1 0 r 0
v_mov_b32 v26, v4                                  // glvw 7 mb 0 tt1 0 r 0
v_mov_b32 v27, v5                                  // glvw 7 mb 0 tt1 0 r 0
v_mov_b32 v28, v6                                  // glvw 7 mb 0 tt1 0 r 0
v_mov_b32 v29, v7                                  // glvw 7 mb 0 tt1 0 r 0
v_mov_b32 v0, v23
v_mov_b32 v1, v24
v_mov_b32 v2, v25
v_mov_b32 v3, v26
v_mov_b32 v4, v27
v_mov_b32 v5, v28
v_mov_b32 v6, v29
s_mov_b32 s8, 0xFFFFFFFF                           // to restore all threads active
s_or_saveexec_b32 vcc_lo, s8                       // all threads active

/* no shifting */
s_branch label_ShiftVectorComponents0_GLVW0

label_ShiftVectorComponents0_GLVW0:  /// end shift0

/* not-LocalSplitU: global write indices */
/* computeStoreVgprs */
v_lshrrev_b32 v20, 5, v[vgprSerial]                // 20 = Serial / 32
v_lshrrev_b32 v21, 0, v20                          // 21 = 20 / 1
v_mul_lo_u32 v17, 0x10, v21                        // wave coordination offset 1
v_and_b32 v21, 15, v[vgprSerial]                   // v21 = v[vgprSerial] % 16
v_add_lshl_u32 v17, v21, v17, 0                    // coordination 1 = vwB *(wave_id1 + tid1)
v_mul_lo_u32 v18, v17, s[sgprStrideC1J]            //  offset 1
v_mul_lo_u32 v19, v17, s[sgprStrideD1J]            //  offset 1
v_and_b32 v21, 0, v20                              // v21 = v20 % 1
v_mul_lo_u32 v21, 0x10, v21                        // wave coordination offset 0
v_and_b32 v16, 31, v[vgprSerial]                   // v16 = v[vgprSerial] % 32
v_lshrrev_b32 v16, 4, v16                          // 16 = 16 / 16
v_lshlrev_b32 v16, 3, v16                          // thread0 * continuous_output
v_add_lshl_u32 v16, v21, v16, 0                    // coordination 0 = vwA *(wave_id0 + tid0)
s_mul_i32 s8, 16, s[sgprWorkGroup0]                // wgp0 * MT0
v_add_nc_u32 v16, s8, v16                          // coord 0 = (tid0/MI_m)*4 + waveG0*MIB_m + MT0*SG0
s_mul_i32 s8, 16, s[sgprWorkGroup1]                // wgp1 * MT1
v_add_nc_u32 v17, s8, v17                          // coord 1 = (tid0%MI_m) + waveG1*MIB_n + MT1*SG1

/* not-LocalSplitU: global write */

/******************************************/
/* Global Write Elements                  */
/******************************************/
s_and_b32 s8, s[sgprGSU], 0x3fff                   // Restore GSU
s_cmp_eq_u32 s8, 1                                 // GSU == 1 ?
s_cbranch_scc1 label_GSU_4                         // branch if GSU == 1
label_GW_B0_1:
label_GW_B0_FD0_1:
s_and_b32 s30, 15, s[sgprSizeI]                    // s30 = s[sgprSizeI] % 16
s_add_u32 s31, -0x1, s[sgprNumWorkGroups0]
s_cmp_ge_u32 s[sgprWorkGroup0], s31                // wg0 >= nwg0-1 ?
s_cselect_b32 s30, s30, 0                          // set rem
s_mov_b32 s8, 0
s_cmp_gt_u32 s30, s8                               // rem > 0
s_cbranch_scc1 label_GW_B0_FD0_VW8_Else_1          // jump if edges required
s_and_b32 s30, 15, s[sgprSizeJ]                    // s30 = s[sgprSizeJ] % 16
s_add_u32 s31, -0x1, s[sgprNumWorkGroups1]
s_cmp_ge_u32 s[sgprWorkGroup1], s31                // wg1 >= nwg1-1
s_cselect_b32 s30, s30, 0                          // set rem
s_mov_b32 s8, 0
s_cmp_gt_u32 s30, s8                               // rem > 0
s_cbranch_scc1 label_GW_B0_FD0_VW8_Then_1          // jump if edges required
label_GW_B0_FD0_VW8_NonEdge_1:

/* edge=0, allocate 1 sgpr. perBatchTmpS=1 perBatchMaskS=0 perElementMaskS=0 elementsPerBatch=1 */
/* optSingleColVgpr=1 optSharedColVgpr=0 optSGPRUsage=BufferLoad_Mask optSrdIncForRow=1 factorDim=0 */

/******************************************/
/* Global Write Batch #0 (d1,d0,vc1,vc0) = */
/*    (0,0,0,0:vw8)                       */
/******************************************/

/* calc coords, apply mask, and issue loads (if necessary) */
/* (d1,vc1,d0,vc0)=(0,0,0,0) */
v_add_lshl_u32 v27, v19, v16, 0x2                  // optSingleColVgpr scaleToBpe: sharedAddrVgpr <- cinRowPtr + coord0, scaled by BPE. BSHERE:coord0=16, coord0Vgpr=16

/* rC *= alpha batchElements=[(0, 0, 0, 0)] */
v_mov_b32 v[vgprValuC+40], v[vgprValuC+0]          // Rearrange MI out reg
v_mov_b32 v[vgprValuC+41], v[vgprValuC+1]          // Rearrange MI out reg
v_mov_b32 v[vgprValuC+42], v[vgprValuC+2]          // Rearrange MI out reg
v_mov_b32 v[vgprValuC+43], v[vgprValuC+3]          // Rearrange MI out reg
v_mov_b32 v[vgprValuC+44], v[vgprValuC+4]          // Rearrange MI out reg
v_mov_b32 v[vgprValuC+45], v[vgprValuC+5]          // Rearrange MI out reg
v_mov_b32 v[vgprValuC+46], v[vgprValuC+6]          // Rearrange MI out reg
v_mov_b32 v[vgprValuC+47], v[vgprValuC+7]          // Rearrange MI out reg

/* apply mask, calc new C and issue writes */
buffer_store_b128 v[40:43], v27, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
buffer_store_b128 v[44:47], v27, s[sgprSrdD:sgprSrdD+3], null offen offset:16 // store D
s_nop 0                                            // 1 wait state required when next inst writes vgprs held by previous dwordx4 store inst
s_branch label_GW_End_1                            // jump to end
label_GW_B0_FD0_VW8_NonEdgeEnd_1:
label_GW_B0_FD0_VW8_Then_1:

/* edge=1, allocate 3 sgpr. perBatchTmpS=2 perBatchMaskS=1 perElementMaskS=0 elementsPerBatch=2 */
/* optSingleColVgpr=0 optSharedColVgpr=0 optSGPRUsage=BufferLoad_Edge_Mask optSrdIncForRow=0 factorDim=0 */

/******************************************/
/* Global Write Edge Batch #0 (d1,d0,vc1,vc0) = */
/*    (0,0,0,0:vw8)                       */
/******************************************/

/* calc coords, apply mask, and issue loads (if necessary) */
v_mov_b32 v22, BufferOOB
/* (d1,vc1,d0,vc0)=(0,0,0,0) */
v_cmp_lt_u32 s30, v16, s[sgprSizeI]                // coord0 < size0
v_cmp_lt_u32 s32, v17, s[sgprSizeJ]                // coord1 < size1
s_and_b32 s32, s30, s32                            // in0 && in1
v_add_lshl_u32 v27, v19, v16, 0x2                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v27, v22, v27, s32                   // LDD clip if OOB. offset

/* rC *= alpha batchElements=[(0, 0, 0, 0)] */
v_mov_b32 v[vgprValuC+40], v[vgprValuC+0]          // Rearrange MI out reg
v_mov_b32 v[vgprValuC+41], v[vgprValuC+1]          // Rearrange MI out reg
v_mov_b32 v[vgprValuC+42], v[vgprValuC+2]          // Rearrange MI out reg
v_mov_b32 v[vgprValuC+43], v[vgprValuC+3]          // Rearrange MI out reg
v_mov_b32 v[vgprValuC+44], v[vgprValuC+4]          // Rearrange MI out reg
v_mov_b32 v[vgprValuC+45], v[vgprValuC+5]          // Rearrange MI out reg
v_mov_b32 v[vgprValuC+46], v[vgprValuC+6]          // Rearrange MI out reg
v_mov_b32 v[vgprValuC+47], v[vgprValuC+7]          // Rearrange MI out reg

/* apply mask, calc new C and issue writes */
buffer_store_b128 v[40:43], v27, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
buffer_store_b128 v[44:47], v27, s[sgprSrdD:sgprSrdD+3], null offen offset:16 // store D
s_nop 0                                            // 1 wait state required when next inst writes vgprs held by previous dwordx4 store inst
s_branch label_GW_End_1                            // jump to end
label_GW_B0_FD0_VW8_Else_1:
label_GW_B0_FD0_VW1_Else:
label_GW_B0_FD0_VW1_Then:

/* edge=1, allocate 3 sgpr. perBatchTmpS=2 perBatchMaskS=1 perElementMaskS=0 elementsPerBatch=9 */
/* optSingleColVgpr=0 optSharedColVgpr=0 optSGPRUsage=BufferLoad_Edge_Mask optSrdIncForRow=0 factorDim=0 */

/******************************************/
/* Global Write Edge Batch #0 (d1,d0,vc1,vc0) = */
/*    (0,0,0,0:vw1); (0,0,0,1:vw1); (0,0,0,2:vw1); (0,0,0,3:vw1); (0,0,0,4:vw1); (0,0,0,5:vw1); (0,0,0,6:vw1); (0,0,0,7:vw1) */
/******************************************/

/* calc coords, apply mask, and issue loads (if necessary) */
v_mov_b32 v22, BufferOOB
/* (d1,vc1,d0,vc0)=(0,0,0,0) */
v_cmp_lt_u32 s30, v16, s[sgprSizeI]                // coord0 < size0
v_cmp_lt_u32 s32, v17, s[sgprSizeJ]                // coord1 < size1
s_and_b32 s32, s30, s32                            // in0 && in1
v_add_lshl_u32 v36, v19, v16, 0x2                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v36, v22, v36, s32                   // LDD clip if OOB. offset
/* (d1,vc1,d0,vc0)=(0,0,0,1) */
v_add_co_u32 v20, vcc_lo, v16, 1                   // coord0.1: coord0 += d0*sg0*VW + vc0
v_cmp_lt_u32 s30, v20, s[sgprSizeI]                // coord0 < size0
v_cmp_lt_u32 s32, v17, s[sgprSizeJ]                // coord1 < size1
s_and_b32 s32, s30, s32                            // in0 && in1
v_add_lshl_u32 v37, v19, v20, 0x2                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v37, v22, v37, s32                   // LDD clip if OOB. offset
/* (d1,vc1,d0,vc0)=(0,0,0,2) */
v_add_co_u32 v20, vcc_lo, v16, 2                   // coord0.1: coord0 += d0*sg0*VW + vc0
v_cmp_lt_u32 s30, v20, s[sgprSizeI]                // coord0 < size0
v_cmp_lt_u32 s32, v17, s[sgprSizeJ]                // coord1 < size1
s_and_b32 s32, s30, s32                            // in0 && in1
v_add_lshl_u32 v38, v19, v20, 0x2                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v38, v22, v38, s32                   // LDD clip if OOB. offset
/* (d1,vc1,d0,vc0)=(0,0,0,3) */
v_add_co_u32 v20, vcc_lo, v16, 3                   // coord0.1: coord0 += d0*sg0*VW + vc0
v_cmp_lt_u32 s30, v20, s[sgprSizeI]                // coord0 < size0
v_cmp_lt_u32 s32, v17, s[sgprSizeJ]                // coord1 < size1
s_and_b32 s32, s30, s32                            // in0 && in1
v_add_lshl_u32 v39, v19, v20, 0x2                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v39, v22, v39, s32                   // LDD clip if OOB. offset
/* (d1,vc1,d0,vc0)=(0,0,0,4) */
v_add_co_u32 v20, vcc_lo, v16, 4                   // coord0.1: coord0 += d0*sg0*VW + vc0
v_cmp_lt_u32 s30, v20, s[sgprSizeI]                // coord0 < size0
v_cmp_lt_u32 s32, v17, s[sgprSizeJ]                // coord1 < size1
s_and_b32 s32, s30, s32                            // in0 && in1
v_add_lshl_u32 v40, v19, v20, 0x2                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v40, v22, v40, s32                   // LDD clip if OOB. offset
/* (d1,vc1,d0,vc0)=(0,0,0,5) */
v_add_co_u32 v20, vcc_lo, v16, 5                   // coord0.1: coord0 += d0*sg0*VW + vc0
v_cmp_lt_u32 s30, v20, s[sgprSizeI]                // coord0 < size0
v_cmp_lt_u32 s32, v17, s[sgprSizeJ]                // coord1 < size1
s_and_b32 s32, s30, s32                            // in0 && in1
v_add_lshl_u32 v41, v19, v20, 0x2                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v41, v22, v41, s32                   // LDD clip if OOB. offset
/* (d1,vc1,d0,vc0)=(0,0,0,6) */
v_add_co_u32 v20, vcc_lo, v16, 6                   // coord0.1: coord0 += d0*sg0*VW + vc0
v_cmp_lt_u32 s30, v20, s[sgprSizeI]                // coord0 < size0
v_cmp_lt_u32 s32, v17, s[sgprSizeJ]                // coord1 < size1
s_and_b32 s32, s30, s32                            // in0 && in1
v_add_lshl_u32 v42, v19, v20, 0x2                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v42, v22, v42, s32                   // LDD clip if OOB. offset
/* (d1,vc1,d0,vc0)=(0,0,0,7) */
v_add_co_u32 v20, vcc_lo, v16, 7                   // coord0.1: coord0 += d0*sg0*VW + vc0
v_cmp_lt_u32 s30, v20, s[sgprSizeI]                // coord0 < size0
v_cmp_lt_u32 s32, v17, s[sgprSizeJ]                // coord1 < size1
s_and_b32 s32, s30, s32                            // in0 && in1
v_add_lshl_u32 v43, v19, v20, 0x2                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v43, v22, v43, s32                   // LDD clip if OOB. offset

/* rC *= alpha batchElements=[(0, 0, 0, 0), (0, 0, 0, 1), (0, 0, 0, 2), (0, 0, 0, 3), (0, 0, 0, 4), (0, 0, 0, 5), (0, 0, 0, 6), (0, 0, 0, 7)] */
v_mov_b32 v[vgprValuC+27], v[vgprValuC+0]          // Rearrange MI out reg
v_mov_b32 v[vgprValuC+28], v[vgprValuC+1]          // Rearrange MI out reg
v_mov_b32 v[vgprValuC+29], v[vgprValuC+2]          // Rearrange MI out reg
v_mov_b32 v[vgprValuC+30], v[vgprValuC+3]          // Rearrange MI out reg
v_mov_b32 v[vgprValuC+31], v[vgprValuC+4]          // Rearrange MI out reg
v_mov_b32 v[vgprValuC+32], v[vgprValuC+5]          // Rearrange MI out reg
v_mov_b32 v[vgprValuC+33], v[vgprValuC+6]          // Rearrange MI out reg
v_mov_b32 v[vgprValuC+35], v[vgprValuC+7]          // Rearrange MI out reg

/* apply mask, calc new C and issue writes */
buffer_store_b32 v27, v36, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
buffer_store_b32 v28, v37, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
buffer_store_b32 v29, v38, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
buffer_store_b32 v30, v39, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
buffer_store_b32 v31, v40, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
buffer_store_b32 v32, v41, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
buffer_store_b32 v33, v42, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
buffer_store_b32 v35, v43, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
s_nop 0                                            // 1 wait state required when next inst writes vgprs held by previous dwordx4 store inst
s_branch label_GW_End_1                            // jump to end
label_GW_End_1:
s_getpc_b64 s[30:31]                               // addr of next instr
s_add_i32 s32, label_KernelEnd, 4                  // target branch offset
s_add_u32 s30, s30, s32                            // add target branch offset
s_addc_u32 s31, s31, 0                             // add high and carry
s_setpc_b64 s[30:31]                               // branch to label_KernelEnd
label_GSU_4:
s_mov_b32 s11, 0
s_cmp_eq_u32 s[sgprBeta], s11                      // Beta == 0
s_cbranch_scc0 label_GW_B1                         // Branch if Beta is not zero

label_GW_B0_2:
label_GW_B0_FD0_2:
s_and_b32 s30, 15, s[sgprSizeI]                    // s30 = s[sgprSizeI] % 16
s_add_u32 s31, -0x1, s[sgprNumWorkGroups0]
s_cmp_ge_u32 s[sgprWorkGroup0], s31                // wg0 >= nwg0-1 ?
s_cselect_b32 s30, s30, 0                          // set rem
s_mov_b32 s8, 0
s_cmp_gt_u32 s30, s8                               // rem > 0
s_cbranch_scc1 label_GW_B0_FD0_VW8_Else_2          // jump if edges required
s_and_b32 s30, 15, s[sgprSizeJ]                    // s30 = s[sgprSizeJ] % 16
s_add_u32 s31, -0x1, s[sgprNumWorkGroups1]
s_cmp_ge_u32 s[sgprWorkGroup1], s31                // wg1 >= nwg1-1
s_cselect_b32 s30, s30, 0                          // set rem
s_mov_b32 s8, 0
s_cmp_gt_u32 s30, s8                               // rem > 0
s_cbranch_scc1 label_GW_B0_FD0_VW8_Then_2          // jump if edges required
label_GW_B0_FD0_VW8_NonEdge_2:

/* edge=0, allocate 1 sgpr. perBatchTmpS=1 perBatchMaskS=0 perElementMaskS=0 elementsPerBatch=1 */
/* optSingleColVgpr=1 optSharedColVgpr=0 optSGPRUsage=BufferLoad_Mask optSrdIncForRow=1 factorDim=0 */

/******************************************/
/* Global Write Batch #0 (d1,d0,vc1,vc0) = */
/*    (0,0,0,0:vw8)                       */
/******************************************/

/* calc coords, apply mask, and issue loads (if necessary) */
/* (d1,vc1,d0,vc0)=(0,0,0,0) */
v_add_lshl_u32 v27, v19, v16, 0x0                  // optSingleColVgpr scaleToBpe: sharedAddrVgpr <- cinRowPtr + coord0, scaled by BPE. BSHERE:coord0=16, coord0Vgpr=16

/* rC *= alpha batchElements=[(0, 0, 0, 0)] */
v_mul_f32 v[vgprValuC+40], s[sgprAlpha], v[vgprValuC+0] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+41], s[sgprAlpha], v[vgprValuC+1] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+42], s[sgprAlpha], v[vgprValuC+2] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+43], s[sgprAlpha], v[vgprValuC+3] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+44], s[sgprAlpha], v[vgprValuC+4] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+45], s[sgprAlpha], v[vgprValuC+5] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+46], s[sgprAlpha], v[vgprValuC+6] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+47], s[sgprAlpha], v[vgprValuC+7] // Multiply MI out reg with alpha

/* apply mask, calc new C and issue writes */
v_mov_b32 v24, 0x207                               // Nan and +/- inf
v_mov_b32 v26, 0x43E00000                          // Fp8 Max value 448 as float32
v_mov_b32 v25, 0xc3E00000                          // Fp8 Min value -448 as float32
v_cmp_class_f32 s8, v[vgprValuC+40], v24           // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+40], v25, v26
v_cndmask_b32 v[vgprValuC+40], v23, v[vgprValuC+40], s8
v_cmp_class_f32 s8, v[vgprValuC+41], v24           // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+41], v25, v26
v_cndmask_b32 v[vgprValuC+41], v23, v[vgprValuC+41], s8
v_cvt_pk_fp8_f32 v40, v[vgprValuC+40], v[vgprValuC+41] op_sel:[0,0,0]
v_cmp_class_f32 s8, v[vgprValuC+42], v24           // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+42], v25, v26
v_cndmask_b32 v[vgprValuC+42], v23, v[vgprValuC+42], s8
v_cmp_class_f32 s8, v[vgprValuC+43], v24           // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+43], v25, v26
v_cndmask_b32 v[vgprValuC+43], v23, v[vgprValuC+43], s8
v_cvt_pk_fp8_f32 v40, v[vgprValuC+42], v[vgprValuC+43] op_sel:[0,0,1]
v_cmp_class_f32 s8, v[vgprValuC+44], v24           // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+44], v25, v26
v_cndmask_b32 v[vgprValuC+44], v23, v[vgprValuC+44], s8
v_cmp_class_f32 s8, v[vgprValuC+45], v24           // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+45], v25, v26
v_cndmask_b32 v[vgprValuC+45], v23, v[vgprValuC+45], s8
v_cvt_pk_fp8_f32 v41, v[vgprValuC+44], v[vgprValuC+45] op_sel:[0,0,0]
v_cmp_class_f32 s8, v[vgprValuC+46], v24           // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+46], v25, v26
v_cndmask_b32 v[vgprValuC+46], v23, v[vgprValuC+46], s8
v_cmp_class_f32 s8, v[vgprValuC+47], v24           // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+47], v25, v26
v_cndmask_b32 v[vgprValuC+47], v23, v[vgprValuC+47], s8
v_cvt_pk_fp8_f32 v41, v[vgprValuC+46], v[vgprValuC+47] op_sel:[0,0,1]
buffer_store_b64 v[40:41], v27, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
s_nop 0                                            // 1 wait state required when next inst writes vgprs held by previous dwordx4 store inst
s_branch label_GW_End_2                            // jump to end
label_GW_B0_FD0_VW8_NonEdgeEnd_2:
label_GW_B0_FD0_VW8_Then_2:

/* edge=1, allocate 3 sgpr. perBatchTmpS=2 perBatchMaskS=1 perElementMaskS=0 elementsPerBatch=2 */
/* optSingleColVgpr=0 optSharedColVgpr=0 optSGPRUsage=BufferLoad_Edge_Mask optSrdIncForRow=0 factorDim=0 */

/******************************************/
/* Global Write Edge Batch #0 (d1,d0,vc1,vc0) = */
/*    (0,0,0,0:vw8)                       */
/******************************************/

/* calc coords, apply mask, and issue loads (if necessary) */
v_mov_b32 v22, BufferOOB
/* (d1,vc1,d0,vc0)=(0,0,0,0) */
v_cmp_lt_u32 s30, v16, s[sgprSizeI]                // coord0 < size0
v_cmp_lt_u32 s32, v17, s[sgprSizeJ]                // coord1 < size1
s_and_b32 s32, s30, s32                            // in0 && in1
v_add_lshl_u32 v27, v19, v16, 0x0                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v27, v22, v27, s32                   // LDD clip if OOB. offset

/* rC *= alpha batchElements=[(0, 0, 0, 0)] */
v_mul_f32 v[vgprValuC+40], s[sgprAlpha], v[vgprValuC+0] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+41], s[sgprAlpha], v[vgprValuC+1] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+42], s[sgprAlpha], v[vgprValuC+2] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+43], s[sgprAlpha], v[vgprValuC+3] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+44], s[sgprAlpha], v[vgprValuC+4] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+45], s[sgprAlpha], v[vgprValuC+5] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+46], s[sgprAlpha], v[vgprValuC+6] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+47], s[sgprAlpha], v[vgprValuC+7] // Multiply MI out reg with alpha

/* apply mask, calc new C and issue writes */
v_mov_b32 v24, 0x207                               // Nan and +/- inf
v_mov_b32 v26, 0x43E00000                          // Fp8 Max value 448 as float32
v_mov_b32 v25, 0xc3E00000                          // Fp8 Min value -448 as float32
v_cmp_class_f32 s30, v[vgprValuC+40], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+40], v25, v26
v_cndmask_b32 v[vgprValuC+40], v23, v[vgprValuC+40], s30
v_cmp_class_f32 s30, v[vgprValuC+41], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+41], v25, v26
v_cndmask_b32 v[vgprValuC+41], v23, v[vgprValuC+41], s30
v_cvt_pk_fp8_f32 v40, v[vgprValuC+40], v[vgprValuC+41] op_sel:[0,0,0]
v_cmp_class_f32 s30, v[vgprValuC+42], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+42], v25, v26
v_cndmask_b32 v[vgprValuC+42], v23, v[vgprValuC+42], s30
v_cmp_class_f32 s30, v[vgprValuC+43], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+43], v25, v26
v_cndmask_b32 v[vgprValuC+43], v23, v[vgprValuC+43], s30
v_cvt_pk_fp8_f32 v40, v[vgprValuC+42], v[vgprValuC+43] op_sel:[0,0,1]
v_cmp_class_f32 s30, v[vgprValuC+44], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+44], v25, v26
v_cndmask_b32 v[vgprValuC+44], v23, v[vgprValuC+44], s30
v_cmp_class_f32 s30, v[vgprValuC+45], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+45], v25, v26
v_cndmask_b32 v[vgprValuC+45], v23, v[vgprValuC+45], s30
v_cvt_pk_fp8_f32 v41, v[vgprValuC+44], v[vgprValuC+45] op_sel:[0,0,0]
v_cmp_class_f32 s30, v[vgprValuC+46], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+46], v25, v26
v_cndmask_b32 v[vgprValuC+46], v23, v[vgprValuC+46], s30
v_cmp_class_f32 s30, v[vgprValuC+47], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+47], v25, v26
v_cndmask_b32 v[vgprValuC+47], v23, v[vgprValuC+47], s30
v_cvt_pk_fp8_f32 v41, v[vgprValuC+46], v[vgprValuC+47] op_sel:[0,0,1]
buffer_store_b64 v[40:41], v27, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
s_nop 0                                            // 1 wait state required when next inst writes vgprs held by previous dwordx4 store inst
s_branch label_GW_End_2                            // jump to end
label_GW_B0_FD0_VW8_Else_2:
label_GW_B0_FD0_VW1_Else_1:
label_GW_B0_FD0_VW1_Then_1:

/* edge=1, allocate 3 sgpr. perBatchTmpS=2 perBatchMaskS=1 perElementMaskS=0 elementsPerBatch=9 */
/* optSingleColVgpr=0 optSharedColVgpr=0 optSGPRUsage=BufferLoad_Edge_Mask optSrdIncForRow=0 factorDim=0 */

/******************************************/
/* Global Write Edge Batch #0 (d1,d0,vc1,vc0) = */
/*    (0,0,0,0:vw1); (0,0,0,1:vw1); (0,0,0,2:vw1); (0,0,0,3:vw1); (0,0,0,4:vw1); (0,0,0,5:vw1); (0,0,0,6:vw1); (0,0,0,7:vw1) */
/******************************************/

/* calc coords, apply mask, and issue loads (if necessary) */
v_mov_b32 v22, BufferOOB
/* (d1,vc1,d0,vc0)=(0,0,0,0) */
v_cmp_lt_u32 s30, v16, s[sgprSizeI]                // coord0 < size0
v_cmp_lt_u32 s32, v17, s[sgprSizeJ]                // coord1 < size1
s_and_b32 s32, s30, s32                            // in0 && in1
v_add_lshl_u32 v36, v19, v16, 0x0                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v36, v22, v36, s32                   // LDD clip if OOB. offset
/* (d1,vc1,d0,vc0)=(0,0,0,1) */
v_add_co_u32 v20, vcc_lo, v16, 1                   // coord0.1: coord0 += d0*sg0*VW + vc0
v_cmp_lt_u32 s30, v20, s[sgprSizeI]                // coord0 < size0
v_cmp_lt_u32 s32, v17, s[sgprSizeJ]                // coord1 < size1
s_and_b32 s32, s30, s32                            // in0 && in1
v_add_lshl_u32 v37, v19, v20, 0x0                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v37, v22, v37, s32                   // LDD clip if OOB. offset
/* (d1,vc1,d0,vc0)=(0,0,0,2) */
v_add_co_u32 v20, vcc_lo, v16, 2                   // coord0.1: coord0 += d0*sg0*VW + vc0
v_cmp_lt_u32 s30, v20, s[sgprSizeI]                // coord0 < size0
v_cmp_lt_u32 s32, v17, s[sgprSizeJ]                // coord1 < size1
s_and_b32 s32, s30, s32                            // in0 && in1
v_add_lshl_u32 v38, v19, v20, 0x0                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v38, v22, v38, s32                   // LDD clip if OOB. offset
/* (d1,vc1,d0,vc0)=(0,0,0,3) */
v_add_co_u32 v20, vcc_lo, v16, 3                   // coord0.1: coord0 += d0*sg0*VW + vc0
v_cmp_lt_u32 s30, v20, s[sgprSizeI]                // coord0 < size0
v_cmp_lt_u32 s32, v17, s[sgprSizeJ]                // coord1 < size1
s_and_b32 s32, s30, s32                            // in0 && in1
v_add_lshl_u32 v39, v19, v20, 0x0                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v39, v22, v39, s32                   // LDD clip if OOB. offset
/* (d1,vc1,d0,vc0)=(0,0,0,4) */
v_add_co_u32 v20, vcc_lo, v16, 4                   // coord0.1: coord0 += d0*sg0*VW + vc0
v_cmp_lt_u32 s30, v20, s[sgprSizeI]                // coord0 < size0
v_cmp_lt_u32 s32, v17, s[sgprSizeJ]                // coord1 < size1
s_and_b32 s32, s30, s32                            // in0 && in1
v_add_lshl_u32 v40, v19, v20, 0x0                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v40, v22, v40, s32                   // LDD clip if OOB. offset
/* (d1,vc1,d0,vc0)=(0,0,0,5) */
v_add_co_u32 v20, vcc_lo, v16, 5                   // coord0.1: coord0 += d0*sg0*VW + vc0
v_cmp_lt_u32 s30, v20, s[sgprSizeI]                // coord0 < size0
v_cmp_lt_u32 s32, v17, s[sgprSizeJ]                // coord1 < size1
s_and_b32 s32, s30, s32                            // in0 && in1
v_add_lshl_u32 v41, v19, v20, 0x0                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v41, v22, v41, s32                   // LDD clip if OOB. offset
/* (d1,vc1,d0,vc0)=(0,0,0,6) */
v_add_co_u32 v20, vcc_lo, v16, 6                   // coord0.1: coord0 += d0*sg0*VW + vc0
v_cmp_lt_u32 s30, v20, s[sgprSizeI]                // coord0 < size0
v_cmp_lt_u32 s32, v17, s[sgprSizeJ]                // coord1 < size1
s_and_b32 s32, s30, s32                            // in0 && in1
v_add_lshl_u32 v42, v19, v20, 0x0                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v42, v22, v42, s32                   // LDD clip if OOB. offset
/* (d1,vc1,d0,vc0)=(0,0,0,7) */
v_add_co_u32 v20, vcc_lo, v16, 7                   // coord0.1: coord0 += d0*sg0*VW + vc0
v_cmp_lt_u32 s30, v20, s[sgprSizeI]                // coord0 < size0
v_cmp_lt_u32 s32, v17, s[sgprSizeJ]                // coord1 < size1
s_and_b32 s32, s30, s32                            // in0 && in1
v_add_lshl_u32 v43, v19, v20, 0x0                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v43, v22, v43, s32                   // LDD clip if OOB. offset

/* rC *= alpha batchElements=[(0, 0, 0, 0), (0, 0, 0, 1), (0, 0, 0, 2), (0, 0, 0, 3), (0, 0, 0, 4), (0, 0, 0, 5), (0, 0, 0, 6), (0, 0, 0, 7)] */
v_mul_f32 v[vgprValuC+27], s[sgprAlpha], v[vgprValuC+0] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+28], s[sgprAlpha], v[vgprValuC+1] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+29], s[sgprAlpha], v[vgprValuC+2] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+30], s[sgprAlpha], v[vgprValuC+3] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+31], s[sgprAlpha], v[vgprValuC+4] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+32], s[sgprAlpha], v[vgprValuC+5] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+33], s[sgprAlpha], v[vgprValuC+6] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+35], s[sgprAlpha], v[vgprValuC+7] // Multiply MI out reg with alpha

/* apply mask, calc new C and issue writes */
v_mov_b32 v24, 0x207                               // Nan and +/- inf
v_mov_b32 v26, 0x43E00000                          // Fp8 Max value 448 as float32
v_mov_b32 v25, 0xc3E00000                          // Fp8 Min value -448 as float32
v_cmp_class_f32 s30, v[vgprValuC+27], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+27], v25, v26
v_cndmask_b32 v[vgprValuC+27], v23, v[vgprValuC+27], s30
v_cvt_pk_fp8_f32 v27, v[vgprValuC+27], v[vgprValuC+27] op_sel:[0,0,0]
buffer_store_b8 v27, v36, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
v_cmp_class_f32 s30, v[vgprValuC+28], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+28], v25, v26
v_cndmask_b32 v[vgprValuC+28], v23, v[vgprValuC+28], s30
v_cvt_pk_fp8_f32 v28, v[vgprValuC+28], v[vgprValuC+28] op_sel:[0,0,0]
buffer_store_b8 v28, v37, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
v_cmp_class_f32 s30, v[vgprValuC+29], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+29], v25, v26
v_cndmask_b32 v[vgprValuC+29], v23, v[vgprValuC+29], s30
v_cvt_pk_fp8_f32 v29, v[vgprValuC+29], v[vgprValuC+29] op_sel:[0,0,0]
buffer_store_b8 v29, v38, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
v_cmp_class_f32 s30, v[vgprValuC+30], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+30], v25, v26
v_cndmask_b32 v[vgprValuC+30], v23, v[vgprValuC+30], s30
v_cvt_pk_fp8_f32 v30, v[vgprValuC+30], v[vgprValuC+30] op_sel:[0,0,0]
buffer_store_b8 v30, v39, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
v_cmp_class_f32 s30, v[vgprValuC+31], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+31], v25, v26
v_cndmask_b32 v[vgprValuC+31], v23, v[vgprValuC+31], s30
v_cvt_pk_fp8_f32 v31, v[vgprValuC+31], v[vgprValuC+31] op_sel:[0,0,0]
buffer_store_b8 v31, v40, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
v_cmp_class_f32 s30, v[vgprValuC+32], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+32], v25, v26
v_cndmask_b32 v[vgprValuC+32], v23, v[vgprValuC+32], s30
v_cvt_pk_fp8_f32 v32, v[vgprValuC+32], v[vgprValuC+32] op_sel:[0,0,0]
buffer_store_b8 v32, v41, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
v_cmp_class_f32 s30, v[vgprValuC+33], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+33], v25, v26
v_cndmask_b32 v[vgprValuC+33], v23, v[vgprValuC+33], s30
v_cvt_pk_fp8_f32 v33, v[vgprValuC+33], v[vgprValuC+33] op_sel:[0,0,0]
buffer_store_b8 v33, v42, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
v_cmp_class_f32 s30, v[vgprValuC+35], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+35], v25, v26
v_cndmask_b32 v[vgprValuC+35], v23, v[vgprValuC+35], s30
v_cvt_pk_fp8_f32 v35, v[vgprValuC+35], v[vgprValuC+35] op_sel:[0,0,0]
buffer_store_b8 v35, v43, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
s_nop 0                                            // 1 wait state required when next inst writes vgprs held by previous dwordx4 store inst
s_branch label_GW_End_2                            // jump to end
label_GW_B1:
label_GW_B1_FD0:
s_and_b32 s30, 15, s[sgprSizeI]                    // s30 = s[sgprSizeI] % 16
s_add_u32 s31, -0x1, s[sgprNumWorkGroups0]
s_cmp_ge_u32 s[sgprWorkGroup0], s31                // wg0 >= nwg0-1 ?
s_cselect_b32 s30, s30, 0                          // set rem
s_mov_b32 s8, 0
s_cmp_gt_u32 s30, s8                               // rem > 0
s_cbranch_scc1 label_GW_B1_FD0_VW8_Else            // jump if edges required
s_and_b32 s30, 15, s[sgprSizeJ]                    // s30 = s[sgprSizeJ] % 16
s_add_u32 s31, -0x1, s[sgprNumWorkGroups1]
s_cmp_ge_u32 s[sgprWorkGroup1], s31                // wg1 >= nwg1-1
s_cselect_b32 s30, s30, 0                          // set rem
s_mov_b32 s8, 0
s_cmp_gt_u32 s30, s8                               // rem > 0
s_cbranch_scc1 label_GW_B1_FD0_VW8_Then            // jump if edges required
label_GW_B1_FD0_VW8_NonEdge:

/* edge=0, allocate 1 sgpr. perBatchTmpS=1 perBatchMaskS=0 perElementMaskS=0 elementsPerBatch=1 */
/* optSingleColVgpr=1 optSharedColVgpr=0 optSGPRUsage=BufferLoad_Mask optSrdIncForRow=1 factorDim=0 */

/******************************************/
/* Global Write Beta Batch #0 (d1,d0,vc1,vc0) = */
/*    (0,0,0,0:vw8)                       */
/******************************************/

/* calc coords, apply mask, and issue loads (if necessary) */
/* (d1,vc1,d0,vc0)=(0,0,0,0) */
v_add_lshl_u32 v28, v18, v16, 0x0                  // optSingleColVgpr scaleToBpe: sharedAddrVgpr <- cinRowPtr + coord0, scaled by BPE. BSHERE:coord0=16, coord0Vgpr=16
buffer_load_b64 v[30:31], v28, s[sgprSrdC:sgprSrdC+3], null offen offset:0 // load C
v_add_lshl_u32 v27, v19, v16, 0x0                  // optSingleColVgpr scaleToBpe: sharedAddrVgpr <- cinRowPtr + coord0, scaled by BPE. BSHERE:coord0=16, coord0Vgpr=16

/* rC *= alpha batchElements=[(0, 0, 0, 0)] */
v_mul_f32 v[vgprValuC+40], s[sgprAlpha], v[vgprValuC+0] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+41], s[sgprAlpha], v[vgprValuC+1] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+42], s[sgprAlpha], v[vgprValuC+2] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+43], s[sgprAlpha], v[vgprValuC+3] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+44], s[sgprAlpha], v[vgprValuC+4] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+45], s[sgprAlpha], v[vgprValuC+5] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+46], s[sgprAlpha], v[vgprValuC+6] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+47], s[sgprAlpha], v[vgprValuC+7] // Multiply MI out reg with alpha

/* apply mask, calc new C and issue writes */
v_mov_b32 v24, 0x207                               // Nan and +/- inf
v_mov_b32 v26, 0x43E00000                          // Fp8 Max value 448 as float32
v_mov_b32 v25, 0xc3E00000                          // Fp8 Min value -448 as float32

s_wait_loadcnt 0                                   // vlcnt(0) = 1 - 1 (beta) (interleaved)
v_cvt_pk_f32_fp8 v[20:21], v30 op_sel:[0]
s_nop 0
v_fmac_f32 v[vgprValuC+40], v20, s[sgprBeta]       // finalSum = sum*alpha + C*beta
v_fmac_f32 v[vgprValuC+41], v21, s[sgprBeta]       // finalSum = sum*alpha + C*beta (PK)
v_cvt_pk_f32_fp8 v[20:21], v30 op_sel:[1]
s_nop 0
v_fmac_f32 v[vgprValuC+42], v20, s[sgprBeta]       // finalSum = sum*alpha + C*beta
v_fmac_f32 v[vgprValuC+43], v21, s[sgprBeta]       // finalSum = sum*alpha + C*beta (PK)
v_cvt_pk_f32_fp8 v[20:21], v31 op_sel:[0]
s_nop 0
v_fmac_f32 v[vgprValuC+44], v20, s[sgprBeta]       // finalSum = sum*alpha + C*beta
v_fmac_f32 v[vgprValuC+45], v21, s[sgprBeta]       // finalSum = sum*alpha + C*beta (PK)
v_cvt_pk_f32_fp8 v[20:21], v31 op_sel:[1]
s_nop 0
v_fmac_f32 v[vgprValuC+46], v20, s[sgprBeta]       // finalSum = sum*alpha + C*beta
v_fmac_f32 v[vgprValuC+47], v21, s[sgprBeta]       // finalSum = sum*alpha + C*beta (PK)
v_cmp_class_f32 s8, v[vgprValuC+40], v24           // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+40], v25, v26
v_cndmask_b32 v[vgprValuC+40], v23, v[vgprValuC+40], s8
v_cmp_class_f32 s8, v[vgprValuC+41], v24           // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+41], v25, v26
v_cndmask_b32 v[vgprValuC+41], v23, v[vgprValuC+41], s8
v_cvt_pk_fp8_f32 v40, v[vgprValuC+40], v[vgprValuC+41] op_sel:[0,0,0]
v_cmp_class_f32 s8, v[vgprValuC+42], v24           // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+42], v25, v26
v_cndmask_b32 v[vgprValuC+42], v23, v[vgprValuC+42], s8
v_cmp_class_f32 s8, v[vgprValuC+43], v24           // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+43], v25, v26
v_cndmask_b32 v[vgprValuC+43], v23, v[vgprValuC+43], s8
v_cvt_pk_fp8_f32 v40, v[vgprValuC+42], v[vgprValuC+43] op_sel:[0,0,1]
v_cmp_class_f32 s8, v[vgprValuC+44], v24           // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+44], v25, v26
v_cndmask_b32 v[vgprValuC+44], v23, v[vgprValuC+44], s8
v_cmp_class_f32 s8, v[vgprValuC+45], v24           // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+45], v25, v26
v_cndmask_b32 v[vgprValuC+45], v23, v[vgprValuC+45], s8
v_cvt_pk_fp8_f32 v41, v[vgprValuC+44], v[vgprValuC+45] op_sel:[0,0,0]
v_cmp_class_f32 s8, v[vgprValuC+46], v24           // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+46], v25, v26
v_cndmask_b32 v[vgprValuC+46], v23, v[vgprValuC+46], s8
v_cmp_class_f32 s8, v[vgprValuC+47], v24           // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+47], v25, v26
v_cndmask_b32 v[vgprValuC+47], v23, v[vgprValuC+47], s8
v_cvt_pk_fp8_f32 v41, v[vgprValuC+46], v[vgprValuC+47] op_sel:[0,0,1]
buffer_store_b64 v[40:41], v27, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
s_nop 0                                            // 1 wait state required when next inst writes vgprs held by previous dwordx4 store inst
s_branch label_GW_End_2                            // jump to end
label_GW_B1_FD0_VW8_NonEdgeEnd:
label_GW_B1_FD0_VW8_Then:

/* edge=1, allocate 3 sgpr. perBatchTmpS=2 perBatchMaskS=1 perElementMaskS=0 elementsPerBatch=1 */
/* optSingleColVgpr=0 optSharedColVgpr=0 optSGPRUsage=BufferLoad_Edge_Mask optSrdIncForRow=0 factorDim=0 */

/******************************************/
/* Global Write Beta Edge Batch #0 (d1,d0,vc1,vc0) = */
/*    (0,0,0,0:vw8)                       */
/******************************************/

/* calc coords, apply mask, and issue loads (if necessary) */
v_mov_b32 v22, BufferOOB
/* (d1,vc1,d0,vc0)=(0,0,0,0) */
v_cmp_lt_u32 s30, v16, s[sgprSizeI]                // coord0 < size0
v_cmp_lt_u32 s32, v17, s[sgprSizeJ]                // coord1 < size1
s_and_b32 s32, s30, s32                            // in0 && in1
v_add_lshl_u32 v27, v18, v16, 0x0                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v27, v22, v27, s32                   // LDC clip if OOB. offset
buffer_load_b64 v[28:29], v27, s[sgprSrdC:sgprSrdC+3], null offen offset:0 // load C
v_add_lshl_u32 v27, v19, v16, 0x0                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v27, v22, v27, s32                   // LDD clip if OOB. offset

/* rC *= alpha batchElements=[(0, 0, 0, 0)] */
v_mul_f32 v[vgprValuC+40], s[sgprAlpha], v[vgprValuC+0] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+41], s[sgprAlpha], v[vgprValuC+1] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+42], s[sgprAlpha], v[vgprValuC+2] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+43], s[sgprAlpha], v[vgprValuC+3] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+44], s[sgprAlpha], v[vgprValuC+4] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+45], s[sgprAlpha], v[vgprValuC+5] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+46], s[sgprAlpha], v[vgprValuC+6] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+47], s[sgprAlpha], v[vgprValuC+7] // Multiply MI out reg with alpha
s_wait_loadcnt 0                                   // wait for Beta

/* apply mask, calc new C and issue writes */
v_mov_b32 v24, 0x207                               // Nan and +/- inf
v_mov_b32 v26, 0x43E00000                          // Fp8 Max value 448 as float32
v_mov_b32 v25, 0xc3E00000                          // Fp8 Min value -448 as float32
v_cvt_pk_f32_fp8 v[20:21], v28 op_sel:[0]
s_nop 0
v_fmac_f32 v[vgprValuC+40], v20, s[sgprBeta]       // finalSum = sum*alpha + C*beta
v_fmac_f32 v[vgprValuC+41], v21, s[sgprBeta]       // finalSum = sum*alpha + C*beta (PK)
v_cvt_pk_f32_fp8 v[20:21], v28 op_sel:[1]
s_nop 0
v_fmac_f32 v[vgprValuC+42], v20, s[sgprBeta]       // finalSum = sum*alpha + C*beta
v_fmac_f32 v[vgprValuC+43], v21, s[sgprBeta]       // finalSum = sum*alpha + C*beta (PK)
v_cvt_pk_f32_fp8 v[20:21], v29 op_sel:[0]
s_nop 0
v_fmac_f32 v[vgprValuC+44], v20, s[sgprBeta]       // finalSum = sum*alpha + C*beta
v_fmac_f32 v[vgprValuC+45], v21, s[sgprBeta]       // finalSum = sum*alpha + C*beta (PK)
v_cvt_pk_f32_fp8 v[20:21], v29 op_sel:[1]
s_nop 0
v_fmac_f32 v[vgprValuC+46], v20, s[sgprBeta]       // finalSum = sum*alpha + C*beta
v_fmac_f32 v[vgprValuC+47], v21, s[sgprBeta]       // finalSum = sum*alpha + C*beta (PK)
v_cmp_class_f32 s30, v[vgprValuC+40], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+40], v25, v26
v_cndmask_b32 v[vgprValuC+40], v23, v[vgprValuC+40], s30
v_cmp_class_f32 s30, v[vgprValuC+41], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+41], v25, v26
v_cndmask_b32 v[vgprValuC+41], v23, v[vgprValuC+41], s30
v_cvt_pk_fp8_f32 v40, v[vgprValuC+40], v[vgprValuC+41] op_sel:[0,0,0]
v_cmp_class_f32 s30, v[vgprValuC+42], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+42], v25, v26
v_cndmask_b32 v[vgprValuC+42], v23, v[vgprValuC+42], s30
v_cmp_class_f32 s30, v[vgprValuC+43], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+43], v25, v26
v_cndmask_b32 v[vgprValuC+43], v23, v[vgprValuC+43], s30
v_cvt_pk_fp8_f32 v40, v[vgprValuC+42], v[vgprValuC+43] op_sel:[0,0,1]
v_cmp_class_f32 s30, v[vgprValuC+44], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+44], v25, v26
v_cndmask_b32 v[vgprValuC+44], v23, v[vgprValuC+44], s30
v_cmp_class_f32 s30, v[vgprValuC+45], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+45], v25, v26
v_cndmask_b32 v[vgprValuC+45], v23, v[vgprValuC+45], s30
v_cvt_pk_fp8_f32 v41, v[vgprValuC+44], v[vgprValuC+45] op_sel:[0,0,0]
v_cmp_class_f32 s30, v[vgprValuC+46], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+46], v25, v26
v_cndmask_b32 v[vgprValuC+46], v23, v[vgprValuC+46], s30
v_cmp_class_f32 s30, v[vgprValuC+47], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+47], v25, v26
v_cndmask_b32 v[vgprValuC+47], v23, v[vgprValuC+47], s30
v_cvt_pk_fp8_f32 v41, v[vgprValuC+46], v[vgprValuC+47] op_sel:[0,0,1]
buffer_store_b64 v[40:41], v27, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
s_nop 0                                            // 1 wait state required when next inst writes vgprs held by previous dwordx4 store inst
s_branch label_GW_End_2                            // jump to end
label_GW_B1_FD0_VW8_Else:
label_GW_B1_FD0_VW1_Else:
label_GW_B1_FD0_VW1_Then:

/* edge=1, allocate 3 sgpr. perBatchTmpS=2 perBatchMaskS=1 perElementMaskS=0 elementsPerBatch=6 */
/* optSingleColVgpr=0 optSharedColVgpr=0 optSGPRUsage=BufferLoad_Edge_Mask optSrdIncForRow=0 factorDim=0 */

/******************************************/
/* Global Write Beta Edge Batch #0 (d1,d0,vc1,vc0) = */
/*    (0,0,0,0:vw1); (0,0,0,1:vw1); (0,0,0,2:vw1); (0,0,0,3:vw1); (0,0,0,4:vw1); (0,0,0,5:vw1) */
/******************************************/

/* calc coords, apply mask, and issue loads (if necessary) */
v_mov_b32 v22, BufferOOB
/* (d1,vc1,d0,vc0)=(0,0,0,0) */
v_cmp_lt_u32 s30, v16, s[sgprSizeI]                // coord0 < size0
v_cmp_lt_u32 s32, v17, s[sgprSizeJ]                // coord1 < size1
s_and_b32 s32, s30, s32                            // in0 && in1
v_add_lshl_u32 v35, v18, v16, 0x0                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v35, v22, v35, s32                   // LDC clip if OOB. offset
buffer_load_d16_u8 v33, v35, s[sgprSrdC:sgprSrdC+3], null offen offset:0 // load C
v_add_lshl_u32 v35, v19, v16, 0x0                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v35, v22, v35, s32                   // LDD clip if OOB. offset
/* (d1,vc1,d0,vc0)=(0,0,0,1) */
v_add_co_u32 v20, vcc_lo, v16, 1                   // coord0.1: coord0 += d0*sg0*VW + vc0
v_cmp_lt_u32 s30, v20, s[sgprSizeI]                // coord0 < size0
v_cmp_lt_u32 s32, v17, s[sgprSizeJ]                // coord1 < size1
s_and_b32 s32, s30, s32                            // in0 && in1
v_add_lshl_u32 v37, v18, v20, 0x0                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v37, v22, v37, s32                   // LDC clip if OOB. offset
buffer_load_d16_u8 v36, v37, s[sgprSrdC:sgprSrdC+3], null offen offset:0 // load C
v_add_lshl_u32 v37, v19, v20, 0x0                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v37, v22, v37, s32                   // LDD clip if OOB. offset
/* (d1,vc1,d0,vc0)=(0,0,0,2) */
v_add_co_u32 v20, vcc_lo, v16, 2                   // coord0.1: coord0 += d0*sg0*VW + vc0
v_cmp_lt_u32 s30, v20, s[sgprSizeI]                // coord0 < size0
v_cmp_lt_u32 s32, v17, s[sgprSizeJ]                // coord1 < size1
s_and_b32 s32, s30, s32                            // in0 && in1
v_add_lshl_u32 v39, v18, v20, 0x0                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v39, v22, v39, s32                   // LDC clip if OOB. offset
buffer_load_d16_u8 v38, v39, s[sgprSrdC:sgprSrdC+3], null offen offset:0 // load C
v_add_lshl_u32 v39, v19, v20, 0x0                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v39, v22, v39, s32                   // LDD clip if OOB. offset
/* (d1,vc1,d0,vc0)=(0,0,0,3) */
v_add_co_u32 v20, vcc_lo, v16, 3                   // coord0.1: coord0 += d0*sg0*VW + vc0
v_cmp_lt_u32 s30, v20, s[sgprSizeI]                // coord0 < size0
v_cmp_lt_u32 s32, v17, s[sgprSizeJ]                // coord1 < size1
s_and_b32 s32, s30, s32                            // in0 && in1
v_add_lshl_u32 v41, v18, v20, 0x0                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v41, v22, v41, s32                   // LDC clip if OOB. offset
buffer_load_d16_u8 v40, v41, s[sgprSrdC:sgprSrdC+3], null offen offset:0 // load C
v_add_lshl_u32 v41, v19, v20, 0x0                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v41, v22, v41, s32                   // LDD clip if OOB. offset
/* (d1,vc1,d0,vc0)=(0,0,0,4) */
v_add_co_u32 v20, vcc_lo, v16, 4                   // coord0.1: coord0 += d0*sg0*VW + vc0
v_cmp_lt_u32 s30, v20, s[sgprSizeI]                // coord0 < size0
v_cmp_lt_u32 s32, v17, s[sgprSizeJ]                // coord1 < size1
s_and_b32 s32, s30, s32                            // in0 && in1
v_add_lshl_u32 v43, v18, v20, 0x0                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v43, v22, v43, s32                   // LDC clip if OOB. offset
buffer_load_d16_u8 v42, v43, s[sgprSrdC:sgprSrdC+3], null offen offset:0 // load C
v_add_lshl_u32 v43, v19, v20, 0x0                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v43, v22, v43, s32                   // LDD clip if OOB. offset
/* (d1,vc1,d0,vc0)=(0,0,0,5) */
v_add_co_u32 v20, vcc_lo, v16, 5                   // coord0.1: coord0 += d0*sg0*VW + vc0
v_cmp_lt_u32 s30, v20, s[sgprSizeI]                // coord0 < size0
v_cmp_lt_u32 s32, v17, s[sgprSizeJ]                // coord1 < size1
s_and_b32 s32, s30, s32                            // in0 && in1
v_add_lshl_u32 v45, v18, v20, 0x0                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v45, v22, v45, s32                   // LDC clip if OOB. offset
buffer_load_d16_u8 v44, v45, s[sgprSrdC:sgprSrdC+3], null offen offset:0 // load C
v_add_lshl_u32 v45, v19, v20, 0x0                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v45, v22, v45, s32                   // LDD clip if OOB. offset

/* rC *= alpha batchElements=[(0, 0, 0, 0), (0, 0, 0, 1), (0, 0, 0, 2), (0, 0, 0, 3), (0, 0, 0, 4), (0, 0, 0, 5)] */
v_mul_f32 v[vgprValuC+27], s[sgprAlpha], v[vgprValuC+0] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+28], s[sgprAlpha], v[vgprValuC+1] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+29], s[sgprAlpha], v[vgprValuC+2] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+30], s[sgprAlpha], v[vgprValuC+3] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+31], s[sgprAlpha], v[vgprValuC+4] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+32], s[sgprAlpha], v[vgprValuC+5] // Multiply MI out reg with alpha
s_wait_loadcnt 0                                   // wait for Beta

/* apply mask, calc new C and issue writes */
v_mov_b32 v24, 0x207                               // Nan and +/- inf
v_mov_b32 v26, 0x43E00000                          // Fp8 Max value 448 as float32
v_mov_b32 v25, 0xc3E00000                          // Fp8 Min value -448 as float32
v_cvt_f32_fp8 v20, v33 byte_sel:[0]
s_nop 0
v_fmac_f32 v[vgprValuC+27], v20, s[sgprBeta]       // finalSum = sum*alpha + C*beta
v_cmp_class_f32 s30, v[vgprValuC+27], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+27], v25, v26
v_cndmask_b32 v[vgprValuC+27], v23, v[vgprValuC+27], s30
v_cvt_pk_fp8_f32 v27, v[vgprValuC+27], v[vgprValuC+27] op_sel:[0,0,0]
buffer_store_b8 v27, v35, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
v_cvt_f32_fp8 v20, v36 byte_sel:[0]
s_nop 0
v_fmac_f32 v[vgprValuC+28], v20, s[sgprBeta]       // finalSum = sum*alpha + C*beta
v_cmp_class_f32 s30, v[vgprValuC+28], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+28], v25, v26
v_cndmask_b32 v[vgprValuC+28], v23, v[vgprValuC+28], s30
v_cvt_pk_fp8_f32 v28, v[vgprValuC+28], v[vgprValuC+28] op_sel:[0,0,0]
buffer_store_b8 v28, v37, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
v_cvt_f32_fp8 v20, v38 byte_sel:[0]
s_nop 0
v_fmac_f32 v[vgprValuC+29], v20, s[sgprBeta]       // finalSum = sum*alpha + C*beta
v_cmp_class_f32 s30, v[vgprValuC+29], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+29], v25, v26
v_cndmask_b32 v[vgprValuC+29], v23, v[vgprValuC+29], s30
v_cvt_pk_fp8_f32 v29, v[vgprValuC+29], v[vgprValuC+29] op_sel:[0,0,0]
buffer_store_b8 v29, v39, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
v_cvt_f32_fp8 v20, v40 byte_sel:[0]
s_nop 0
v_fmac_f32 v[vgprValuC+30], v20, s[sgprBeta]       // finalSum = sum*alpha + C*beta
v_cmp_class_f32 s30, v[vgprValuC+30], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+30], v25, v26
v_cndmask_b32 v[vgprValuC+30], v23, v[vgprValuC+30], s30
v_cvt_pk_fp8_f32 v30, v[vgprValuC+30], v[vgprValuC+30] op_sel:[0,0,0]
buffer_store_b8 v30, v41, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
v_cvt_f32_fp8 v20, v42 byte_sel:[0]
s_nop 0
v_fmac_f32 v[vgprValuC+31], v20, s[sgprBeta]       // finalSum = sum*alpha + C*beta
v_cmp_class_f32 s30, v[vgprValuC+31], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+31], v25, v26
v_cndmask_b32 v[vgprValuC+31], v23, v[vgprValuC+31], s30
v_cvt_pk_fp8_f32 v31, v[vgprValuC+31], v[vgprValuC+31] op_sel:[0,0,0]
buffer_store_b8 v31, v43, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
v_cvt_f32_fp8 v20, v44 byte_sel:[0]
s_nop 0
v_fmac_f32 v[vgprValuC+32], v20, s[sgprBeta]       // finalSum = sum*alpha + C*beta
v_cmp_class_f32 s30, v[vgprValuC+32], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+32], v25, v26
v_cndmask_b32 v[vgprValuC+32], v23, v[vgprValuC+32], s30
v_cvt_pk_fp8_f32 v32, v[vgprValuC+32], v[vgprValuC+32] op_sel:[0,0,0]
buffer_store_b8 v32, v45, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
s_nop 0                                            // 1 wait state required when next inst writes vgprs held by previous dwordx4 store inst
/* optSingleColVgpr=0 optSharedColVgpr=0 optSGPRUsage=BufferLoad_Edge_Mask optSrdIncForRow=0 factorDim=0 */

/******************************************/
/* Global Write Beta Edge Batch #1 (d1,d0,vc1,vc0) = */
/*    (0,0,0,6:vw1); (0,0,0,7:vw1)        */
/******************************************/

/* calc coords, apply mask, and issue loads (if necessary) */
v_mov_b32 v22, BufferOOB
/* (d1,vc1,d0,vc0)=(0,0,0,6) */
v_add_co_u32 v20, vcc_lo, v16, 6                   // coord0.1: coord0 += d0*sg0*VW + vc0
v_cmp_lt_u32 s30, v20, s[sgprSizeI]                // coord0 < size0
v_cmp_lt_u32 s32, v17, s[sgprSizeJ]                // coord1 < size1
s_and_b32 s32, s30, s32                            // in0 && in1
v_add_lshl_u32 v30, v18, v20, 0x0                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v30, v22, v30, s32                   // LDC clip if OOB. offset
buffer_load_d16_u8 v29, v30, s[sgprSrdC:sgprSrdC+3], null offen offset:0 // load C
v_add_lshl_u32 v30, v19, v20, 0x0                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v30, v22, v30, s32                   // LDD clip if OOB. offset
/* (d1,vc1,d0,vc0)=(0,0,0,7) */
v_add_co_u32 v20, vcc_lo, v16, 7                   // coord0.1: coord0 += d0*sg0*VW + vc0
v_cmp_lt_u32 s30, v20, s[sgprSizeI]                // coord0 < size0
v_cmp_lt_u32 s32, v17, s[sgprSizeJ]                // coord1 < size1
s_and_b32 s32, s30, s32                            // in0 && in1
v_add_lshl_u32 v32, v18, v20, 0x0                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v32, v22, v32, s32                   // LDC clip if OOB. offset
buffer_load_d16_u8 v31, v32, s[sgprSrdC:sgprSrdC+3], null offen offset:0 // load C
v_add_lshl_u32 v32, v19, v20, 0x0                  // scaleToBpe: accumulate d0 lower and *= bpe into Cin addr
v_cndmask_b32 v32, v22, v32, s32                   // LDD clip if OOB. offset

/* rC *= alpha batchElements=[(0, 0, 0, 6), (0, 0, 0, 7)] */
v_mul_f32 v[vgprValuC+27], s[sgprAlpha], v[vgprValuC+6] // Multiply MI out reg with alpha
v_mul_f32 v[vgprValuC+28], s[sgprAlpha], v[vgprValuC+7] // Multiply MI out reg with alpha
s_wait_loadcnt 0                                   // wait for Beta

/* apply mask, calc new C and issue writes */
v_mov_b32 v24, 0x207                               // Nan and +/- inf
v_mov_b32 v26, 0x43E00000                          // Fp8 Max value 448 as float32
v_mov_b32 v25, 0xc3E00000                          // Fp8 Min value -448 as float32
v_cvt_f32_fp8 v20, v29 byte_sel:[0]
s_nop 0
v_fmac_f32 v[vgprValuC+27], v20, s[sgprBeta]       // finalSum = sum*alpha + C*beta
v_cmp_class_f32 s30, v[vgprValuC+27], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+27], v25, v26
v_cndmask_b32 v[vgprValuC+27], v23, v[vgprValuC+27], s30
v_cvt_pk_fp8_f32 v27, v[vgprValuC+27], v[vgprValuC+27] op_sel:[0,0,0]
buffer_store_b8 v27, v30, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
v_cvt_f32_fp8 v20, v31 byte_sel:[0]
s_nop 0
v_fmac_f32 v[vgprValuC+28], v20, s[sgprBeta]       // finalSum = sum*alpha + C*beta
v_cmp_class_f32 s30, v[vgprValuC+28], v24          // Nan and +/- inf
v_med3_f32 v23, v[vgprValuC+28], v25, v26
v_cndmask_b32 v[vgprValuC+28], v23, v[vgprValuC+28], s30
v_cvt_pk_fp8_f32 v28, v[vgprValuC+28], v[vgprValuC+28] op_sel:[0,0,0]
buffer_store_b8 v28, v32, s[sgprSrdD:sgprSrdD+3], null offen offset:0 // store D
s_nop 0                                            // 1 wait state required when next inst writes vgprs held by previous dwordx4 store inst
s_branch label_GW_End_2                            // jump to end
label_GW_End_2:
label_KernelEnd:
s_endpgm                                           // Kernel End
label_ASM_End:  /// The end of the kernel
