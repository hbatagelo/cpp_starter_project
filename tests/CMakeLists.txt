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

# Code coverage configuration
if (CMAKE_CXX_COMPILER_ID MATCHES "GNU" AND CODE_COVERAGE)
  target_compile_options(
    ${TEST_TARGET} PRIVATE 
    --coverage # Coverage flags
    -O0        # No optimization
    -g         # Generate debug info
  )
  if(CMAKE_VERSION VERSION_GREATER_EQUAL 3.13)
    target_link_options(${TEST_TARGET} PRIVATE --coverage)
  else()
    target_link_libraries(${TEST_TARGET} PRIVATE --coverage)
  endif()
endif()

add_test(NAME Tester COMMAND ${TEST_TARGET})