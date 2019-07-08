cmake_minimum_required (VERSION 3.10)

add_executable(intro src/main.cpp)

if (MSVC)
  target_compile_options(intro PRIVATE /W4)
else()
  target_compile_options(intro PRIVATE -Wall -Wextra -Wpedantic)
endif()
  
target_compile_features(intro PRIVATE cxx_std_17)
