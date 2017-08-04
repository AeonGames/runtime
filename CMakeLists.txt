cmake_minimum_required(VERSION 2.8)
if(COMMAND cmake_policy)
      cmake_policy(SET CMP0003 NEW)
endif(COMMAND cmake_policy)

if(POLICY CMP0054)
    cmake_policy(SET CMP0054 OLD)
endif()

project(runtime)

set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake ${CMAKE_SOURCE_DIR}/recipes)
set(HTTP_PROXY "" CACHE string "If you are behind a http proxy, set it here")
set(HTTPS_PROXY "" CACHE string "If you are behind a https proxy, set it here")
set(DOWNLOAD_DIRECTORY "${CMAKE_SOURCE_DIR}/packages" CACHE path "Source packages will be downloaded to this directory")
set(BUILD_DIRECTORY "${CMAKE_BINARY_DIR}/build" CACHE path "Source packages will be decompressed, repositories cloned to this directory")
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin)
set(LIBRARY_OUTPUT_PATH  ${CMAKE_BINARY_DIR}/bin)

if(NOT "${HTTP_PROXY}" STREQUAL "")
    set(ENV{http_proxy} "${HTTP_PROXY}")
endif()
if(NOT "${HTTPS_PROXY}" STREQUAL "")
    set(ENV{https_proxy} "${HTTPS_PROXY}")
endif()

find_package(Git)

if(WIN32)
    # On Windows try to use the mingw64 binaries of unix tools
    # provided by git before cygwin binaries.
    string(REPLACE "/cmd/git.exe" "" GIT_PATH ${GIT_EXECUTABLE})
    list(APPEND CMAKE_PREFIX_PATH "${GIT_PATH}/mingw64")    
    list(APPEND CMAKE_PREFIX_PATH "${GIT_PATH}/usr")
endif(WIN32)

list(APPEND CMAKE_PREFIX_PATH "${CMAKE_INSTALL_PREFIX}")

find_package(Cygwin)
if(CYGWIN_INSTALL_PATH)
    list(APPEND CMAKE_PREFIX_PATH "${CYGWIN_INSTALL_PATH}")
    set(ENV{CYGWIN} "nodosfilewarning")
endif(CYGWIN_INSTALL_PATH)

if(UNIX)
    # Use RPATH so generated binaries know where to look for their libraries
    list(APPEND CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}")
    list(APPEND CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/${CMAKE_LIBRARY_ARCHITECTURE}")
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
endif()

if(NOT IS_DIRECTORY "${BUILD_DIRECTORY}")
    file(MAKE_DIRECTORY ${BUILD_DIRECTORY})
endif(NOT IS_DIRECTORY "${BUILD_DIRECTORY}")
message(STATUS "${CMAKE_GENERATOR_TOOLSET}")

find_program (GREP_EXECUTABLE grep HINTS ENV ProgramFiles PATH_SUFFIXES Git/usr/bin)
configure_file("${CMAKE_SOURCE_DIR}/deploy.bat.in" "${CMAKE_SOURCE_DIR}/deploy.bat")

# Packages-----------------------------------------
include(gmock_gtest)
include(zlib)
include(libpng)
include(freetype)
include(libxml2)
include(xxd)
include(astyle)
include(glslang)
include(yaml-cpp)
include(protobuf)
include(pixman)
include(cairo)
include(spirv-tools)
include(nodeeditor)