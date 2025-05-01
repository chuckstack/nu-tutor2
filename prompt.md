I am using nushell.

We are starting with a markdown file.

```nu
open sample.md
```

Here is the output
```md
# sample

Sample is a nu command.

## room

The `sample room` command measures your room characteristics.

## house

The `sample house` command measure your house characteristics.

The following works. I now need to remove any row that is empty. For example, the 0 index row is empty
```

Here is a nushell script named injest.nu
```nu
#example usage:
# source injest.nu
# open sample.md | injest

def injest [] {
    $in | split row -r '(?m)(?<=^)(?=#)' | enumerate | where (($it.item | str length) > 0)
}
```

Here is the output:
```nu
~/code/nu-tutor-v1> open sample.md | injest
╭───┬────────────────────────────────────────────────────────────────╮
│ # │                              item                              │
├───┼────────────────────────────────────────────────────────────────┤
│ 1 │ # sample                                                       │
│   │                                                                │
│   │ Sample is a nu command.                                        │
│   │                                                                │
│   │                                                                │
│ 2 │ ## room                                                        │
│   │                                                                │
│   │ The `sample room` command measures your room characteristics.  │
│   │                                                                │
│   │                                                                │
│ 3 │ ## house                                                       │
│   │                                                                │
│   │ The `sample house` command measure your house characteristics. │
│   │                                                                │
╰───┴────────────────────────────────────────────────────────────────╯
```

Now, how do I add a new column to the above table with a hardcoded value of 'test'
