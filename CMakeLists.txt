cmake_minimum_required (VERSION 3.10)

add_executable(intro src/main.cpp)

if (CMAKE_COMPILER_IS_GNUCC)
  option(ENABLE_COVERAGE "Enable coverage reporting for gcc/clang" ON)

  if (ENABLE_COVERAGE)
    target_compile_options(intro PRIVATE --coverage -O0)
    target_link_libraries(intro PRIVATE --coverage)
  endif()
endif()

if (MSVC)
  target_compile_options(intro PRIVATE /W4)
else()
  target_compile_options(intro PRIVATE -Wall -Wextra -Wpedantic)
endif()
  
target_compile_features(intro PRIVATE cxx_std_17)

enable_testing()
add_executable(tester src/tester.cpp)
target_link_libraries(tester PRIVATE --coverage)
add_test(Tester tester)
