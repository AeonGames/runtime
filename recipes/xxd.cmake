# Copyright 2015 AeonGames, Rodrigo Hernandez
# Licensed under the terms of the Apache 2.0 License.

include(functions)
option(RUNTIME_BUILD_XXD "Build xxd utility.")

if(RUNTIME_BUILD_XXD)
    download("http://grail.cba.csuohio.edu/~somos/xxd-1.10.tar.gz" "xxd-1.10.tar.gz")
    decompress("xxd-1.10.tar.gz" "xxd-1.10")
    message(STATUS "Patching XXD source...")
    file(READ ${BUILD_DIRECTORY}/xxd-1.10/xxd.c XXD_C)
    string(REGEX REPLACE "([^\\/])(extern long int strtol)" "\\1//\\2"
            XXD_C "${XXD_C}")
    string(REGEX REPLACE "([^\\/])(extern long int ftell)" "\\1//\\2"
            XXD_C "${XXD_C}")
    file(WRITE ${BUILD_DIRECTORY}/xxd-1.10/xxd.c "${XXD_C}")
    message(STATUS "Done.")
    add_executable(xxd ${BUILD_DIRECTORY}/xxd-1.10/xxd.c)
    install(TARGETS xxd RUNTIME DESTINATION bin)
endif()
