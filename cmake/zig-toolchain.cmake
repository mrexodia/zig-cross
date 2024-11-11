include_guard()

if(CMAKE_GENERATOR MATCHES "Visual Studio")
    message(FATAL_ERROR "Visual Studio generator not supported, use: cmake -G Ninja")
endif()

if(NOT ZIG_TARGET MATCHES "^([a-zZ-Z0-9_]+)-([a-zZ-Z0-9_]+)-([a-zZ-Z0-9_]+)$")
    message(FATAL_ERROR "Expected -DZIG_TARGET=<arch>-<os>-<abi>")
endif()

set(ZIG_ARCH ${CMAKE_MATCH_1})
set(ZIG_OS ${CMAKE_MATCH_2})
set(ZIG_ABI ${CMAKE_MATCH_3})

if(ZIG_OS STREQUAL "linux")
    set(CMAKE_SYSTEM_NAME "Linux")
elseif(ZIG_OS STREQUAL "windows")
    set(CMAKE_SYSTEM_NAME "Windows")
elseif(ZIG_OS STREQUAL "macos")
    set(CMAKE_SYSTEM_NAME "Darwin")
elseif(ZIG_OS STREQUAL "freestanding")
    set(CMAKE_SYSTEM_NAME "Generic")
elseif(ZIG_OS STREQUAL "uefi")
    set(CMAKE_SYSTEM_NAME "UEFI")
    # Fix compiler detection (lld-link: error: <root>: undefined symbol: EfiMain)
    set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
else()
    # NOTE: If this happens, add a new case with one of the following system names:
    # https://cmake.org/cmake/help/latest/variable/CMAKE_SYSTEM_NAME.html#system-names-known-to-cmake
    message(FATAL_ERROR "Unknown OS: ${ZIG_OS}")
endif()

set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR ${ZIG_ARCH})

set(CMAKE_C_COMPILER "zig" cc -target ${ZIG_TARGET})
set(CMAKE_CXX_COMPILER "zig" c++ -target ${ZIG_TARGET})

if(WIN32)
    set(SCRIPT_SUFFIX ".cmd")
else()
    set(SCRIPT_SUFFIX ".sh")
endif()

# This is working (thanks to Simon for finding this trick)
set(CMAKE_AR "${CMAKE_CURRENT_LIST_DIR}/zig-ar${SCRIPT_SUFFIX}")
set(CMAKE_RANLIB "${CMAKE_CURRENT_LIST_DIR}/zig-ranlib${SCRIPT_SUFFIX}")
set(CMAKE_RC_COMPILER "${CMAKE_CURRENT_LIST_DIR}/zig-rc${SCRIPT_SUFFIX}")

# Add custom UEFI platform to module path
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}")
