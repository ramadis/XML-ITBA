if [[ $1 ]]
then
  java net.sf.saxon.Query junta.xq fecha=$1 > datos_json.xml
  java net.sf.saxon.Transform -s:datos_json.xml -xsl:eventos.xsl > eventos.json
else
  echo "Debe ingresar la fecha por argumento"
fi
