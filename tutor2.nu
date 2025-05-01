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

With the `tutor` command, you'll be able to learn a lot about how Nushell
works along with many fun tips and tricks to speed up everyday tasks.

To get started, you can use `tutor begin`, and to see all the available
tutorials just run `tutor list`.

'#
| nu-light
}

export def "tutor2 begin" [] {
r#'
Nushell is a structured shell and programming language. One way to begin
using it is to try a few of the commands.

The first command to try is `ls`. The `ls` command will show you a list
of the files in the current directory. Notice that these files are shown
as a table. Each column of this table not only tells us what is being
shown, but also gives us a way to work with the data.

You can combine the `ls` command with other commands using the pipeline
symbol '|'. This allows data to flow from one command to the next.

For example, if we only wanted the name column, we could do:
```
ls | select name
```
Notice that we still get a table, but this time it only has one column:
the name column.

You can continue to learn more about tables by running:
```
tutor tables
```
If at any point, you'd like to restart this tutorial, you can run:
```
tutor begin
```
'#
| nu-light
}

export def "tutor2 table" [] {
r#'
The most common form of data in Nushell is the table. Tables contain rows and
columns of data. In each cell of the table, there is data that you can access
using Nushell commands.

To get the 3rd row in the table, you can use the `select` command:
```
ls | select 2
```
This will get the 3rd (note that `select` is zero-based) row in the table created
by the `ls` command. You can use `select` on any table created by other commands
as well.

You can also access the column of data in one of two ways. If you want
to keep the column as part of a new table, you can use `select`.
```
ls | select name
```
This runs `ls` and returns only the "name" column of the table.

If, instead, you'd like to get access to the values inside of the column, you
can use the `get` command.
```
ls | get name
```
This allows us to get to the list of strings that are the filenames rather
than having a full table. In some cases, this can make the names easier to
work with.

You can continue to learn more about working with cells of the table by
running:
```
tutor cells
```
'#
| nu-light
}

export def "tutor2 cell" [] {
r#'
Working with cells of data in the table is a key part of working with data in
Nushell. Because of this, there is a rich list of commands to work with cells
as well as handy shorthands for accessing cells.

Cells can hold simple values like strings and numbers, or more complex values
like lists and tables.

To reach a cell of data from a table, you can combine a row operation and a
column operation.
```
ls | select 4 | get name
```
You can combine these operations into one step using a shortcut.
```
(ls).4.name
```
Names/strings represent columns names and numbers represent row numbers.

The `(ls)` is a form of expression. You can continue to learn more about
expressions by running:
```
tutor expressions
```
You can also learn about these cell shorthands by running:
```
tutor shorthands
```
'#
| nu-light
}

export def "tutor2 expression" [] {
r#'
Expressions give you the power to mix calls to commands with math. The
simplest expression is a single value like a string or number.
```
3
```
Expressions can also include math operations like addition or division.
```
10 / 2
```
Normally, an expression is one type of operation: math or commands. You can
mix these types by using subexpressions. Subexpressions are just like
expressions, but they're wrapped in parentheses `()`.
```
10 * (3 + 4)
```
Here we use parentheses to create a higher math precedence in the math
expression.
```
echo (2 + 3)
```
You can continue to learn more about the `echo` command by running:
```
tutor echo
```
'#
| nu-light
}

export def "tutor2 echo" [] {
r#'
The `echo` command in Nushell is a powerful tool for not only seeing values,
but also for creating new ones.
```
echo "Hello"
```
You can echo output. This output, if it's not redirected using a "|" pipeline
will be displayed to the screen.
```
echo 1..10
```
You can also use echo to work with individual values of a range. In this
example, `echo` will create the values from 1 to 10 as a list.
```
echo 1 2 3 4 5
```
You can also create lists of values by passing `echo` multiple arguments.
This can be helpful if you want to later processes these values.

The `echo` command can pair well with the `each` command which can run
code on each row, or item, of input.

You can continue to learn more about the `each` command by running:
```
tutor each
```
'#
| nu-light
}

export def "tutor2 each" [] {
r#'
The `each` command gives us a way of working with the individual elements
(sometimes called 'rows') of a list one at a time. It reads these in from
the pipeline and runs a block on each one. A block is a group of pipelines.
```
echo 1 2 3 | each { |it| $it + 10}
```
This example iterates over each element sent by `echo`, giving us three new
values that are the original value + 10. Here, the `$it` is a variable that
is the name given to the block's parameter by default.

You can learn more about blocks by running:
```
tutor blocks
```
You can also learn more about variables by running:
```
tutor variables
```
'#
| nu-light
}

export def "tutor2 variable" [] {
r#'
Variables are an important way to store values to be used later. To create a
variable, you can use the `let` keyword. The `let` command will create a
variable and then assign it a value in one step.
```
let $x = 3
```
Once created, we can refer to this variable by name.
```
$x
```
Nushell also comes with built-in variables. The `$nu` variable is a reserved
variable that contains a lot of information about the currently running
instance of Nushell. The `$it` variable is the name given to block parameters
if you don't specify one. And `$in` is the variable that allows you to work
with all of the data coming in from the pipeline in one place.

'#
| nu-light
}

export def "tutor2 block" [] {
r#'
Blocks are a special form of expression that hold code to be run at a later
time. Often, you'll see blocks as one of the arguments given to commands
like `each` and `if`.
```
ls | each {|x| $x.name}
```
The above will create a list of the filenames in the directory.
```
if true { echo "it's true" } else { echo "it's not true" }
```
This `if` call will run the first block if the expression is true, or the
second block if the expression is false.

"#
}

fn shorthand_tutor() -> &'static str {
    r#"
You can access data in a structure via a shorthand notation called a "cell path",
sometimes called a "column path". These paths allow you to go from a structure to
rows, columns, or cells inside of the structure.

Shorthand paths are made from rows numbers, column names, or both. You can use
them on any variable or subexpression.
```
$env.PWD
```
The above accesses the built-in `$env` variable, gets its table, and then uses
the shorthand path to retrieve only the cell data inside the "PWD" column.
```
(ls).name.4
```
This will retrieve the cell data in the "name" column on the 5th row (note:
row numbers are zero-based).

For tables, rows and columns don't need to come in any specific order. You can
produce the same value using:
```
(ls).4.name
```
'#
| nu-light
}

export def "tutor2 shorthand" [] {
r#'
You can access data in a structure via a shorthand notation called a "cell path",
sometimes called a "column path". These paths allow you to go from a structure to
rows, columns, or cells inside of the structure.

Shorthand paths are made from rows numbers, column names, or both. You can use
them on any variable or subexpression.
```
$env.PWD
```
The above accesses the built-in `$env` variable, gets its table, and then uses
the shorthand path to retrieve only the cell data inside the "PWD" column.
```
(ls).name.4
```
This will retrieve the cell data in the "name" column on the 5th row (note:
row numbers are zero-based).

For tables, rows and columns don't need to come in any specific order. You can
produce the same value using:
```
(ls).4.name
```
'#
| nu-light
}

