#pragma once

#ifdef _WIN32
#define MYLIB_EXPORT __declspec(dllexport)
#else
#define MYLIB_EXPORT
#endif // _WIN32


extern "C" MYLIB_EXPORT const char* mylib();