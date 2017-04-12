# Copyright 2017 AeonGames, Rodrigo Hernandez
# Licensed under the terms of the Apache 2.0 License.

include(functions)

option(RUNTIME_BUILD_SPIRV_TOOLS "Build SPIRV-Tools.")

if(RUNTIME_BUILD_SPIRV_TOOLS)
    gitclonecommit("https://github.com/KhronosGroup/SPIRV-Tools.git" "SPIRV-Tools" "4f216402ba6467ddcf929866243995a31192817f")
	gitclonecommit("https://github.com/KhronosGroup/SPIRV-Headers.git" "SPIRV-Tools/external/SPIRV-Headers" "db5cf6176137003ca4c25df96f7c0649998c3499")
    add_subdirectory("${BUILD_DIRECTORY}/SPIRV-Tools")
endif()
