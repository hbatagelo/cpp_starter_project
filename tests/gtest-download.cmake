# Adapted after https://crascit.com/2015/07/25/cmake-gtest/
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(gtest-download NONE)

include(ExternalProject)

ExternalProject_Add(gtest
  SOURCE_DIR "@GTEST_DOWNLOAD_ROOT@/gtest-src"
  BINARY_DIR "@GTEST_DOWNLOAD_ROOT@/gtest-build"
  GIT_REPOSITORY https://github.com/google/googletest.git
  GIT_TAG master
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ""
  TEST_COMMAND ""
)
