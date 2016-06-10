let $row_events := doc("fdc-eventos-2012.xml")//ROW
let $row_obras := doc("fdc-obras-2012.xml")//ROW
let $row_artists := doc("fdc-artistas-2012.xml")//ROW

for $row_event in $row_events
  for $row_obra in $row_obras
    let $obras := $row_obra/ID_PLAY[contains(.,$row_event/ID_PLAY/text())]/..
    for $obra in $obras
      return <evento>{$row_event/TIME, $obra/SYNOPSIS_ES, $obra/TITLE}</evento>
