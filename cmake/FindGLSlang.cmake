# - Try to find GLSlang
# Once done this will define
#  GLSlang_FOUND - System has GLSlang
#  GLSlang_INCLUDE_DIRS - The GLSlang include directories
#  GLSlang_LIBRARIES - The libraries needed to use GLSlang
#  GLSlang_DEFINITIONS - Compiler switches required for using GLSlang

find_path(GLSlang_INCLUDE_DIR glslang/Public/ShaderLang.h
          PATH_SUFFIXES include)
find_library(GLSlang_LIBRARY NAMES glslang)

set(GLSlang_LIBRARIES ${GLSlang_LIBRARY} )
set(GLSlang_INCLUDE_DIRS ${GLSlang_INCLUDE_DIR} )

include(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set GLSlang_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(GLSlang  DEFAULT_MSG
                                  GLSlang_LIBRARY GLSlang_INCLUDE_DIR)

mark_as_advanced(GLSlang_INCLUDE_DIR GLSlang_LIBRARY )
