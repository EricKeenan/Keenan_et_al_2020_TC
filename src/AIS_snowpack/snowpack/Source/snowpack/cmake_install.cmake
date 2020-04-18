# Install script for directory: /projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/projects/erke2265/src/AIS_snowpack/usr")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "0")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xheadersx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/snowpack" TYPE FILE FILES
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/Constants.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/DataClasses.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/Hazard.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/Laws_sn.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/MainPage.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/Meteo.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/Saltation.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/SnowDrift.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/SnowpackConfig.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/Stability.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/StabilityAlgorithms.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/TechnicalSnow.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/Utils.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/libsnowpack.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/vanGenuchten.h"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xheadersx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/snowpack/plugins" TYPE FILE FILES
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/plugins/AsciiIO.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/plugins/CaaMLIO.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/plugins/ImisDBIO.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/plugins/SmetIO.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/plugins/SnowpackIO.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/plugins/SnowpackIOInterface.h"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xheadersx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/snowpack/snowpackCore" TYPE FILE FILES
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/snowpackCore/Aggregate.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/snowpackCore/Canopy.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/snowpackCore/Metamorphism.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/snowpackCore/PhaseChange.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/snowpackCore/ReSolver1d.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/snowpackCore/SalinityTransport.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/snowpackCore/SeaIce.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/snowpackCore/Snowpack.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/snowpackCore/Solver.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/snowpackCore/VapourTransport.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/snowpackCore/WaterTransport.h"
    )
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/snowpack/cmake_install.cmake")
  include("/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/applications/snowpack/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/projects/erke2265/src/AIS_snowpack/snowpack/Source/snowpack/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
