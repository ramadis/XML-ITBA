declare variable $fecha as xs:string external;

<eventos fecha="
    { if (matches($fecha , '^2012-10-(0[4-8]|11)$'))
        then($fecha)
      else if (matches($fecha ,'^(\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01]))$'))
        then ('No hay eventos en la fecha', $fecha)
      else('Fecha incorrecta. Ingrese con el formato YYYY-MM-DD')
    }">
  
  {for $evento in doc('fdc-eventos-2012.xml')//ROW/DATE[matches(., concat('^', $fecha, '$'))]/..
    return (
      <evento>
        {for $obra in doc('fdc-obras-2012.xml')//ROW
          where $obra/ID_PLAY[matches(., concat('^', $evento/ID_PLAY/text(), '$'))]
          return (<titulo> { $obra/TITLE/text()} </titulo>, <descripcion> { $obra/SYNOPSIS_ES/text() } </descripcion>)
        }
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
  }
</eventos>