# Copyright 2016 AeonGames, Rodrigo Hernandez
# Licensed under the terms of the Apache 2.0 License.

include(functions)
option(RUNTIME_BUILD_ASTYLE "Build Astyle code formatter.")

if(RUNTIME_BUILD_ASTYLE)
    decompress("astyle_2.05.1_linux.tar.gz" "astyle")
    add_executable(astyle 
		${BUILD_DIRECTORY}/astyle/src/astyle_main.cpp
		${BUILD_DIRECTORY}/astyle/src/ASBeautifier.cpp
		${BUILD_DIRECTORY}/astyle/src/ASFormatter.cpp
		${BUILD_DIRECTORY}/astyle/src/ASEnhancer.cpp
		${BUILD_DIRECTORY}/astyle/src/ASLocalizer.cpp
		${BUILD_DIRECTORY}/astyle/src/ASResource.cpp)
	if(CMAKE_COMPILER_IS_GNUCXX)
		set_target_properties(astyle PROPERTIES
        COMPILE_FLAGS "-W -Wall -fno-rtti -fno-exceptions"
        COMPILE_FLAGS_RELEASE "-DNDEBUG -O3"
        COMPILE_FLAGS_DEBUG "-g")
	endif()
    install(TARGETS astyle RUNTIME DESTINATION bin)
endif()
