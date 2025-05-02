#example usage:
# source injest.nu
# open sample.md | injest

def injest [] {
    # split markdown into headings and create info columns
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
    | insert command-prefix []

    ## find command depth (number of #'s)
    #$table_source = $table_source
    #| each { |row|
    #    $row | update indent (($row.item | split row ' ' | first | str length) - 1)
    #}

    ## set command
    #$table_source = $table_source
    #| each { |row|
    #    $row | update command ($row.item |  str replace -r '^#+\s' '' | split words | first)
    #}

    ## set body
    #$table_source = $table_source
    #| each { |row|
    #    $row | update body ($row.item | lines | skip 1 | str join "\n" )
    #}

    # set subcommand
    # re-index table (enumerate) to account for previously removed rows
    mut result = []
    mut previous_command = ""
    mut previous_command_list = []
    mut previous_indent = 0

    #$table_source = $table_source | enumerate | flatten
    #| each { |row|
    #    #todo: getting error
    #    if $row.indent > $previous_indent {
    #        #need to check to see if jump is > 1; then error
    #        $previous_command_list | append $previous_command
    #        $row | update command-prefix $previous_command_list
    #    } else if $row.indent < $previous_indent {
    #        $previous_command_list | drop -1
    #        $row | update command-prefix $previous_command_list
    #    } else {
    #        $row | update command-prefix $previous_command_list
    #    }
    #    #closing
    #    $previous_command = $row.command
    #    $previous_indent = $row.indent
    #    $row
    #}

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

    $result
}
