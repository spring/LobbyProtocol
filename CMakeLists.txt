project(ProtocolDescription)
find_program( XSLTPROC xsltproc )
cmake_minimum_required(VERSION 2.8)
message( STATUS "${XSLTPROC}" )
if( NOT EXISTS ${XSLTPROC} )
	message(FATAL_ERROR "xsltproc not found, can't continue!")
endif()

add_custom_command(
	OUTPUT ProtocolDescription.html
	COMMAND ${XSLTPROC} ${CMAKE_CURRENT_SOURCE_DIR}/ProtocolDescription_xml2html.xsl
	${CMAKE_CURRENT_SOURCE_DIR}/ProtocolDescription.xml  > ${CMAKE_CURRENT_BINARY_DIR}/ProtocolDescription.html
	DEPENDS ProtocolDescription.xml ProtocolDescription_xml2html.xsl
)
add_custom_command(
	OUTPUT index.html
	COMMAND ${XSLTPROC} ${CMAKE_CURRENT_SOURCE_DIR}/index.xsl
	${CMAKE_CURRENT_SOURCE_DIR}/ProtocolDescription.xml  > ${CMAKE_CURRENT_BINARY_DIR}/index.html
	DEPENDS ProtocolDescription.xml index.xsl
)
add_custom_target(docs ALL
	DEPENDS index.html ProtocolDescription.html
)
