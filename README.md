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
You need to have racket installed. Look here for further details -> https://docs.racket-lang.org/getting-started/

You can find the full code repository here:
https://github.com/oplS16projects/SlimeVolleyball

In the SlimeVolleyball directory, open /Source/SlimeGame.rkt using racket or it's gui interace Drracket.
On linux, this can be achieved easily by running
```
racket SlimeGame.rkt
```
in the Source directory.

###Updates
As of Wed Apr 26:
A simplistic Ai was developed. Prompt for one or two player mode was added upon opening the game. Movement is working well. Wall, net, and slime collisions with the ball are all fully functional. Scorekeeping was added, along with pausing after ball hits the ground, and resuming using spacebar. Winner and point winner notifications were added alongside scorekeeping.

As of Fri Apr 22:
Working out the final kinks in movement. Stutter has been fixed, and movement is starting to feel like the original game. 
We have added menu functionality for 1 or 2 player mode, and will hopefully have time to add the AI so that 1 player can
acutally be played. The scoreboard is functional, and a small message is currently played describng who earned a point, 
and will be enlargedand centered soon. The collisions are almost done, with the only remaining ones to be the walls and net.We have added a single bitmap background to reduce calls to draw as much as possible. The slime's eyes were added earlier in the week, and are fully operatonal.

As of Fri Apr 15:
We have movement mostly down, and just need to figue out why it's stuttering when the left and right keys are held.
Game is currently two player, with WASD functioning for player two.
Gravity is functional, and ball Y directional movement and collisions are working.
Graphics are in the works, and we have slime templates now so it is fairly simply to create new ones. The main challenge is keeping screen updates to a minimum, as the base/gui begins to cause flicker.
Hopefully collisions and the kinks with the gui and keyboard sutter will be solved soon, and we can begin on Ai and scorekeeping/gameplay.

