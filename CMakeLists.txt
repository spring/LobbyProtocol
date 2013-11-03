project(ProtocolDescription)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(UtilGit)
find_package(Git REQUIRED)

Set(D16 "[0-9a-f]") # matches a (lower-case) hexadecimal digit

# Matches the a dev version postfix (".1-<#commits>-g<SHA1> <branch>")
Set(VERSION_REGEX "-([0-9]+)-g(${D16}${D16}${D16}${D16}${D16}${D16}${D16})")

Git_Util_Describe(VERSION "${CMAKE_CURRENT_SOURCE_DIR}" "*")
if("${VERSION}" MATCHES "${VERSION_REGEX}")
	message(STATUS "Develop version ${VERSION}")
	set(RELEASE FALSE)
else()
	message(STATUS "Release version ${VERSION}")
	set(RELEASE TRUE)
endif()

find_program( XSLTPROC xsltproc )
cmake_minimum_required(VERSION 2.8)
message( STATUS "${XSLTPROC}" )
if( NOT EXISTS ${XSLTPROC} )
	message(FATAL_ERROR "xsltproc not found, can't continue!")
endif()

add_custom_command(
	OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/ProtocolDescription.html
	COMMAND ${XSLTPROC} ${CMAKE_CURRENT_SOURCE_DIR}/ProtocolDescription_xml2html.xsl
	${CMAKE_CURRENT_SOURCE_DIR}/ProtocolDescription.xml  > ${CMAKE_CURRENT_BINARY_DIR}/ProtocolDescription.html
	DEPENDS ProtocolDescription.xml ProtocolDescription_xml2html.xsl
)
add_custom_command(
	OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/index.html
	COMMAND ${XSLTPROC} ${CMAKE_CURRENT_SOURCE_DIR}/index.xsl
	${CMAKE_CURRENT_SOURCE_DIR}/ProtocolDescription.xml  > ${CMAKE_CURRENT_BINARY_DIR}/index.html
	DEPENDS ProtocolDescription.xml index.xsl
)
add_custom_target(docs ALL
	DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/index.html ${CMAKE_CURRENT_BINARY_DIR}/ProtocolDescription.html
)

if(RELEASE)
	set(OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/releases/${VERSION}")
	add_custom_command(TARGET docs POST_BUILD
		COMMAND ${CMAKE_COMMAND} -E make_directory ${OUTPUT}
		COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/ProtocolDescription.html ${OUTPUT}/ProtocolDescription.html
		COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/index.html ${OUTPUT}/index.html
		COMMENT "created ${VERSION} release folder"
		)
	add_dependencies(docs test)
endif()
