/*******************************************************************************
 *
 * MIT License
 *
 * Copyright (C) 2022-2024 Advanced Micro Devices, Inc. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 *******************************************************************************/

#include <boost/algorithm/string/classification.hpp>
#include <boost/algorithm/string/split.hpp>
#include <boost/program_options.hpp>
#include <cstring>
#include <stdexcept>
#include <vector>

#include "utilities.hpp"
#include "AMAXRunner.hpp"
#include "FastAMAXRunner.hpp"
#include "GemmAmaxDRunner.hpp"
#include "GemmRunner.hpp"
#include "SwizzleAGemmRunner.hpp"
#include "SwizzleAGemmRunnerRDNANN.hpp"
#include "SwizzleAGemmRunnerRDNATN.hpp"
#include "SwizzleBGemmRunner.hpp"

namespace po = boost::program_options;

template <typename T>
po::typed_value<T>* value_default(std::string const& desc)
{
    return po::value<T>()->default_value(T(), desc);
}

template <typename T>
po::typed_value<T>* value_default()
{
    return po::value<T>()->default_value(T());
}

template <typename T>
po::typed_value<std::vector<T>>* vector_default_empty()
{
    return value_default<std::vector<T>>("[]");
}

po::options_description all_options()
{
    po::options_description options("Tensile client options");

    // clang-format off
            options.add_options()
                ("help,h", "Show help message.")

                ("config-file",              vector_default_empty<std::string>(), "INI config file(s) to read.")

                ("code-object,c",            vector_default_empty<std::string>(), "Code object file with kernel(s).  If none are "
                                                                                  "specified, we will use the embedded code "
                                                                                  "object(s) if available.")

                ("asm-file",                 po::value<std::string>(), ".s filename to compile and run, not used in cpp, used in python")

                ("kernelname",               po::value<std::string>(), "kernel name in the asm mete")

                ("workgroup-size",           vector_default_empty<std::string>(), "Num-Threads in a block.  Comma-separated list of "
                                                                                   "sizes, in the order of the Einstein notation.")

                ("num-workgroups",           vector_default_empty<std::string>(), "How man blocks launched.  Comma-separated list of "
                                                                                   "sizes, in the order of the Einstein notation.")

                ("input-bytes",              po::value<size_t>()->default_value(0), "bytes of input (only for LDS_TEST)")

                ("device-idx",               po::value<int>()->default_value(0), "device id")

                ("ext-lds-bytes",            po::value<size_t>()->default_value(0), "extern lds sizes (Should be 0 if the asm has hardcoded lds-usage)")

                ("size_M",                   po::value<uint32_t>()->default_value(16), "Dim M (def=16) for Matrix(A,D)")

                ("size_N",                   po::value<uint32_t>()->default_value(16), "Dim N (def=16) for Matrix(B,D)")

                ("size_K",                   po::value<uint32_t>()->default_value(32), "Dim K (def=32) for Matrix(A,B)")

                ("alpha",                    po::value<float>()->default_value(1.0f), "Alpha (def=1.0)")

                ("beta",                     po::value<float>()->default_value(0.0f), "Beta (def=0.0)")

                ("bias",                     po::value<float>()->default_value(1.0f), "Bias")

                ("test-tag",                 po::value<std::string>(), "test-tag to find kernel arg and validation funcs")

                ("do-swizzle",               po::value<int>()->default_value(1),
                 "For swizzleA_gemm_rdna_tn / _tn_f8 / _nn / _nn_f8: 1=host doSwizzle A then H2D (default); "
                 "0=upload raw A — pair with no-swizzle kernel code object.")

                ("tensor-element-type",      po::value<std::string>()->default_value("fp16"),
                 "Reserved / unused for RDNA swizzle runners: FP16 vs FP8 is selected by test-tag "
                 "(swizzleA_gemm_rdna_tn vs swizzleA_gemm_rdna_tn_f8, same for _nn).")

                ("a-init-mode", po::value<std::string>()->default_value("ramp"),
                 "ramp | random — host init for A (TN/NN). FP8 NN logs use random+seed; FP8 TN logs use ramp.")

                ("a-init-seed", po::value<unsigned>()->default_value(2567u),
                 "Seed for a-init-mode=random (mt19937). Also passed to srand() for legacy runners.")
                ;
    // clang-format on

    return options;
}

int GetHardware(po::variables_map const& args)
{
    int deviceCount = 0;
    HIP_CHECK_EXC(hipGetDeviceCount(&deviceCount));

    int deviceIdx = args["device-idx"].as<int>();

    if(deviceIdx >= deviceCount)
        throw std::runtime_error("Invalid device index " + std::to_string(deviceIdx) + " ("
                                 + std::to_string(deviceCount) + " total found.)");

    HIP_CHECK_EXC(hipSetDevice(deviceIdx));
    return deviceIdx;
}

hipStream_t GetStream(po::variables_map const& args)
{
    if(true)
        return 0;

    hipStream_t stream;
    HIP_CHECK_EXC(hipStreamCreate(&stream));
    return stream;
}

void LoadCodeObjects(po::variables_map const& args, SolutionAdapter& adapter)
{
    auto const& filenames = args["code-object"].as<std::vector<std::string>>();

    if(filenames.empty())
    {
        throw std::runtime_error(
            "No code object files (--code-object / config ini). "
            "Use --config-file <path.ini> (same as asm-runner), not --runConfig.");
    }
    else
    {
        //only trigger exception when failed to load all code objects.
        bool       loaded   = false;
        hipError_t retError = hipSuccess;

        for(auto const& filename : filenames)
        {
            hipError_t ret;

            std::cout << "Loading " << filename << std::endl;
            ret = adapter.loadCodeObjectFile(filename);

            if(ret == hipSuccess)
                loaded = true;
            else
                retError = ret;
        }

        if(!loaded)
            HIP_CHECK_EXC(retError);
    }
}

template <typename T>
std::vector<T> split_nums(std::string const& value)
{
    std::vector<std::string> parts;
    boost::split(parts, value, boost::algorithm::is_any_of(",;"));

    std::vector<T> rv;
    rv.reserve(parts.size());

    for(auto const& part : parts)
        if(part != "")
            rv.push_back(boost::lexical_cast<T>(part));

    return rv;
}

template <typename T>
void parse_arg_nums(po::variables_map& args, std::string const& name)
{
    auto inValue = args[name].as<std::vector<std::string>>();

    std::vector<std::vector<T>> outValue;
    outValue.reserve(inValue.size());
    for(auto const& str : inValue)
        outValue.push_back(split_nums<T>(str));

    boost::any v(outValue);

    args.at(name).value() = v;
}

void parse_arg_ints(po::variables_map& args, std::string const& name)
{
    parse_arg_nums<size_t>(args, name);
}

void parse_arg_double(po::variables_map& args, std::string const& name)
{
    parse_arg_nums<double>(args, name);
}

po::variables_map parse_args(int argc, const char* argv[])
{
    auto options = all_options();

    po::variables_map args;
    po::store(po::parse_command_line(argc, argv, options), args);
    po::notify(args);

    if(args.count("help"))
    {
        std::cout << options << std::endl;
        exit(1);
    }

    if(args.count("config-file"))
    {
        auto configFiles = args["config-file"].as<std::vector<std::string>>();
        for(auto filename : configFiles)
        {
            std::cout << "loading config file " << filename << std::endl;
            std::ifstream file(filename.c_str());
            if(file.bad())
                throw std::runtime_error("Could not open " + filename);
            po::store(po::parse_config_file(file, options), args);
        }
    }

    parse_arg_ints(args, "workgroup-size");
    parse_arg_ints(args, "num-workgroups");

    return args;
}

AsmRunnerAndValidator* CreateTypedRunner(po::variables_map& args)
{
    // branch to different test cases
    std::string test_tag = args["test-tag"].as<std::string>();

    if(test_tag == "amax")
        return new AMAXRunner(args);
    else if(test_tag == "fastAmax")
        return new FastAMAXRunner(args);
    else if(test_tag == "gemm_amaxD")
        return new GemmAmaxDRunner(args);
    else if(test_tag == "gemm_runner")
        return new GemmRunner(args, false); // default TN
    else if(test_tag == "swizzleA_gemm")
        return new SwizzleAGemmRunner(args); // Only TN
    else if(test_tag == "swizzleA_gemm_rdna_tn")
        return new SwizzleAGemmRunnerRDNATN<_Float16>(args);
    else if(test_tag == "swizzleA_gemm_rdna_tn_f8")
        return new SwizzleAGemmRunnerRDNATN<hipblaslt_f8_fnuz>(args);
    else if(test_tag == "swizzleA_gemm_rdna_nn")
        return new SwizzleAGemmRunnerRDNANN<_Float16>(args);
    else if(test_tag == "swizzleA_gemm_rdna_nn_f8")
        return new SwizzleAGemmRunnerRDNANN<hipblaslt_f8_fnuz>(args);
    else if(test_tag == "swizzleB_gemm")
        return new SwizzleBGemmRunner(args); // Only TN
    else
    {
        std::cout << "haven't implemented the SetupKernelArgs for test-tag:" << test_tag
                  << std::endl;
        return nullptr;
    }
}

int main(int argc, const char* argv[])
{
    // rocprofv3 invokes:  runner -- --config-file foo.ini
    // Boost.Program_options treats `--` as "end of options", so --config-file is ignored unless we
    // drop that separator (same idea as getopt).
    std::vector<const char*> argv_eff;
    argv_eff.reserve(static_cast<size_t>(argc));
    argv_eff.push_back(argv[0]);
    for(int i = 1; i < argc; ++i)
    {
        if(i == 1 && std::strcmp(argv[i], "--") == 0)
            continue;
        argv_eff.push_back(argv[i]);
    }

    auto args = parse_args(static_cast<int>(argv_eff.size()), argv_eff.data());

    unsigned int seed = args["a-init-seed"].as<unsigned>();
    std::cout << std::endl
              << "a-init-seed=" << seed
              << " -> srand(" << seed << ") for rand()-based runners; TN/NN FP8 random A init uses this seed with "
                 "mt19937 (Tensile-style distribution, not rand())."
              << std::endl
              << std::endl;
    srand(static_cast<unsigned>(seed));

    auto        deviceID = GetHardware(args);
    hipStream_t stream   = GetStream(args);

    SolutionAdapter adapter(true);
    LoadCodeObjects(args, adapter);

    std::vector<size_t> wgs = args["workgroup-size"].as<std::vector<std::vector<size_t>>>().front();
    std::vector<size_t> numWGS
        = args["num-workgroups"].as<std::vector<std::vector<size_t>>>().front();

    KernelInvocation kernelInvoc;

    // launch param
    kernelInvoc.kernelName   = args["kernelname"].as<std::string>();
    kernelInvoc.blockDim     = dim3(wgs[0], wgs[1], wgs[2]); // size of a WK (threads)
    kernelInvoc.gridDim      = dim3(numWGS[0], numWGS[1], numWGS[2]); // num oF WG
    kernelInvoc.totalItemDim = dim3(wgs[0] * numWGS[0], wgs[1] * numWGS[1], wgs[2] * numWGS[2]);
    kernelInvoc.sharedMemBytes
        = args["ext-lds-bytes"].as<size_t>(); // should be zero for hand-written assembly

    auto runnerClass = CreateTypedRunner(args);
    if(!runnerClass)
    {
        return 1;
    }

    // kernal arguments
    runnerClass->SetupKernelArgs(kernelInvoc);

    // launch kernel
    runnerClass->LaunchKernel(adapter, kernelInvoc, stream);

    // validation
    if(runnerClass->Validation())
        std::cout << "validation succeeded!" << std::endl;
    else
        std::cout << "validation failed!" << std::endl;

    return 0;
}
