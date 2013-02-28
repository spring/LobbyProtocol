# README - Spring RTS lobby protocol

## What is Spring RTS?

Spring (formerly TASpring) is an Open Source Real Time Strategy game engine.
Visit our [project homepage](http://springrts.com/) for help, suggestions,
bugs, community forum and everything spring related.

## What is the lobby protocol used for?

Lobby clients and servers use this protocol to communicate together.
The lobby-system is where players get together to chat and organize games.

You can inspect the protocol in a human readable form
by opening _ProtocolDescription.xml_ in your browser, if it supports XSL.

## Files

* _ProtocolDescription.xml_ - the main document, describing the individual commands
* _ProtocolDescription.dtd_ - can be used to validate syntactical correctness of _ProtocolDescription.xml_
* _ProtocolDescription_xml2html.xsl_ - can be used to generate a human readable HTML form of _ProtocolDescription.xml_
* _README.md_ - this read-me

You can get the latest official version of these files [here](https://github.com/spring/LobbyProtocol).

A [readable Page](http://springrts.com/dl/LobbyProtocol/) is automaticly generated every night.
