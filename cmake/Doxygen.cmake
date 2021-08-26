# Enables doxygen doc builds
function(enable_doxygen)

  option(ENABLE_DOXYGEN "Enable doxygen doc builds of source" OFF)

  if(ENABLE_DOXYGEN)
    set(_DOXYGEN_CALLER_GRAPH YES)
    set(_DOXYGEN_CALL_GRAPH YES)
    set(_DOXYGEN_EXTRACT_ALL YES)
    find_package(Doxygen REQUIRED dot)
    doxygen_add_docs(doxygen-docs ${PROJECT_SOURCE_DIR})
  endif()

endfunction()
