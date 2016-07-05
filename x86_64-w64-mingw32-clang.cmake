# This is a CMAKE_TOOLCHAIN_FILE to use it
# add -DCMAKE_TOOLCHAIN_FILE=<path to this file>
# to the initial cmake command line call or
# set CMAKE_TOOLCHAIN_FILE to the path of this file
# to the CMAKE GUI.

# the name of the target operating system
set(CMAKE_SYSTEM_NAME Windows)

# which compilers to use for C and C++
set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)
set(CMAKE_RC_COMPILER windres)
set(CMAKE_RANLIB "llvm-ranlib" CACHE INTERNAL "llvm-ranlib")
set(CMAKE_AR "llvm-ar" CACHE INTERNAL "llvm-ar")
set(CMAKE_LINKER "llvm-link" CACHE INTERNAL "llvm-link")
set(CMAKE_NM "llvm-nm" CACHE INTERNAL "llvm-nm")
set(CMAKE_OBJDUMP "llvm-objdump" CACHE INTERNAL "llvm-objdump")

