#pragma once

// rocprof / rocprofv3: wrap the binary; optional repeat launches via env (see LaunchKernel).
//   export ASM_ROCPROF_KERNEL_LOOPS=200
//   export ASM_ROCPROF_WARMUP=10

#include <algorithm>
#include <cstdlib>
#include <string>
#include <type_traits>

#if defined(ASM_WITH_ROCTX)
#include <rocprofiler-sdk-roctx/roctx.h>
#endif

#include "utilities.hpp"
#include "TensorData.hpp"
#include "SwizzleRdna4Common.hpp"

using TensorClass = Tensor::Manipulation::Tensor;

#if defined(ASM_WITH_ROCTX)
inline void tn_roctx_push(const char* msg)
{
    roctxRangePushA(msg);
}
inline void tn_roctx_pop()
{
    roctxRangePop();
}
#else
inline void tn_roctx_push(const char*)
{}
inline void tn_roctx_pop()
{}
#endif

/// GEMM element type **`_Float16`** or **`hipblaslt_f8_fnuz`** for A, B, C, D. Test-tag
/// `swizzleA_gemm_rdna_tn_f8` vs `swizzleA_gemm_rdna_tn`.
template <typename ADataType>
class SwizzleAGemmRunnerRDNATN : public AsmRunnerAndValidator
{
    static_assert(std::is_same_v<ADataType, _Float16> || std::is_same_v<ADataType, hipblaslt_f8_fnuz>);

private:
    static const uint32_t minM = 16;
    static const uint32_t minK = 32;

    bool        doHostSwizzle_;
    std::string aInitMode_;
    unsigned    aInitSeed_;

    std::vector<ADataType> inputA_h;
    std::vector<ADataType> inputB_h;
    std::vector<ADataType> inputC_h;
    std::vector<ADataType> outputD_h;

    gpubuf_t<ADataType> inputA_d;
    gpubuf_t<ADataType> inputB_d;
    gpubuf_t<ADataType> inputC_d;
    gpubuf_t<ADataType> outputD_d;

    size_t Coord2Idx(uint32_t D1, uint32_t D2, size_t idx_1, size_t idx_2)
    {
        return idx_2 * D1 + idx_1;
    }

    /// Tensile-style reference: `dot = Σ float(a)*float(b)`, then `D = round(alpha*dot + beta*C)`.
    void cpuGEMM_tensile_ref(ADataType* A, ADataType* B, ADataType* C, ADataType* D)
    {
        std::cout << "cpuGEMM (Tensile Reference: dot then alpha*dot + beta*C): (K, M): (" << K << ", " << M
                  << "), (N, K): (" << N << ", " << K << ")" << std::endl;
        for(uint32_t dx = 0; dx < N; ++dx)
        {
            for(uint32_t dy = 0; dy < M; ++dy)
            {
                float dot = 0.f;
                for(uint32_t dk = 0; dk < K; ++dk)
                {
                    size_t idx_A = Coord2Idx(K, M, dk, dy);
                    size_t idx_B = Coord2Idx(K, N, dk, dx);
                    dot += static_cast<float>(A[idx_A]) * static_cast<float>(B[idx_B]);
                }
                size_t idx_CD = Coord2Idx(M, N, dy, dx);
                float  acc    = alpha * dot + beta * static_cast<float>(C[idx_CD]);
                if constexpr(std::is_same_v<ADataType, _Float16>)
                    D[idx_CD] = static_cast<_Float16>(acc);
                else
                    D[idx_CD] = hipblaslt_f8_fnuz(acc * 2.0f);
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

    static void printTensorFlatDecodedF8(std::ostream& os, const TensorClass& tensor)
    {
        const uint8_t* d = tensor.as<uint8_t>();
        size_t         n = tensor.getDesc().flattenSize();
        os << "[";
        for(size_t i = 0; i < n; ++i)
            os << SwizzleRdna4::f8uToFloat(d[i]) << ", ";
        os << "]\n";
    }

    /// Build host **A** (K×M), optional TN slab swizzle, **H2D** → `inputA_d`. FP16 ignores `a-init-mode=random`.
    void tnHostPrepareAndUploadA()
    {
        TensorClass tensorA_h({K, M}, sizeof(ADataType));
        TensorClass swizzledA_h = [&] {
            if constexpr(std::is_same_v<ADataType, _Float16>)
                return TensorClass({K, M}, sizeof(_Float16));
            else
                return TensorClass({1}, 1u);
        }();

        outputD_h.assign(static_cast<size_t>(M * N), ADataType{});
        HIP_CHECK_EXC(outputD_d.alloc(sizeof(ADataType) * M * N));
        inputA_h.assign(static_cast<size_t>(M * K), ADataType{});

        auto idxTn = [this](size_t dimM, size_t dimK) {
            return swizzle_rdna_host::linearA_tn_rowMajorKxM(
                static_cast<uint32_t>(dimM), static_cast<uint32_t>(dimK), K);
        };
        if constexpr(std::is_same_v<ADataType, _Float16>)
            swizzle_rdna_host::fill_inputA_ramp(M, K, minM, inputA_h.data(), idxTn);
        else if(aInitMode_ == "random")
            swizzle_rdna_host::fill_inputA_random_tensile(M, K, aInitSeed_, inputA_h.data(), idxTn);
        else
            swizzle_rdna_host::fill_inputA_ramp(M, K, minM, inputA_h.data(), idxTn);

        memcpy(tensorA_h.as<void>(), inputA_h.data(), tensorA_h.getNumBytes());

        std::cout << std::endl << "Non-Swizzled InputA: (K, M): (" << K << ", " << M << ")";
        if constexpr(!std::is_same_v<ADataType, _Float16>)
        {
            std::cout << ", A init: ";
            if(aInitMode_ == "random")
                std::cout << "Tensile-style Random; seed=" << aInitSeed_ << std::endl;
            else
                std::cout << "integer ramp (K * linearM + k) * scale" << std::endl;
        }
        else
            std::cout << std::endl;
        print_row_by_row(inputA_h.data(), K, M, true);

        if constexpr(!std::is_same_v<ADataType, _Float16>)
        {
            std::cout << "Non-Swizzled InputA storage hex (row-major K×M, same cell order as float print above):"
                      << std::endl;
            SwizzleRdna4::printBufferHex(std::cout, inputA_h.data(), inputA_h.size());
        }

        if(doHostSwizzle_)
        {
            if constexpr(std::is_same_v<ADataType, _Float16>)
            {
                tn_roctx_push("TN_pre_shuffle_doSwizzleFp16");
                SwizzleRdna4::tnSlabDoSwizzleFp16(tensorA_h, swizzledA_h);
                tn_roctx_pop();
                std::cout << std::endl << "Swizzled InputA:" << std::endl;
                Tensor::Manipulation::printTensorDataMultiDims<_Float16>(std::cout, swizzledA_h);
                std::cout << "swizzledA_h: " << std::endl;
                Tensor::Manipulation::printTensorData<_Float16>(std::cout, swizzledA_h);
            }
            else
            {
                tn_roctx_push("TN_pre_shuffle_doSwizzleF8");
                SwizzleRdna4::tnSlabDoSwizzleF8(tensorA_h, swizzledA_h);
                tn_roctx_pop();
                std::cout << std::endl
                          << "Swizzled InputA (RM 16×32 per tile; segment interleave top/bottom rows):"
                          << std::endl;
                printTensorFlatDecodedF8(std::cout, swizzledA_h);
                std::cout << "swizzledA_h: " << std::endl;
                printTensorFlatDecodedF8(std::cout, swizzledA_h);
                std::cout << "Swizzled A linear storage hex (" << swizzledA_h.getDesc().flattenSize()
                          << " elements)" << std::endl;
                SwizzleRdna4::printBufferHex(std::cout, swizzledA_h.as<void>(), swizzledA_h.getNumBytes());
            }
            HIP_CHECK_EXC(inputA_d.alloc(swizzledA_h.getNumBytes()));
            tn_roctx_push("TN_H2D_swizzled_A");
            HIP_CHECK_EXC(hipMemcpy(inputA_d.data(),
                                    swizzledA_h.as<void>(),
                                    swizzledA_h.getNumBytes(),
                                    hipMemcpyHostToDevice));
            tn_roctx_pop();
        }
        else
        {
            std::cout << std::endl
                      << "Host doSwizzle skipped (do-swizzle=0); H2D raw A (K,M) — use no-swizzle kernel .co."
                      << std::endl;
            HIP_CHECK_EXC(inputA_d.alloc(tensorA_h.getNumBytes()));
            tn_roctx_push("TN_H2D_raw_A");
            HIP_CHECK_EXC(hipMemcpy(
                inputA_d.data(), tensorA_h.as<void>(), tensorA_h.getNumBytes(), hipMemcpyHostToDevice));
            tn_roctx_pop();
        }
    }

public:
    explicit SwizzleAGemmRunnerRDNATN(po::variables_map const& args)
        : AsmRunnerAndValidator(args)
        , doHostSwizzle_(args.at("do-swizzle").as<int>() != 0)
        , aInitMode_(args.at("a-init-mode").as<std::string>())
        , aInitSeed_(args.at("a-init-seed").as<unsigned>())
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
        inputB_h = std::vector<ADataType>(N * K, ADataType(1.0f));
        inputC_h = std::vector<ADataType>(M * N, ADataType(0.0f));
        HIP_CHECK_EXC(inputB_d.alloc(sizeof(ADataType) * N * K));
        HIP_CHECK_EXC(inputC_d.alloc(sizeof(ADataType) * M * N));

        tnHostPrepareAndUploadA();

        for(size_t idxB = 0; idxB < inputB_h.size(); ++idxB)
        {
            auto rowID = idxB % K;
            inputB_h[idxB]
                = (rowID % 3 == 2) ? ADataType(0.0f) : ADataType(1.0f);
        }
        std::cout << std::endl << "InputB:" << std::endl;
        print_row_by_row(inputB_h.data(), N, K, false);
        tn_roctx_push("TN_H2D_B_C");
        HIP_CHECK_EXC(hipMemcpy(inputB_d.data(),
                                inputB_h.data(),
                                sizeof(ADataType) * inputB_h.size(),
                                hipMemcpyHostToDevice));
        HIP_CHECK_EXC(hipMemcpy(inputC_d.data(),
                                inputC_h.data(),
                                sizeof(ADataType) * inputC_h.size(),
                                hipMemcpyHostToDevice));
        tn_roctx_pop();

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

        // Same pointer order as SwizzleAGemmRunner / GemmRunner: D, C, A, B (BH_UserArgs ABI).
        kernelArg.append("D", static_cast<void*>(outputD_d.data()));
        kernelArg.append("C", static_cast<void*>(inputC_d.data()));
        kernelArg.append("A", static_cast<void*>(inputA_d.data()));
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
            maxErr = std::max(maxErr, std::abs(err));
        }

        std::cout << "max error : " << maxErr << std::endl;
        return (maxErr == 0.0f) && !std::isnan(maxErr) && !std::isinf(maxErr);
    }

    bool compare_fp8(const std::vector<hipblaslt_f8_fnuz>& gpuOutput,
                     const std::vector<hipblaslt_f8_fnuz>& ref)
    {
        size_t bad    = 0;
        float  maxAbs = 0.f;
        float  maxRat = 0.f;
        for(size_t i = 0; i < ref.size(); ++i)
        {
            float a = static_cast<float>(ref[i]);
            float b = static_cast<float>(gpuOutput[i]);
            float e = std::fabs(a - b);
            maxAbs  = std::max(maxAbs, e);
            float den = std::fabs(a) + std::fabs(b) + 1.f;
            if(den > 0.f)
                maxRat = std::max(maxRat, e / den);
            if(!SwizzleRdna4::almostEqualF8(ref[i].data, gpuOutput[i].data, nullptr))
                ++bad;
        }
        std::cout << "Validation vs tensilelite Reference.hpp AlmostEqual (Float8_fnuz tol=0.125×(|a|+|b|+1)):"
                  << std::endl;
        std::cout << "  mismatched elements: " << bad << " / " << ref.size() << std::endl;
        std::cout << "  max |ref-gpu| (float decode): " << maxAbs << std::endl;
        std::cout << "  max |ref-gpu|/(|ref|+|gpu|+1): " << maxRat
                  << " (Tensile allows < 0.125)" << std::endl;
        if(bad != 0)
        {
            std::cout << "Why non-zero: A,B are FP8 (or FP16); inner products use float math with different\n"
                      << "  accumulation order (CPU sequential vs GPU WMMA tree), then final D rounds to E4M3 "
                         "— so decoded float rarely matches bit-exact."
                      << std::endl;
        }
        return bad == 0;
    }

    virtual bool Validation() override
    {
        std::cout << std::endl << "Validation:" << std::endl;

        if constexpr(!std::is_same_v<ADataType, _Float16>)
        {
            cpuGEMM_tensile_ref(inputA_h.data(), inputB_h.data(), inputC_h.data(), outputD_h.data());
            std::cout << std::endl << "Ref:" << std::endl;
            print_row_by_row(outputD_h.data(), N, M, false);

            std::vector<hipblaslt_f8_fnuz> gpuOutput(M * N);
            HIP_CHECK_EXC(hipMemcpy(gpuOutput.data(),
                                    outputD_d.data(),
                                    sizeof(hipblaslt_f8_fnuz) * gpuOutput.size(),
                                    hipMemcpyDeviceToHost));
            std::cout << std::endl << "Kernel Result:" << std::endl;
            print_row_by_row(gpuOutput.data(), N, M, false);

            return compare_fp8(gpuOutput, outputD_h);
        }

        cpuGEMM_tensile_ref(inputA_h.data(), inputB_h.data(), inputC_h.data(), outputD_h.data());
        std::cout << std::endl << "Ref:" << std::endl;
        print_row_by_row(outputD_h.data(), N, M, false);

        std::vector<ADataType> gpuOutput(M * N);
        HIP_CHECK_EXC(hipMemcpy(
            gpuOutput.data(), outputD_d.data(), sizeof(ADataType) * gpuOutput.size(), hipMemcpyDeviceToHost));
        std::cout << std::endl << "Kernel Result:" << std::endl;
        print_row_by_row(gpuOutput.data(), N, M, false);

        return compare(gpuOutput, outputD_h);
    }
};
