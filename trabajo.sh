if [[ $1 ]]
then
  java net.sf.saxon.Query junta.xq fecha=$1 > datos_json.xml
else
  echo "Debe ingresar la fecha por argumento"
fi