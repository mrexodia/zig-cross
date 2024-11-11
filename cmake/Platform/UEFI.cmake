# References:
# - https://gitlab.kitware.com/cmake/cmake/-/merge_requests/6630
# - https://gitlab.kitware.com/cmake/cmake/-/issues/16538
# - https://kubasejdak.com/how-to-cross-compile-for-embedded-with-cmake-like-a-champ

include(Platform/Generic)

set(CMAKE_EXECUTABLE_SUFFIX ".efi")
set(CMAKE_SHARED_LIBRARY_SUFFIX ".efi")
set(CMAKE_SHARED_LIBRARY_PREFIX "")

# UEFI APIs might expect 16-bit wchar_t
add_compile_options(-fshort-wchar)
