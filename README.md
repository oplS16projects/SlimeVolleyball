# FP7-Slime Volleyball

##Authors
Cameron Oliver

Kenny Sanders

##Overview
The classic browser game Slime Volleyball has been implemented in your favorite functional programming language.  Play as the humble half circle slime in the fight to make the a small yellow circle land on your opponent's side of the screen!  With multiplayer or AI support (Player 1 moves left to right wih A and D and jumps with W, Player 2 if playing uses the arrow keys).

##Screenshot

![alt tag](https://raw.githubusercontent.com/oplS16projects/SlimeVolleyball/master/Gamplay.jpg)
![alt tag](https://raw.githubusercontent.com/oplS16projects/SlimeVolleyball/master/Final_Architecture.jpg)

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
####Kenny
This conditional statement houses the basic logic of the AI. By calculating where the ball will land (landing) and the comparing it to where the slime is, the direction the slime should move is determined. The AI also determines when to jump if it is already under the ball. It was difficult to figure out at first, but once i started to think about the thought process one goes through when playing, it seemed relatively simple.
```scheme
 (cond
	((and (< (+ (car (slime 'get_pos)) (slime 'get_rad) ) landing) (> (+ (car (slime 'get_pos)) (slime 'get_rad) -45) landing)) (begin (display "here") ((slime 'set_jump) #t) ((slime 'set_vel (car (slime 'get_vel) -18)))))
        ((< (+ (car (slime 'get_pos)) (slime 'get_rad) -5) landing) ((slime 'set_vel) 6 (cdr (slime 'get_vel)))
        ((> (+ (car (slime 'get_pos)) (slime 'get_rad) -45) landing) ((slime 'set_vel) -6 (cdr (slime 'get_vel))))
        (else (begin ((slime 'set_vel) 0 (cdr (slime 'get_vel))) (if (> (cdr (ball 'get_pos)) (- windowYbound 100)) ((slime 'set_jump) #t) 'done)))))
            
```

#How to Download and Run
*You need to have racket installed.* Look here for further details -> https://docs.racket-lang.org/getting-started/

#####You can find the full code repository here: https://github.com/oplS16projects/SlimeVolleyball

####Once you have downloaded and extracted the repository from github:


#####On windows:
Open the source folder and run SlimeGame.rkt using racket or it's gui interface Drracket. 
#####On linux: 
Navigate to the source directory and run the command  ``` racket SlimeGame.rkt```


