# FP7-Slime Volleyball

##Authors
Cameron Oliver

Kenny Sanders

##Overview
The classic browser game Slime Volleyball has been implemented in your favorite functional programming language.  Play as the humble half circle slime in the fight to make the a small yellow circle land on your opponent's side of the screen!  With multiplayer or AI support (Player 1 moves left to right wih A and D and jumps with W, Player 2 if playing uses the arrow keys).

##Screenshot

![alt tag](https://raw.githubusercontent.com/C4m0/FP7-webpage/master/Gamplay.jpg)
![alt tag](https://raw.githubusercontent.com/C4m0/FP7-webpage/master/Architecture.jpg)

##Concepts Demonstrated
Identify the OPL concepts demonstrated in your project. Be brief. A simple list and example is sufficient. 
* **Data abstraction** and **encapsulation** implemented using *Message Passing* provide access to the necessary states and functions belonging to the ball and the slimes.


##External Technology and Libraries
(require racket/gui/base) provides bindings for various GUI related tools including functions to handle keyboard and mouse input, file handling, managing windows, and drawing/displaying images.  The official doccumentation can be fround here: https://docs.racket-lang.org/gui/

##Favorite Scheme Expressions
####Cam
This short bit of code lets you create the Racket equivalent of header files and source files.  This is extremely useful for
keeping organized on a big project like this, it was one of the first things I figured out how to do when we started the project
and I am glad because it makes the code a lot easier to look through.
```scheme
(provide (all-defined-out))    ;This is in classes.rkt
(require (file "classes.rkt")) ;and this is in SlimeGame.rkt
```
####Lillian (another team member)
This expression reads in a regular expression and elegantly matches it against a pre-existing hashmap....
```scheme
(let* ((expr (convert-to-regexp (read-line my-in-port)))
             (matches (flatten
                       (hash-map *words*
                                 (lambda (key value)
                                   (if (regexp-match expr key) key '()))))))
  matches)
```

##Additional Remarks
Anything else you want to say in your report. Can rename or remove this section.

#How to Download and Run
You can find the full code repository here:
https://github.com/oplS16projects/SlimeVolleyball
You should keep all of the files in the source folder together, then open SlimeGame.rkt and press run to play!

