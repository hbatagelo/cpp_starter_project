# From: https://github.com/conan-io/cmake-conan

# Download Conan packages and extras specified in CONAN_EXTRA_REQUIRES
macro(run_conan)
  list(APPEND CMAKE_MODULE_PATH ${CMAKE_BINARY_DIR})
  list(APPEND CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR})

  # Download automatically, you can also just copy the conan.cmake file
  if(NOT EXISTS "${CMAKE_BINARY_DIR}/conan.cmake")
    message(
      STATUS
        "Downloading conan.cmake from https://github.com/conan-io/cmake-conan")
    file(
      DOWNLOAD
      "https://raw.githubusercontent.com/conan-io/cmake-conan/v0.16.1/conan.cmake"
      "${CMAKE_BINARY_DIR}/conan.cmake"
      EXPECTED_HASH
        SHA256=396e16d0f5eabdc6a14afddbcfff62a54a7ee75c6da23f32f7a31bc85db23484
      TLS_VERIFY ON)
  endif()

  include(${CMAKE_BINARY_DIR}/conan.cmake)

  # Bincrafters remote requires conan clients to have revisions enabled
  set(ENV{CONAN_REVISIONS_ENABLED} 1)

  # Add bincrafters remote repository
  conan_check()
  conan_add_remote(
    NAME bincrafters URL
    https://bincrafters.jfrog.io/artifactory/api/conan/public-conan)

  # Launch conan install
  conan_cmake_configure(
    REQUIRES
    ${CONAN_EXTRA_REQUIRES}
    catch2/2.13.6
    docopt.cpp/0.6.3
    fmt/7.1.3
    spdlog/1.8.5
    OPTIONS
    ${CONAN_EXTRA_OPTIONS}
    GENERATORS
    cmake_find_package_multi)

  # For multi configuration generators, like VS and XCode
  if("${CMAKE_CONFIGURATION_TYPES}" STREQUAL "")
    message(STATUS "Single configuration build!")
    set(LIST_OF_BUILD_TYPES ${CMAKE_BUILD_TYPE})
  else()
    message(STATUS "Multi-configuration build: '${CMAKE_CONFIGURATION_TYPES}'!")
    set(LIST_OF_BUILD_TYPES ${CMAKE_CONFIGURATION_TYPES})
  endif()

  foreach(TYPE ${LIST_OF_BUILD_TYPES})
    message(STATUS "Running Conan for build type '${TYPE}'")
    conan_cmake_autodetect(settings BUILD_TYPE ${TYPE})

    conan_cmake_install(
      PATH_OR_REFERENCE
      .
      BUILD
      missing
      ENV
      CC=${CMAKE_C_COMPILER}
      ENV
      CXX=${CMAKE_CXX_COMPILER}
      SETTINGS
      ${settings})
  endforeach()

  find_package(Catch2 CONFIG)
  find_package(docopt CONFIG)
  find_package(fmt CONFIG)
  find_package(spdlog CONFIG)
endmacro()
