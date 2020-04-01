include(GoogleTest)
# include(gtest.cmake)

# fetch_gtest(${PROJECT_SOURCE_DIR}/tests ${PROJECT_BINARY_DIR}/gtest)

# Add targets
add_executable(${TEST_TARGET} tester.cpp mockrng.cpp)
add_test(NAME Tester COMMAND ${TEST_TARGET})

# Include the gtest library. gtest_SOURCE_DIR is available due to
# 'project(gtest)' above.

# target_include_directories(${TEST_TARGET} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}
# ${gtest_SOURCE_DIR} ${gtest_SOURCE_DIR}/include ${PROJECT_SOURCE_DIR}/include)
target_include_directories(
  ${TEST_TARGET}
  PRIVATE ${CMAKE_CURRENT_SOURCE_DIR} ${PROJECT_SOURCE_DIR}/include
          ${CONAN_GTEST_ROOT}/include)

# Use C++20
target_compile_features(${TEST_TARGET} PRIVATE cxx_std_20)

# Standard linking to gtest stuff

# target_link_libraries(${TEST_TARGET} PRIVATE gtest gtest_main gmock
# gmock_main)

target_link_libraries(
  ${TEST_TARGET}
  PUBLIC CONAN_PKG::gtest
  PRIVATE ${PROJLIB_TARGET} ${OPTIONS_TARGET})
