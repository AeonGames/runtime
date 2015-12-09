# Copyright 2015 AeonGames, Rodrigo Hernandez
# Licensed under the terms of the Apache 2.0 License.

include(functions)

option(RUNTIME_BUILD_GLSLANG "Build the glslang GLSL verifier.")

if(RUNTIME_BUILD_ZLIB)
	download("https://github.com/KhronosGroup/glslang/archive/3.0.tar.gz" "glslang-3.0.tar.gz")
	decompress("glslang-3.0.tar.gz" "glslang-3.0")
	add_subdirectory("${BUILD_DIRECTORY}/glslang-3.0" "${CMAKE_BINARY_DIR}/glslang-3.0")
endif()
