<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>
<xsl:template match="/eventos">
<html>
<body>{
	"fecha": "<xsl:value-of select="fecha"/>",
	"eventos": [<xsl:for-each select="evento">{
			"evento": {
					"titulo": "<xsl:value-of select="titulo"/>",
					"descripcion": "<xsl:value-of select="descripcion"/>",
					"lugar": {	<xsl:for-each select="lugar">
						"nombre": "<xsl:value-of select="nombre"/>",
						"direccion": "<xsl:value-of select="direccion"/>",
						"sala": "<xsl:value-of select="sala"/>"</xsl:for-each>					
					 }
				"hora" : "<xsl:value-of select="hora"/>",
				"artistas" : [<xsl:for-each select="artistas"><xsl:for-each select="nombre">{"nombre" : "<xsl:value-of select="current()"/>"}<xsl:if test="not(position() = last())">,
					       </xsl:if>
					</xsl:for-each>
			</xsl:for-each>]
			}
		}
		</xsl:for-each>
	}]
	}
</body>

</html>

</xsl:template>
</xsl:stylesheet>
