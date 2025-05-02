        def nu-light [] {
            $in
            | split row '`'
            | enumerate
            | each { if $in.index mod 2 == 1 { $in.item | nu-highlight } else { $in.item } }
            | str join
        }
 export def " sample" [] {r#'
Sample is a nu command.

This is really cool
'#}
 export def "sample room" [] {r#'
The `sample room` command measures your room characteristics.

```bash
some code
```

```nu
nu code
```
'#}
 export def "sample house" [] {r#'
The `sample house` command measure your house characteristics.

second line
'#}
 export def " tickle" [] {r#'
places you can tickle
'#}
 export def "tickle arm" [] {r#'
good starting point
'#}
 export def "tickle ribs" [] {r#'
best spot
'#}
 export def "tickle ribs rib1" [] {r#'
smallest rib
'#}
 export def "tickle ribs rib2" [] {r#'
most sensitive rib
'#}
 export def " engage" [] {r#'
time to engage someone
'#}
 export def "engage spouse" [] {r#'
best person to engage'#}
