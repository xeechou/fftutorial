# - Try to find ffmpeg libraries (libavcodec, libavformat and libavutil)
# Once done this will define
#
# FFMPEG_FOUND - system has ffmpeg or libav
# FFMPEG_INCLUDE_DIR - the ffmpeg include directory
# FFMPEG_LIBRARIES - Link these to use ffmpeg
# FFMPEG_LIBAVCODEC
# FFMPEG_LIBAVFORMAT
# FFMPEG_LIBAVUTIL
#
# Copyright (c) 2008 Andreas Schneider <mail@cynapses.org>
# Modified for other libraries by Lasse Kärkkäinen <tronic>
# Modified for Hedgewars by Stepik777
#
# Redistribution and use is allowed according to the terms of the New
# BSD license.
#

# use pkg-config to get the directories and then use these values
# in the FIND_PATH() and FIND_LIBRARY() calls

set(FFmpeg_INCLUDE_DIRS)
set(FFmpeg_LIBRARIES)

find_package(PkgConfig)
if(PKG_CONFIG_FOUND)
  message("Using pkg-config")
endif()

set(FFmpeg_FOUND on)
foreach(name ${FFmpeg_FIND_COMPONENTS})
  if (PKG_CONFIG_FOUND)
    pkg_check_modules(FFmpeg_${name} REQUIRED "lib${name}")
  else() #use the old method to do it
    find_path(FFmpeg_${name}_INCLUDEDIR
      NAMES "lib${name}/${name}.h"
      PATHS /usr/include/ /usr/local/include $ENV{MINGW_PREFIX}/include
      )
    find_library(FFmpeg_${name}_LIBRARIES
      NAMES ${name}
      PATHS /usr/lib /usr/local/lib $ENV{MINGW_PREFIX}/lib
      )
  endif()
  if(FFmpeg_${name}_INCLUDEDIR AND FFmpeg_${name}_LIBRARIES)
    list(APPEND FFmpeg_INCLUDE_DIRS "${FFmpeg_${name}_INCLUDEDIR}")
    list(APPEND FFmpeg_LIBRARIES "${FFmpeg_${name}_LIBRARIES}")
  else()
    set(FFmpeg_FOUND off)
  endif()
endforeach()

if (FFmpeg_FOUND)
  message(STATUS "Found FFMPEG or Libav: ${FFmpeg_LIBRARIES}, ${FFmpeg_INCLUDE_DIRS}")
else ()
  if (FFmpeg_FIND_REQUIRED)
    message(FATAL_ERROR "Could not find libavcodec or libavformat or libavutil")
  endif ()
endif ()
