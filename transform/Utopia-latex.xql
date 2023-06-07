(:~

    Transformation module generated from TEI ODD extensions for processing models.
    ODD: /db/apps/Github/resources/odd/Utopia.odd
 :)
xquery version "3.1";

module namespace model="http://www.tei-c.org/pm/models/Utopia/latex";

declare default element namespace "http://www.tei-c.org/ns/1.0";

declare namespace xhtml='http://www.w3.org/1999/xhtml';

declare namespace ns='https://miurena.github.io/';

declare namespace pb='http://teipublisher.com/1.0';

import module namespace css="http://www.tei-c.org/tei-simple/xquery/css";

import module namespace latex="http://www.tei-c.org/tei-simple/xquery/functions/latex";

(: generated template function for element spec: formula :)
declare %private function model:template-formula2($config as map(*), $node as node()*, $params as map(*)) {
    ``[\begin{equation}`{string-join($config?apply-children($config, $node, $params?content))}`\end{equation}]``
};
(: generated template function for element spec: formula :)
declare %private function model:template-formula3($config as map(*), $node as node()*, $params as map(*)) {
    ``[\begin{math}`{string-join($config?apply-children($config, $node, $params?content))}`\end{math}]``
};
(:~

    Main entry point for the transformation.
    
 :)
declare function model:transform($options as map(*), $input as node()*) {
        
    let $config :=
        map:merge(($options,
            map {
                "output": ["latex"],
                "odd": "/db/apps/Github/resources/odd/Utopia.odd",
                "apply": model:apply#2,
                "apply-children": model:apply-children#3
            }
        ))
    let $config := latex:init($config, $input)
    
    return (
        
        let $output := model:apply($config, $input)
        return
            latex:finish($config, $output)
    )
};

declare function model:apply($config as map(*), $input as node()*) {
        let $parameters := 
        if (exists($config?parameters)) then $config?parameters else map {}
        let $mode := 
        if (exists($config?mode)) then $config?mode else ()
        let $trackIds := 
        $parameters?track-ids
        let $get := 
        model:source($parameters, ?)
    return
    $input !         (
            let $node := 
                .
            return
                            typeswitch(.)
                    case element(app) return
                        latex:section($config, ., ("tei-app", css:map-rend-to-class(.)), .)
                    case element(ab) return
                        latex:paragraph($config, ., ("tei-ab", css:map-rend-to-class(.)), .)
                    case element(author) return
                        if (ancestor::teiHeader) then
                            latex:block($config, ., ("tei-author1", css:map-rend-to-class(.)), .)
                        else
                            latex:inline($config, ., ("tei-author2", css:map-rend-to-class(.)), .)
                    case element(back) return
                        latex:block($config, ., ("tei-back", css:map-rend-to-class(.)), .)
                    case element(bibl) return
                        if (parent::listBibl) then
                            latex:listItem($config, ., ("tei-bibl1", css:map-rend-to-class(.)), ., ())
                        else
                            latex:inline($config, ., ("tei-bibl2", css:map-rend-to-class(.)), .)
                    case element(body) return
                        (
                            latex:index($config, ., ("tei-body1", css:map-rend-to-class(.)), ., 'toc'),
                            latex:block($config, ., ("tei-body2", css:map-rend-to-class(.)), .)
                        )

                    case element(cb) return
                        latex:break($config, ., ("tei-cb", css:map-rend-to-class(.)), ., 'column', @n)
                    case element(corr) return
                        if (parent::choice and count(parent::*/*) gt 1) then
                            (: simple inline, if in parent choice. :)
                            latex:inline($config, ., ("tei-corr1", css:map-rend-to-class(.)), .)
                        else
                            latex:inline($config, ., ("tei-corr2", css:map-rend-to-class(.)), .)
                    case element(date) return
                        latex:inline($config, ., ("tei-date2", css:map-rend-to-class(.)), .)
                    case element(dateline) return
                        latex:block($config, ., ("tei-dateline", css:map-rend-to-class(.)), .)
                    case element(del) return
                        latex:inline($config, ., ("tei-del", css:map-rend-to-class(.)), .)
                    case element(div) return
                        if (@type='title_page') then
                            latex:block($config, ., ("tei-div1", css:map-rend-to-class(.)), .)
                        else
                            if (parent::body or parent::front or parent::back) then
                                latex:section($config, ., ("tei-div2", css:map-rend-to-class(.)), .)
                            else
                                latex:block($config, ., ("tei-div3", css:map-rend-to-class(.)), .)
                    case element(docTitle) return
                        latex:block($config, ., css:get-rendition(., ("tei-docTitle", css:map-rend-to-class(.))), .)
                    case element(edition) return
                        if (ancestor::teiHeader) then
                            latex:block($config, ., ("tei-edition", css:map-rend-to-class(.)), .)
                        else
                            $config?apply($config, ./node())
                    case element(floatingText) return
                        latex:block($config, ., ("tei-floatingText", css:map-rend-to-class(.)), .)
                    case element(foreign) return
                        latex:inline($config, ., ("tei-foreign", css:map-rend-to-class(.)), .)
                    case element(formula) return
                        if (@rendition='simple:display') then
                            latex:block($config, ., ("tei-formula1", css:map-rend-to-class(.)), .)
                        else
                            if (@rend="display") then
                                let $params := 
                                    map {
                                        "content": string()
                                    }

                                                                let $content := 
                                    model:template-formula2($config, ., $params)
                                return
                                                                latex:inline(map:merge(($config, map:entry("template", true()))), ., ("tei-formula2", css:map-rend-to-class(.)), $content)
                            else
                                if (@rend='display') then
                                    (: No function found for behavior: webcomponent :)
                                    $config?apply($config, ./node())
                                else
                                    (: More than one model without predicate found for ident formula. Choosing first one. :)
                                    let $params := 
                                        map {
                                            "content": string()
                                        }

                                                                        let $content := 
                                        model:template-formula3($config, ., $params)
                                    return
                                                                        latex:inline(map:merge(($config, map:entry("template", true()))), ., ("tei-formula3", css:map-rend-to-class(.)), $content)
                    case element(front) return
                        latex:block($config, ., ("tei-front", css:map-rend-to-class(.)), .)
                    case element(fw) return
                        if (ancestor::p or ancestor::ab) then
                            latex:inline($config, ., ("tei-fw1", css:map-rend-to-class(.)), .)
                        else
                            latex:block($config, ., ("tei-fw2", css:map-rend-to-class(.)), .)
                    case element(g) return
                        if (not(text())) then
                            latex:glyph($config, ., ("tei-g1", css:map-rend-to-class(.)), .)
                        else
                            latex:inline($config, ., ("tei-g2", css:map-rend-to-class(.)), .)
                    case element(graphic) return
                        latex:graphic($config, ., ("tei-graphic", css:map-rend-to-class(.)), ., @url, @width, @height, @scale, desc)
                    case element(group) return
                        latex:block($config, ., ("tei-group", css:map-rend-to-class(.)), .)
                    case element(head) return
                        if ($parameters?header='short') then
                            latex:inline($config, ., ("tei-head1", css:map-rend-to-class(.)), replace(string-join(.//text()[not(parent::ref)]), '^(.*?)[^\w]*$', '$1'))
                        else
                            if (parent::figure) then
                                latex:block($config, ., ("tei-head2", css:map-rend-to-class(.)), .)
                            else
                                if (parent::table) then
                                    latex:block($config, ., ("tei-head3", css:map-rend-to-class(.)), .)
                                else
                                    if (parent::lg) then
                                        latex:block($config, ., ("tei-head4", css:map-rend-to-class(.)), .)
                                    else
                                        if (parent::list) then
                                            latex:block($config, ., ("tei-head5", css:map-rend-to-class(.)), .)
                                        else
                                            if (parent::div) then
                                                latex:heading($config, ., ("tei-head6", css:map-rend-to-class(.)), ., count(ancestor::div))
                                            else
                                                latex:block($config, ., ("tei-head7", css:map-rend-to-class(.)), .)
                    case element(hi) return
                        latex:inline($config, ., css:get-rendition(., ("tei-hi", css:map-rend-to-class(.))), .)
                    case element(l) return
                        latex:block($config, ., css:get-rendition(., ("tei-l", css:map-rend-to-class(.))), .)
                    case element(licence) return
                        latex:omit($config, ., ("tei-licence2", css:map-rend-to-class(.)), .)
                    case element(lb) return
                        latex:break($config, ., css:get-rendition(., ("tei-lb", css:map-rend-to-class(.))), ., 'line', @n)
                    case element(lg) return
                        latex:block($config, ., ("tei-lg", css:map-rend-to-class(.)), .)
                    case element(list) return
                        latex:list($config, ., css:get-rendition(., ("tei-list", css:map-rend-to-class(.))), item, ())
                    case element(listBibl) return
                        if (bibl) then
                            latex:list($config, ., ("tei-listBibl1", css:map-rend-to-class(.)), ., ())
                        else
                            latex:block($config, ., ("tei-listBibl2", css:map-rend-to-class(.)), .)
                    case element(note) return
                        latex:note($config, ., ("tei-note", css:map-rend-to-class(.)), ., @place, @n)
                    case element(opener) return
                        latex:block($config, ., ("tei-opener", css:map-rend-to-class(.)), .)
                    case element(p) return
                        latex:paragraph($config, ., css:get-rendition(., ("tei-p2", css:map-rend-to-class(.))), .)
                    case element(pb) return
                        latex:break($config, ., css:get-rendition(., ("tei-pb", css:map-rend-to-class(.))), ., 'page', (concat(if(@n) then concat(@n,' ') else '',if(@facs) then                   concat('@',@facs) else '')))
                    case element(publicationStmt) return
                        latex:omit($config, ., ("tei-publicationStmt2", css:map-rend-to-class(.)), .)
                    case element(q) return
                        if (l) then
                            latex:block($config, ., css:get-rendition(., ("tei-q1", css:map-rend-to-class(.))), .)
                        else
                            if (ancestor::p or ancestor::cell) then
                                latex:inline($config, ., css:get-rendition(., ("tei-q2", css:map-rend-to-class(.))), .)
                            else
                                latex:block($config, ., css:get-rendition(., ("tei-q3", css:map-rend-to-class(.))), .)
                    case element(quote) return
                        if (ancestor::p) then
                            (: If it is inside a paragraph then it is inline, otherwise it is block level :)
                            latex:inline($config, ., css:get-rendition(., ("tei-quote1", css:map-rend-to-class(.))), .)
                        else
                            (: If it is inside a paragraph then it is inline, otherwise it is block level :)
                            latex:block($config, ., css:get-rendition(., ("tei-quote2", css:map-rend-to-class(.))), .)
                    case element(ref) return
                        if (@target) then
                            latex:link($config, ., ("tei-ref1", css:map-rend-to-class(.)), ., @target, map {})
                        else
                            if (not(node())) then
                                latex:link($config, ., ("tei-ref2", css:map-rend-to-class(.)), @target, @target, map {})
                            else
                                latex:inline($config, ., ("tei-ref3", css:map-rend-to-class(.)), .)
                    case element(role) return
                        latex:block($config, ., ("tei-role", css:map-rend-to-class(.)), .)
                    case element(roleDesc) return
                        latex:block($config, ., ("tei-roleDesc", css:map-rend-to-class(.)), .)
                    case element(seg) return
                        if (@n) then
                            (: No function found for behavior: webcomponent :)
                            $config?apply($config, ./node())
                        else
                            latex:inline($config, ., css:get-rendition(., ("tei-seg2", css:map-rend-to-class(.))), .)
                    case element(sic) return
                        if (parent::choice and count(parent::*/*) gt 1) then
                            latex:inline($config, ., ("tei-sic1", css:map-rend-to-class(.)), .)
                        else
                            latex:inline($config, ., ("tei-sic2", css:map-rend-to-class(.)), .)
                    case element(table) return
                        latex:table($config, ., ("tei-table", css:map-rend-to-class(.)), ., map {})
                    case element(fileDesc) return
                        if ($parameters?header='short') then
                            (
                                latex:block($config, ., ("tei-fileDesc1", "header-short", css:map-rend-to-class(.)), titleStmt),
                                latex:block($config, ., ("tei-fileDesc2", "header-short", css:map-rend-to-class(.)), editionStmt),
                                latex:block($config, ., ("tei-fileDesc3", "header-short", css:map-rend-to-class(.)), publicationStmt)
                            )

                        else
                            latex:title($config, ., ("tei-fileDesc4", css:map-rend-to-class(.)), titleStmt)
                    case element(profileDesc) return
                        latex:omit($config, ., ("tei-profileDesc", css:map-rend-to-class(.)), .)
                    case element(revisionDesc) return
                        latex:omit($config, ., ("tei-revisionDesc", css:map-rend-to-class(.)), .)
                    case element(encodingDesc) return
                        latex:omit($config, ., ("tei-encodingDesc", css:map-rend-to-class(.)), .)
                    case element(teiHeader) return
                        latex:metadata($config, ., ("tei-teiHeader1", css:map-rend-to-class(.)), .)
                    case element(TEI) return
                        latex:document($config, ., ("tei-TEI", css:map-rend-to-class(.)), .)
                    case element(text) return
                        latex:body($config, ., ("tei-text", css:map-rend-to-class(.)), .)
                    case element(time) return
                        latex:inline($config, ., ("tei-time", css:map-rend-to-class(.)), .)
                    case element(title) return
                        if ($parameters?header='short') then
                            latex:heading($config, ., ("tei-title1", css:map-rend-to-class(.)), ., 5)
                        else
                            if (parent::titleStmt/parent::fileDesc) then
                                (
                                    if (preceding-sibling::title) then
                                        latex:text($config, ., ("tei-title2", css:map-rend-to-class(.)), ' — ')
                                    else
                                        (),
                                    latex:inline($config, ., ("tei-title3", css:map-rend-to-class(.)), .)
                                )

                            else
                                if (not(@level) and parent::bibl) then
                                    latex:inline($config, ., ("tei-title4", css:map-rend-to-class(.)), .)
                                else
                                    if (@level='m' or not(@level)) then
                                        (
                                            latex:inline($config, ., ("tei-title5", css:map-rend-to-class(.)), .),
                                            if (ancestor::biblFull) then
                                                latex:text($config, ., ("tei-title6", css:map-rend-to-class(.)), ', ')
                                            else
                                                ()
                                        )

                                    else
                                        if (@level='s' or @level='j') then
                                            (
                                                latex:inline($config, ., ("tei-title7", css:map-rend-to-class(.)), .),
                                                if (following-sibling::* and     (  ancestor::biblFull)) then
                                                    latex:text($config, ., ("tei-title8", css:map-rend-to-class(.)), ', ')
                                                else
                                                    ()
                                            )

                                        else
                                            if (@level='u' or @level='a') then
                                                (
                                                    latex:inline($config, ., ("tei-title9", css:map-rend-to-class(.)), .),
                                                    if (following-sibling::* and     (    ancestor::biblFull)) then
                                                        latex:text($config, ., ("tei-title10", css:map-rend-to-class(.)), '. ')
                                                    else
                                                        ()
                                                )

                                            else
                                                latex:inline($config, ., ("tei-title11", css:map-rend-to-class(.)), .)
                    case element(titlePage) return
                        latex:block($config, ., css:get-rendition(., ("tei-titlePage", css:map-rend-to-class(.))), .)
                    case element(titlePart) return
                        latex:block($config, ., css:get-rendition(., ("tei-titlePart", css:map-rend-to-class(.))), .)
                    case element(titleStmt) return
                        (: No function found for behavior: meta :)
                        $config?apply($config, ./node())
                    case element(w) return
                        latex:inline($config, ., ("tei-w", css:map-rend-to-class(.)), .)
                    case element() return
                        if (namespace-uri(.) = 'http://www.tei-c.org/ns/1.0') then
                            $config?apply($config, ./node())
                        else
                            .
                    case text() | xs:anyAtomicType return
                        latex:escapeChars(.)
                    default return 
                        $config?apply($config, ./node())

        )

};

declare function model:apply-children($config as map(*), $node as element(), $content as item()*) {
        
    if ($config?template) then
        $content
    else
        $content ! (
            typeswitch(.)
                case element() return
                    if (. is $node) then
                        $config?apply($config, ./node())
                    else
                        $config?apply($config, .)
                default return
                    latex:escapeChars(.)
        )
};

declare function model:source($parameters as map(*), $elem as element()) {
        
    let $id := $elem/@exist:id
    return
        if ($id and $parameters?root) then
            util:node-by-id($parameters?root, $id)
        else
            $elem
};

declare function model:process-annotation($html, $context as node()) {
        
    let $classRegex := analyze-string($html/@class, '\s?annotation-([^\s]+)\s?')
    return
        if ($classRegex//fn:match) then (
            if ($html/@data-type) then
                ()
            else
                attribute data-type { ($classRegex//fn:group)[1]/string() },
            if ($html/@data-annotation) then
                ()
            else
                attribute data-annotation {
                    map:merge($context/@* ! map:entry(node-name(.), ./string()))
                    => serialize(map { "method": "json" })
                }
        ) else
            ()
                    
};

declare function model:map($html, $context as node(), $trackIds as item()?) {
        
    if ($trackIds) then
        for $node in $html
        return
            typeswitch ($node)
                case document-node() | comment() | processing-instruction() return 
                    $node
                case element() return
                    if ($node/@class = ("footnote")) then
                        if (local-name($node) = 'pb-popover') then
                            ()
                        else
                            element { node-name($node) }{
                                $node/@*,
                                $node/*[@class="fn-number"],
                                model:map($node/*[@class="fn-content"], $context, $trackIds)
                            }
                    else
                        element { node-name($node) }{
                            attribute data-tei { util:node-id($context) },
                            $node/@*,
                            model:process-annotation($node, $context),
                            $node/node()
                        }
                default return
                    <pb-anchor data-tei="{ util:node-id($context) }">{$node}</pb-anchor>
    else
        $html
                    
};

