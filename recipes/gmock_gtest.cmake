# Copyright 2015,2016 AeonGames, Rodrigo Hernandez
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

    file(READ ${BUILD_DIRECTORY}/gmock-1.7.0/CMakeLists.txt GMOCK_CMAKELISTS)
    if(NOT GMOCK_CMAKELISTS MATCHES "install\\(TARGETS gmock gmock_main")
        #string(CONCAT GMOCK_CMAKELISTS "${GMOCK_CMAKELISTS}" "\ninstall(TARGETS gmock gmock_main RUNTIME DESTINATION bin LIBRARY DESTINATION lib ARCHIVE DESTINATION lib)")
        set(GMOCK_CMAKELISTS "${GMOCK_CMAKELISTS}\ninstall(TARGETS gmock gmock_main RUNTIME DESTINATION bin LIBRARY DESTINATION lib ARCHIVE DESTINATION lib)")
        #string(CONCAT GMOCK_CMAKELISTS "${GMOCK_CMAKELISTS}" "\ninstall(DIRECTORY include/gmock DESTINATION include)")
        set(GMOCK_CMAKELISTS "${GMOCK_CMAKELISTS}\ninstall(DIRECTORY include/gmock DESTINATION include)")
        file(WRITE ${BUILD_DIRECTORY}/gmock-1.7.0/CMakeLists.txt "${GMOCK_CMAKELISTS}")
    endif()

    file(READ ${BUILD_DIRECTORY}/gmock-1.7.0/gtest/CMakeLists.txt GTEST_CMAKELISTS)
    if(NOT GTEST_CMAKELISTS MATCHES "install\\(TARGETS gtest gtest_main")
        #string(CONCAT GTEST_CMAKELISTS "${GTEST_CMAKELISTS}" "\ninstall(TARGETS gtest gtest_main RUNTIME DESTINATION bin LIBRARY DESTINATION lib ARCHIVE DESTINATION lib)")
        set(GTEST_CMAKELISTS "${GTEST_CMAKELISTS}\ninstall(TARGETS gtest gtest_main RUNTIME DESTINATION bin LIBRARY DESTINATION lib ARCHIVE DESTINATION lib)")
        #string(CONCAT GTEST_CMAKELISTS "${GTEST_CMAKELISTS}" "\ninstall(DIRECTORY include/gtest DESTINATION include)")
        set(GTEST_CMAKELISTS "${GTEST_CMAKELISTS}\ninstall(DIRECTORY include/gtest DESTINATION include)")
        file(WRITE ${BUILD_DIRECTORY}/gmock-1.7.0/gtest/CMakeLists.txt "${GTEST_CMAKELISTS}")
    endif()

    set(gtest_disable_pthreads ON CACHE BOOL "Do not require linking tests against pthreads" FORCE)
    add_subdirectory("${BUILD_DIRECTORY}/gmock-1.7.0")
endif()
