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
                <title>Item Viewer | CoEDL-Paradisec</title>
                <meta charset="utf-8"/>
                <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>

                <link rel="stylesheet" type="text/css" href="/Shared/coedl-assets/dist/bootstrap-3.3.7-dist/css/bootstrap.min.css"/>
                <link rel="stylesheet" type="text/css" href="/Shared/coedl-assets/dist/bootstrap-3.3.7-dist/css/bootstrap-theme.min.css"/>
                <link rel="stylesheet" type="text/css" href="/Shared/coedl-assets/css/noto-sans.css"/>
                <link rel="stylesheet" type="text/css" href="/Shared/coedl-assets/dist/mediaelement-4.2.6-build/mediaelementplayer.min.css" />
                <link rel="stylesheet" type="text/css" href="/Shared/coedl-assets/dist/featherlight-1.7.9/featherlight.min.css"/>

                <link rel="stylesheet" type="text/css" href="/Shared/coedl-assets/css/item-view.css"/>

            </head>
            <body>
                <div class="container-fluid">
                    <div class="row">
                        <xsl:apply-templates select="item"/>
                    </div>

                    <div class="row">
                        <hr />
                        <div class="col-xs-12" id="logos">
                            <img src="/Shared/coedl-assets/images/coedl-logo-hoz@2x.png" style="width:225px"/>
                            <img src="/Shared/coedl-assets/images/ParadisecLogo-compressed.jpg" style="width:90px"/>
                    </div>
                    </div>
                </div>

                <script type="text/javascript" src="/Shared/coedl-assets/dist/jquery-3.2.1.min.js"></script>
                <script type="text/javascript" src="/Shared/coedl-assets/dist/tehter-1.4.0.min.js"></script>
                <script type="text/javascript" src="/Shared/coedl-assets/dist/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
                <script type="text/javascript" src="/Shared/coedl-assets/dist/mediaelement-4.2.6-build/mediaelement-and-player.min.js"></script>
                <script type="text/javascript" src="/Shared/coedl-assets/dist/featherlight-1.7.9/featherlight.min.js"></script>

            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="item">

        <main class="col-sm-9 col-xs-12 offset-sm-3">

            Go to: <a href="#files">Files</a> | <a href="#files">Collection information</a> 

            <h2>Item information</h2>

            <table id="item-metadata">
                <xsl:apply-templates select="identifier|collectionId|title|
                                            description|originationDate|
                                            originationNarrative|archiveLink|
                                            collector|language|dialect|region|
                                            university|countries|
                                            subjectLanguages|contentLanguages|dataCategories"/>
            </table>

            <h2 id="files">Files</h2>

            <div class='files'>
                <ul>
                    <xsl:apply-templates select="files/file"/>
                </ul>
            </div>

            <h2>Collection</h2>

            <table id="collection-metadata">
                <xsl:apply-templates select="collection/*"/>
            </table>

        </main>
    </xsl:template>
    
    <!-- items that go into a div -->
    <xsl:template match="identifier|title|description|originationDate|originationNarrative|archiveLink|collector|language|dialect|region|university|operator|discourseType|citation">
        <xsl:if test="text() != ''">
            <xsl:element name="tr">
                <xsl:element name="td">
                    <xsl:attribute name="class">key</xsl:attribute>
                    <xsl:value-of select="name()"/>
                </xsl:element>
                <xsl:element name="td">
                    <xsl:attribute name="class">value</xsl:attribute>
                    <xsl:value-of select="text()"/>
                </xsl:element>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    
    <!-- items that get concatenated with a comma and placed in a div -->
    <xsl:template match="countries|subjectLanguages|contentLanguages|dataCategories">
        <xsl:element name="tr">
            <xsl:element name="td">
                <xsl:attribute name="class">key</xsl:attribute>
                <xsl:value-of select="name()"/>
            </xsl:element>

            <xsl:element name="td">
                <xsl:attribute name="class">value</xsl:attribute>
                
                <xsl:apply-templates select="country"/>
                <xsl:apply-templates select="language"/>
                <xsl:apply-templates select="category"/>
            </xsl:element>
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
        <!-- <xsl:if test="position() != 1">
            <xsl:text>, </xsl:text>
        </xsl:if>
        <xsl:value-of select="."/> -->
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
                         readyForExport|languages">
        <xsl:element name="tr">
            <xsl:element name="td">
                <xsl:attribute name="class">key</xsl:attribute>
                <xsl:value-of select="name()"/>
            </xsl:element>

            <xsl:element name="td">
                <xsl:attribute name="class">value</xsl:attribute>
                
                <xsl:apply-templates select="country"/>
                <xsl:apply-templates select="language"/>
                <xsl:apply-templates select="category"/>
            </xsl:element>
        </xsl:element>  
    </xsl:template>
    
    
</xsl:stylesheet>