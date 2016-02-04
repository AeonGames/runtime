# Copyright 2015 AeonGames, Rodrigo Hernandez
# Licensed under the terms of the Apache 2.0 License.

include(functions)
option(RUNTIME_BUILD_LIBXML2 "Build LibXml2.")

if(RUNTIME_BUILD_LIBXML2)
    #LIBXML2 Version 2.9.2 has a broken MSVC build system (missing configure.in from the distro)
    set(XML2_VERSION 2.9.1)
    set(LIBXML_CONFIG_PARAMS "")
    download("ftp://xmlsoft.org/libxml2/libxml2-${XML2_VERSION}.tar.gz" "libxml2-${XML2_VERSION}.tar.gz")
    decompress("libxml2-${XML2_VERSION}.tar.gz" "libxml2-${XML2_VERSION}")
    # Patch Windows config file
    file(READ "${BUILD_DIRECTORY}/libxml2-${XML2_VERSION}/include/win32config.h" XML2_WIN32CONFIG)
    string(REPLACE "#define snprintf _snprintf" "#if _MSC_VER < 1900\n#define snprintf _snprintf\n#endif"
            XML2_WIN32CONFIG_PATCHED "${XML2_WIN32CONFIG}")
    file(WRITE "${BUILD_DIRECTORY}/libxml2-${XML2_VERSION}/include/win32config.h" ${XML2_WIN32CONFIG_PATCHED})
    set(LIBXML2_LIBRARIES "${CMAKE_BINARY_DIR}/libxml2/lib/libxml2.lib" CACHE FILEPATH "LibXml2 Library" FORCE)
    set(LIBXML2_INCLUDE_DIR "${CMAKE_BINARY_DIR}/libxml2/include/libxml2" CACHE PATH "LibXml2 include directory" FORCE)
    set(LIBXML2_XMLLINT_EXECUTABLE "${CMAKE_BINARY_DIR}/libxml2/bin/xmllint.exe" CACHE FILEPATH "LibXml2 include directory" FORCE)
    if(MSVC)
        string(REGEX REPLACE "/" "\\\\" WIN_BUILD_DIRECTORY ${BUILD_DIRECTORY})
        string(REGEX REPLACE "/" "\\\\" WIN_CMAKE_BINARY_DIR ${CMAKE_BINARY_DIR})
        message(STATUS "Configuring libxml2...")
        if(RUNTIME_BUILD_ZLIB)
            set(LIBXML_CONFIG_PARAMS
                zlib=yes
                "include=${WIN_BUILD_DIRECTORY}\\zlib-1.2.8\;${WIN_CMAKE_BINARY_DIR}\\zlib-1.2.8"
                "lib=${WIN_CMAKE_BINARY_DIR}\\bin\\Debug") # TODO: this shouldn't be hardcoded
        endif()
        add_custom_target(libxml2
            cscript configure.js debug=no iconv=no ${LIBXML_CONFIG_PARAMS} "prefix=${WIN_CMAKE_BINARY_DIR}\\libxml2"
            COMMAND nmake install
            BYPRODUCTS ${LIBXML2_LIBRARIES}
            WORKING_DIRECTORY "${BUILD_DIRECTORY}/libxml2-${XML2_VERSION}/win32" COMMENT "Building LibXml2" VERBATIM)
        install(DIRECTORY ${CMAKE_BINARY_DIR}/libxml2/bin/ DESTINATION bin PATTERN "*")
        install(DIRECTORY ${CMAKE_BINARY_DIR}/libxml2/lib/ DESTINATION lib PATTERN "*")
        install(DIRECTORY ${CMAKE_BINARY_DIR}/libxml2/include/ DESTINATION include PATTERN "*")
    endif(MSVC)
endif()
