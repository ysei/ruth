# Ruth

A little Forth-like language written in Ruby.


## Running Ruth

There's a rake task to run the repl:

    rake repl

Currently, it supports basic math operations and defining your own words.

To see what words are available, start the repl, type `words`, and hit enter:

    ruth> words
    exit words .ds . + - * / : ;


## Ruth Words

`exit`
- quits the REPL

`words`
- prints a list of currently defined words

`.ds`
- prints the contents of the data stack

`.`
- pops and prints the top value of the stack

`+`, `-`, `*`, `/`
- pop the top two items on the stack, perform the specified operation, and push
  the result onto the top of the stack

`:`, `;`
- used to define new words


## Defining new words example

Start the repl:

    $ rake repl
    ruth> words
    exit words .ds . + - * / : ;

Define a new word. We'll define `inc`, short for increment, which will
increment the number at the top of the stack:

    ruth> : inc 1 + ;
    ruth> words
    exit words .ds . + - * / : ; inc

Notice that `inc` is now in our list of available words. We can use it like any
other Ruth word:

    ruth> 3 inc .ds
    [4]
    ruth> exit
    $ |


## Todo

- Stack manipulation words.
- More control-flow words - loop constructs, if-then-else, etc.
- Load vocabularies from source file.
- Implement a more complete set of typical Forth words.
- Support for calling ruby from Ruth.
