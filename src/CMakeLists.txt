# Add targets
add_library(${PROJLIB_TARGET} coin-flipper.cpp foo.cpp ../include/coin-flipper.hpp ../include/foo.hpp)
add_executable(${PROJ_TARGET} main.cpp ../include/coin-flipper.hpp ../include/foo.hpp)

# Includes
target_include_directories(${PROJLIB_TARGET} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR} ${PROJECT_SOURCE_DIR}/include)
target_include_directories(${PROJ_TARGET} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR} ${PROJECT_SOURCE_DIR}/include)

# Linked libraries
target_link_libraries(${PROJ_TARGET} PRIVATE ${PROJLIB_TARGET} ${OPTIONS_TARGET} ${WARNINGS_TARGET})

# Use C++17 target_compile_features(${PROJLIB_TARGET} PRIVATE cxx_std_17) target_compile_features(${PROJ_TARGET} PRIVATE
# cxx_std_17)

# Extra arguments for MSVC
if(MSVC)
  target_compile_options(${PROJLIB_TARGET} PRIVATE /MP)
  target_compile_options(${PROJ_TARGET} PRIVATE /MP)
endif()

# Post build
if(ENABLE_COVERAGE)
  if(CMAKE_CXX_COMPILER_ID MATCHES "GNU" OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    add_custom_command(
      TARGET ${PROJ_TARGET}
      POST_BUILD
      # COMMAND ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${PROJ_TARGET} > /dev/null
      COMMAND ${CMAKE_CURRENT_BINARY_DIR}/${PROJ_TARGET} > /dev/null
      # COMMAND ${CMAKE_COMMAND} -E echo ${CMAKE_CURRENT_BINARY_DIR} WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
      COMMENT "Post build execution")
  endif()
endif()
