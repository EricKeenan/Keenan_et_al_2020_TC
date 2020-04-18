# Install script for directory: /projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/alpine3d" TYPE FILE FILES
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/Alpine3D.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/AlpineControl.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/AlpineMain.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/DataAssimilation.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/Glaciers.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/MPIControl.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/MainPage.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/MeteoObj.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/OMPControl.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/SnowpackInterface.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/SnowpackInterfaceWorker.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/TechSnowA3D.h"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xheadersx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/alpine3d/ebalance" TYPE FILE FILES
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/ebalance/EBStruct.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/ebalance/EnergyBalance.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/ebalance/RadiationField.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/ebalance/TerrainRadiation.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/ebalance/TerrainRadiationAlgorithm.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/ebalance/TerrainRadiationHelbig.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/ebalance/TerrainRadiationPETSc.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/ebalance/TerrainRadiationSimple.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/ebalance/VFSymetricMatrix.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/ebalance/ViewFactors.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/ebalance/ViewFactorsAlgorithm.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/ebalance/ViewFactorsCluster.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/ebalance/ViewFactorsHelbig.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/ebalance/ViewFactorsSectors.h"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xheadersx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/alpine3d/runoff" TYPE FILE FILES "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/runoff/Runoff.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xheadersx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/alpine3d/snowdrift" TYPE FILE FILES
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/snowdrift/Cell.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/snowdrift/SnowDrift.h"
    "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/snowdrift/checksum.h"
    )
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/alpine3d/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/projects/erke2265/src/AIS_snowpack/snowpack/Source/alpine3d/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
