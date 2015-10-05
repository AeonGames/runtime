# Copyright 2015 AeonGames, Rodrigo Hernandez
# Licensed under the terms of the Apache 2 License.

include(functions)

option(RUNTIME_BUILD_FREETYPE "Build the freetype true type font library.")

if(RUNTIME_BUILD_FREETYPE)
	download("http://download.savannah.gnu.org/releases/freetype/freetype-2.6.tar.gz" "freetype-2.6.tar.gz")
	decompress("freetype-2.6.tar.gz" "freetype-2.6")
	if(BUILD_SHARED_LIBS AND MSVC)
		message(STATUS "Warning!!! the Freetype Shared Library for VS does not generate an export library.")
	endif()
	add_subdirectory("${BUILD_DIRECTORY}/freetype-2.6" "${CMAKE_BINARY_DIR}/freetype-2.6")	
	# Set these variables in case a latter package has FT2 as a dependency.
	set(FREETYPE_INCLUDE_DIR_freetype2 "${BUILD_DIRECTORY}/freetype-2.6/include" CACHE PATH "FreeType2 Include Directory")
	set(FREETYPE_INCLUDE_DIR_ft2build  "${BUILD_DIRECTORY}/freetype-2.6/include" CACHE PATH "ft2build Include Directory")
	set(FREETYPE_LIBRARIES "freetype" CACHE INTERNAL "freetype library")
endif()
