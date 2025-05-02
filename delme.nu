
#export def "tutor2 changeme" [] {
#r#'
#'#
#| nu-light
#}

def nu-light [] {
    $in
    | split row '`'
    | enumerate
    | each { if $in.index mod 2 == 1 { $in.item | nu-highlight } else { $in.item } }
    | str join
}

export def main [] {
r#'
Welcome to the Nushell tutorial!

With the `tutor2` command, you'll be able to learn a lot about how Nushell
works along with many fun tips and tricks to speed up everyday tasks.

To get started, you can use `tutor2 begin`, and to see all the available
tutorials just run `tutor2 list`.

'#
| nu-light
}

export def "tutor2 list" [] {
r#'
to be implemented - list all commands

'#
| nu-light
}

export def "tutor3" [] {
r#'
to be implemented - list all commands

'#
| nu-light
}

