#pragma once

// NN RDNA4 swizzle: lane-ordered layout (must match NN_HHS_BH_UserArgs_MT16x16x32_DTVA.s SWZ path).
// See asm/rdna4/doc/NN_doSwizzle_coalesced_A.md and NN_doSwizzle_A_layout_visualization.html

#include <cassert>
#include <cstdlib>

#if defined(ASM_WITH_ROCTX)
#include <rocprofiler-sdk-roctx/roctx.h>
#endif

#include "utilities.hpp"
#include "TensorData.hpp"

using TensorClass = Tensor::Manipulation::Tensor;

#if defined(ASM_WITH_ROCTX)
inline void nn_roctx_push(const char* msg)
{
    roctxRangePushA(msg);
}
inline void nn_roctx_pop()
{
    roctxRangePop();
}
#else
inline void nn_roctx_push(const char*)
{}
inline void nn_roctx_pop()
{}
#endif

class SwizzleAGemmRunnerRDNANN : public AsmRunnerAndValidator
{
private:
    static const uint32_t minM = 16;
    static const uint32_t minK = 32;

    std::vector<_Float16> inputA_h;
    std::vector<_Float16> inputB_h;
    std::vector<_Float16> inputC_h;
    std::vector<_Float16> outputD_h;

    gpubuf_t<_Float16> inputA_d;
    gpubuf_t<_Float16> inputB_d;
    gpubuf_t<_Float16> inputC_d;
    gpubuf_t<_Float16> outputD_d;

    size_t Coord2Idx(uint32_t D1, uint32_t D2, size_t idx_1, size_t idx_2)
    {
        return idx_2 * D1 + idx_1;
    }

    // A is **column-major** (leading dim M=16): linear index L = m + M*k, 0<=m<16, 0<=k<32.
    //   col k=0: L = 0..15  (m=0..15), col k=1: L = 16..31, col k=2: L = 32..47, ...
    //
    // Swizzled dst: 16×32 row-major dst[r*32+c]. Cell (r,c) holds src[V] where V is that element’s
    // col-major linear index:  V(r,c) = (r/4)*128 + (r%4)*4 + (c/8) + (c%8)*16
    static size_t linearA_colMajor(uint32_t m, uint32_t k)
    {
        return static_cast<size_t>(m) + static_cast<size_t>(minM) * static_cast<size_t>(k);
    }

    template <typename T>
    void cpuGEMM(T* A, T* B, T* C, T* D)
    {
        std::cout << "cpuGEMM NN: (K, M): (" << K << ", " << M << "), (N, K): (" << N << ", " << K << ")" << std::endl;
        for(auto dx = 0; dx < N; ++dx)
        {
            for(auto dy = 0; dy < M; ++dy)
            {
                float d = 0;
                for(auto dk = 0; dk < K; ++dk)
                {
                    // A: col-major M×K  →  A(m,k) at m + M*k  (dy=m, dk=k)
                    auto idx_A = linearA_colMajor(static_cast<uint32_t>(dy), static_cast<uint32_t>(dk));
                    auto idx_B = Coord2Idx(K, N, dk, dx);
                    d += alpha * (A[idx_A] * B[idx_B]);
                }
                auto idx_CD = Coord2Idx(M, N, dy, dx);
                d += beta * C[idx_CD];
                D[idx_CD] = (T)(d);
            }
        }
    }

    template <typename T>
    bool print_row_by_row(T* gpuOutput, uint32_t rowLens, uint32_t colLens, bool isRowMajor)
    {
        for(int y = 0; y < colLens; y++)
        {
            for(int x = 0; x < rowLens; x++)
            {
                auto  id    = (isRowMajor) ? Coord2Idx(rowLens, colLens, x, y) : Coord2Idx(colLens, rowLens, y, x);
                float value = (float)(gpuOutput[id]);
                std::cout << value << ", ";
            }
            std::cout << std::endl;
        }
        return true;
    }

    // 512 fp16: row-major 16×32 equals NN lane packing (32×8 + 32×8) for this tile shape.
    void doSwizzle(const std::vector<_Float16>& srcMK, TensorClass& swizzled)
    {
        assert(srcMK.size() >= static_cast<size_t>(M * K));
        assert(M == 16u && K == 32u && "layout formula is for 16×32 A");
        swizzled = TensorClass({static_cast<size_t>(M * K)}, sizeof(_Float16));
        _Float16* dst = swizzled.as<_Float16>();
        const _Float16* src = srcMK.data();

        constexpr uint32_t R = 16u, C = 32u;
        for(uint32_t r = 0; r < R; ++r)
        {
            for(uint32_t c = 0; c < C; ++c)
            {
                const uint32_t V = (r / 4u) * 128u + (r % 4u) * 4u + (c / 8u) + (c % 8u) * 16u;
                dst[r * C + c] = src[V];
            }
        }
    }

public:
    explicit SwizzleAGemmRunnerRDNANN(po::variables_map const& args)
        : AsmRunnerAndValidator(args)
    {
    }

    virtual void LaunchKernel(SolutionAdapter& adapter, KernelInvocation& kernelInvoc, hipStream_t stream) override
    {
        auto parseEnvU32 = [](const char* name, uint32_t defaultVal) -> uint32_t {
            const char* s = std::getenv(name);
            if(!s || !*s)
                return defaultVal;
            char* end{};
            unsigned long v = std::strtoul(s, &end, 10);
            if(end == s || v == 0ul || v > 0xFFFFFFFFul)
                return defaultVal;
            return static_cast<uint32_t>(v);
        };

        const uint32_t warmup = parseEnvU32("ASM_ROCPROF_WARMUP", 0);
        const uint32_t loops  = parseEnvU32("ASM_ROCPROF_KERNEL_LOOPS", 1);

        for(uint32_t w = 0; w < warmup; ++w)
            HIP_CHECK_EXC(adapter.launchKernel(kernelInvoc, stream, nullptr, nullptr));
        if(warmup != 0u)
            HIP_CHECK_EXC(hipStreamSynchronize(stream));

        for(uint32_t i = 0; i < loops; ++i)
            HIP_CHECK_EXC(adapter.launchKernel(kernelInvoc, stream, nullptr, nullptr));
    }

    virtual void SetupKernelArgs(KernelInvocation& kernelInvoc) override
    {
        TensorClass tensorA_h = TensorClass({M, K}, sizeof(_Float16));
        TensorClass swizzledA_h = TensorClass({static_cast<size_t>(M * K)}, sizeof(_Float16));

        inputA_h  = std::vector<_Float16>();
        inputB_h  = std::vector<_Float16>(N * K, (_Float16)1.0f);
        inputC_h  = std::vector<_Float16>(M * N, (_Float16)0.0f);
        outputD_h = std::vector<_Float16>(M * N, (_Float16)0.0f);

        HIP_CHECK_EXC(inputB_d.alloc(sizeof(_Float16) * N * K));
        HIP_CHECK_EXC(inputC_d.alloc(sizeof(_Float16) * M * N));
        HIP_CHECK_EXC(outputD_d.alloc(sizeof(_Float16) * M * N));

        for(size_t dimM = 0; dimM < M; ++dimM)
        {
            size_t scale    = ((dimM / minM) % 2) + 1;
            size_t linearM  = dimM % minM;
            size_t value    = (K * linearM);
            for(size_t dimK = 0; dimK < K; ++dimK)
            {
                inputA_h.push_back((value + dimK) * scale);
            }
        }

        memcpy(tensorA_h.as<void>(), inputA_h.data(), tensorA_h.getNumBytes());
        std::cout << std::endl << "Non-Swizzled InputA (NN, A col-major m+16*k; printed by row m, col k):" << std::endl;
        print_row_by_row(tensorA_h.as<_Float16>(), K, M, false);

        nn_roctx_push("NN_pre_shuffle_doSwizzle");
        doSwizzle(inputA_h, swizzledA_h);
        nn_roctx_pop();

        std::cout << std::endl << "Swizzled InputA (512, lane order):" << std::endl;
        Tensor::Manipulation::printTensorData<_Float16>(std::cout, swizzledA_h);

        HIP_CHECK_EXC(inputA_d.alloc(swizzledA_h.getNumBytes()));

        for(size_t idxB = 0; idxB < inputB_h.size(); ++idxB)
        {
            auto rowID     = idxB % K;
            inputB_h[idxB] = (rowID % 3 == 2) ? 0 : 1;
        }
        std::cout << std::endl << "InputB:" << std::endl;
        print_row_by_row(inputB_h.data(), N, K, false);

        nn_roctx_push("NN_H2D_swizzled_A");
        HIP_CHECK_EXC(hipMemcpy(inputA_d.data(),
                                swizzledA_h.as<void>(),
                                swizzledA_h.getNumBytes(),
                                hipMemcpyHostToDevice));
        nn_roctx_pop();
        nn_roctx_push("NN_H2D_B_C");
        HIP_CHECK_EXC(hipMemcpy(inputB_d.data(),
                                inputB_h.data(),
                                sizeof(_Float16) * inputB_h.size(),
                                hipMemcpyHostToDevice));
        HIP_CHECK_EXC(hipMemcpy(inputC_d.data(),
                                inputC_h.data(),
                                sizeof(_Float16) * inputC_h.size(),
                                hipMemcpyHostToDevice));
        nn_roctx_pop();

        kernelInvoc.args           = KernelArguments(false);
        KernelArguments& kernelArg = kernelInvoc.args;

        kernelArg.reserve(1024, 128);
        kernelArg.append("gemm_count", (uint32_t)1);
        kernelArg.append("internalArgs", (uint32_t)1);
        kernelArg.append("internalArgs1", (uint32_t)1275592712);
        kernelArg.append("numWG", (uint32_t)(kernelInvoc.gridDim.x));
        kernelArg.append("SizesFree0", M);
        kernelArg.append("SizesFree1", N);
        kernelArg.append("SizesFree2", (uint32_t)1);
        kernelArg.append("SizesSum0", K);

        kernelArg.append("D", outputD_d.data());
        kernelArg.append("C", inputC_d.data());
        kernelArg.append("A", inputA_d.data());
        kernelArg.append("B", inputB_d.data());

        kernelArg.append("strideD0", M);
        kernelArg.append("strideD1", (M * N));
        kernelArg.append("strideC0", M);
        kernelArg.append("strideC1", (M * N));
        kernelArg.append("strideA0", K);
        kernelArg.append("strideA1", (M * K));
        kernelArg.append("strideB0", K);
        kernelArg.append("strideB1", (K * N));

        kernelArg.append("alpha", alpha);
        kernelArg.append("beta", beta);
    }

    template <typename T>
    bool compare(std::vector<T>& gpuOutput, std::vector<T>& ref)
    {
        float maxErr = 0.0;
        for(int i = 0; i < ref.size(); i++)
        {
            float refV = (float)(ref[i]);
            float gpuV = (float)(gpuOutput[i]);
            float err  = refV - gpuV;
            if(std::isnan(gpuV) || std::isinf(gpuV))
                return false;
            maxErr = max(maxErr, abs(err));
        }

        std::cout << "max error : " << maxErr << std::endl;
        return (maxErr == 0.0f) && !std::isnan(maxErr) && !std::isinf(maxErr);
    }

    virtual bool Validation() override
    {
        std::cout << std::endl << "Validation:" << std::endl;

        cpuGEMM(inputA_h.data(), inputB_h.data(), inputC_h.data(), outputD_h.data());
        std::cout << std::endl << "Ref:" << std::endl;
        print_row_by_row(outputD_h.data(), N, M, false);

        std::vector<_Float16> gpuOutput(M * N);
        HIP_CHECK_EXC(hipMemcpy(gpuOutput.data(), outputD_d.data(), outputD_d.size(), hipMemcpyDeviceToHost));
        std::cout << std::endl << "Kernel Result:" << std::endl;
        print_row_by_row(gpuOutput.data(), N, M, false);

        return compare(gpuOutput, outputD_h);
    }
};
