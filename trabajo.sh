if [[ $1 ]]
then
  java net.sf.saxon.Query junta.xq fecha=$1 > datos_json.xml
else
  echo "Debe ingresar la fecha por argumento"
fi

java net.sf.saxon.Transform -s:datos_json.xml -xsl:eventos.xslt > eventos.json