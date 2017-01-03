# Copyright 2015-2017 AeonGames, Rodrigo Hernandez
# Licensed under the terms of the Apache 2.0 License.

include(functions)
option(RUNTIME_BUILD_GMOCK_GTEST "Build Google Mock and Test libraries.")

if(RUNTIME_BUILD_GMOCK_GTEST)
    download("https://github.com/google/googletest/archive/release-1.8.0.zip" "googletest-1.8.0.zip")
    decompress("googletest-1.8.0.zip" "googletest-release-1.8.0")
    # Note: previous iterations of this file had some commands to disable a pthreads requirement
    # and some installation directory patching.
    set(BUILD_GTEST ON CACHE BOOL "Build GTest" FORCE)
    add_subdirectory("${BUILD_DIRECTORY}/googletest-release-1.8.0")
endif()
