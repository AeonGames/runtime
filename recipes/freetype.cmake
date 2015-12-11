# Copyright 2015 AeonGames, Rodrigo Hernandez
# Licensed under the terms of the Apache 2 License.

include(functions)

option(RUNTIME_BUILD_FREETYPE "Build the freetype true type font library.")

if(RUNTIME_BUILD_FREETYPE)
	download("http://download.savannah.gnu.org/releases/freetype/freetype-2.6.tar.gz" "freetype-2.6.tar.gz")
	decompress("freetype-2.6.tar.gz" "freetype-2.6")
	if(MSVC)
		add_definitions(-D_CRT_SECURE_NO_WARNINGS)
		if(BUILD_SHARED_LIBS)
			message(STATUS "Warning!!! the Freetype Shared Library for VS does not currently generate an export library.")
		endif()		
	endif()	
	add_subdirectory("${BUILD_DIRECTORY}/freetype-2.6" "${CMAKE_BINARY_DIR}/freetype-2.6")	
	# Set these variables in case a latter package has FT2 as a dependency.
	set(FREETYPE_INCLUDE_DIR_freetype2 "${CMAKE_SOURCE_DIR}/freetype-2.6/include" CACHE PATH "FreeType2 Include Directory" FORCE)
	set(FREETYPE_INCLUDE_DIR_ft2build  "${CMAKE_SOURCE_DIR}/freetype-2.6/include" CACHE PATH "ft2build Include Directory" FORCE)
	set(FREETYPE_INCLUDE_DIRS ${FREETYPE_INCLUDE_DIR_freetype2} ${FREETYPE_INCLUDE_DIR_ft2build} CACHE PATH "ft2build Include Directory" FORCE)
	set(FREETYPE_LIBRARY "freetype" CACHE INTERNAL "freetype library" FORCE)
	set(FREETYPE_LIBRARIES "freetype" CACHE INTERNAL "freetype library" FORCE)
endif()
