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

find_package(GTest CONFIG)

target_link_libraries(
  ${TEST_TARGET}
  PUBLIC GTest::gtest_main GTest::gmock GTest::gtest
  PRIVATE ${PROJLIB_TARGET} ${OPTIONS_TARGET})

# gtest_discover_tests(${TEST_TARGET})
