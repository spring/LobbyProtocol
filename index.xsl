<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" omit-xml-declaration="yes" media-type="text/html" encoding="utf-8"/>

<!--

  See DTD file for more info on various elements/attributes!

  Some useful links:
  ******************

  How to test if node contains no text:
    http://www.dpawson.co.uk/xsl/sect2/N3328.html#d4281e58

  List of css tags:
    http://www.w3.org/TR/REC-CSS1

  CSS font-family:
    http://www.codestyle.org/css/font-family/
 -->

<xsl:template match="ProtocolDescription">
  <html>
  <head>
    <title>Index - Spring lobby protocol description</title>

    <style type="text/css">
      h3 {
      color: navy;
      font-size: 1.1em;
      line-height: 1.25em;
      text-align: left;
      margin-top: 0;
      margin-bottom: 0.25em;
      border-bottom: 1px solid navy
      }

    </style>

  </head>
  <body>
	<h1>Protocol command index</h1>

	<div>
		<div style="float:left;width:40%">
			<h2>Client</h2>
			<ul>
				<xsl:for-each select="CommandList/Command">
					<xsl:if test="@Source='client'">
						<li>
							<a href="ProtocolDescription.html#{@Name}:{@Source}">
								<xsl:value-of select="@Name"/>
							</a>
						</li>
					</xsl:if>
				</xsl:for-each>
			</ul>
		</div>
		<div style="float:right;width:40%">
			<h2>Server</h2>
			<ul>
				<xsl:for-each select="CommandList/Command">
					<xsl:if test="@Source='server'">
						<li>
							<a href="ProtocolDescription.html#{@Name}:{@Source}">
								<xsl:value-of select="@Name"/>
							</a>
						</li>
					</xsl:if>
				</xsl:for-each>
			</ul>
		</div>
	</div>
  </body>
  </html>
</xsl:template>

<!-- this overrides default built-in template for text nodes. Currently doesn't do anything useful! -->
<xsl:template match="text()">
  <xsl:value-of select="(.)"/>
</xsl:template>

<xsl:template match="clink">

  <xsl:variable name="type"><xsl:value-of select="substring-after(@name, ':')"/></xsl:variable> <!-- doesn't neccessarily exist! -->

  <xsl:choose>
    <xsl:when test="$type=''">
      <!-- the ":x" post-fix doesn't exist -->
      <xsl:choose>
        <xsl:when test="//Command[@Name=current()/@name and @Source='client']">
          <a href="#{@name}:client"><xsl:value-of select="@name"/></a>
        </xsl:when>
        <xsl:when test="//Command[@Name=current()/@name and @Source='server']">
          <a href="#{@name}:server"><xsl:value-of select="@name"/></a>
        </xsl:when>
		<xsl:otherwise>
		  <!-- error: command does not exist! (link is broken) -->
          <a href="#{@name}"><xsl:value-of select="@name"/></a><span style="color: red"> [broken link]</span>
		</xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <!-- the ":x" post-fix exists -->
      <xsl:choose>
        <xsl:when test="starts-with($type,'c')">
          <a href="#{substring-before(@name, ':')}:client"><xsl:value-of select="substring-before(@name, ':')"/></a>
        </xsl:when>
        <xsl:when test="starts-with($type,'s')">
          <a href="#{substring-before(@name, ':')}:server"><xsl:value-of select="substring-before(@name, ':')"/></a>
        </xsl:when>
		<xsl:otherwise>
		  <!-- error: command does not exist! (link is broken) -->
          <a href="#{@name}"><xsl:value-of select="@name"/></a><span style="color: red"> [broken link]</span>
		</xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template>

<xsl:template match="i">
  <span style="font-style: italic;"><xsl:apply-templates /></span>
</xsl:template>

<xsl:template match="b">
  <span style="font-weight: bold;"><xsl:apply-templates /></span>
</xsl:template>

<xsl:template match="u">
  <span style="text-decoration: underline;"><xsl:apply-templates /></span>
</xsl:template>

<xsl:template match="br">
  <br /><xsl:apply-templates />
</xsl:template>

<xsl:template match="br2">
  <br /><br /><xsl:apply-templates />
</xsl:template>

<xsl:template match="p">
  <p><xsl:apply-templates /></p>
</xsl:template>

<xsl:template match="ul">
  <ul><xsl:apply-templates /></ul>
</xsl:template>

<xsl:template match="li">
  <li><xsl:apply-templates /></li>
</xsl:template>

<xsl:template match="url">
  <xsl:variable name="link"><xsl:value-of select="." /></xsl:variable>
  <a href="{$link}" style="white-space: nowrap"><xsl:value-of select="$link" /></a>
</xsl:template>

<!-- This template replaces all newlines with html BR tags
     Code has been copied from:
     http://www.biglist.com/lists/xsl-list/archives/200310/msg01013.html
-->
<xsl:template name="insertBreaks">
   <xsl:param name="text" select="."/>
   <xsl:choose>
   <xsl:when test="contains($text, '&#xa;')">
      <xsl:value-of select="substring-before($text, '&#xa;')"/>
      <br />
      <xsl:call-template name="insertBreaks">
          <xsl:with-param name="text" select="substring-after($text,'&#xa;')"/>
      </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
	<xsl:value-of select="$text"/>
   </xsl:otherwise>
   </xsl:choose>
</xsl:template>

</xsl:stylesheet>
