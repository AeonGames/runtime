# - Try to find GLSlang
# Once done this will define
#  GLSlang_FOUND - System has GLSlang
#  GLSlang_INCLUDE_DIRS - The GLSlang include directories
#  GLSlang_LIBRARIES - The libraries needed to use GLSlang
#  GLSlang_DEFINITIONS - Compiler switches required for using GLSlang

find_path(GLSlang_INCLUDE_DIR glslang/Public/ShaderLang.h
          PATH_SUFFIXES include)
find_library(GLSlang_LIBRARY NAMES glslang)
find_library(OSDependent_LIBRARY NAMES OSDependent)
find_library(OGLCompiler_LIBRARY NAMES OGLCompiler)
find_library(SPIRV_LIBRARY NAMES SPIRV)

set(GLSlang_LIBRARIES ${GLSlang_LIBRARY} ${OSDependent_LIBRARY} ${OGLCompiler_LIBRARY} ${SPIRV_LIBRARY})
set(GLSlang_INCLUDE_DIRS ${GLSlang_INCLUDE_DIR} )

include(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set GLSlang_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(GLSlang  DEFAULT_MSG
                                  GLSlang_LIBRARY GLSlang_INCLUDE_DIR)

mark_as_advanced(GLSlang_INCLUDE_DIR GLSlang_LIBRARY )
