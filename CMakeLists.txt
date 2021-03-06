### CMakeLists automatically created with AutoVala
### Do not edit

project (autovala)
cmake_minimum_required (VERSION 2.6)
cmake_policy (VERSION 2.8)
list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
enable_testing ()
option(ICON_UPDATE "Update the icon cache after installing" ON)
option(BUILD_VALADOC "Build API documentation if Valadoc is available" OFF)
option(DEBUG "DEBUG" OFF)

set(HAVE_VALADOC OFF)
if(BUILD_VALADOC)
	find_package(Valadoc)
	if(VALADOC_FOUND)
		set(HAVE_VALADOC ON)
		include(Valadoc)
	else()
		message("Valadoc not found, will not build documentation")
	endif()
endif()

find_package(PkgConfig)

set(MODULES_TO_CHECK ${MODULES_TO_CHECK} cairo)
set(MODULES_TO_CHECK ${MODULES_TO_CHECK} gdk-3.0)
set(MODULES_TO_CHECK ${MODULES_TO_CHECK} gdk-pixbuf-2.0)
set(MODULES_TO_CHECK ${MODULES_TO_CHECK} gee-0.8)
set(MODULES_TO_CHECK ${MODULES_TO_CHECK} gio-2.0)
set(MODULES_TO_CHECK ${MODULES_TO_CHECK} glib-2.0)
set(MODULES_TO_CHECK ${MODULES_TO_CHECK} gobject-2.0)
set(MODULES_TO_CHECK ${MODULES_TO_CHECK} pango)
set(MODULES_TO_CHECK ${MODULES_TO_CHECK} pangocairo)

pkg_check_modules(DEPS REQUIRED ${MODULES_TO_CHECK})

find_program ( WHERE_PANDOC pandoc )
if ( NOT WHERE_PANDOC )
	MESSAGE(FATAL_ERROR "Error! PANDOC is not installed.")
endif()

add_subdirectory(doc)
add_subdirectory(po)
add_subdirectory(src/autovalaLib)
add_subdirectory(wiki)
add_subdirectory(data/cmake)
add_subdirectory(data/bash_completion)
add_subdirectory(src)
