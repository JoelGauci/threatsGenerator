<?xml version="1.0" encoding="utf-8"?>
<!--+
	|************************************************************
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apigee.threats.xsl
	|*** Scenario: XML AND JSON THREATS FILE GENERATOR
	|*** Description: XSL Stylesheet template used to create XML AND JSON threats:
	|*** - Document Size Attack
	|*** - Document Width Attack
	|*** - Document Depth Attack
	|*** Revision : 1.0.0 : initial version
	|************************************************************
	+-->
	
<xsl:stylesheet version="1.0"					
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		extension-element-prefixes="" 							
		exclude-result-prefixes="">
						
	<!-- Define the output as an indented XML content -->
	<!-- The output of this XSL Stylesheet is an XML Threat - so take care of it ! -->
	<xsl:output method="xml" indent="yes" encoding="UTF-8"/>
	
	<!-- Variables that contain generic element and attribute names -->
	<xsl:variable name="generic-element-name">elmt_name_</xsl:variable>
	<xsl:variable name="generic-attribute-name">attr_name_</xsl:variable>
	
	<!-- Variable that contains the default value for attributes (with attack) -->
	<xsl:variable name="generic-attribute-value">attr_value</xsl:variable>

<!--+
	|********************************
	|*** Matching Template
	|*** Element: ROOT
	|********************************
	+-->
	<xsl:template match="/">
		
		<!-- Apply templates on the 'DocXMLGenerator' element -->
		<xsl:apply-templates select="DocXMLGenerator"/>

		<!-- Apply templates on the 'DocJSONGenerator' element -->
		<xsl:apply-templates select="DocJSONGenerator"/>
		
	</xsl:template>
	
<!--+
	|********************************
	|*** Matching Template
	|*** Element: DOCXMLGENERATOR
	|********************************
	+-->
	<xsl:template match="DocXMLGenerator">
		
		<!-- Create the XML Threat... -->
		<XMLThreat>
			<!-- add attributes as a summary of the test -->
			<xsl:attribute name="size"><xsl:value-of select="./NumElements/text()"/></xsl:attribute>
			<xsl:attribute name="width"><xsl:value-of select="./NumAttributes/text()"/></xsl:attribute>
			<xsl:attribute name="depth"><xsl:value-of select="./ElementDepth/text()"/></xsl:attribute>
			<xsl:call-template name="setXMLThreat">
				<xsl:with-param name="aNumElement" select="./NumElements/text()"/>
				<xsl:with-param name="aNumAttribute" select="./NumAttributes/text()"/>
				<xsl:with-param name="aElementDepth" select="./ElementDepth/text()"/>
			</xsl:call-template>
		</XMLThreat>
	</xsl:template>

<!--+
	|********************************
	|*** Matching Template
	|*** Element: DOCJSONGENERATOR
	|********************************
	+-->
	<xsl:template match="DocJSONGenerator">

		<!-- Create the JSON Threat... -->
		<JSONThreat>
			<!-- add attributes as a summary of the test -->
			<xsl:attribute name="size"><xsl:value-of select="./NumElements/text()"/></xsl:attribute>
			<xsl:attribute name="width"><xsl:value-of select="./NumAttributes/text()"/></xsl:attribute>
			<xsl:attribute name="depth"><xsl:value-of select="./ElementDepth/text()"/></xsl:attribute>
			<xsl:call-template name="setXMLThreat">
				<xsl:with-param name="aNumElement" select="./NumElements/text()"/>
				<xsl:with-param name="aNumAttribute" select="./NumAttributes/text()"/>
				<xsl:with-param name="aElementDepth" select="./ElementDepth/text()"/>
			</xsl:call-template>
		</JSONThreat>
	</xsl:template>
	
<!--+
	|********************************
	|*** Named Template
	|*** Name: setXMLThreat
	|********************************
	+-->
	<!-- Set the the required XML threats: Width/Size/Depth attacks -->
	<xsl:template name="setXMLThreat">
		<xsl:param name="aNumElement"/>
		<xsl:param name="aNumAttribute"/>
		<xsl:param name="aElementDepth"/>
		
		<!-- Code to be added here... -->
		<xsl:call-template name="setDocumentSizeAttack">
			<xsl:with-param name="aNumElement" select="$aNumElement"/>
			<xsl:with-param name="aNumAttribute" select="$aNumAttribute"/>
			<xsl:with-param name="aElementDepth" select="$aElementDepth"/>
		</xsl:call-template>
		
	</xsl:template>
	
	
<!--+
	|********************************
	|*** Named Template
	|*** Name: setDocumentSizeAttack
	|********************************
	+-->
	<!-- Set the the required XML threats: Width/Size/Depth attacks -->
	<xsl:template name="setDocumentSizeAttack">
		<xsl:param name="aNumElement"/>
		<xsl:param name="aNumAttribute"/>
		<xsl:param name="aElementDepth"/>
		<xsl:param name="aIterator" select="1"/>
		
		<xsl:choose>
			<xsl:when test="number($aIterator) &lt;= number($aNumElement)">
				<xsl:element name="{concat($generic-element-name,string($aIterator))}">
					<xsl:call-template name="setDocumentWidthAttack">
						<xsl:with-param name="aNumElement" select="$aNumElement"/>
						<xsl:with-param name="aNumAttribute" select="$aNumAttribute"/>
						<xsl:with-param name="aElementDepth" select="$aElementDepth"/>
					</xsl:call-template>
					<xsl:call-template name="setDocumentDepthAttack">
						<xsl:with-param name="aNumElement" select="$aNumElement"/>
						<xsl:with-param name="aNumAttribute" select="$aNumAttribute"/>
						<xsl:with-param name="aElementDepth" select="$aElementDepth"/>
						<xsl:with-param name="aIterator1" select="number($aIterator)"/>
					</xsl:call-template>
				</xsl:element>
				<xsl:call-template name="setDocumentSizeAttack">
					<xsl:with-param name="aNumElement" select="$aNumElement"/>
					<xsl:with-param name="aNumAttribute" select="$aNumAttribute"/>
					<xsl:with-param name="aElementDepth" select="$aElementDepth"/>
					<xsl:with-param name="aIterator" select="number($aIterator)+1"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
		
	</xsl:template>
	
<!--+
	|********************************
	|*** Named Template
	|*** Name: setDocumentWidthAttack
	|********************************
	+-->
	<!-- Set the the required XML threats: Width/Size/Depth attacks -->
	<xsl:template name="setDocumentWidthAttack">
		<xsl:param name="aNumElement"/>
		<xsl:param name="aNumAttribute"/>
		<xsl:param name="aElementDepth"/>
		<xsl:param name="aIterator" select="1"/>
		
		<xsl:choose>
			<xsl:when test="number($aIterator) &lt;= number($aNumAttribute)">
				<xsl:attribute name="{concat($generic-attribute-name,string($aIterator))}">
					<xsl:value-of select="$generic-attribute-value"/>
				</xsl:attribute>
				<xsl:call-template name="setDocumentWidthAttack">
					<xsl:with-param name="aNumElement" select="$aNumElement"/>
					<xsl:with-param name="aNumAttribute" select="$aNumAttribute"/>
					<xsl:with-param name="aElementDepth" select="$aElementDepth"/>
					<xsl:with-param name="aIterator" select="number($aIterator)+1"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
		
	</xsl:template>

<!--+
	|********************************
	|*** Named Template
	|*** Name: setDocumentDepthAttack
	|********************************
	+-->
	<!-- Set the the required XML threats: Width/Size/Depth attacks -->
	<xsl:template name="setDocumentDepthAttack">
		<xsl:param name="aNumElement"/>
		<xsl:param name="aNumAttribute"/>
		<xsl:param name="aElementDepth"/>
		<xsl:param name="aIterator1" select="1"/>
		<xsl:param name="aIterator2" select="1"/>
		
		<xsl:choose>
			<xsl:when test="number($aIterator2) &lt;= number($aElementDepth)">
				<xsl:element name="{concat($generic-element-name,string($aIterator1),'_',string($aIterator2))}">
					<xsl:call-template name="setDocumentWidthAttack">
						<xsl:with-param name="aNumElement" select="$aNumElement"/>
						<xsl:with-param name="aNumAttribute" select="$aNumAttribute"/>
						<xsl:with-param name="aElementDepth" select="$aElementDepth"/>
					</xsl:call-template>
					<xsl:call-template name="setDocumentDepthAttack">
						<xsl:with-param name="aNumElement" select="$aNumElement"/>
						<xsl:with-param name="aNumAttribute" select="$aNumAttribute"/>
						<xsl:with-param name="aElementDepth" select="$aElementDepth"/>
						<xsl:with-param name="aIterator1" select="number($aIterator1)"/>
						<xsl:with-param name="aIterator2" select="number($aIterator2)+1"/>
				</xsl:call-template>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
		
	</xsl:template>

</xsl:stylesheet>