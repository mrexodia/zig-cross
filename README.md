# zig--cross

Wrapper to make it easy to use [Zig](https://ziglang.org) as a cross compiler with [CMake](https://cmake.org).

## Building

```
cmake -B build
cmake --build build
```

Modify `cmake.toml` to change the build settings. For more information: https://cmkr.build.

## Installation

You can rename the `zig--cross` executable to `zig--<command>` and put it in your PATH:

```
zig--ar.exe
zig--dlltool.exe
zig--lib.exe
zig--ranlib.exe

zig--c++.exe
zig--cc.exe
```

**Note**: You also need `zig` in your PATH for this to work.

## Example (aarch64-linux-gnu)

First create `cmake/zig-aarch64-toolchain.cmake` in your project folder with the following contents:

```cmake
if(CMAKE_GENERATOR MATCHES "Visual Studio")
    message(FATAL_ERROR "Visual Studio generator not supported, use: cmake -G Ninja")
endif()
set(CMAKE_SYSTEM_NAME "Linux")
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR "aarch64")
set(CMAKE_C_COMPILER "zig" cc -target aarch64-linux-gnu)
set(CMAKE_CXX_COMPILER "zig" c++ -target aarch64-linux-gnu)
set(CMAKE_AR "zig--ar")
set(CMAKE_RANLIB "zig--ranlib")
```

Then configure and build your project:

```sh
cmake -B build-aarch64 -G Ninja -DCMAKE_TOOLCHAIN_FILE=cmake/zig-aarch64-toolchain.cmake
cmake --build build-aarch64
```