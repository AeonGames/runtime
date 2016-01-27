# AeonGames Runtime
cmake based open source run-time enviroment

# Introduction
The AeonGames Runtime is a collection of CMake scripts that build an assortment of open source tools and libraries in order to be used as dependencies for other projects.
This is most useful on Windows as most Linux distributions already contain development libraries for most open source projects.

# Dependencies
Other than cmake, a compiler and maybe an IDE of your choise, Git must be installed in such a way that it can be detected by cmake.
Different packages have different dependencies, some are part of the build, for example libpng depends on zlib, and zlib is an optional dependency for protobuf. Glslang depends on bison for which it may be required to install the 32 bit version of cygwin and include the bison package gnuwin32 versions may be too old.

# Included Packages
- zlib 1.2.8
- libpng 1.6.18
- freetype 2.6
- glslang
- google mock/test
- xxd
- protobuf
- yaml-cpp

# F.A.Q.
- Why don't you include bison as part of the runtime?
  Bison is special in the sense that it has a self dependency, bison needs a previous version of bison to build itself, including the bison executable to build bison defeats the purpose of building it on the first place. Besides, building bison on MSVC is more complicated than it is worth at this time.
