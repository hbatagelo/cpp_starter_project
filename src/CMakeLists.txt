# Add targets
add_library(${PROJLIB_TARGET} coin-flipper.cpp foo.cpp
                              ../include/coin-flipper.hpp ../include/foo.hpp)
add_executable(${PROJ_TARGET} main.cpp ../include/coin-flipper.hpp
                              ../include/foo.hpp)

# Includes
target_include_directories(${PROJLIB_TARGET}
                           PRIVATE ${PROJECT_SOURCE_DIR}/include)
target_include_directories(${PROJ_TARGET} PRIVATE ${PROJECT_SOURCE_DIR}/include)

# Linked libraries
target_link_libraries(${PROJLIB_TARGET} PRIVATE ${OPTIONS_TARGET}
                                                ${WARNINGS_TARGET})
target_link_libraries(
  ${PROJ_TARGET} PRIVATE ${PROJLIB_TARGET} ${OPTIONS_TARGET} ${WARNINGS_TARGET})

# Eigen
if(USE_EIGEN)
  target_include_directories(${PROJ_TARGET} PRIVATE ${CONAN_EIGEN_ROOT}/include)
  target_link_libraries(${PROJ_TARGET} PRIVATE CONAN_PKG::eigen)
endif()

# OpenCV
if(USE_OPENCV)
  find_package(OpenCV REQUIRED)
  target_include_directories(${PROJ_TARGET}
                             PRIVATE ${CONAN_OPENCV_ROOT}/include)
  target_link_libraries(${PROJ_TARGET} PRIVATE CONAN_PKG::opencv)
endif()

# Dear ImGui
if(USE_IMGUI)
  target_link_libraries(${PROJ_TARGET} PRIVATE CONAN_PKG::imgui-sfml)
endif()

# SDL
if(USE_SDL)
  find_package(SDL2 REQUIRED)
  target_link_libraries(${PROJ_TARGET} PRIVATE CONAN_PKG::sdl2)
endif()

# Extra arguments for MSVC
if(MSVC)
  target_compile_options(${PROJLIB_TARGET} PRIVATE /MP)
  target_compile_options(${PROJ_TARGET} PRIVATE /MP)
endif()

# Post build
if(ENABLE_COVERAGE MATCHES "TRUE")
  if(CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
    add_custom_command(
      TARGET ${PROJ_TARGET}
      POST_BUILD
      # ${CMAKE_CURRENT_BINARY_DIR} is project_name/build/src
      # ${CMAKE_CURRENT_SOURCE_DIR} is project_name/src
      # ${CMAKE_RUNTIME_OUTPUT_DIRECTORY} is project_name/build/bin
      COMMAND ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${PROJ_TARGET} > /dev/null
      COMMENT "Post build execution")
  endif()
endif()
