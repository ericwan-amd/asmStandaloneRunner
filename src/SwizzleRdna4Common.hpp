#pragma once

#include "TensorData.hpp"
#include "hipblaslt_float8.h"

#include <cassert>
#include <cstdint>
#include <cmath>
#include <cstring>
#include <iomanip>
#include <iostream>
#include <random>

namespace SwizzleRdna4
{

using TensorClass = Tensor::Manipulation::Tensor;

inline float f8uToFloat(uint8_t u)
{
    hipblaslt_f8_fnuz v(0.f);
    v.data = u;
    return float(v);
}

inline uint8_t floatToF8u(float x)
{
    hipblaslt_f8_fnuz v(x);
    return v.data;
}

/// **TN FP16 / BF16 slab:** logical `A` is **(K, M)**; host stages RM **(M, K)** with
/// **linear = 32×m + k**, then **pad → reshape → `permute({0,2,3,1,4})`** so device linear matches
/// **lane-major** `8×lane + elem` (see `asm/rdna4_swzA/doc/reshape_permute_to_target_layout.md`).
/// `tnSlabDoSwizzleFp16` calls this path only.
inline void tnSlabDoSwizzle(const TensorClass& inBuffer, TensorClass& swizzled)
{
    size_t MiM_N = 16, MiK = 16, MiKv = 8, PackK = 1;
    auto   unrolledSize = inBuffer.getDesc().getShape()[0];
    auto   tiledSize    = inBuffer.getDesc().getShape()[1];
    ::Tensor::Manipulation::Shape paddedShape{
        ((tiledSize / MiM_N) + !!(tiledSize % MiM_N)) * MiM_N,
        (unrolledSize / (MiK * PackK) + !!(unrolledSize % (MiK * PackK))) * MiK * PackK};
    auto tmpTensor = TensorClass({tiledSize, unrolledSize}, inBuffer.getElementSize());
    memcpy(tmpTensor.as<void>(), inBuffer.as<void>(), tmpTensor.getNumBytes());
    uint64_t padVal{};
    auto     paddedTensor
        = ::Tensor::Manipulation::pad(tmpTensor, paddedShape, &padVal, tmpTensor.getElementSize());
    paddedTensor.reshape({paddedShape[0] / MiM_N,
                          MiM_N,
                          paddedShape[1] / (MiK * PackK),
                          MiK / MiKv,
                          MiKv * PackK});

    swizzled = ::Tensor::Manipulation::permute(paddedTensor, {0, 2, 3, 1, 4});
}

/// **TN FP8 slab (device as RM 16×32):** same padded RM **(M, K)** tile as FP16 staging, then for
/// each **512** elements (one 16×32 tile), walk source **row-major** linear `i = 0..511`.
/// Partition into **64-element groups** `g = 0..7`. Within each group, four **16**-element runs
/// split: **first 8** go to **top** row `g` (cols 0–7, 8–15, 16–23, 24–31 by quarter), **last 8**
/// to **bottom** row `g + 8` at the same column bands — i.e. every 16 in linear order: upper
/// slab / lower slab at matching columns (matches the FP8 layout figure / ramp 0..511 grid).
inline void tnSlabDoSwizzleF8(const TensorClass& inBuffer, TensorClass& swizzled)
{
    assert(inBuffer.getElementSize() == 1 && "RDNA4 F8 swizzle: each tensor element must be 1 byte (e.g. hipblaslt_f8_fnuz)");
    size_t MiM_N = 16, MiK = 16, PackK = 1;
    auto   unrolledSize = inBuffer.getDesc().getShape()[0];
    auto   tiledSize    = inBuffer.getDesc().getShape()[1];
    ::Tensor::Manipulation::Shape paddedShape{
        ((tiledSize / MiM_N) + !!(tiledSize % MiM_N)) * MiM_N,
        (unrolledSize / (MiK * PackK) + !!(unrolledSize % (MiK * PackK))) * MiK * PackK};
    auto tmpTensor = TensorClass({tiledSize, unrolledSize}, inBuffer.getElementSize());
    memcpy(tmpTensor.as<void>(), inBuffer.as<void>(), tmpTensor.getNumBytes());
    uint64_t padVal{};
    auto     paddedTensor
        = ::Tensor::Manipulation::pad(tmpTensor, paddedShape, &padVal, tmpTensor.getElementSize());

    const size_t elemSize = paddedTensor.getElementSize();
    const size_t nel      = paddedTensor.getDesc().flattenSize();
    assert(nel % 512 == 0
           && "RDNA4 F8 TN slab: padded element count must be a multiple of 512 (16×32 tiles)");

    swizzled = TensorClass(paddedTensor.getDesc().getShape(), elemSize);
    const auto* srcB = static_cast<const unsigned char*>(paddedTensor.as<void>());
    auto*       dstB = static_cast<unsigned char*>(swizzled.as<void>());

    for(size_t slab = 0; slab < nel / 512; ++slab)
    {
        const unsigned char* ps = srcB + slab * 512 * elemSize;
        unsigned char*       pd = dstB + slab * 512 * elemSize;
        for(size_t i = 0; i < 512; ++i)
        {
            const uint32_t seg = static_cast<uint32_t>(i / 8);
            const uint32_t eis = static_cast<uint32_t>(i % 8);
            const uint32_t g   = seg / 8u;
            const uint32_t row = (seg % 2u) == 0u ? g : (g + 8u);
            const uint32_t col = (seg % 8u) / 2u * 8u + eis;
            const size_t   o   = static_cast<size_t>(row) * 32u + static_cast<size_t>(col);
            memcpy(pd + o * elemSize, ps + i * elemSize, elemSize);
        }
    }
}

/// Explicit **FP16 (2 bytes / element)** host swizzle for RDNA4 TN swizzleA HHS path.
inline void tnSlabDoSwizzleFp16(const TensorClass& inBuffer, TensorClass& swizzled)
{
    assert(inBuffer.getElementSize() == sizeof(uint16_t) && "RDNA4 FP16 swizzle expects 2-byte elements");
    tnSlabDoSwizzle(inBuffer, swizzled);
}

/// Tensile-style small integer draws for host tensors (matches typical client tests).
inline int32_t tensileRandomInt(std::mt19937& gen)
{
    std::uniform_int_distribution<int32_t> dist(-3, 3);
    return dist(gen);
}

inline bool almostEqualF8(uint8_t refU, uint8_t gpuU, float* maxAbsOut = nullptr)
{
    float a   = f8uToFloat(refU);
    float b   = f8uToFloat(gpuU);
    float tol = 0.125f * (std::fabs(a) + std::fabs(b) + 1.f);
    float e   = std::fabs(a - b);
    if(maxAbsOut != nullptr)
        *maxAbsOut = std::max(*maxAbsOut, e);
    return e <= tol;
}

inline void printBufferHex(std::ostream& os, const void* p, size_t nbytes, size_t perRow = 32)
{
    const auto* u = static_cast<const uint8_t*>(p);
    for(size_t i = 0; i < nbytes; ++i)
    {
        if(i % perRow == 0 && i != 0)
            os << '\n';
        os << "0x" << std::hex << std::setfill('0') << std::setw(2) << static_cast<unsigned>(u[i])
           << std::dec;
        if(i + 1 < nbytes)
            os << ", ";
    }
    os << '\n';
}

} // namespace SwizzleRdna4
