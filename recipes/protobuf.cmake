# Copyright 2016 AeonGames, Rodrigo Hernandez
# Licensed under the terms of the Apache 2.0 License.

include(functions)

option(RUNTIME_BUILD_PROTOBUF "Build the google proto buffers library.")

if(RUNTIME_BUILD_PROTOBUF)
	gitclone("https://github.com/google/protobuf.git" "protobuf")
	set(protobuf_BUILD_TESTS OFF CACHE BOOL "We have our own gtest instance." FORCE)
	if(RUNTIME_BUILD_ZLIB)
		set(protobuf_WITH_ZLIB ON CACHE INTERNAL "Link against the zlib we're already building" FORCE)
	endif()
	add_subdirectory("${BUILD_DIRECTORY}/protobuf/cmake")
endif()
