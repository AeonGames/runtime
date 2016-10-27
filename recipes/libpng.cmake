# Copyright 2015 AeonGames, Rodrigo Hernandez
# Licensed under the terms of the Apache 2.0 License.

include(functions)

option(RUNTIME_BUILD_LIBPNG "Build the PNG image library")
if(RUNTIME_BUILD_LIBPNG)
    # Force ZLIB which is a non-optional libpng dependency
    if(NOT RUNTIME_BUILD_ZLIB)
        set(RUNTIME_BUILD_ZLIB ON)
        include(zlib)
    endif()
    download("http://download.sourceforge.net/libpng/libpng-1.6.24.tar.gz" "libpng-1.6.24.tar.gz")
    decompress("libpng-1.6.24.tar.gz" "libpng-1.6.24")
    set(PNG_TESTS OFF CACHE INTERNAL "PNG Tests DISABLED." FORCE)
    set(PNG_SHARED ON CACHE INTERNAL "Building PNG shared library." FORCE)
    set(PNG_STATIC ON CACHE INTERNAL "Building PNG static library." FORCE)
    set(SKIP_INSTALL_EXPORT ON)
	cmake_policy(PUSH)
	cmake_policy(SET CMP0026 OLD)	
    add_subdirectory("${BUILD_DIRECTORY}/libpng-1.6.24" "${CMAKE_BINARY_DIR}/libpng-1.6.24")
	cmake_policy(POP)
endif()
