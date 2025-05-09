# See readme.md for details

def injest [] {
    # split markdown into headings and create info columns

    #TODO: validations and error checking
    #cannot repeat command at the same level
    #cannot jump more than 1 heading level when creating subcommands (ok to skip going back)

    let list_indent_char = "  "
    let list_indent_id = "- "

    mut table_source = $in 
    | split row -r '(?m)(?<=^)(?=#)' 
    | enumerate 
    | where (($it.item | str length) > 0)
    | insert indent { |row|
        ($row.item | split row ' ' | first | str length) - 1
    }
    | insert command { |row|
        $row.item |  str replace -r '^#+\s' '' | split words | first
    } 
    | insert body { |row|
        $row.item | lines | skip 1 | str join "\n"
    }
    | insert list { |row|
        (0..$row.indent | each {$list_indent_char} | str join) | append $list_indent_id | append $row.command | str join
    }
    | insert command-prefix []

    # set subcommand (command prefix)
    mut result = []
    mut previous_command = ""
    mut previous_command_list = []
    mut previous_indent = 0

    for row in $table_source {
        let new_row = if $row.indent > $previous_indent {
            #need to check to see if jump is > 1; then error
            $previous_command_list = ($previous_command_list | append $previous_command)
            $row | update command-prefix $previous_command_list
        } else if $row.indent < $previous_indent {
            $previous_command_list = ($previous_command_list | drop ($previous_indent - $row.indent))
            $row | update command-prefix $previous_command_list
        } else {
            $row | update command-prefix $previous_command_list
        }

        $previous_command = $row.command
        $previous_indent = $row.indent
        $result = ($result | append $new_row)
    }

    let title_command = $result | first | get command

    let nu_light = r#'
        def nu-light [] {
            $in
            | split row '`'
            | enumerate
            | each { if $in.index mod 2 == 1 { $in.item | nu-highlight } else { $in.item } }
            | str join
        } '#

    let nu_command = $result 
    | each { 
        |row| $"export def \"($row.command-prefix | str join ' ')($row.command-prefix | length | if $in > 0 { ' ' } else { '' })($row.command)\" [] {r#' ($row.body)'#\n | nu-light \n}\n"
    } 
    | str join " "

    # define list command
    let list_command = $result | get list | str join "\n"
    let list_command_def = $"export def \"($title_command) list\" [] {r#'($list_command)'#\n | nu-light \n}\n"

    $"($nu_light) \n ($nu_command) \n ($list_command_def)"
}
