#pragma once

#include <boost/program_options.hpp>

#include <cstddef>
#include <fstream>
#include <hip/hip_ext.h>
#include <hip/hip_runtime.h>
#include <hip/hip_runtime_api.h>
#include <iostream>
#include <mutex>
#include <random>
#include <sstream>
#include <stdexcept>
#include <string>
#include <unordered_map>
#include <unordered_set>

#include "bfloat16.h"
#include "hipblaslt_float8.h"

#include "SwizzleRdna4Common.hpp"

namespace po = boost::program_options;

/// Shared host **A** indexing + fill patterns for RDNA swizzle TN/NN runners (Tensile-style ramp / random).
namespace swizzle_rdna_host
{

/// NN **A** column-major M×K, `lda = M` → `L = m + lda * k`.
inline size_t linearA_colMajor(uint32_t m, uint32_t k, uint32_t ldaM)
{
    return static_cast<size_t>(m) + static_cast<size_t>(ldaM) * static_cast<size_t>(k);
}

/// TN **A** row-major **K×M** (K rows, M cols): index for row `dimM`, col `dimK` is `dimM * K + dimK` with leading dim K.
inline size_t linearA_tn_rowMajorKxM(uint32_t dimM, uint32_t dimK, uint32_t K)
{
    return static_cast<size_t>(dimM) * static_cast<size_t>(K) + static_cast<size_t>(dimK);
}

/// Integer ramp `(K * linearM + k) * scale` at each logical `(dimM, dimK)`; `idx(dimM,dimK)` → linear offset in `out`.
template <typename ADataType, typename IndexFn>
void fill_inputA_ramp(uint32_t M, uint32_t K, uint32_t minM, ADataType* out, IndexFn&& idx)
{
    for(size_t dimM = 0; dimM < M; ++dimM)
    {
        size_t scale   = ((dimM / minM) % 2) + 1;
        size_t linearM = dimM % minM;
        size_t value   = (static_cast<size_t>(K) * linearM);
        for(size_t dimK = 0; dimK < K; ++dimK)
            out[idx(dimM, dimK)]
                = ADataType(static_cast<float>((value + dimK) * scale));
    }
}

/// Tensile-style small-integer random at each `(dimM, dimK)` (see `SwizzleRdna4::tensileRandomInt`).
template <typename ADataType, typename IndexFn>
void fill_inputA_random_tensile(uint32_t M, uint32_t K, unsigned seed, ADataType* out, IndexFn&& idx)
{
    std::mt19937 gen(seed);
    for(size_t dimM = 0; dimM < M; ++dimM)
    {
        for(size_t dimK = 0; dimK < K; ++dimK)
            out[idx(dimM, dimK)]
                = ADataType(static_cast<float>(SwizzleRdna4::tensileRandomInt(gen)));
    }
}

} // namespace swizzle_rdna_host

#define HIP_CHECK_EXC(expr)                                                                       \
    do                                                                                            \
    {                                                                                             \
        hipError_t e = (expr);                                                                    \
        if(e)                                                                                     \
        {                                                                                         \
            const char*        errName = hipGetErrorName(e);                                      \
            const char*        errMsg  = hipGetErrorString(e);                                    \
            std::ostringstream msg;                                                               \
            msg << "Error " << e << "(" << errName << ") " << __FILE__ << ":" << __LINE__ << ": " \
                << std::endl                                                                      \
                << #expr << std::endl                                                             \
                << errMsg << std::endl;                                                           \
            throw std::runtime_error(msg.str());                                                  \
        }                                                                                         \
    } while(0)

#define HIP_CHECK_EXC_MESSAGE(expr, message)                                                      \
    do                                                                                            \
    {                                                                                             \
        hipError_t e = (expr);                                                                    \
        if(e)                                                                                     \
        {                                                                                         \
            const char*        errName = hipGetErrorName(e);                                      \
            const char*        errMsg  = hipGetErrorString(e);                                    \
            std::ostringstream msg;                                                               \
            msg << "Error " << e << "(" << errName << ") " << __FILE__ << ":" << __LINE__ << ": " \
                << std::endl                                                                      \
                << #expr << std::endl                                                             \
                << errMsg << std::endl                                                            \
                << (message) << std::endl;                                                        \
            throw std::runtime_error(msg.str());                                                  \
        }                                                                                         \
    } while(0)

#define HIP_CHECK_RETURN(expr) \
    do                         \
    {                          \
        hipError_t e = (expr); \
        if(e)                  \
            return e;          \
    } while(0)

#define HIP_CHECK_PRINT(expr)                             \
    {                                                     \
        hipError_t e = (expr);                            \
        if(e)                                             \
            std::cout << "Error code " << e << std::endl; \
    }

// randomly pick a value from [begin, last]
static int random_int(int begin, int last)
{
    if(begin == last)
        return last;

    std::random_device              rd;
    std::mt19937                    gen(rd());
    std::uniform_int_distribution<> distr(begin, last); // define the range

    int picked = distr(gen);
    return picked;
}

// randomly small float [0.1, 0.2, 0.3,...., 1.0]
static float random_small_float()
{
    return (float)random_int(1, 10) / 10.0f;
}

// Simple RAII class for GPU buffers.  T is the type of pointer that
// data() returns
template <class T = void>
class gpubuf_t
{
public:
    gpubuf_t() {}
    // buffers are movable but not copyable
    gpubuf_t(gpubuf_t&& other)
    {
        std::swap(buf, other.buf);
        std::swap(bsize, other.bsize);
    }
    gpubuf_t& operator=(gpubuf_t&& other)
    {
        std::swap(buf, other.buf);
        std::swap(bsize, other.bsize);
        return *this;
    }
    gpubuf_t(const gpubuf_t&)            = delete;
    gpubuf_t& operator=(const gpubuf_t&) = delete;

    ~gpubuf_t()
    {
        free();
    }

    hipError_t alloc(const size_t size)
    {
        bsize = size;
        free();
        auto ret = hipMalloc(&buf, bsize);
        if(ret != hipSuccess)
        {
            buf   = nullptr;
            bsize = 0;
        }
        return ret;
    }

    hipError_t set_zero()
    {
        if(bsize > 0)
        {
            auto ret = hipMemset(buf, 0, bsize);
            return ret;
        }

        return hipSuccess;
    }

    size_t size() const
    {
        return bsize;
    }

    void free()
    {
        if(buf != nullptr)
        {
            (void)hipFree(buf);
            buf = nullptr;
        }
    }

    T* data() const
    {
        return static_cast<T*>(buf);
    }

    // equality/bool tests
    bool operator==(std::nullptr_t n) const
    {
        return buf == n;
    }
    bool operator!=(std::nullptr_t n) const
    {
        return buf != n;
    }
    operator bool() const
    {
        return buf;
    }

private:
    // The GPU buffer
    void*  buf   = nullptr;
    size_t bsize = 0;
};

// copy a host vector to the device
template <typename T>
gpubuf_t<> host_vec_to_dev(const std::vector<T>& hvec)
{
    gpubuf_t<> ret;
    if(ret.alloc(sizeof(T) * hvec.size()) != hipSuccess)
        throw std::runtime_error("failed to hipMalloc");
    if(hipMemcpy(ret.data(), hvec.data(), sizeof(T) * hvec.size(), hipMemcpyHostToDevice)
       != hipSuccess)
        throw std::runtime_error("failed to memcpy");
    return ret;
}

template <typename T>
class KernelArgumentsContainer
{
public:
    void setPointer(void* pointer, size_t size)
    {
        m_data     = (T*)pointer;
        m_dataSize = size;
    }

    void reserve(size_t maxSize)
    {
        m_maxSize = maxSize;
        if(!m_data)
        {
            m_vec_data.reserve(maxSize);
        }
    }

    void insert(size_t startPos, size_t size, T value)
    {
        if(!m_data)
        {
            m_vec_data.insert(m_vec_data.end(), size, value);
            m_currentLocation = m_vec_data.size();
            return;
        }
        else if(startPos + size < m_dataSize)
        {
            // We don't insert 0 here because we'll copy data later.
            // Adding this API is to compatible with vector insert.
            // for(size_t i = startPos; i < startPos + size; i++)
            // {
            //     m_data[i] = value;
            // }
            m_currentLocation += size;
        }
    }

    size_t size() const
    {
        return m_currentLocation;
    }

    size_t end() const
    {
        return m_currentLocation;
    }

    const uint8_t* data() const
    {
        if(!m_data)
        {
            return m_vec_data.data();
        }
        return (const uint8_t*)m_data;
    }

    uint8_t* rawdata()
    {
        if(!m_data)
        {
            T* ptr = m_vec_data.data();
            return ptr;
        }
        return (uint8_t*)m_data;
    }

    const T& operator[](unsigned int i) const
    {
        if(!m_data)
        {
            return m_vec_data[i];
        }
        return m_data[i];
    }

    T& operator[](unsigned int i)
    {
        if(!m_data)
        {
            return m_vec_data[i];
        }
        return m_data[i];
    }

private:
    size_t         m_maxSize         = 0;
    size_t         m_currentLocation = 0;
    T*             m_data            = nullptr;
    size_t         m_dataSize;
    std::vector<T> m_vec_data;
};

class KernelArguments
{
public:
    KernelArguments(bool log = true);
    virtual ~KernelArguments();

    void reserve(size_t bytes, size_t count);

    template <typename T>
    void append(std::string const& name, T value);

    void const* data() const;
    uint8_t*    rawdata();
    size_t      size() const;

private:
    template <typename T>
    void append(std::string const& name, T value, bool bound);

    template <typename T>
    std::string stringForValue(T value, bool bound);

    // void appendRecord(std::string const& name, Arg info);

    template <typename T>
    void writeValue(size_t offset, T value);

    KernelArgumentsContainer<uint8_t> m_data;

    std::vector<std::string> m_names;

    bool m_log;
};

template <typename T>
inline void KernelArguments::append(std::string const& name, T value)
{
    append(name, value, true);
}

template <typename T>
inline std::string KernelArguments::stringForValue(T value, bool bound)
{
    if(!m_log)
        return "";

    if(!bound)
        return "<unbound>";

    using castType = std::conditional_t<std::is_pointer<T>::value, void const*, T>;

    std::ostringstream msg;
    msg << static_cast<castType>(value);
    return msg.str();
}

template <typename T>
inline void KernelArguments::append(std::string const& name, T value, bool bound)
{
    size_t offset = m_data.size();
    size_t size   = sizeof(T);

    m_data.insert(m_data.end(), sizeof(value), 0);
    writeValue(offset, value);
}

template <typename T>
inline void KernelArguments::writeValue(size_t offset, T value)
{
    if(offset + sizeof(T) > m_data.size())
    {
        throw std::runtime_error("Value exceeds allocated bounds.");
    }

    std::memcpy(&m_data[offset], &value, sizeof(T));
}

KernelArguments::KernelArguments(bool log)
    : m_log(log)
{
}

KernelArguments::~KernelArguments() {}

void KernelArguments::reserve(size_t bytes, size_t count)
{
    m_data.reserve(bytes);
    m_names.reserve(count);
}

void const* KernelArguments::data() const
{
    return reinterpret_cast<void const*>(m_data.data());
}

uint8_t* KernelArguments::rawdata()
{
    return m_data.rawdata();
}

size_t KernelArguments::size() const
{
    return m_data.size();
}

struct KernelInvocation
{
public:
    std::string kernelName;
    std::string codeObjectFile; //Code object file kernel is located in

    dim3   blockDim; // threads in a block
    dim3   gridDim; // num of block
    dim3   totalItemDim; // total threads numbers
    size_t sharedMemBytes = 0;

    KernelArguments args;
};

class SolutionAdapter
{
public:
    SolutionAdapter();
    SolutionAdapter(bool debug);
    SolutionAdapter(bool debug, std::string const& name);
    ~SolutionAdapter();

    virtual std::string name() const
    {
        return m_name;
    }

    hipError_t loadCodeObjectFile(std::string const& path);

    hipError_t launchKernel(KernelInvocation const& kernel);
    hipError_t launchKernel(KernelInvocation const& kernel,
                            hipStream_t             stream,
                            hipEvent_t              startEvent,
                            hipEvent_t              stopEvent);

    hipError_t initKernel(std::string const& name);

private:
    hipError_t getKernel(hipFunction_t& rv, std::string const& name);

    std::mutex m_access;

    std::vector<hipModule_t>                       m_modules;
    std::unordered_map<std::string, hipFunction_t> m_kernels;
    bool                                           m_debug           = false;
    bool                                           m_debugSkipLaunch = false;
    std::string                                    m_name            = "HipSolutionAdapter";
    std::string                                    m_codeObjectDirectory;

    std::vector<std::string>        m_loadedModuleNames;
    std::unordered_set<std::string> m_loadedCOFiles;
};

SolutionAdapter::SolutionAdapter() {}

SolutionAdapter::SolutionAdapter(bool debug)
    : m_debug(debug)
{
}

SolutionAdapter::SolutionAdapter(bool debug, std::string const& name)
    : m_debug(debug)
    , m_name(name)
{
}

SolutionAdapter::~SolutionAdapter()
{
    for(auto module : m_modules)
        HIP_CHECK_PRINT(hipModuleUnload(module));
}

std::string removeXnack(std::string coFilename)
{
    std::string xnackVersion = "xnack"; //Extra character before and after xnack
    size_t      loc          = coFilename.find(xnackVersion);
    if(loc != std::string::npos)
        coFilename.replace(loc - 1, xnackVersion.length() + 2, "");

    return coFilename;
}

hipError_t SolutionAdapter::loadCodeObjectFile(std::string const& path)
{
    hipModule_t module;

    HIP_CHECK_RETURN(hipModuleLoad(&module, path.c_str()));

    if(m_debug)
        std::cout << "loaded code object " << path << std::endl;

    {
        std::lock_guard<std::mutex> guard(m_access);
        m_modules.push_back(module);
        m_loadedModuleNames.push_back("File " + path);

        //Isolate filename
        size_t start = path.rfind('/');
        start        = (start == std::string::npos) ? 0 : start + 1;
        m_loadedCOFiles.insert(removeXnack(std::string(path.begin() + start, path.end())));
    }
    return hipSuccess;
}

hipError_t SolutionAdapter::initKernel(std::string const& name)
{
    hipFunction_t function;
    return getKernel(function, name);
}

hipError_t SolutionAdapter::getKernel(hipFunction_t& rv, std::string const& name)
{
    std::unique_lock<std::mutex> guard(m_access);
    hipError_t                   err = hipErrorNotFound;

    auto it = m_kernels.find(name);
    if(it != m_kernels.end())
    {
        rv = it->second;
        return hipSuccess;
    }

    for(auto module : m_modules)
    {
        err = hipModuleGetFunction(&rv, module, name.c_str());

        if(err == hipSuccess)
        {
            m_kernels[name] = rv;
            return err;
        }
        else if(err != hipErrorNotFound)
        {
            return err;
        }
    }

    return err;
}

hipError_t SolutionAdapter::launchKernel(KernelInvocation const& kernel)
{
    return launchKernel(kernel, nullptr, nullptr, nullptr);
}

hipError_t SolutionAdapter::launchKernel(KernelInvocation const& kernel,
                                         hipStream_t             stream,
                                         hipEvent_t              startEvent,
                                         hipEvent_t              stopEvent)
{
    if(!kernel.codeObjectFile.empty())
    {
        //If required code object file hasn't yet been loaded, load it now
        m_access.lock();
        bool loaded
            = m_loadedCOFiles.find(removeXnack(kernel.codeObjectFile)) != m_loadedCOFiles.end();
        std::string codeObjectDir = m_codeObjectDirectory;
        m_access.unlock();

        if(!loaded)
        {
            //Try other xnack versions
            size_t     loc = kernel.codeObjectFile.rfind('.');
            hipError_t err;

            for(auto ver : {"", "-xnack-", "-xnack+"})
            {
                std::string modifiedCOName = kernel.codeObjectFile;
                modifiedCOName.insert(loc, ver);
                err = loadCodeObjectFile(codeObjectDir + modifiedCOName);

                if(err == hipSuccess)
                    break;
            }
        }
    }

    if(m_debug)
    {
        std::cout << "Kernel " << kernel.kernelName << std::endl;
        std::cout << " l[" << kernel.blockDim.x << "," << kernel.blockDim.y << ","
                  << kernel.blockDim.z << "] x g[" << kernel.gridDim.x << "," << kernel.gridDim.y
                  << "," << kernel.gridDim.z << "] = [" << kernel.totalItemDim.x << ","
                  << kernel.totalItemDim.y << "," << kernel.totalItemDim.z << "]" << std::endl;
    }
    if(m_debugSkipLaunch)
    {
        std::cout << "DEBUG: Skip kernel execution" << std::endl;
        if(startEvent != nullptr)
            HIP_CHECK_RETURN(hipEventRecord(startEvent, stream));
        if(stopEvent != nullptr)
            HIP_CHECK_RETURN(hipEventRecord(stopEvent, stream));
        return hipSuccess;
    }

    hipFunction_t function;
    HIP_CHECK_RETURN(getKernel(function, kernel.kernelName));

    void*  kernelArgs = const_cast<void*>(kernel.args.data());
    size_t argsSize   = kernel.args.size();

    void* hipLaunchParams[] = {HIP_LAUNCH_PARAM_BUFFER_POINTER,
                               kernelArgs,
                               HIP_LAUNCH_PARAM_BUFFER_SIZE,
                               &argsSize,
                               HIP_LAUNCH_PARAM_END};

    if(startEvent != nullptr)
        HIP_CHECK_RETURN(hipEventRecord(startEvent, stream));
    HIP_CHECK_RETURN(hipExtModuleLaunchKernel(function,
                                              kernel.totalItemDim.x,
                                              kernel.totalItemDim.y,
                                              kernel.totalItemDim.z,
                                              kernel.blockDim.x,
                                              kernel.blockDim.y,
                                              kernel.blockDim.z,
                                              kernel.sharedMemBytes, // sharedMem
                                              stream, // stream
                                              nullptr,
                                              (void**)&hipLaunchParams,
                                              nullptr, // event
                                              nullptr // event
                                              ));
    if(stopEvent != nullptr)
        HIP_CHECK_RETURN(hipEventRecord(stopEvent, stream));
    return hipSuccess;
}

namespace po = boost::program_options;
class AsmRunnerAndValidator
{
protected:

    uint32_t M;
    uint32_t N;
    uint32_t K;
    float    alpha;
    float    beta;

public:
    AsmRunnerAndValidator() = delete;
    AsmRunnerAndValidator(po::variables_map const& args)
    {
        M     = args["size_M"].as<uint32_t>();
        N     = args["size_N"].as<uint32_t>();
        K     = args["size_K"].as<uint32_t>();
        alpha = args["alpha"].as<float>();
        beta  = args["beta"].as<float>();
    }
    virtual ~AsmRunnerAndValidator(){};
    virtual void
        LaunchKernel(SolutionAdapter& adapter, KernelInvocation& kernelInvoc, hipStream_t stream)
    {
        HIP_CHECK_EXC(adapter.launchKernel(kernelInvoc, stream, nullptr, nullptr));
    }

    virtual void SetupKernelArgs(KernelInvocation& kernelInvoc) = 0;
    virtual bool Validation()                                   = 0;
};