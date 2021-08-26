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
  find_package(Eigen3 CONFIG)
  target_include_directories(${PROJ_TARGET} PRIVATE ${CONAN_EIGEN_ROOT}/include)
  target_link_libraries(${PROJ_TARGET} PRIVATE Eigen3::Eigen)
endif()

# OpenCV
if(USE_OPENCV)
  find_package(OpenCV CONFIG REQUIRED)
  target_include_directories(${PROJ_TARGET}
                             PRIVATE ${CONAN_OPENCV_ROOT}/include)
  target_link_libraries(${PROJ_TARGET} PRIVATE opencv::core)
  # opencv::flann opencv::imgproc opencv::ml opencv::opencv_ml opencv::photo
  # opencv::opencv_photo opencv::features2d opencv::imgcodecs opencv::videoio
  # opencv::calib3d opencv::highgui opencv::opencv_highgui
  # opencv::opencv_videoio opencv::opencv_imgcodecs opencv::objdetect
  # opencv::opencv_objdetect opencv::stitching opencv::opencv_stitching
  # opencv::video opencv::opencv_video opencv::opencv_calib3d
  # opencv::opencv_features2d opencv::opencv_flann opencv::dnn
  # opencv::opencv_dnn opencv::opencv_imgproc opencv::opencv_core
endif()

# Dear ImGui
if(USE_IMGUI)
  find_package(ImGui-SFML CONFIG)
  target_link_libraries(${PROJ_TARGET} PRIVATE ImGui-SFML::ImGui-SFML)
endif()

# SDL
if(USE_SDL)
  find_package(SDL2 CONFIG REQUIRED)
  target_link_libraries(${PROJ_TARGET} PRIVATE CONAN_PKG::sdl2)
endif()

# Extra arguments for MSVC
if(MSVC)
  target_compile_options(${PROJLIB_TARGET} PRIVATE /MP)
  target_compile_options(${PROJ_TARGET} PRIVATE /MP)
endif()

# Post build
if(ENABLE_COVERAGE MATCHES "ON")
  if(CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
    add_custom_command(
      TARGET ${PROJ_TARGET}
      POST_BUILD
      # ${CMAKE_CURRENT_BINARY_DIR} is project_name/build/src
      # ${CMAKE_CURRENT_SOURCE_DIR} is project_name/src
      # ${CMAKE_RUNTIME_OUTPUT_DIRECTORY} is project_name/build/bin
      COMMAND ${CMAKE_CURRENT_BINARY_DIR}/${PROJ_TARGET} > /dev/null
      COMMENT "Post build execution")
  endif()
endif()
