# Copyright 2015-2016 AeonGames, Rodrigo Hernandez
# Licensed under the terms of the Apache 2.0 License.

include(functions)
include(EchoTargetProperties)

option(RUNTIME_BUILD_ZLIB "Build the zlib compression library")

if(RUNTIME_BUILD_ZLIB)
    download("http://zlib.net/zlib-1.2.8.tar.gz" "zlib-1.2.8.tar.gz")
    decompress("zlib-1.2.8.tar.gz" "zlib-1.2.8")
    # Remove add_test(example example) from the zlib cmake lists file as it is not really a test at all
    file(READ ${BUILD_DIRECTORY}/zlib-1.2.8/CMakeLists.txt ZLIB_CMAKELISTS)
    string(REGEX REPLACE "([ \t]*)add_test" "\\1#add_test"
            ZLIB_CMAKELISTS_PATCHED "${ZLIB_CMAKELISTS}")
    file(WRITE ${BUILD_DIRECTORY}/zlib-1.2.8/CMakeLists.txt "${ZLIB_CMAKELISTS_PATCHED}")
    set(ZLIB_INCLUDE_DIRS "${BUILD_DIRECTORY}/zlib-1.2.8" "${CMAKE_BINARY_DIR}/zlib-1.2.8" CACHE PATH "Local zlib include directories" FORCE)
    set(ZLIB_INCLUDE_DIR ${ZLIB_INCLUDE_DIRS} CACHE PATH "Local zlib include directories" FORCE)
    include_directories(${ZLIB_INCLUDE_DIRS})
    add_subdirectory("${BUILD_DIRECTORY}/zlib-1.2.8" "${CMAKE_BINARY_DIR}/zlib-1.2.8")
    set(ZLIB_FOUND ON CACHE INTERNAL "Link against the zlib we're already building" FORCE)
    get_property(ZLIB_LIBRARY_TEST TARGET zlib PROPERTY OUTPUT_NAME)
    set(ZLIB_LIBRARY zlib CACHE STRING "Local zlib" FORCE)
    if(NOT TARGET ZLIB::ZLIB)
        add_library(ZLIB::ZLIB UNKNOWN IMPORTED)
        if(MSVC)
            set_target_properties(ZLIB::ZLIB PROPERTIES
                IMPORTED_LOCATION_RELEASE "${CMAKE_BINARY_DIR}/bin/$(Configuration)/zlib.lib"
                IMPORTED_LOCATION_DEBUG "${CMAKE_BINARY_DIR}/bin/$(Configuration)/zlibd.lib"
                INTERFACE_INCLUDE_DIRECTORIES "${ZLIB_INCLUDE_DIRS}")
        else()
            if(CMAKE_VERSION VERSION_LESS 3.0.0.0)
                get_property(ZLIB_LOCATION TARGET zlib PROPERTY LOCATION)
                get_property(ZLIB_LOCATION_DEBUG TARGET zlib PROPERTY LOCATION_DEBUG)
                get_property(ZLIB_LOCATION_RELEASE TARGET zlib PROPERTY LOCATION_RELEASE)
                set_target_properties(ZLIB::ZLIB PROPERTIES
                    IMPORTED_LOCATION "${ZLIB_LOCATION}"
                    IMPORTED_LOCATION_RELEASE "${ZLIB_LOCATION_RELEASE}"
                    IMPORTED_LOCATION_DEBUG "${ZLIB_LOCATION_DEBUG}"
                    INTERFACE_INCLUDE_DIRECTORIES "${ZLIB_INCLUDE_DIRS}")
			else()
				message(STATUS "Location: $<TARGET_PROPERTY:ZLIB::ZLIB,LOCATION>")
                set_target_properties(ZLIB::ZLIB PROPERTIES
                    IMPORTED_LOCATION "$<TARGET_PROPERTY:ZLIB::ZLIB,LOCATION>"
                    IMPORTED_LOCATION_RELEASE "$<TARGET_PROPERTY:LOCATION_RELEASE>"
                    IMPORTED_LOCATION_DEBUG "$<TARGET_PROPERTY:LOCATION_DEBUG>"
                    INTERFACE_INCLUDE_DIRECTORIES "${ZLIB_INCLUDE_DIRS}")
            endif()
        endif()
    endif()
endif()
