cmake_minimum_required (VERSION 3.10)

project(cpp_starter_project LANGUAGES CXX)

set(SOURCE_DIR src)
set(EXECUTABLE intro)
set(TEST_EXECUTABLE tester)

add_executable(${EXECUTABLE} ${SOURCE_DIR}/main.cpp)

# Using GCC
if (CMAKE_CXX_COMPILER_ID MATCHES "GNU")
  option(CODE_COVERAGE "Enable coverage reporting for gcc" OFF)

  if (CODE_COVERAGE)
    target_compile_options(${EXECUTABLE} PRIVATE --coverage -O0 -g)
    target_link_libraries(${EXECUTABLE} PRIVATE --coverage)
  endif()
endif()

# Using Visual Studio
if (MSVC)
  target_compile_options(${EXECUTABLE} PRIVATE /W4)
else()
  target_compile_options(${EXECUTABLE} PRIVATE -Wall -Wextra -Wpedantic)
endif()

# Use C++17
target_compile_features(${EXECUTABLE} PRIVATE cxx_std_17)

# Post build
if (UNIX AND CODE_COVERAGE)
  add_custom_command(
    TARGET ${EXECUTABLE} POST_BUILD
    COMMAND ${CMAKE_CURRENT_BINARY_DIR}/${EXECUTABLE} > /dev/null  
    #COMMAND ${CMAKE_COMMAND} -E echo ${CMAKE_CURRENT_BINARY_DIR}
    #WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    COMMENT "Post build execution"    
  )
endif()

# Tests
option(BUILD_TESTING "Build the testing tree" ON)
if (BUILD_TESTING)
  enable_testing()
  add_executable(${TEST_EXECUTABLE} ${SOURCE_DIR}/tester.cpp)
  add_test(Tester ${TEST_EXECUTABLE})
endif()
