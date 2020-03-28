# Download Conan packages and extras specified in CONAN_EXTRA_REQUIRES
macro(run_conan)
  # Download automatically, you can also just copy the conan.cmake file
  if(NOT EXISTS "${CMAKE_BINARY_DIR}/conan.cmake")
    message(STATUS "Downloading conan.cmake from https://github.com/conan-io/cmake-conan")
    file(DOWNLOAD "https://github.com/conan-io/cmake-conan/raw/v0.15/conan.cmake" "${CMAKE_BINARY_DIR}/conan.cmake")
  endif()
  include(${CMAKE_BINARY_DIR}/conan.cmake)

  # Add bincrafters remote repository
  conan_check()
  conan_add_remote(NAME bincrafters URL https://api.bintray.com/conan/bincrafters/public-conan)

  # Launch conan install
  conan_cmake_run(
    REQUIRES
    ${CONAN_EXTRA_REQUIRES}
    catch2/2.11.0
    docopt.cpp/0.6.2
    fmt/6.0.0
    spdlog/1.5.0
    OPTIONS
    ${CONAN_EXTRA_OPTIONS}
    BASIC_SETUP
    CMAKE_TARGETS # individual targets to link to
    BUILD
    missing)
endmacro()
