# Nushell Tutor Generator

The purpose of this repository is to help users create interactive Nushell tutors. It converts a markdown file into an interactive Nushell script.

What is special about this concept is that a single markdown file can published to both a website (using github or `mdbook`) and a Nushell environment without repeating yourself.

## Why Use a Tutor

Tutors help guide users in how to think in a given domain. The `tutor2` example included in this repository shows how to think in the `nu` or Nushell domain.

Command line help references (example: `ls --help`) are great to see the details of any command; however, they sometimes lack the ability to create or convey the bigger picture. Iterative tutors complement and support command help nicely.

## Example

We include a sample `tutor2.md` markdown file to make the process easy to understand and test.

```nu
source injest.nu
open tutor2.md | injest | save -f tutor2.nu
```

```nu
source tutor2.nu
```

You can now:

- Type `tutor2` to see the introduction.
- Type `tutor2 list` to see all tutor2 commands.
- Type `tutor2 <tab>` to interactively explore the tutor2 commands.

Note that each tutor command can represent anything: a concept, a convention, a process, an actual command.

Also note the hierarchy of commands in `tutor2 list`. This hierarchy allows you to represent more complex concepts while still presenting bite-sized chunks of information.

```txt
~> tutor2 list
  - tutor2
    - begin
    - tables
    - cells
    - expressions
    - echo
    - each
    - variables
    - blocks
    - shorthands
```

## Markdown Source

Here are the guidelines for creating your markdown tutor file:

### Tutor Name

Use H1 heading to name your tutor:

```md
# tutor_name

This is the text that describes your tutor.
```

### Tutor Subcommands

Use H2 or greater to define subcommands:

```md
## list

This is a `list` subcommand to `tutor_name` defined above.
```

Do not jump by more than one heading number at a time when increasing headings; however, it is OK to jump when decreasing headings.

Here is an example:

```md
# tutor_name
## list
### states
### countries
### continents
##### bad #not allowed to jump from h3 to h5+
```

### Documentation Links

Most terminals support clicking on hyperlinks. This means markdown html links also work from the terminal. This helps bring your web-based documentation to life.

## Sample Alternative

We include a sample `sample-alt.md` markdown file that includes more heading/indentation examples:

```nu
source injest.nu
open sample-alt.md | injest | save -f sample.nu
source sample.nu
```

