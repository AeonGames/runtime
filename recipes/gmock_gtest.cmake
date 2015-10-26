# Copyright 2015 AeonGames, Rodrigo Hernandez
# Licensed under the terms of the Apache 2.0 License.

include(functions)
option(RUNTIME_BUILD_GMOCK_GTEST "Build Google Mock and Test libraries.")

if(RUNTIME_BUILD_GMOCK_GTEST)

	download("https://googlemock.googlecode.com/files/gmock-1.7.0.zip" "gmock-1.7.0.zip")
	decompress("gmock-1.7.0.zip" "gmock-1.7.0")
	set(gtest_force_shared_crt ON CACHE BOOL "Forced value for gtest" FORCE)
	
	set(GTEST_INCLUDE_DIR "${BUILD_DIRECTORY}/gmock-1.7.0/gtest/include" CACHE PATH "GTest Include path" FORCE)
	set(GMOCK_LIBRARIES gmock)
	set(GMOCK_MAIN_LIBRARIES gmock_main)
	set(GMOCK_BOTH_LIBRARIES ${GMOCK_LIBRARIES} ${GMOCK_MAIN_LIBRARIES})
	set(GMOCK_LIBRARY gmock CACHE PATH "gmock Library" FORCE)
	set(GMOCK_INCLUDE_DIR "${BUILD_DIRECTORY}/gmock-1.7.0/include" CACHE PATH "gmock Include path" FORCE)
	set(GMOCK_MAIN_LIBRARY gmock_main CACHE PATH "gmock Main Function Library" FORCE)
	set(GMOCK_SUBDIRECTORY ${BUILD_DIRECTORY}/gmock-1.7.0 CACHE PATH "gmock Source Path" FORCE)
	add_subdirectory("${BUILD_DIRECTORY}/gmock-1.7.0")
endif()
