# Copyright 2016 AeonGames, Rodrigo Hernandez
# Licensed under the terms of the Apache 2.0 License.

include(functions)

option(RUNTIME_BUILD_YAML_CPP "Build the yaml-cpp library.")

if(RUNTIME_BUILD_YAML_CPP)
	gitclone("https://github.com/Kwizatz/yaml-cpp.git" "yaml-cpp" FALSE)
	set(YAML_CPP_BUILD_TOOLS OFF)
	add_subdirectory("${BUILD_DIRECTORY}/yaml-cpp")
endif()
