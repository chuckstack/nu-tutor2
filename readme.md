# Nushell Tutor Generator

The purpose of this repository is to help users create interactive Nushell tutors.

It converts a markdown file into an interactive Nushell script.

## Why Use a Tutor

Tutors help guide users in how to think in a given domain. This example shows how to think in the `nu` or Nushell domain.

Command line help references (example: `ls --help`) are great to see the details of any command; however, they sometimes lack the ability to create or convey the bigger picture.

## Example

We included a sample `tutor2.md` markdown file to make the process easy to understand and test.

```nu
source injest.nu
open tutor2.md | injest | save -f tutor2.nu
source tutor2.nu
```

You can now:

- Type `tutor2` to see the introduction.
- Type `tutor2 list` to see all tutor2 commands.
- Type `tutor2 <tab>` to interactively explore the tutor2 commands.

Note that each command can represent anything: concept, convention, process, an actual command.

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

