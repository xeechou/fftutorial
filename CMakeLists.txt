cmake_minimum_required(VERSION 3.1.0)

project(mysamples
  VERSION 0.1
  LANGUAGES C CXX)

if(WIN32)
  set(CMAKE_EXE_LINKER_FLAGS "-static")
else()
  set(CMAKE_CXX_FLAGS "-g")
endif()

set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

include(CPack)
find_package(Boost REQUIRED COMPONENTS system chrono date_time filesystem program_options)
find_package(PkgConfig)
#find_package(OpenCV 3.2 REQUIRED)
#find_package(DLIB REQUIRED)
#I don't know where you found the qt
#find_package(Qt5 REQUIRED COMPONENTS Core Widgets)
##find_package(Qt5Core REQUIRED)
#find_package(Qt5Widgets REQUIRED)
find_package(SDL2 REQUIRED)
find_package(FFmpeg REQUIRED COMPONENTS avformat avcodec avutil swscale)

set(CMAKE_AUTOMOC ON)

include_directories(${FFMPEG_INCLUDE_DIR})

set(LIB_THIRDPARTY
  ${SDL2_LIBRARIES}
  ${FFmpeg_LIBRARIES}
  )

if(WIN32)
  set(CMAKE_BINARY_DIR "${CMAKE_SOURCE_DIR}/build")
else()
  set(CMAKE_BINARY_DIR "${CMAKE_SOURCE_DIR}/build_linux")
endif()

include_directories(${SDL2_LIBRARIES})


add_executable(simple_player
  player.cpp)


target_link_libraries(simple_player
  ${LIB_THIRDPARTY}
  )
