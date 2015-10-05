# Copyright 2015 AeonGames, Rodrigo Hernandez
# Licensed under the terms of the Apache 2 License.

include(functions)

download("http://download.savannah.gnu.org/releases/freetype/freetype-2.6.tar.gz" "freetype-2.6.tar.gz")
decompress("freetype-2.6.tar.gz" "freetype-2.6")

add_subdirectory("${BUILD_DIRECTORY}/freetype-2.6" "${CMAKE_BINARY_DIR}/freetype-2.6")