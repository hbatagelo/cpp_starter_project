# Enable sanitizers for target project_target
function(enable_sanitizers project_target)

  # Code coverage
  if(CMAKE_CXX_COMPILER_ID MATCHES "GNU" OR CMAKE_CXX_COMPILER_ID MATCHES
                                            ".*Clang")
    option(ENABLE_COVERAGE "Enable coverage reporting for gcc/clang" OFF)

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
    option(ENABLE_SANITIZER_ADDRESS "Enable address sanitizer" OFF)
    if(ENABLE_SANITIZER_ADDRESS)
      list(APPEND _SANITIZERS "address")
    endif()

    # Leak sanitizer
    option(ENABLE_SANITIZER_MEMORY "Enable leak sanitizer" OFF)
    if(ENABLE_SANITIZER_LEAK)
      list(APPEND _SANITIZERS "leak")
    endif()

    # UB sanitizer
    option(ENABLE_SANITIZER_UNDEFINED_BEHAVIOR
           "Enable undefined behavior sanitizer" OFF)
    if(ENABLE_SANITIZER_UNDEFINED_BEHAVIOR)
      list(APPEND _SANITIZERS "undefined")
    endif()

    # Thread sanitizer
    option(ENABLE_SANITIZER_THREAD "Enable thread sanitizer" OFF)
    if(ENABLE_SANITIZER_THREAD)
      if("address" IN_LIST SANITIZERS OR "leak" IN_LIST SANITIZERS)
        message(
          WARNING
            "Thread sanitizer does not work with Address and Leak sanitizer enabled"
        )
      else()
        list(APPEND _SANITIZERS "thread")
      endif()
    endif()

    # Memory sanitizer
    option(ENABLE_SANITIZER_MEMORY "Enable memory sanitizer" OFF)
    if(ENABLE_SANITIZER_MEMORY AND CMAKE_CXX_COMPILER_ID MATCHES ".*Clang")
      message(
        WARNING
          "Memory sanitizer requires all the code (including libc++) to be MSan-instrumented otherwise it reports false positives"
      )
      if("address" IN_LIST SANITIZERS
         OR "thread" IN_LIST SANITIZERS
         OR "leak" IN_LIST SANITIZERS)
        message(
          WARNING
            "Memory sanitizer does not work with Address, Thread and Leak sanitizer enabled"
        )
      else()
        list(APPEND SANITIZERS "memory")
      endif()
    endif()

    # Comma separated list of sanitizers
    list(JOIN _SANITIZERS "," LIST_OF_SANITIZERS)
  endif()

  # Set list of sanitizers if not empty
  if(LIST_OF_SANITIZERS)
    if(NOT "${LIST_OF_SANITIZERS}" STREQUAL "")
      message(STATUS "List of sanitizers: ${LIST_OF_SANITIZERS}")
      target_compile_options(${project_target}
                             INTERFACE -fsanitize=${LIST_OF_SANITIZERS})
      if(CMAKE_VERSION VERSION_GREATER_EQUAL 3.13)
        target_link_options(${project_target} INTERFACE
                            -fsanitize=${LIST_OF_SANITIZERS})
      else()
        target_link_libraries(${project_target}
                              INTERFACE -fsanitize=${LIST_OF_SANITIZERS})
      endif()
    endif()
  endif()

endfunction()
