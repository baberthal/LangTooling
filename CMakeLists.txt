cmake_minimum_required(VERSION 3.4.3)
project(SwiftLangTooling)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake/Modules)

include(MacroEnsureOutOfSourceBuild)
macro_ensure_out_of_source_build("do not build in the source tree")

include(SLTUtils)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Debug"
    CACHE STRING
    "Build type: choose one of Debug, Release, RelWithDebInfo"
    FORCE
  )
endif(NOT CMAKE_BUILD_TYPE)

# if(NOT SLT_SWIFT_SOURCE_DIR)
#   set(SLT_SWIFT_SOURCE_DIR "/opt/src/swift-src/swift")
# endif(NOT SLT_SWIFT_SOURCE_DIR)

# list(APPEND CMAKE_MODULE_PATH "${SLT_SWIFT_SOURCE_DIR}/cmake/Modules")

option(SLT_INCLUDE_TOOLS "Generate build targets for slt tools" ON)
option(SLT_INCLUDE_DOCS "Build the doxygen documentation" OFF)
option(SLT_INCLUDE_TESTS "Build the unit tests" OFF)
option(SLT_GENERATE_TAGS "Generate tags" ON)
option(SLT_ENABLE_PROFILE "Generate profiling information" OFF)
option(SLT_ENABLE_VALGRIND "Configure build for valgrind" OFF)

set(SWIFT_BUILT_STANDALONE TRUE CACHE BOOL "")
add_subdirectory(projects) # add our swift/llvm stuff

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(SLT_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
set(SLT_BINARY_DIR "${CMAKE_CURRENT_BINARY_DIR}")

set(SLT_RUNTIME_OUTPUT_INTDIR "${CMAKE_BINARY_DIR}/${CMAKE_CFG_INTDIR}/bin")
set(SLT_LIBRARY_OUTPUT_INTDIR "${CMAKE_BINARY_DIR}/${CMAKE_CFG_INTDIR}/lib")

set(CMAKE_INCLUDE_CURRENT_DIR ON)

include_directories(BEFORE
  ${CMAKE_CURRENT_BINARY_DIR}/include
  ${CMAKE_CURRENT_SOURCE_DIR}/include)

find_package(LibXml2)
if(LIBXML2_FOUND)
  set(SLT_HAVE_LIBXML 1)
endif()

if(SLT_GENERATE_TAGS)
  include(CTags)
  add_ctags_target(${CMAKE_CURRENT_LIST_DIR}/.git/tags)
endif(SLT_GENERATE_TAGS)

if (LLVM_ENABLE_DOXYGEN)
  message(STATUS "Doxygen: enabled")
endif()

if(SLT_INCLUDE_TOOLS)
  add_subdirectory(include)
  add_subdirectory(lib)
  add_subdirectory(tools)
endif()

add_subdirectory(utils)

if(SLT_INCLUDE_TESTS)
  add_subdirectory(test)
  add_subdirectory(unittests)
endif()
if(SLT_INCLUDE_DOCS)
  add_subdirectory(docs)
endif()
