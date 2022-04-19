cmake_minimum_required(VERSION 3.10)
project(cpp_starter_project LANGUAGES CXX)

# Project targets
set(WARNINGS_TARGET warnings)
set(OPTIONS_TARGET options)
set(PROJ_TARGET intro)
set(PROJLIB_TARGET introlib)
set(TEST_TARGET tester)

option(BUILD_SHARED_LIBS "Enable compilation of shared libraries" OFF)
option(ENABLE_TESTING "Enable test builds" ON)

# ccache, IPO and default configuration
include(cmake/StandardProjectSettings.cmake)

# Link this 'library' to set the c++ standard / compile-time options requested
add_library(${OPTIONS_TARGET} INTERFACE)
target_compile_features(${OPTIONS_TARGET} INTERFACE cxx_std_20)

if(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang")
  option(ENABLE_BUILD_WITH_TIME_TRACE
         "Enable -ftime-trace to generate time tracing .json files on clang"
         OFF)
  if(ENABLE_BUILD_WITH_TIME_TRACE)
    target_compile_options(project_options INTERFACE -ftime-trace)
  endif()
endif()

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
  # This sets a global PCH parameter, each project will build its own PCH, which
  # is a good idea if any #define's change
  target_precompile_headers(${OPTIONS_TARGET} INTERFACE <vector> <string> <map>
                            <utility>)
endif()

# Set up some extra Conan dependencies based on our needs before loading Conan
set(CONAN_EXTRA_REQUIRES "")
set(CONAN_EXTRA_OPTIONS "")

# Google Tests
if(ENABLE_TESTING)
  set(CONAN_EXTRA_REQUIRES ${CONAN_EXTRA_REQUIRES} gtest/1.11.0)
endif()

# Eigen
option(USE_EIGEN "Use Eigen" ON)
if(USE_EIGEN)
  set(CONAN_EXTRA_REQUIRES ${CONAN_EXTRA_REQUIRES} eigen/3.4.0)
endif()

# OpenCV
option(USE_OPENCV "Use OpenCV" ON)
if(USE_OPENCV)
  set(CONAN_EXTRA_REQUIRES ${CONAN_EXTRA_REQUIRES} opencv/4.5.5)
  set(CONAN_EXTRA_REQUIRES ${CONAN_EXTRA_REQUIRES} zlib/1.2.12)
  set(CONAN_EXTRA_OPTIONS ${CONAN_EXTRA_OPTIONS} opencv:with_eigen=False)
  set(CONAN_EXTRA_OPTIONS ${CONAN_EXTRA_OPTIONS} opencv:with_webp=False)
  set(CONAN_EXTRA_OPTIONS ${CONAN_EXTRA_OPTIONS} opencv:with_quirc=False)
  set(CONAN_EXTRA_OPTIONS ${CONAN_EXTRA_OPTIONS} opencv:with_ffmpeg=False)
  # if(NOT MSVC) set(CONAN_EXTRA_OPTIONS ${CONAN_EXTRA_OPTIONS} opencv:gtk=3)
  # endif()
endif()

# Dear ImGui
option(USE_IMGUI "Use Dear ImGui" ON)
if(USE_IMGUI)
  set(CONAN_EXTRA_REQUIRES ${CONAN_EXTRA_REQUIRES}
                           imgui-sfml/2.5@bincrafters/stable)
  # set(CONAN_EXTRA_OPTIONS ${CONAN_EXTRA_OPTIONS} sfml:shared=False
  # sfml:graphics=True sfml:audio=False sfml:window=True
  # libalsa:disable_python=True)
endif()

# SDL
option(USE_SDL "Use SDL" OFF)
if(USE_SDL)
  set(CONAN_EXTRA_REQUIRES ${CONAN_EXTRA_REQUIRES} sdl2/2.0.20)

  # WSL
  if(${CMAKE_SYSTEM} MATCHES "(M|m)icrosoft")
    set(CONAN_EXTRA_OPTIONS ${CONAN_EXTRA_OPTIONS} sdl2:pulse=False)
  endif()
endif()

# Conan
option(ENABLE_CONAN "Use Conan for dependency management" ON)
if(ENABLE_CONAN)
  include(cmake/Conan.cmake)
  run_conan()
endif()

# Copy compile_commands.json to source directory
if(NOT DEFINED ENV{APPVEYOR})
  add_custom_target(
    copy-compile-commands ALL
    ${CMAKE_COMMAND} -E copy_if_different
    ${CMAKE_BINARY_DIR}/compile_commands.json ${CMAKE_SOURCE_DIR})
endif()

# Tests

# Only build tests if we are the top-level project Allows this to be used by
# super projects with `add_subdirectory`
if(ENABLE_TESTING AND (PROJECT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR))
  enable_testing()
  add_subdirectory(tests)
  # Disable IPO for tests
  set_property(TARGET ${TEST_TARGET} PROPERTY INTERPROCEDURAL_OPTIMIZATION OFF)
endif()

# Define project sources
add_subdirectory(src)
