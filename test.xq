<eventos>
  <fecha>2012-10-05</fecha>
  {for $evento in doc('fdc-eventos-2012.xml')//ROW/DATE[contains(., '2012-10-05')]/..
    return (
      <evento>&#10;
        <hora>{ $evento/TIME/text() }</hora>&#10;
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
        </lugar>&#10;
        <artistas>
          {for $artista in doc('fdc-artistas-2012.xml')
            where $artista/ID_ARTIST[contains(., $evento/ID_ARTIST1/text())]
            return (<nombre> { $artista/NAME/text() } </nombre>)
          }
        </artistas>&#10;
      </evento>
    )
  }
</eventos>