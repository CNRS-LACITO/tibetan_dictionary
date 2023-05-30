<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>
<!-- Version nouveau format : les Parties ont disparu, les colonnes portent un double nom fr. & tib. -->

<xsl:output method = "text" />
<xsl:strip-space elements="*" />

<xsl:template match="/">Chapitre / ལེའུ་ཨང་གྲངས།;TChapFr / ལེའུའི་ཁ་བྱང་།  ཧྥ་སྐད།;TChapTib / ལེའུའི་ཁ་བྱང་།   བོད་ཡིག;Section / ལེ་ཚན་ཨ་གྲངས།;TSectFr / ལེ་ཚན་ཁ་བྱང་།  ཧྥ་སྐད།;TSectTib / ལེ་ཚན་ཁ་བྱང་།  བོད་ཡིག;Entrée / མ་ཚིག།;DefGram / མ་ཚིག་གི་བརྡ་ཕྲོད་ཁྱད་ཆོས།;DefNiv / མ་ཚིག་གི་བེད་སྤྱོད་རིགས་དང་པོ།;DefPéj / མ་ཚིག་གི་བེད་སྤྱོད་རིགས་གཉིས་པ།;SynFr / ཉེ་ཚིག;SFGram / ཉེ་ཚིག་གི་བརྡ་འཕྲོད་ཁྱད་ཆོས།;SFNiv / ཉེ་ཚིག་གི་བེད་སྤྱོད་རིགས་དང་པོ།;SFPéj / ཉེ་ཚིག་གི་བེད་སྤྱོད་རིགས་གཉིས་པ།;SynTib / མ་ཚིག་གི་སྐད་སྒྱུར།;STPhon / སྒྲ་གདངས།;STGram /  སྐད་སྒྱུར་གྱི་བརྡ་འཕྲོད་ཁྱད་ཆོས།;STNiv / ཞེ་ས་ཡིན་མིན།;STPéj / དམའ་འབེབས་ཡིན་མིན།;Ex / དཔེར་ན།;ExTib / དཔེ་བརྗོད།;ExTPhon / དཔེ་བརྗོད་ཀྱི་སྒྲ་གདངས།;ExTNiv / དཔེ་བརྗོད་ཀྱི་བེད་སྤྱོད།;ExFr / དཔེར་བརྗོད་ཀྱི་སྐད་བསྒྱུར།;ExFNiv / དཔེ་བརྗོད་སྐད་སྒྱུར་གྱི་བེད་སྤྱོད།
<xsl:apply-templates />
</xsl:template>

<!-- Table de correspondance noms - décalage en nombre de ';' :
Chapitre = 0 / A '' TChapFr = 1 / B ';'  TChapTib = 2 / C ';;'
Section = 3 / D ';;;' TSectFr = 4 / E ';;;;' TSectTib = 5 / F ';;;;;'
Entrée = 6 / G  ';;;;;;'  DefGram = 7 / H ';;;;;;;' DefNiv = 8 / I ';;;;;;;;' DefPéj =  9 / J ';;;;;;;;;'
SynFr = 10 / K ';;;;;;;;;;' SFGram = 11 / L ';;;;;;;;;;;' SFNiv = 12 / M ';;;;;;;;;;;;' SFPéj = 13 / N ';;;;;;;;;;;;;'
SynTib = 14 / O ';;;;;;;;;;;;;;'  STPhon = 15 / P ';;;;;;;;;;;;;;;' STGram = 16 / Q ';;;;;;;;;;;;;;;;' STNiv = 17 / R ';;;;;;;;;;;;;;;;;' STPéj = 18 / S ';;;;;;;;;;;;;;;;;;' 
Ex = 19 / T ';;;;;;;;;;;;;;;;;;;' 
ExTib = 20 / U ';;;;;;;;;;;;;;;;;;;;' ExTPhon = 21 / V ';;;;;;;;;;;;;;;;;;;;;' ExTNiv = 22 / W ';;;;;;;;;;;;;;;;;;;;;;'
ExFr = 23 / X ';;;;;;;;;;;;;;;;;;;;;;;' ExFNiv = 24 / Y ';;;;;;;;;;;;;;;;;;;;;;;;' 
-->


<xsl:template match="Chapitre"><xsl:value-of select="@Nom" />;<xsl:value-of select="TitreFr" />;<xsl:value-of select="TitreTib" /><xsl:text>
</xsl:text>
<xsl:apply-templates select="Section" />
</xsl:template>

<xsl:template match="Section">;;;<xsl:value-of select="@Nom" />;<xsl:value-of select="TitreFr" />;<xsl:value-of select="TitreTib" /><xsl:text>
</xsl:text>
<xsl:apply-templates select="Entrée" />
</xsl:template>

<xsl:template match="Entrée">;;;;;;<xsl:value-of select="Définition/DefFr/Vedette" />;<xsl:value-of select="Définition/DefFr/Vedette/@gram" />;<xsl:value-of select="Définition/DefFr/Vedette/@niv" />;<xsl:value-of select="Définition/DefFr/Vedette/@péj" /><xsl:text>
</xsl:text>
	<xsl:for-each select="Définition/DefFr/SynDefFr">;;;;;;;;;;<xsl:value-of select="."/>;<xsl:value-of select="@gram"/>;<xsl:value-of select="@niv"/>;<xsl:value-of select="@péj"/><xsl:text>
</xsl:text>
    </xsl:for-each>
    <xsl:for-each select="Définition/DefTib/SynDefTib">;;;;;;;;;;;;;;<xsl:value-of select="."/>;<xsl:value-of select="@phon"/>;<xsl:value-of select="@gram"/>;<xsl:value-of select="@niv"/>;<xsl:value-of select="@péj"/><xsl:text>
</xsl:text>
    </xsl:for-each>
	<xsl:if test="Exemple">
		<xsl:for-each select="Exemple">;;;;;;;;;;;;;;;;;;;Ex<xsl:text>
</xsl:text>
			<xsl:for-each select="TxtTib/SynEx">;;;;;;;;;;;;;;;;;;;;<xsl:value-of select="."/>;<xsl:value-of select="@phon"/>;<xsl:value-of select="@niv"/><xsl:text>
</xsl:text>
     		</xsl:for-each>	
     		<xsl:for-each select="TxtFr/SynEx">;;;;;;;;;;;;;;;;;;;;;;;<xsl:value-of select="translate(text(), ';', '-')"/>;<xsl:value-of select="@niv"/><xsl:text>
</xsl:text>
     		</xsl:for-each>	
		</xsl:for-each>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
