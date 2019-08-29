cmake_minimum_required(VERSION 3.10)

project(cpp_starter_project LANGUAGES CXX)

set(SOURCE_DIR src)
set(PROJ_TARGET intro)

set(TEST_DIR tests)
set(TEST_TARGET tester)

add_executable(${PROJ_TARGET} ${SOURCE_DIR}/main.cpp)

# Using GCC
if (CMAKE_CXX_COMPILER_ID MATCHES "GNU")
  option(CODE_COVERAGE "Enable coverage reporting for gcc" OFF)

  if (CODE_COVERAGE)
    target_compile_options(${PROJ_TARGET} PRIVATE --coverage -O0 -g)
    target_link_libraries(${PROJ_TARGET} PRIVATE --coverage)
  endif()
endif()

# Using Visual Studio
if (MSVC)
  target_compile_options(${PROJ_TARGET} PRIVATE /MP /W4)
else()
  target_compile_options(${PROJ_TARGET} PRIVATE -Wall -Wextra -Wpedantic)
endif()

# Use C++17
target_compile_features(${PROJ_TARGET} PRIVATE cxx_std_17)

# Post build
if (CMAKE_CXX_COMPILER_ID MATCHES "GNU" AND CODE_COVERAGE)
  add_custom_command(
    TARGET ${PROJ_TARGET} POST_BUILD
    COMMAND ${CMAKE_CURRENT_BINARY_DIR}/${PROJ_TARGET} > /dev/null  
    #COMMAND ${CMAKE_COMMAND} -E echo ${CMAKE_CURRENT_BINARY_DIR}
    #WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    COMMENT "Post build execution"    
  )
endif()

# Tests
option(BUILD_TESTING "Build the testing tree" ON)
if (BUILD_TESTING)
  include(tests/gtest.cmake)
  fetch_gtest(
    ${PROJECT_SOURCE_DIR}/${TEST_DIR}
    ${PROJECT_BINARY_DIR}/gtest
  )

  enable_testing()
  add_executable(${TEST_TARGET} ${TEST_DIR}/tester.cpp)
  add_test(Tester ${TEST_TARGET})
endif()
