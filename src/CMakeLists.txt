add_library(${PROJLIB_TARGET} foo.cpp ../include/foo.hpp)

# Proj library
target_include_directories(
  ${PROJLIB_TARGET} PRIVATE
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${PROJECT_SOURCE_DIR}/include
)

if (MSVC)
  target_compile_options(${PROJLIB_TARGET} PRIVATE /MP /W4)
else()
  target_compile_options(${PROJLIB_TARGET} PRIVATE -Wall -Wextra -Wpedantic)
endif()

# Use C++17
target_compile_features(${PROJLIB_TARGET} PRIVATE cxx_std_17)

# Code coverage configuration
if (CMAKE_CXX_COMPILER_ID MATCHES "GNU" AND CODE_COVERAGE)
  target_compile_options(
    ${PROJLIB_TARGET} PRIVATE 
    --coverage # Coverage flags
    -O0        # No optimization
    -g         # Generate debug info
  )
  if(CMAKE_VERSION VERSION_GREATER_EQUAL 3.13)
    target_link_options(${PROJLIB_TARGET} INTERFACE --coverage)
  else()
    target_link_libraries(${PROJLIB_TARGET} INTERFACE --coverage)
  endif()
endif()

# Executable
add_executable(${PROJ_TARGET} main.cpp ../include/foo.hpp)

target_include_directories(
  ${PROJ_TARGET} PRIVATE
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${PROJECT_SOURCE_DIR}/include
)

if (MSVC)
  target_compile_options(${PROJ_TARGET} PRIVATE /MP /W4)
else()
  target_compile_options(${PROJ_TARGET} PRIVATE -Wall -Wextra -Wpedantic)
endif()

# Use C++17
target_compile_features(${PROJ_TARGET} PRIVATE cxx_std_17)

target_link_libraries(${PROJ_TARGET} PRIVATE ${PROJLIB_TARGET})

# Post build
#if (CMAKE_CXX_COMPILER_ID MATCHES "GNU" AND CODE_COVERAGE)
#  add_custom_command(
#    TARGET ${PROJ_TARGET} POST_BUILD
#    COMMAND ${CMAKE_CURRENT_BINARY_DIR}/${PROJ_TARGET} > /dev/null
#    #COMMAND ${CMAKE_COMMAND} -E echo ${CMAKE_CURRENT_BINARY_DIR}
#    #WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
#    COMMENT "Post build execution"    
#  )
#endif()
