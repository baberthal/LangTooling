function(add_ctags_target _output_file)
  find_program(CTAGS ctags)

  if(NOT CTAGS)
    message(FATAL_ERROR "Could not find ctags command")
  endif(NOT CTAGS)

  file(GLOB_RECURSE SRC_ALL *.[ch])

  add_custom_command(
    OUTPUT tags
    COMMAND ${CTAGS} -a ${SRC_ALL}
    DEPENDS ${SRC_ALL}
  )

  message(STATUS ${CTAGS_OUTPUT})

  add_custom_target(
    do_tags ALL
    DEPENDS tags
    COMMAND ${CMAKE_COMMAND} -E copy
    ${CMAKE_CURRENT_BINARY_DIR}/tags ${_output_file}
  )
endfunction(add_ctags_target)
