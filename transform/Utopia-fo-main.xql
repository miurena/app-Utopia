import module namespace m='http://www.tei-c.org/pm/models/Utopia/fo' at '/db/apps/Github/transform/Utopia-fo.xql';

declare variable $xml external;

declare variable $parameters external;

let $options := map {
    "styles": ["transform/Utopia.css"],
    "collection": "/db/apps/Github/transform",
    "parameters": if (exists($parameters)) then $parameters else map {}
}
return m:transform($options, $xml)