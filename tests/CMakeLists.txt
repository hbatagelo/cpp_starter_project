include(gtest.cmake)
fetch_gtest(
  ${PROJECT_SOURCE_DIR}/tests
  ${PROJECT_BINARY_DIR}/gtest
)

add_executable(${TEST_TARGET} tester.cpp mockrng.cpp)

# Include the gtest library. gtest_SOURCE_DIR is available due to
# 'project(gtest)' above.
target_include_directories(
  ${TEST_TARGET} PRIVATE
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${gtest_SOURCE_DIR}
  ${gtest_SOURCE_DIR}/include
  ${PROJECT_SOURCE_DIR}/include
)

target_compile_features(${TEST_TARGET} PRIVATE cxx_std_17)

# Standard linking to gtest stuff
target_link_libraries(${TEST_TARGET} PRIVATE gtest gtest_main gmock gmock_main)

# Extra linking for the project
target_link_libraries(${TEST_TARGET} PRIVATE ${PROJLIB_TARGET})
target_link_libraries(${TEST_TARGET} PRIVATE ${OPTIONS_TARGET})

add_test(NAME Tester COMMAND ${TEST_TARGET})