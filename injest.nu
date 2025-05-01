#example usage:
# source injest.nu
# open sample.md | injest

def injest [] {
    let $source_table = $in 
    | split row -r '(?m)(?<=^)(?=#)' 
    | enumerate 
    | where (($it.item | str length) > 0)
    | insert indention 0 
    | insert command "" 
    | insert command-prefix "" 
    | insert body ""

    #todo: need to update the $source_table to populate the indention column with the number of #
    let $updated_table = $source_table
    | each { |row|
        #$row | update indention 5
        $row | update indention ($row.item | split row ' ' | first | str length)
    }
    echo $updated_table
}
