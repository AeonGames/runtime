# Copyright 2015 AeonGames, Rodrigo Hernandez
# Licensed under the terms of the Apache 2.0 License.

include(functions)

option(RUNTIME_BUILD_GLSLANG "Build the glslang GLSL verifier.")

if(RUNTIME_BUILD_GLSLANG)
	download("https://github.com/KhronosGroup/glslang/archive/3.0.tar.gz" "glslang-3.0.tar.gz")
	decompress("glslang-3.0.tar.gz" "glslang-3.0")
	message(STATUS "Pacthing glslang...")
	file(READ ${BUILD_DIRECTORY}/glslang-3.0/CMakeLists.txt GLSLANG_CMAKELISTS)
	string(REGEX REPLACE "(\\s*)[^#](set\\(CMAKE_GENERATOR_TOOLSET)" "\\1#\\2"
			GLSLANG_CMAKELISTS "${GLSLANG_CMAKELISTS}")
	string(REGEX REPLACE "(\\s*)[^#](set\\(CMAKE_INSTALL_PREFIX)" "\\1#\\2"
			GLSLANG_CMAKELISTS "${GLSLANG_CMAKELISTS}")
	file(WRITE ${BUILD_DIRECTORY}/glslang-3.0/CMakeLists.txt "${GLSLANG_CMAKELISTS}")
	
	file(READ ${BUILD_DIRECTORY}/glslang-3.0/glslang/CMakeLists.txt GLSLANG_CMAKELISTS)
	if(NOT GLSLANG_CMAKELISTS MATCHES "install\\(DIRECTORY Public")
		#string(CONCAT GLSLANG_CMAKELISTS "${GLSLANG_CMAKELISTS}" "\ninstall(DIRECTORY Public DESTINATION include/glslang)")
		#string(CONCAT GLSLANG_CMAKELISTS "${GLSLANG_CMAKELISTS}" "\ninstall(DIRECTORY Include DESTINATION include/glslang)")
		#string(CONCAT GLSLANG_CMAKELISTS "${GLSLANG_CMAKELISTS}" "\ninstall(DIRECTORY MachineIndependent DESTINATION include/glslang)")
		set(GLSLANG_CMAKELISTS "${GLSLANG_CMAKELISTS}\ninstall(DIRECTORY Public DESTINATION include/glslang)")
		set(GLSLANG_CMAKELISTS "${GLSLANG_CMAKELISTS}\ninstall(DIRECTORY Include DESTINATION include/glslang)")
		set(GLSLANG_CMAKELISTS "${GLSLANG_CMAKELISTS}\ninstall(DIRECTORY MachineIndependent DESTINATION include/glslang)")
		file(WRITE ${BUILD_DIRECTORY}/glslang-3.0/glslang/CMakeLists.txt "${GLSLANG_CMAKELISTS}")
	endif()
	
	file(READ ${BUILD_DIRECTORY}/glslang-3.0/glslang/OSDependent/Linux/CMakeLists.txt GLSLANG_LINUX_CMAKELISTS)
	if(NOT GLSLANG_LINUX_CMAKELISTS MATCHES "install\\(FILES osinclude.h")
		#string(CONCAT GLSLANG_LINUX_CMAKELISTS "${GLSLANG_LINUX_CMAKELISTS}" "\ninstall(FILES osinclude.h DESTINATION include/glslang)")
		set(GLSLANG_LINUX_CMAKELISTS "${GLSLANG_LINUX_CMAKELISTS}\ninstall(FILES osinclude.h DESTINATION include/glslang)")
		file(WRITE ${BUILD_DIRECTORY}/glslang-3.0/glslang/OSDependent/Linux/CMakeLists.txt "${GLSLANG_LINUX_CMAKELISTS}")
	endif()
	
	file(READ ${BUILD_DIRECTORY}/glslang-3.0/glslang/OSDependent/Windows/CMakeLists.txt GLSLANG_WINDOWS_CMAKELISTS)
	if(NOT GLSLANG_WINDOWS_CMAKELISTS MATCHES "install\\(FILES osinclude.h")
		#string(CONCAT GLSLANG_WINDOWS_CMAKELISTS "${GLSLANG_WINDOWS_CMAKELISTS}" "\ninstall(FILES osinclude.h DESTINATION include/glslang)")
		set(GLSLANG_WINDOWS_CMAKELISTS "${GLSLANG_WINDOWS_CMAKELISTS}\ninstall(FILES osinclude.h DESTINATION include/glslang)")
		file(WRITE ${BUILD_DIRECTORY}/glslang-3.0/glslang/OSDependent/Windows/CMakeLists.txt "${GLSLANG_WINDOWS_CMAKELISTS}")
	endif()
	
	file(READ ${BUILD_DIRECTORY}/glslang-3.0/SPIRV/CMakeLists.txt GLSLANG_SPIRV_CMAKELISTS)
	if(NOT GLSLANG_SPIRV_CMAKELISTS MATCHES "install\\(FILES")
		#string(CONCAT GLSLANG_SPIRV_CMAKELISTS "${GLSLANG_SPIRV_CMAKELISTS}" "\ninstall(FILES \${HEADERS} DESTINATION include/SPIRV)")
		set(GLSLANG_SPIRV_CMAKELISTS "${GLSLANG_SPIRV_CMAKELISTS}\ninstall(FILES \${HEADERS} DESTINATION include/SPIRV)")
		file(WRITE ${BUILD_DIRECTORY}/glslang-3.0/SPIRV/CMakeLists.txt "${GLSLANG_SPIRV_CMAKELISTS}")
	endif()
	
	message(STATUS "Done.")
	add_subdirectory("${BUILD_DIRECTORY}/glslang-3.0" "${CMAKE_BINARY_DIR}/glslang-3.0")
	install(FILES ${CMAKE_SOURCE_DIR}/cmake/FindGLSlang.cmake DESTINATION cmake)
endif()
