declare variable $fecha as xs:string external;

<eventos>
  <fecha> {if (matches($fecha , '^2012-10-([0-2][0-9]|30|31)$'))
      then($fecha)
      else if (matches($fecha ,'^(\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01]))$'))
      then ('No hay eventos en la fecha', $fecha)
      else('Fecha incorrecta. Ingrese con el formato YYYY-MM-DD')}
  </fecha>
  {for $evento in doc('fdc-eventos-2012.xml')//ROW/DATE[matches(., concat('^', $fecha, '$'))]/..
    return (
      <evento>
        <hora>{ $evento/TIME/text() }</hora>
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
        <artistas>
          {for $artista in doc('fdc-artistas-2012.xml')//ROW
            where $artista/ID_ARTIST[matches(., concat('^', $evento/ID_ARTIST1/text(), '$'))]
              | $artista/ID_ARTIST[matches(., concat('^', $evento/ID_ARTIST2/text(), '$'))]
            return (<nombre> { $artista/NAME/text() } </nombre>)
          }
        </artistas>
      </evento>
    )
  }
</eventos>