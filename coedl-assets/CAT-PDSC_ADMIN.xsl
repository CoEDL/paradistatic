<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="1.0">

    <xsl:template match="/ | @* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="/">
        <html>
            <head>

            </head>
            <body>
                <xsl:apply-templates select="item"/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="item">
        <div class='core_items'>
            <xsl:apply-templates select="identifier|collectionId|title|
                                        description|originationDate|
                                        originationNarrative|archiveLink|
                                        collector|language|dialect|region|
                                        university|agents|countries|
                                        subjectLanguages|contentLanguages|dataCategories"/>
        </div>
        <div class='files'>
            <ul>
                <xsl:apply-templates select="files/file"/>
            </ul>
        </div>
        <div class='collection'>
            <xsl:apply-templates select="collection/*"/>
        </div>
    </xsl:template>
    
    <!-- items that go into a div -->
    <xsl:template match="identifier|title|description|originationDate|originationNarrative|archiveLink|collector|language|dialect|region|university|operator|discourseType|citation">
        <xsl:if test="text() != ''">
            <xsl:element name="div">
                <xsl:attribute name="class">
                    <xsl:value-of select="name()"/>
                </xsl:attribute>
                <xsl:apply-templates select="text()"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    
    <!-- items that get concatenated with a comma and placed in a div -->
    <xsl:template match="countries|subjectLanguages|contentLanguages|dataCategories">
        <xsl:element name="div">
            <xsl:attribute name="class">
                <xsl:value-of select="name()"/>
            </xsl:attribute>
            <xsl:apply-templates select="country"/>
            <xsl:apply-templates select="language"/>
            <xsl:apply-templates select="category"/>
        </xsl:element>
    </xsl:template>

    <!-- agents include data in an attribute nad are handled separately -->
    <xsl:template match="agents">
        <div class='agents'>
            <xsl:apply-templates select="agent"/>
        </div>
    </xsl:template>

    <xsl:template match="agent">
        <xsl:if test="position()!=1">
            <xsl:text>, </xsl:text>
        </xsl:if><xsl:value-of select="."/><xsl:text> (</xsl:text><xsl:value-of select="@role"/><xsl:text>)</xsl:text>
    </xsl:template>
    
    <!-- concats -->
    <xsl:template match="language|category|country">
        <xsl:if test="position() != 1">
            <xsl:text>, </xsl:text>
        </xsl:if>
        <xsl:value-of select="."/>
    </xsl:template>
    
    
    <xsl:template match="file">
        <li>
            <xsl:value-of select="name"/>
        <xsl:choose>
            <xsl:when test="contains(name/text(), '.mp3')">
                <audio width="240" class="mejs__player">
                    <xsl:attribute name="data-mejsoptions">{"alwaysShowControls": "true"}</xsl:attribute>
                    <xsl:attribute name="src">
                        <xsl:value-of select="name"/>
                    </xsl:attribute>
                </audio>
            </xsl:when>
            <xsl:when test="contains(name/text(),'.jpg') or contains(name/text(),'.tif')">
                <br/>
                <a href="#">
                    <xsl:attribute name="data-featherlight">
                        <xsl:value-of select="name"/>
                    </xsl:attribute>
                    <img width='240'>
                        <xsl:attribute name="src">
                            <xsl:value-of select="name"/>
                        </xsl:attribute>
                    </img>
                </a>
            </xsl:when>
            <xsl:when test="contains(name/text(), '.mp4')">
                <video width="240" height="180" class="mejs__player">
                    <xsl:attribute name="src">
                        <xsl:value-of select="name"/>
                    </xsl:attribute>
                    <xsl:attribute name="data-mejsoptions">{"alwaysShowControls": "true"}</xsl:attribute>
                </video>
            </xsl:when>
        </xsl:choose>
        </li>
    </xsl:template>
    
    
    <!-- send to /dev/null -->
    <xsl:template match="collectionId|private|geographicLocation|
                         accessInfo|adminAccess|depositInfo|metadataSource|
                         orthographicNotes|media|recordCreated|
                         recordLastModified|depositInfo|grants|adminInfo|readyForExport|
                         readyForExport|languages"/>
        
    
    
</xsl:stylesheet>