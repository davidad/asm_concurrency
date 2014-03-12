asm_concurrency
===============

How to run:

* Make sure you have a recent `nasm`; check that `nasm -v` reports `2.11` or newer.
```
$ git clone https://github.com/davidad/asm_concurrency.git
$ cd asm_concurrency
$ make
```
* See results.
* If you want to verify deterministic behavior, run `make integrity_check`.

You can also supply a command-line argument, which will be opened as a binary file.

    $ make concurrency-noprint-x3 concurrency-noprint-x4
    $ ./concurrency-noprint-x4 foo
    $ ./concurrency-noprint-x3 bar
    $ diff foo bar
    $ # same results, yay!
    
The number after the x indicates how many processes will be forked by that executable. You can even run more than one instance of "concurrency" concurrently (shocker).

    $ make clean
    $ make size=10000000 concurrency-noprint-x3
    $ ./concurrency-noprint-x3 quux &            # this will take a little while
    $ ./concurrency-noprint-x3 quux
    $ ./concurrency-noprint-x3 quuux &
    $ ./concurrency-noprint-x3 quuux &
    $ ./concurrency-noprint-x3 quuux
    $ diff quux quuux
    $ # hoo-ah!

`make` options you can tweak (with their default values):

    $ make size=1000000 "nprocs=1 2 3 4 5 6 7 8 9 10 11 12 13 14 15"

* The output file will have size `(size+1)*8`. (This is due to keeping a bookkeeping quad-word in the file and assuming for simplicity that the file is an integer number of quad-words.)
* `nprocs` specifies the set of executables to build and test (`-x1`, `-x2`, etc.). This should have just been a command-line argument, but eh, this way works.
