# Copyright 2016 AeonGames, Rodrigo Hernandez
# Licensed under the terms of the Apache 2 License.

include(functions)

option(RUNTIME_BUILD_CAIRO "Build the cairo library.")

if(RUNTIME_BUILD_CAIRO)
	find_program (SED_EXECUTABLE sed HINTS ENV ProgramFiles PATH_SUFFIXES Git/usr/bin)
    download("https://www.cairographics.org/releases/cairo-1.14.6.tar.xz" "cairo-1.14.6.tar.xz")
    decompress("cairo-1.14.6.tar.xz" "cairo-1.14.6")
    message(STATUS "Generating Cairo CMakeLists.txt.")
	execute_process(
		COMMAND
			${SED_EXECUTABLE} -e :a -e '/\\\\\\\\$/N\; s/\\\\\\\\\\\\n//\; ta' Makefile.sources
        OUTPUT_FILE CMakeLists.txt
		WORKING_DIRECTORY 
            ${BUILD_DIRECTORY}/cairo-1.14.6/src)
	execute_process(
		COMMAND
			${SED_EXECUTABLE} -i 's/[ \\t][ \\t]*/ /g' CMakeLists.txt
		WORKING_DIRECTORY 
            ${BUILD_DIRECTORY}/cairo-1.14.6/src)
endif()
