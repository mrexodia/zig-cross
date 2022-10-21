cmake_minimum_required(VERSION 3.22)

project(cmake-zig)

add_library(mylib-static STATIC src/mylib.cpp)
add_library(mylib-shared SHARED src/mylib.cpp)

add_executable(myexe src/myexe.cpp)
target_link_libraries(myexe PRIVATE mylib-static)