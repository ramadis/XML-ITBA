declare variable $fecha as xs:string external;

if (matches($fecha , '^2012-10-(0[4-8]|11)$'))
  then(
    <eventos fecha="{ $fecha }">
      {for $evento in doc('fdc-eventos-2012.xml')//ROW/DATE[matches(., concat('^', $fecha, '$'))]/..
        where $evento/ID_PLAY[not(matches(.,'NULL|0'))]
        return (
        for $obra in doc('fdc-obras-2012.xml')//ROW
          where $obra/ID_PLAY[matches(., concat('^', $evento/ID_PLAY/text(), '$'))]
          return (
            <evento>
              <titulo> { $obra/TITLE/text()} </titulo>
              <descripcion> { $obra/SYNOPSIS_ES/text() } </descripcion>
              <lugar>
                {for $sede in doc('fdc-sedes-2012.xml')//ROW
                  where $sede/ID_PLACE[matches(., concat('^', $evento/ID_PLACE/text(), '$'))]
                  return (<nombre> { $sede/TITLE/text() } </nombre>, <direccion> { $sede/ADDRESS/text() } </direccion>)
                }
                <sala> { $evento/ROOMS/text() } </sala>
              </lugar>
              <hora>{ $evento/TIME/text() }</hora>
              <artistas>
                {for $artista in doc('fdc-artistas-2012.xml')//ROW
                  where (($artista/ID_ARTIST[matches(., concat('^', $evento/ID_ARTIST1/text(), '$'))]
                    or $artista/ID_ARTIST[matches(., concat('^', $evento/ID_ARTIST2/text(), '$'))])
                    and $artista/ID_ARTIST[not(matches(.,'NULL|0'))])
                  return (<nombre> { $artista/NAME/text() } </nombre>)
                }
              </artistas>
            </evento>
          )
        )
      }
    </eventos>
  )
else if (matches($fecha ,'^(\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01]))$'))
  then <error>{ ('No hay eventos en la fecha', $fecha) } </error>
else <error>{ ('Fecha incorrecta. Ingrese con el formato YYYY-MM-DD') } </error>


(: COSAS QUE SE CONSIDERARON:
  - Si la fecha es invalida, o no hay eventos en la fecha se genera un tag <error> mostrando el error
  - Si no hay obras que matcheen con eventos en esa fecha, se muestra el tag eventos vacio.
  - Si no hay artistas que matcheen, se muestra el tag artistas vacio.
  - Si no hay sala dentro del lugar, se muestra el tag sala vacio.
  - Si no hay tiulo, se muestra el tag titulo vacio
  - Si no hay descripcion, se muestra el tag descripcion vacio.
  - Si no hay hora, se muestra el tag hora vacio.
  - Si no se encuentra la sede, no se muestra ni el nombre ni el lugar.
  - Si se encuentra la sede, se muestran los tags nombre y direccion, vacios o no, segun corresponda.
  - Se considero que el artista no sea NULL ni 0.
  Comprobada validez de xml con xsd con http://www.freeformatter.com/xml-validator-xsd.html
 :)