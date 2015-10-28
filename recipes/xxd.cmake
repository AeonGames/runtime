# Copyright 2015 AeonGames, Rodrigo Hernandez
# Licensed under the terms of the Apache 2.0 License.

include(functions)
option(RUNTIME_BUILD_XXD "Build xxd utility.")

if(RUNTIME_BUILD_XXD)
	download("http://grail.cba.csuohio.edu/~somos/xxd-1.10.tar.gz" "xxd-1.10.tar.gz")
	decompress("xxd-1.10.tar.gz" "xxd-1.10")
	add_executable(xxd ${BUILD_DIRECTORY}/xxd-1.10/xxd.c)
	install(TARGETS xxd RUNTIME DESTINATION bin)	
endif()
