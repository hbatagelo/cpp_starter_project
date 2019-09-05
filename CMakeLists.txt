cmake_minimum_required(VERSION 3.10)

project(cpp_starter_project LANGUAGES CXX)

set(PROJ_TARGET intro)
set(PROJLIB_TARGET introlib)
set(TEST_TARGET tester)

# Define project sources
add_subdirectory(src)

# Tests
option(BUILD_TESTING "Build the testing tree" ON)
option(CODE_COVERAGE "Enable coverage reporting for gcc" OFF)

# Only build tests if we are the top-level project
# Allows this to be used by super projects with `add_subdirectory`
if (BUILD_TESTING AND (PROJECT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR))
  enable_testing()
  add_subdirectory(tests)
endif()