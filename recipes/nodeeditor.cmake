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
            "install(FILES src/Connection.hpp  DESTINATION include/nodes RENAME Connection)\n"
            "install(FILES src/FlowScene.hpp  DESTINATION include/nodes RENAME FlowScene)\n"
            "install(FILES src/Node.hpp  DESTINATION include/nodes RENAME Node)\n"
            "install(FILES src/NodeGeometry.hpp  DESTINATION include/nodes RENAME NodeGeometry)\n"
            "install(FILES src/ConnectionStyle.hpp  DESTINATION include/nodes RENAME ConnectionStyle)\n"
            "install(FILES src/FlowView.hpp  DESTINATION include/nodes RENAME FlowView)\n"
            "install(FILES src/NodeData.hpp  DESTINATION include/nodes RENAME NodeData)\n"
            "install(FILES src/NodePainterDelegate.hpp  DESTINATION include/nodes RENAME NodePainterDelegate)\n"
            "install(FILES src/DataModelRegistry.hpp  DESTINATION include/nodes RENAME DataModelRegistry)\n"
            "install(FILES src/FlowViewStyle.hpp  DESTINATION include/nodes RENAME FlowViewStyle)\n"
            "install(FILES src/NodeDataModel.hpp  DESTINATION include/nodes RENAME NodeDataModel)\n"
            "install(FILES src/NodeStyle.hpp DESTINATION include/nodes RENAME NodeStyle)\n")
    endif()
    add_subdirectory("${BUILD_DIRECTORY}/nodeeditor")
endif()
