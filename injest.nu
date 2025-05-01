#example usage:
# source injest.nu
# open sample.md | injest

def injest [] {
    # split markdown into headings and create info columns
    let $table_source = $in 
    | split row -r '(?m)(?<=^)(?=#)' 
    | enumerate 
    | where (($it.item | str length) > 0)
    | insert indent 0 
    | insert command "" 
    | insert command-prefix "" 
    | insert body ""

    # find command dept (number of #'s)
    let $table_indent = $table_source
    | each { |row|
        #$row | update indent 5
        $row | update indent (($row.item | split row ' ' | first | str length) - 1)
    }

    # set command
    let $table_command = $table_indent
    | each { |row|
        #$row | update indent 5
        $row | update command ($row.item |  str replace -r '^#+\s' '' | split words | first)
    }

    echo $table_command
}
