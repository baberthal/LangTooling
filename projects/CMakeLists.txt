include(SLTUtils)

if(EXISTS "${CMAKE_CURRENT_LIST_DIR}/llvm")
  set(SLT_LLVM_SRC_DIR "${CMAKE_CURRENT_LIST_DIR}/llvm")
endif(EXISTS "${CMAKE_CURRENT_LIST_DIR}/llvm")
message(STATUS "Checking ${CMAKE_CURRENT_LIST_DIR} for llvm")

precondition(SLT_LLVM_SRC_DIR)

include(BuildExternalLLVM)

# if(EXISTS "${CMAKE_CURRENT_LIST_DIR}/llvm")
#   set(SLT_SWIFT_SRC_DIR "${CMAKE_CURRENT_LIST_DIR}/llvm")
# endif(EXISTS "${CMAKE_CURRENT_LIST_DIR}/llvm")

# precondition(SLT_SWIFT_SRC_DIR)
