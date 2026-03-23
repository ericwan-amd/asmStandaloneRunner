################################################################################
#
# Copyright (C) 2022-2024 Advanced Micro Devices, Inc. All rights reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
################################################################################

cmake_minimum_required(VERSION 3.25.2)

project(AsmRunner)

find_package(Boost  COMPONENTS program_options filesystem REQUIRED)

# Optional: ROCTx markers for rocprofv3 --marker-trace / Perfetto (pre-shuffle range on TN runner)
if(DEFINED ENV{ROCM_PATH})
  list(APPEND CMAKE_PREFIX_PATH "$ENV{ROCM_PATH}/lib/cmake")
endif()
list(APPEND CMAKE_PREFIX_PATH "/opt/rocm/lib/cmake")
find_package(rocprofiler-sdk-roctx CONFIG QUIET)

if (CMAKE_BUILD_TYPE MATCHES "Debug" AND NOT WIN32)
    set (CMAKE_CXX_FLAGS_DEBUG "-O0 ${CMAKE_CXX_FLAGS_DEBUG} -ggdb" )
endif()

add_executable(runner src/standalone.cpp)
set_target_properties(runner
                      PROPERTIES
                      CXX_STANDARD 20
                      CXX_STANDARD_REQUIRED ON
                      CXX_EXTENSIONS OFF)
target_include_directories(runner PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/include")# "/opt/rocm/include")
target_link_libraries(runner PRIVATE ${Boost_LIBRARIES})
if(rocprofiler-sdk-roctx_FOUND)
  target_compile_definitions(runner PRIVATE ASM_WITH_ROCTX=1)
  target_link_libraries(runner PRIVATE rocprofiler-sdk-roctx::rocprofiler-sdk-roctx)
  message(STATUS "ROCTx enabled for profiling markers (SwizzleAGemmRunnerRDNATN)")
else()
  message(STATUS "rocprofiler-sdk-roctx not found — build without ROCTx (install ROCm rocprofiler-sdk or set ROCM_PATH)")
endif()
