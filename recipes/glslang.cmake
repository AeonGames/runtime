# Copyright 2015-2017 AeonGames, Rodrigo Hernandez
# Licensed under the terms of the Apache 2.0 License.

include(functions)

option(RUNTIME_BUILD_GLSLANG "Build the glslang GLSL validator/compiler.")

if(RUNTIME_BUILD_GLSLANG)
    # Note: glslang seems to have started as a glsl validator,
    # but has since become a glsl to spir-v translator,
    # perhaps the only one right now, and sadly,
    # stable versions are not as frequent as you may wish for,
    # so we'll just grab the latest commit at the time of writting
    # and update as necesary until a stable version with
    # enough polished glsl to spir-v features is available.
    
    gitclonecommit("https://github.com/KhronosGroup/glslang.git" "glslang" "e2ff404f6bef09d630fc1cd7c09ac9a84a142bbf")
    add_subdirectory("${BUILD_DIRECTORY}/glslang")
    # Note: A previous iteration for this recipe contained some patching commands
    # to allow for library and header installation, if this is not yet implemented
    # upstream, look it up in the git history before reimplementing from scratch.
endif()
