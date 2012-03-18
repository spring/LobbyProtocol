project(ProtocolDescription)
find_program( XSLTPROC xsltproc )
cmake_minimum_required(VERSION 2.8)
message( STATUS "${XSLTPROC}" )
if( EXISTS ${XSLTPROC} )
	add_custom_target( html
		${XSLTPROC} ${CMAKE_CURRENT_SOURCE_DIR}/ProtocolDescription_xml2html.xsl 
		${CMAKE_CURRENT_SOURCE_DIR}/ProtocolDescription.xml  > ${CMAKE_CURRENT_BINARY_DIR}/ProtocolDescription.html &&
		${XSLTPROC} ${CMAKE_CURRENT_SOURCE_DIR}/index.xsl 
		${CMAKE_CURRENT_SOURCE_DIR}/ProtocolDescription.xml  > ${CMAKE_CURRENT_BINARY_DIR}/index.html 
		)
endif( EXISTS ${XSLTPROC} )
