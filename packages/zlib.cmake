# Copyright 2015 AeonGames, Rodrigo Hernandez
# Licensed under the terms of the Apache 2.0 License.

include(functions)

option(RUNTIME_BUILD_ZLIB "Build the zlib compression library")

if(RUNTIME_BUILD_ZLIB)
	download("http://zlib.net/zlib-1.2.8.tar.gz" "zlib-1.2.8.tar.gz")
	decompress("zlib-1.2.8.tar.gz" "zlib-1.2.8")
	# Remove add_test(example example) from the zlib cmake lists file as it is not really a test at all
	file(READ ${BUILD_DIRECTORY}/zlib-1.2.8/CMakeLists.txt ZLIB_CMAKELISTS)
	string(REGEX REPLACE "([ \t]*)add_test" "\\1#add_test" 
			ZLIB_CMAKELISTS_PATCHED "${ZLIB_CMAKELISTS}")
	file(WRITE ${BUILD_DIRECTORY}/zlib-1.2.8/CMakeLists.txt "${ZLIB_CMAKELISTS_PATCHED}") 
	message(STATUS "Tests removed.")
	add_subdirectory(${BUILD_DIRECTORY}/zlib-1.2.8)
endif()
