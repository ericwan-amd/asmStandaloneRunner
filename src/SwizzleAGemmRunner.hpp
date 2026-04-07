#pragma once

#include "utilities.hpp"
#include "TensorData.hpp"

using TensorClass = Tensor::Manipulation::Tensor;

class SwizzleAGemmRunner : public AsmRunnerAndValidator
{
private:
    static const uint32_t minM = 16;
    static const uint32_t minK = 32;

    std::vector<_Float16> inputA_h; // K-major (CPU used only)
    std::vector<_Float16> inputB_h; // Could be N or T
    std::vector<_Float16> inputC_h;
    std::vector<_Float16> outputD_h; // M-major

    gpubuf_t<_Float16> inputA_d;
    gpubuf_t<_Float16> inputB_d;
    gpubuf_t<_Float16> inputC_d;
    gpubuf_t<_Float16> outputD_d;

    size_t Coord2Idx(uint32_t D1,    // D1 = leading dimension
                     uint32_t D2,    // D2 = the other
                     size_t   idx_1, // id moving along D1
                     size_t   idx_2) // id moving along D2
    {
        size_t idx = idx_2 * D1 + idx_1;
        return idx;
    }

    template <typename T>
    void cpuGEMM(T* A, T* B, T* C, T* D)
    {
        for(auto dx = 0; dx < N; ++dx)
        {
            for(auto dy = 0; dy < M; ++dy)
            {
                float d = 0;
                for(auto dk = 0; dk < K; ++dk)
                {
                    auto idx_A = Coord2Idx(K, M, dk, dy);
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

    // For TN, the desc.size[0] = K, desc.size[1] = M if A else N (B)
    // FP16-only path (MiKv=4, PackK=2). RDNA4 gfx12 **F8F8S swizzleA** uses test-tag
    // swizzleA_gemm_rdna_tn_f8 / _nn_f8 and SwizzleRdna4::tnSlabDoSwizzleF8 — not this runner.
    void doSwizzle(const TensorClass& inBuffer, TensorClass& swizzled)
    {
        // using Tensor = Tensor::Manipulation::Tensor;
        // currently, if A then it means MiM = 16, if B then it means MiN = 16
        // For Half
        size_t MiM_N = 16, MiK = 16, MiKv = 4, PackK = 2;
        // calculateKforSwizzling(desc.dataType(), MiK, MiKv, PackK);
        auto unrolledSize = inBuffer.getDesc().getShape()[0];
        auto tiledSize    = inBuffer.getDesc().getShape()[1];
        ::Tensor::Manipulation::Shape paddedShape{ ((tiledSize / MiM_N) + !!(tiledSize % MiM_N)) * MiM_N, (unrolledSize / (MiK * PackK) + !!(unrolledSize % (MiK * PackK))) * MiK * PackK};
        auto tmpTensor = TensorClass({tiledSize, unrolledSize}, inBuffer.getElementSize());
        memcpy(tmpTensor.as<void>(), inBuffer.as<void>(), tmpTensor.getNumBytes());
        //Temporary hack
        uint64_t padVal{};
        auto     paddedTensor = ::Tensor::Manipulation::pad(tmpTensor, paddedShape, &padVal, tmpTensor.getElementSize());
        paddedTensor.reshape({paddedShape[0] / MiM_N,
                              MiM_N,
                              paddedShape[1] / (MiK * PackK),
                              MiK / MiKv,
                              MiKv * PackK});

        swizzled = permute(paddedTensor, {0, 2, 3, 1, 4});
    }

public:
    SwizzleAGemmRunner(po::variables_map const& args)
        : AsmRunnerAndValidator(args)
    {
    }

    virtual void SetupKernelArgs(KernelInvocation& kernelInvoc) override
    {
        uint32_t Mr = M / minM;
        uint32_t Kr = K / minK;

        TensorClass tensorA_h = TensorClass({K, M}, sizeof(_Float16));
        TensorClass swizzledA_h = TensorClass({K, M}, sizeof(_Float16));

        // init A,B,C
        inputA_h  = std::vector<_Float16>();
        inputB_h  = std::vector<_Float16>(N * K, (_Float16)1.0f);
        inputC_h  = std::vector<_Float16>(M * N, (_Float16)0.0f);
        outputD_h = std::vector<_Float16>(M * N, (_Float16)0.0f);

        // alloc after swizzled padded
        // HIP_CHECK_EXC(inputA_d.alloc(sizeof(_Float16) * M * K));
        HIP_CHECK_EXC(inputB_d.alloc(sizeof(_Float16) * N * K));
        HIP_CHECK_EXC(inputC_d.alloc(sizeof(_Float16) * M * N));
        HIP_CHECK_EXC(outputD_d.alloc(sizeof(_Float16) * M * N));

        // non-swizzled A for CPU ref
        size_t value = 0;
        for(size_t dimM = 0; dimM < M; ++dimM)
        {
            size_t scale = ((dimM / minM) % 2) + 1; // wrap scale between [1,2]
            size_t linearM = dimM % minM;
            value = (K * linearM);
            for(size_t dimK = 0; dimK < K; ++dimK)
            {
                inputA_h.push_back((value + dimK) * scale);
            }
            // value = (minK * linearM);
            // for(size_t dimK = 0; dimK < Kr; ++dimK)
            // {
            //     for (size_t v = 0; v < minK; ++v)
            //         inputA_h.push_back((value + v) * scale);
            // }
        }
        memcpy(tensorA_h.as<void>(), inputA_h.data(), tensorA_h.getNumBytes());
        std::cout << std::endl << "Non-Swizzled InputA:" << std::endl;
        // Tensor::Manipulation::printTensorDataMultiDims<_Float16>(std::cout, tensorA_h);
        print_row_by_row(tensorA_h.as<_Float16>(), K, M, true);

        // Tensor Swizzle
        doSwizzle(tensorA_h, swizzledA_h);
        std::cout << std::endl << "Swizzled InputA:" << std::endl;
        Tensor::Manipulation::printTensorDataMultiDims<_Float16>(std::cout, swizzledA_h);
        // print_row_by_row(swizzledA_h.as<_Float16>(), 8*M, K/8, true);


        // final memory size is padded
        HIP_CHECK_EXC(inputA_d.alloc(swizzledA_h.getNumBytes()));


        for(size_t idxB = 0; idxB < inputB_h.size(); ++idxB)
        {
            // auto rowID = idxB % K;
            // inputB_h[idxB] = ((rowID / 8) % 2 == 0)? 0 : 1;

            auto rowID = idxB % K;
            inputB_h[idxB] = (rowID % 3 == 2)? 0 : 1; // column looks like 1,1,0,1,1,0,1,1,0....

            // size_t colID = idxB / K;
            // inputB_h[idxB] = (colID % 2 == 0)? 0 : 1;
        }
        std::cout << std::endl << "InputB:" << std::endl;
        print_row_by_row(inputB_h.data(), N, K, false);

        // copy to device
        // HIP_CHECK_EXC(hipMemcpy(inputA_d.data(),
        //                         inputA_h.data(),
        //                         sizeof(_Float16) * inputA_h.size(),
        //                         hipMemcpyHostToDevice));
        HIP_CHECK_EXC(hipMemcpy(inputA_d.data(),
                                swizzledA_h.as<void>(),
                                swizzledA_h.getNumBytes(),
                                hipMemcpyHostToDevice));
        HIP_CHECK_EXC(hipMemcpy(inputB_d.data(),
                                inputB_h.data(),
                                sizeof(_Float16) * inputB_h.size(),
                                hipMemcpyHostToDevice));
        HIP_CHECK_EXC(hipMemcpy(inputC_d.data(),
                                inputC_h.data(),
                                sizeof(_Float16) * inputC_h.size(),
                                hipMemcpyHostToDevice));

        kernelInvoc.args           = KernelArguments(false);
        KernelArguments& kernelArg = kernelInvoc.args;

        kernelArg.reserve(1024, 128);
        // V1
        // kernelArg.append("Gemm-info", (uint32_t)1);
        // kernelArg.append("kernel-info0", (uint32_t)35651585);
        // kernelArg.append("kernel-info1", (uint32_t)8);
        // V2
        kernelArg.append("gemm_count", (uint32_t)1);
        kernelArg.append("internalArgs", (uint32_t)1);
        kernelArg.append("internalArgs1", (uint32_t)1275592712);
        kernelArg.append("numWG", (uint32_t)(kernelInvoc.gridDim.x));
        kernelArg.append("SizesFree0", M); // M
        kernelArg.append("SizesFree1", N); // N
        kernelArg.append("SizesFree2", (uint32_t)1); // B
        kernelArg.append("SizesSum0", K); // K

        kernelArg.append("D", outputD_d.data());
        kernelArg.append("C", inputC_d.data());
        kernelArg.append("A", inputA_d.data());
        kernelArg.append("B", inputB_d.data());

        kernelArg.append("strideD0", M);
        kernelArg.append("strideD1", (M * N));
        kernelArg.append("strideC0", M);
        kernelArg.append("strideC1", (M * N));
        kernelArg.append("strideA0", K); // K-major
        kernelArg.append("strideA1", (M * K));
        kernelArg.append("strideB0", K); // K-major
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
            maxErr     = max(maxErr, abs(err));
        }

        std::cout << "max error : " << maxErr << std::endl;
        return (maxErr == 0.0f);
    }

    virtual bool Validation() override
    {
        std::cout << std::endl << "Validation:" << std::endl;

        // CPU gemm
        cpuGEMM(inputA_h.data(), inputB_h.data(), inputC_h.data(), outputD_h.data());
        std::cout << std::endl << "Ref:" << std::endl;
        print_row_by_row(outputD_h.data(), N, M, false);

        // compare
        std::vector<_Float16> gpuOutput(M * N);
        HIP_CHECK_EXC(hipMemcpy(gpuOutput.data(), outputD_d.data(), outputD_d.size(), hipMemcpyDeviceToHost));
        std::cout << std::endl << "Kernel Result:" << std::endl;
        print_row_by_row(gpuOutput.data(), N, M, false);

        return compare(gpuOutput, outputD_h);
    }
};