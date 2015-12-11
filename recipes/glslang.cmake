# Copyright 2015 AeonGames, Rodrigo Hernandez
# Licensed under the terms of the Apache 2.0 License.

include(functions)

option(RUNTIME_BUILD_GLSLANG "Build the glslang GLSL verifier.")

if(RUNTIME_BUILD_GLSLANG)
	download("https://github.com/KhronosGroup/glslang/archive/3.0.tar.gz" "glslang-3.0.tar.gz")
	decompress("glslang-3.0.tar.gz" "glslang-3.0")
	message(STATUS "Pacthing glslang...")
	file(READ ${BUILD_DIRECTORY}/glslang-3.0/CMakeLists.txt GLSLANG_CMAKELISTS)
	string(REGEX REPLACE "(\\s*)[^#](set\\(CMAKE_GENERATOR_TOOLSET)" "\\1#\\2"
			GLSLANG_CMAKELISTS "${GLSLANG_CMAKELISTS}")
	string(REGEX REPLACE "(\\s*)[^#](set\\(CMAKE_INSTALL_PREFIX)" "\\1#\\2"
			GLSLANG_CMAKELISTS "${GLSLANG_CMAKELISTS}")
	file(WRITE ${BUILD_DIRECTORY}/glslang-3.0/CMakeLists.txt "${GLSLANG_CMAKELISTS}")
	
	file(READ ${BUILD_DIRECTORY}/glslang-3.0/glslang/CMakeLists.txt GLSLANG_CMAKELISTS)
	if(NOT GLSLANG_CMAKELISTS MATCHES "install\\(DIRECTORY Public/ DESTINATION include/glslang FILES_MATCHING PATTERN \"ShaderLang.h\"\\)")
		string(CONCAT GLSLANG_CMAKELISTS "${GLSLANG_CMAKELISTS}" "install(DIRECTORY Public/ DESTINATION include/glslang FILES_MATCHING PATTERN \"ShaderLang.h\")")
		file(WRITE ${BUILD_DIRECTORY}/glslang-3.0/glslang/CMakeLists.txt "${GLSLANG_CMAKELISTS}")
	endif()
	message(STATUS "Done.")
	add_subdirectory("${BUILD_DIRECTORY}/glslang-3.0" "${CMAKE_BINARY_DIR}/glslang-3.0")
endif()
