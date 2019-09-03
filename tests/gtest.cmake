# Download and unpack Google Test at configure time
# Adapted after https://github.com/bast/gtest-demo
macro(fetch_gtest _download_module_path _download_root)
  set(GTEST_DOWNLOAD_ROOT ${_download_root})
  configure_file(
    ${_download_module_path}/gtest-download.cmake
    ${_download_root}/CMakeLists.txt
    @ONLY
  )
  unset(GTEST_DOWNLOAD_ROOT)

  execute_process(
    COMMAND "${CMAKE_COMMAND}" -G "${CMAKE_GENERATOR}" .
    WORKING_DIRECTORY ${_download_root}
  )
  execute_process(
    COMMAND "${CMAKE_COMMAND}" --build .
    WORKING_DIRECTORY ${_download_root}
  )

  # Prevent GoogleTest from overriding our compiler/linker options
  # when building with Visual Studio
  set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

  # adds the targets: gtest, gtest_main, gmock, gmock_main
  add_subdirectory(
    ${_download_root}/gtest-src
    ${_download_root}/gtest-build
  )
endmacro()
