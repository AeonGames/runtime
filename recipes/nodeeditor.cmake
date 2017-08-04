# Copyright 2017 AeonGames, Rodrigo Hernandez
# Licensed under the terms of the Apache 2.0 License.

include(functions)

option(RUNTIME_BUILD_NODEEDITOR "Build the Qt Node Editor Widget.")

if(RUNTIME_BUILD_NODEEDITOR)
    gitclonecommit("https://github.com/paceholder/nodeeditor.git" "nodeeditor" "b2aa9bc166c2b06d543049d74e6c70b696f97c42")
    set(BUILD_EXAMPLES OFF CACHE INTERNAL "Node Editor Examples DISABLED." FORCE)
    file(MD5 ${BUILD_DIRECTORY}/nodeeditor/CMakeLists.txt NODES_CMAKELISTS_MD5)
    if(NODES_CMAKELISTS_MD5 EQUAL 3e9380df394ed5a756df15879ec86e03)
        file(APPEND ${BUILD_DIRECTORY}/nodeeditor/CMakeLists.txt "\n"
            "install(TARGETS nodes\n"
            "RUNTIME DESTINATION bin\n"
            "LIBRARY DESTINATION bin\n"
            "ARCHIVE DESTINATION lib)\n"
            "install(DIRECTORY include/nodes DESTINATION include)\n")
    endif()
    add_subdirectory("${BUILD_DIRECTORY}/nodeeditor")
endif()
