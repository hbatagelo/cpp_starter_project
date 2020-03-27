cmake_minimum_required(VERSION 3.10)

set(WARNINGS_TARGET warnings)
set(OPTIONS_TARGET options)
set(PROJ_TARGET intro)
set(PROJLIB_TARGET introlib)
set(TEST_TARGET tester)

project(cpp_starter_project LANGUAGES CXX)

include(cmake/StandardProjectSettings.cmake)

# Link this 'library' to set the c++ standard / compile-time options requested
add_library(${OPTIONS_TARGET} INTERFACE)
target_compile_features(${OPTIONS_TARGET} INTERFACE cxx_std_17)

# Link this 'library' to use the warnings specified in CompilerWarnings.cmake
add_library(${WARNINGS_TARGET} INTERFACE)

# Standard compiler warnings
include(cmake/CompilerWarnings.cmake)
set_project_warnings(${WARNINGS_TARGET})

# Sanitizer options if supported by compiler
include(cmake/Sanitizers.cmake)
enable_sanitizers(${OPTIONS_TARGET})

# Doxygen
include(cmake/Doxygen.cmake)
enable_doxygen()

# Static analysis
include(cmake/StaticAnalyzers.cmake)

# Tests
option(BUILD_TESTING "Build the testing tree" ON)
#option(ENABLE_COVERAGE "Enable coverage reporting" OFF)

# Only build tests if we are the top-level project
# Allows this to be used by super projects with `add_subdirectory`
if(BUILD_TESTING AND (PROJECT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR))
  enable_testing()
  add_subdirectory(tests)
  # Disable IPO for tests
  set_property(TARGET ${TEST_TARGET} PROPERTY INTERPROCEDURAL_OPTIMIZATION FALSE)
endif()

# Define project sources
add_subdirectory(src)
