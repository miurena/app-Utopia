import module namespace m='http://www.tei-c.org/pm/models/docx/tei' at '/db/apps/Github/transform/docx-tei.xql';

declare variable $xml external;

declare variable $parameters external;

let $options := map {
    "styles": ["transform/docx.css"],
    "collection": "/db/apps/Github/transform",
    "parameters": if (exists($parameters)) then $parameters else map {}
}
return m:transform($options, $xml)