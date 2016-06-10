<eventos>
  <fecha>2012-10-05</fecha>
  {for $evento in doc('fdc-eventos-2012.xml')//ROW/DATE[contains(., '2012-10-05')]/..
    return (
      <evento>
        <hora>{ $evento/TIME/text() }</hora>
        {for $obra in doc('fdc-obras-2012.xml')//ROW
          where $obra/ID_PLAY[contains(., $evento/ID_PLAY/text())]
          return (<titulo> { $obra/TITLE/text()} </titulo>, <descripcion> { $obra/SYNOPSIS_ES/text() } </descripcion>)
        }
      </evento>
    )
  }
</eventos>