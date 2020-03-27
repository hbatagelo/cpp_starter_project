add_library(${PROJLIB_TARGET}
  coin-flipper.cpp
  foo.cpp
  ../include/coin-flipper.hpp  
  ../include/foo.hpp
)

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

# Executable
add_executable(${PROJ_TARGET}
  main.cpp
  ../include/coin-flipper.hpp
  ../include/foo.hpp
)

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
target_link_libraries(${PROJ_TARGET} PRIVATE ${OPTIONS_TARGET})
target_link_libraries(${PROJ_TARGET} PRIVATE ${WARNINGS_TARGET})

# Post build
if(ENABLE_COVERAGE)
  if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU" OR CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    add_custom_command(
      TARGET ${PROJ_TARGET} POST_BUILD
      COMMAND ${CMAKE_CURRENT_BINARY_DIR}/${PROJ_TARGET} > /dev/null
      #COMMAND ${CMAKE_COMMAND} -E echo ${CMAKE_CURRENT_BINARY_DIR}
      #WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
      COMMENT "Post build execution"
    )
  endif()
endif()
