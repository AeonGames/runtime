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
	add_subdirectory("${BUILD_DIRECTORY}/zlib-1.2.8" "${CMAKE_BINARY_DIR}/zlib-1.2.8")
	set(ZLIB_FOUND ON CACHE INTERNAL "Link against the zlib we're already building" FORCE)
	set(ZLIB_INCLUDE_DIRS "${BUILD_DIRECTORY}/zlib-1.2.8" "${CMAKE_BINARY_DIR}/zlib-1.2.8" CACHE INTERNAL "Local zlib include directories" FORCE)
	set(ZLIB_INCLUDE_DIR ${ZLIB_INCLUDE_DIRS}  CACHE INTERNAL "Local zlib include directories" FORCE)
	get_property(ZLIB_LIBRARY_TEST TARGET zlib PROPERTY OUTPUT_NAME)
	set(ZLIB_LIBRARY zlib CACHE INTERNAL "Local zlib" FORCE)
    if(NOT TARGET ZLIB::ZLIB)
		add_library(ZLIB::ZLIB UNKNOWN IMPORTED)
		set_target_properties(ZLIB::ZLIB PROPERTIES
			IMPORTED_LOCATION_RELEASE "${CMAKE_BINARY_DIR}/bin/$(Configuration)/zlib.lib"
			IMPORTED_LOCATION_DEBUG "${CMAKE_BINARY_DIR}/bin/$(Configuration)/zlibd.lib"
			INTERFACE_INCLUDE_DIRECTORIES "${ZLIB_INCLUDE_DIRS}")
    endif()	
endif()
