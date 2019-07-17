cmake_minimum_required (VERSION 3.10)

add_executable(intro src/main.cpp)

# Using Clang or GCC
if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang" OR "${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
  option(CODE_COVERAGE "Enable coverage reporting for gcc/clang" OFF)

  if (CODE_COVERAGE)
    target_compile_options(intro PRIVATE --coverage -O0 -g)
    target_link_libraries(intro PRIVATE --coverage)
  endif()
endif()

# Using Visual Studio
if (MSVC)
  target_compile_options(intro PRIVATE /W4)
else()
  target_compile_options(intro PRIVATE -Wall -Wextra -Wpedantic)
endif()
  
target_compile_features(intro PRIVATE cxx_std_17)

# Tests
option(BUILD_TESTING "Build the testing tree" ON)
if (BUILD_TESTING)
  enable_testing()
  add_executable(tester src/tester.cpp)
  add_test(Tester tester)
endif()
