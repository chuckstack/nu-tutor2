
        def nu-light [] {
            $in
            | split row '`'
            | enumerate
            | each { if $in.index mod 2 == 1 { $in.item | nu-highlight } else { $in.item } }
            | str join
        }  
 export def "sample" [] {r#' 
Sample is a nu command.

This is really cool
'#
 | nu-light 
}
 export def "sample room" [] {r#' 
The `sample room` command measures your room characteristics.

```bash
some code
```

```nu
nu code
```
'#
 | nu-light 
}
 export def "sample house" [] {r#' 
The `sample house` command measure your house characteristics.

second line
'#
 | nu-light 
}
 export def "tickle" [] {r#' 
places you can tickle
'#
 | nu-light 
}
 export def "tickle arm" [] {r#' 
good starting point
'#
 | nu-light 
}
 export def "tickle ribs" [] {r#' 
best spot
'#
 | nu-light 
}
 export def "tickle ribs rib1" [] {r#' 
smallest rib
'#
 | nu-light 
}
 export def "tickle ribs rib2" [] {r#' 
most sensitive rib
'#
 | nu-light 
}
 export def "engage" [] {r#' 
time to engage someone
'#
 | nu-light 
}
 export def "engage spouse" [] {r#' 
best person to engage'#
 | nu-light 
}
 
 export def "sample list" [] {r#'  - sample
    - room
    - house
  - tickle
    - arm
    - ribs
      - rib1
      - rib2
  - engage
    - spouse'#
 | nu-light 
}
