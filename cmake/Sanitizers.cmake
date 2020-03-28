# Enable sanitizers for target project_target
function(enable_sanitizers project_target)

  # Code coverage
  if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU" OR CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    option(ENABLE_COVERAGE "Enable coverage reporting for gcc/clang" FALSE)
    if(ENABLE_COVERAGE)
      target_compile_options(${project_target} INTERFACE --coverage -O0 -g)
      if(CMAKE_VERSION VERSION_GREATER_EQUAL 3.13)
        target_link_options(${project_target} INTERFACE --coverage)
      else()
        target_link_libraries(${project_target} INTERFACE --coverage)
      endif()
    endif()

    # Start with an empty list of sanitizers
    set(_SANITIZERS "")

    # Address sanitizer
    option(ENABLE_SANITIZER_ADDRESS "Enable address sanitizer" FALSE)
    if(ENABLE_SANITIZER_ADDRESS)
      list(APPEND _SANITIZERS "address")
    endif()

    # Memory sanitizer
    option(ENABLE_SANITIZER_MEMORY "Enable memory sanitizer" FALSE)
    if(ENABLE_SANITIZER_MEMORY)
      list(APPEND _SANITIZERS "memory")
    endif()

    # UB sanitizer
    option(ENABLE_SANITIZER_UNDEFINED_BEHAVIOR "Enable undefined behavior sanitizer" FALSE)
    if(ENABLE_SANITIZER_UNDEFINED_BEHAVIOR)
      list(APPEND _SANITIZERS "undefined")
    endif()

    # Thread sanitizer
    option(ENABLE_SANITIZER_THREAD "Enable thread sanitizer" FALSE)
    if(ENABLE_SANITIZER_THREAD)
      list(APPEND _SANITIZERS "thread")
    endif()

    # Comma separated list of sanitizers
    list(JOIN _SANITIZERS "," LIST_OF_SANITIZERS)
  endif()

  # Set list of sanitizers if not empty
  if(LIST_OF_SANITIZERS)
    if(NOT "${LIST_OF_SANITIZERS}" STREQUAL "")
      target_compile_options(${project_target} INTERFACE -fsanitize=${LIST_OF_SANITIZERS})
      target_link_libraries(${project_target} INTERFACE -fsanitize=${LIST_OF_SANITIZERS})
    endif()
  endif()

endfunction()
