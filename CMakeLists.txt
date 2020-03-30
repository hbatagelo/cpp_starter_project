cmake_minimum_required(VERSION 3.10)
project(cpp_starter_project LANGUAGES CXX)

# Project targets
set(WARNINGS_TARGET warnings)
set(OPTIONS_TARGET options)
set(PROJ_TARGET intro)
set(PROJLIB_TARGET introlib)
set(TEST_TARGET tester)

option(BUILD_TESTING "Build the testing tree" ON)
option(ENABLE_COVERAGE "Enable coverage reporting" OFF)

# ccache, IPO and default configuration
include(cmake/StandardProjectSettings.cmake)

# Link this 'library' to set the c++ standard / compile-time options requested
add_library(${OPTIONS_TARGET} INTERFACE)
target_compile_features(${OPTIONS_TARGET} INTERFACE cxx_std_20)

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

# Very basic PCH example
option(ENABLE_PCH "Enable Precompiled Headers" OFF)
if(ENABLE_PCH)
  # This sets a global PCH parameter, each project will build its own PCH, which is a good idea if any #define's change
  target_precompile_headers(${OPTIONS_TARGET} INTERFACE <vector> <string> <map> <utility>)
endif()

# Set up some extra Conan dependencies based on our needs before loading Conan
set(CONAN_EXTRA_REQUIRES "")
set(CONAN_EXTRA_OPTIONS "")

# Google Tests
if(BUILD_TESTING)
  set(CONAN_EXTRA_REQUIRES ${CONAN_EXTRA_REQUIRES} gtest/[>=1.10.0])
endif()

# Dear ImGui
if(CPP_STARTER_USE_IMGUI)
  set(CONAN_EXTRA_REQUIRES ${CONAN_EXTRA_REQUIRES} imgui-sfml/2.1@bincrafters/stable)
  # set(CONAN_EXTRA_OPTIONS ${CONAN_EXTRA_OPTIONS} sfml:shared=False sfml:graphics=True sfml:audio=False
  # sfml:window=True libalsa:disable_python=True)
endif()

# SDL
if(CPP_STARTER_USE_SDL)
  set(CONAN_EXTRA_REQUIRES ${CONAN_EXTRA_REQUIRES} sdl2/2.0.12@bincrafters/stable)
  # set(CONAN_EXTRA_OPTIONS ${CONAN_EXTRA_OPTIONS} sdl2:wayland=True)
endif()

# Conan
include(cmake/Conan.cmake)
run_conan()

# Tests

# Only build tests if we are the top-level project Allows this to be used by super projects with `add_subdirectory`
if(BUILD_TESTING AND (PROJECT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR))
  enable_testing()
  add_subdirectory(tests)
  # Disable IPO for tests
  set_property(TARGET ${TEST_TARGET} PROPERTY INTERPROCEDURAL_OPTIMIZATION FALSE)
endif()

# Define project sources
add_subdirectory(src)
