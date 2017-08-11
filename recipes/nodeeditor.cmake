# Copyright 2017 AeonGames, Rodrigo Hernandez
# Licensed under the terms of the Apache 2.0 License.

include(functions)

option(RUNTIME_BUILD_NODEEDITOR "Build the Qt Node Editor Widget.")

if(RUNTIME_BUILD_NODEEDITOR)
    gitclonecommit("https://github.com/paceholder/nodeeditor.git" "nodeeditor" "b2aa9bc166c2b06d543049d74e6c70b696f97c42")
    set(BUILD_EXAMPLES OFF CACHE INTERNAL "Node Editor Examples DISABLED." FORCE)
    file(READ ${BUILD_DIRECTORY}/nodeeditor/CMakeLists.txt NODES_CMAKELISTS_TXT)
    if(NOT ${NODES_CMAKELISTS_TXT} MATCHES "install")
        message(STATUS "Patching node editor CMakeLists.txt")
        file(APPEND ${BUILD_DIRECTORY}/nodeeditor/CMakeLists.txt "\n"
            "install(TARGETS nodes\n"
            "RUNTIME DESTINATION bin\n"
            "LIBRARY DESTINATION bin\n"
            "ARCHIVE DESTINATION lib)\n"
            "install(DIRECTORY src/ DESTINATION include/nodes FILES_MATCHING PATTERN \"*.hpp\")\n")
    endif()
    add_subdirectory("${BUILD_DIRECTORY}/nodeeditor")
endif()
