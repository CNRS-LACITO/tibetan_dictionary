<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>

<xsl:template match="/">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta content="text/html; charset=UTF-8" http-equiv="content-type"/>
    <title>Vocabulaire</title>
</head>
<body>

    <h1>Vocabulaire thématique bilingue de langue parlée français-tibétain</h1>
    <br/>    <ul>
        <xsl:apply-templates />
    </ul>
   </body>
  </html>
</xsl:template>

<xsl:template match="Chapitre">
     <li><h3><xsl:value-of select="@Nom"/> &#160; 
     	<xsl:value-of select="TitreTib" /> / <xsl:value-of select="TitreFr" /></h3>
     	<ul><xsl:apply-templates select="Section"/></ul>
     </li>
</xsl:template>

<xsl:template match="Section">
	<li><h4><xsl:value-of select="@Nom"/> &#160; 
		<xsl:value-of select="TitreTib" /> / <xsl:value-of select="TitreFr" /></h4>
     	<ol><xsl:apply-templates select="Entrée"/></ol>
     </li>
</xsl:template>

<xsl:template match="Entrée">
     <li><b><xsl:value-of select="Définition/DefFr/Vedette" /></b>
         <xsl:if test="Définition/DefFr/Vedette/@gram"> [<xsl:value-of select="Définition/DefFr/Vedette/@gram"/>]</xsl:if>
         <xsl:if test="Définition/DefFr/Vedette/@niv"> - <i><xsl:value-of select="Définition/DefFr/Vedette/@niv"/></i></xsl:if>
         <xsl:if test="Définition/DefFr/Vedette/@péj"> (<xsl:value-of select="Définition/DefFr/Vedette/@péj"/>)</xsl:if>
     	<xsl:for-each select="Définition/DefFr/SynDefFr">
     		/ <xsl:value-of select="."/>
     		<xsl:if test="@gram"> [<xsl:value-of select="@gram"/>]</xsl:if>
     		<xsl:if test="@niv"> - <i><xsl:value-of select="@niv"/></i></xsl:if>
     		<xsl:if test="@péj"> (<xsl:value-of select="@péj"/>)</xsl:if>
     	</xsl:for-each>
     	<br />
     	<xsl:for-each select="Définition/DefTib/SynDefTib">
     		<big><xsl:value-of select="."/></big>
     		<xsl:if test="@phon"> &#160; <code><xsl:value-of select="@phon"/></code></xsl:if>
     		<!-- &#160; =  = &nbsp; qui n'est pas préféfini en XML et donc coince... -->
     		<xsl:if test="@gram"> [<xsl:value-of select="@gram"/>]</xsl:if>
     		<xsl:if test="@niv"> - <i><xsl:value-of select="@niv"/></i></xsl:if>  &#160; 
     		<xsl:if test="@péj"> (<xsl:value-of select="@péj"/>)</xsl:if> /
     	</xsl:for-each> 
  
     	<xsl:if test="Exemple">
     		<br />
     		<xsl:if test="count(Exemple) &gt; 1">Exemples</xsl:if> 
     		<xsl:if test="count(Exemple) = 1">Exemple</xsl:if>
     		<ul>
     		<xsl:for-each select="Exemple">
     			<li>
     			<xsl:for-each select="TxtTib/SynEx"> 
     				<xsl:value-of select="."/>
     				<xsl:if test="@phon"> &#160; <code><xsl:value-of select="@phon"/></code></xsl:if>
     				<xsl:if test="@niv"> - <i><xsl:value-of select="@niv"/></i></xsl:if><br />
     			</xsl:for-each>	
     			<xsl:for-each select="TxtFr/SynEx"> 
     				= <i><xsl:value-of select="."/></i>
     				<xsl:if test="@niv"> - <xsl:value-of select="@niv"/></xsl:if><br />
     			</xsl:for-each>	
     			</li>
    		</xsl:for-each>
     		</ul>
     		<br />
     	</xsl:if>
     </li>
</xsl:template>

</xsl:stylesheet>
