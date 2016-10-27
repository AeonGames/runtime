# Copyright 2016 AeonGames, Rodrigo Hernandez
# Licensed under the terms of the Apache 2 License.

include(functions)

option(RUNTIME_BUILD_PIXMAN "Build the pixman library.")

if(RUNTIME_BUILD_PIXMAN)
	find_program (SED_EXECUTABLE sed HINTS ENV ProgramFiles PATH_SUFFIXES Git/usr/bin)
    download("https://www.cairographics.org/releases/pixman-0.34.0.tar.gz" "pixman-0.34.0.tar.gz")
    decompress("pixman-0.34.0.tar.gz" "pixman-0.34.0")
    message(STATUS "Generating pixman source list.")
    #file(READ ${BUILD_DIRECTORY}/pixman-0.34.0/Makefile.win32.common MAKEFILEWIN32COMMON)
    #file(READ ${BUILD_DIRECTORY}/pixman-0.34.0/pixman/Makefile.win32 MAKEFILEWIN32)
    file(READ ${BUILD_DIRECTORY}/pixman-0.34.0/pixman/Makefile.sources PIXMAN_SOURCES)
	# Remove $(NULL)
    string(REPLACE "$(NULL)" ""
            PIXMAN_SOURCES "${PIXMAN_SOURCES}")
	# Remove Lines containing the "=" character
    string(REGEX REPLACE "[^ \t]*[ \t]*=[ \t]*[^ \t]*" ""
            PIXMAN_SOURCES "${PIXMAN_SOURCES}")
	# Remove trailing slash
    string(REGEX REPLACE "[ \t]*\\\\" ""
            PIXMAN_SOURCES "${PIXMAN_SOURCES}")
	# Add path
    string(REGEX REPLACE "[ \t\n]*([^ \t\n]*)\n" "${BUILD_DIRECTORY}/pixman-0.34.0/pixman/\\1;"
            PIXMAN_SOURCES "${PIXMAN_SOURCES}")
    message(STATUS "Done.")
	add_library(pixman-static STATIC ${PIXMAN_SOURCES})
	set_target_properties(pixman-static 
		PROPERTIES 
			COMPILE_FLAGS
				"-wd4267 -wd4146 -wd4244 -D_CRT_SECURE_NO_WARNINGS -DPACKAGE=pixman-1 -DPACKAGE_VERSION= -DPACKAGE_BUGREPORT= -I${BUILD_DIRECTORY}/pixman-0.34.0 -I${BUILD_DIRECTORY}/pixman-0.34.0/pixman")
	add_custom_command(OUTPUT pixman.def
		COMMAND
			dumpbin -LINKERMEMBER $<TARGET_FILE:pixman-static> > pixman.def
		COMMAND
			${SED_EXECUTABLE} -i '/pixman/!d' pixman.def
		DEPENDS pixman-static)

	add_library(pixman SHARED ${PIXMAN_SOURCES} pixman.def)
	set_target_properties(pixman 
		PROPERTIES 
			COMPILE_FLAGS
				"-wd4267 -wd4146 -wd4244 -D_CRT_SECURE_NO_WARNINGS -DPACKAGE=pixman-1 -DPACKAGE_VERSION= -DPACKAGE_BUGREPORT= -I${BUILD_DIRECTORY}/pixman-0.34.0 -I${BUILD_DIRECTORY}/pixman-0.34.0/pixman")

	install(TARGETS pixman-static pixman
		ARCHIVE DESTINATION lib
        LIBRARY DESTINATION lib
        RUNTIME DESTINATION bin)
endif()
