# zig-cross

Example of using [zig](https://ziglang.org) as a CMake Toolchain for cross compiling.

Reference: https://zig.news/kristoff/cross-compile-a-c-c-project-with-zig-3599

## Building

- [Install zig](https://ziglang.org/learn/getting-started/#installing-zig) in your PATH (`choco install zig` on Windows)
- `cmake -B build-aarch64 -G Ninja -DCMAKE_TOOLCHAIN_FILE=cmake/zig-toolchain-aarch64.cmake`
- `cmake --build build-arch64`

You can create toolchains for other triples like this. Here is an example to build for Windows on ARM64:

```cmake
set(ZIG_TARGET "aarch64-windows-gnu")
include(${CMAKE_CURRENT_LIST_DIR}/zig-toolchain.cmake)
```
