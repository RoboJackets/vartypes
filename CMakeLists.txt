project(vartypes)
cmake_minimum_required(VERSION 2.8.9)

include_directories(${src_dir}/vartypes)
include_directories(${src_dir}/vartypes/primitives)
include_directories(${src_dir}/vartypes/enhanced)
include_directories(${src_dir}/vartypes/gui)
include_directories(${src_dir}/vartypes/xml)

set(src_dir .)


# Qt 5
# TODO: remove this and include a FindQt5.cmake module
if(APPLE)
  set(CMAKE_PREFIX_PATH "/usr/local/Cellar/qt5/5.2.1/lib/cmake/Qt5Widgets")
endif()

set(CMAKE_AUTOMOC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
find_package(Qt5Widgets REQUIRED)


set(SRCS
  ${src_dir}/vartypes/VarBase64.cpp
  ${src_dir}/vartypes/VarNotifier.cpp
  ${src_dir}/vartypes/VarTypes.cpp
  ${src_dir}/vartypes/VarXML.cpp
  ${src_dir}/vartypes/VarTypesInstance.cpp
  ${src_dir}/vartypes/VarTypesFactory.cpp
  ${src_dir}/vartypes/xml/xmlParser.cpp

  ${src_dir}/vartypes/primitives/VarStringVal.cpp
  ${src_dir}/vartypes/primitives/VarBoolVal.cpp
  ${src_dir}/vartypes/primitives/VarVal.cpp
  ${src_dir}/vartypes/primitives/VarIntVal.cpp
  ${src_dir}/vartypes/primitives/VarDoubleVal.cpp

  ${src_dir}/vartypes/primitives/VarType.cpp
  ${src_dir}/vartypes/primitives/VarBlob.cpp
  ${src_dir}/vartypes/primitives/VarBool.cpp
  ${src_dir}/vartypes/primitives/VarDouble.cpp
  ${src_dir}/vartypes/primitives/VarExternal.cpp
  ${src_dir}/vartypes/primitives/VarInt.cpp
  ${src_dir}/vartypes/primitives/VarList.cpp
  ${src_dir}/vartypes/primitives/VarQWidget.cpp
  ${src_dir}/vartypes/primitives/VarSelection.cpp
  ${src_dir}/vartypes/primitives/VarString.cpp
  ${src_dir}/vartypes/primitives/VarStringEnum.cpp
  ${src_dir}/vartypes/primitives/VarTrigger.cpp

  ${src_dir}/vartypes/gui/VarItem.cpp
  ${src_dir}/vartypes/gui/VarItemDelegate.cpp
  ${src_dir}/vartypes/gui/VarTreeModel.cpp
  ${src_dir}/vartypes/gui/VarTreeView.cpp
  ${src_dir}/vartypes/gui/VarTreeViewOptions.cpp

  ${src_dir}/vartypes/primitives/VarProtoBufferVal.cpp
  ${src_dir}/vartypes/primitives/VarProtoBuffer.cpp

)

include_directories(${src_dir}/vartypes)
include_directories(${src_dir}/vartypes/primitives)
include_directories(${src_dir}/vartypes/gui)
include_directories(${src_dir}/vartypes/xml)


#only ones that need to be moc'ed
set (HEADERS
  ${src_dir}/vartypes/primitives/VarType.h
  ${src_dir}/vartypes/primitives/VarBlob.h
  ${src_dir}/vartypes/primitives/VarBool.h
  ${src_dir}/vartypes/primitives/VarDouble.h
  ${src_dir}/vartypes/primitives/VarExternal.h
  ${src_dir}/vartypes/primitives/VarInt.h
  ${src_dir}/vartypes/primitives/VarList.h
  ${src_dir}/vartypes/primitives/VarQWidget.h
  ${src_dir}/vartypes/primitives/VarSelection.h
  ${src_dir}/vartypes/primitives/VarString.h
  ${src_dir}/vartypes/primitives/VarStringEnum.h
  ${src_dir}/vartypes/primitives/VarTrigger.h
  ${src_dir}/vartypes/gui/VarItem.h
  ${src_dir}/vartypes/gui/VarItemDelegate.h
  ${src_dir}/vartypes/gui/VarTreeModel.h
  ${src_dir}/vartypes/gui/VarTreeView.h
  ${src_dir}/vartypes/VarNotifier.h
)

set (INSTALLABLE_HEADERS
  ${HEADERS}
  ${src_dir}/vartypes/DllDefines.h
  ${src_dir}/vartypes/VarTypes.h
  ${src_dir}/vartypes/VarTypesFactory.h
  ${src_dir}/vartypes/gui/VarTreeViewOptions.h
  ${src_dir}/vartypes/xml/xmlParser.h
  ${src_dir}/vartypes/primitives/VarVal.h
  ${src_dir}/vartypes/primitives/VarStringVal.h
  ${src_dir}/vartypes/primitives/VarIntVal.h
  ${src_dir}/vartypes/primitives/VarDoubleVal.h
  ${src_dir}/vartypes/primitives/VarBoolVal.h
  ${src_dir}/vartypes/VarXML.h
  ${src_dir}/vartypes/VarTypesInstance.h
  ${src_dir}/vartypes/VarBase64.h
  ${src_dir}/vartypes/primitives/VarProtoBufferVal.h
  ${src_dir}/vartypes/primitives/VarProtoBuffer.h
)

set (INSTALLABLE_DOCFILES
  ${src_dir}/README
  ${src_dir}/COPYING
)

set (INSTALLABLE_EXAMPLE
  ${src_dir}/README
  ${src_dir}/COPYING
)


set (RC
  ${src_dir}/vartypes/gui/icons/icons.qrc
)


if(NOT MSVC)
  #flags to set in debug mode
  set (CMAKE_CXX_FLAGS_DEBUG "-g")

  #flags to set in release mode
  #set (CMAKE_CXX_FLAGS_RELEASE "-DNDEBUG -O3 -march=native")
  set (CMAKE_CXX_FLAGS_RELEASE "-DNDEBUG -O3")
endif()


set(CMAKE_DEBUG_POSTFIX d)
set(CMAKE_INSTALL_LIBDIR lib CACHE PATH "Output directory for libraries")
set(CMAKE_INSTALL_INCLUDEDIR include CACHE PATH "Output directory for header files")
set(CMAKE_INSTALL_DOCDIR share/doc CACHE PATH "Output directory for documentation and license files")

set (target vartypes)
add_library(${target} SHARED ${HEADERS} ${SRCS} ${RC_SRCS})
set_target_properties(${target} PROPERTIES VERSION 0.7.0 SOVERSION 1)
target_link_libraries(${target} ${libs})
qt5_use_modules(${target} Widgets)

install(FILES ${INSTALLABLE_HEADERS} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/vartypes)

install(FILES ${INSTALLABLE_DOCFILES} DESTINATION ${CMAKE_INSTALL_DOCDIR}/vartypes)

install(TARGETS ${target}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION bin
)

file(COPY README COPYING DESTINATION ${CMAKE_BINARY_DIR})
file(RENAME ${CMAKE_BINARY_DIR}/README ${CMAKE_BINARY_DIR}/README.txt)
file(RENAME ${CMAKE_BINARY_DIR}/COPYING ${CMAKE_BINARY_DIR}/COPYING.txt)

# Generate packages
if(UNIX)
  execute_process(COMMAND uname -p OUTPUT_VARIABLE ARCH)
  string(STRIP ${ARCH} ARCH)
  if(APPLE)
    set(ARCH "osx-universal")
  endif()
endif()
set(CPACK_PACKAGE_CONTACT "Jan Segre <jan@segre.in>")
set(CPACK_PACKAGE_NAME "vartypes")
# Note that we're not the author of the package
# but merley packagers who may do some patches
set(CPACK_PACKAGE_VENDOR "RoboIME")
string(TOLOWER ${CPACK_PACKAGE_VENDOR} FLAVOR)
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_BINARY_DIR}/COPYING.txt")
set(CPACK_RESOURCE_FILE_README "${CMAKE_BINARY_DIR}/README.txt")
set(CPACK_PACKAGE_VERSION "0.7.0")
set(CPACK_OUTPUT_FILE_PREFIX ${PROJECT_SOURCE_DIR}/dist)
# Debian specific
# #TODO: find out what components of qt are required, list them here:
# set(CPACK_DEBIAN_PACKAGE_DEPENDS "libqt4-core")
set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}_${CPACK_PACKAGE_VERSION}-${FLAVOR}_${ARCH}")
include(CPack)


