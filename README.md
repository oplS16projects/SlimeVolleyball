#Slime Volleyball

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
Movement of the ball and slimes is done by setting the updating the position according to the x and y velocity of each object.  The object velocities can be changed in several ways: slime velocities can be modified by user input (or by the AI); the ball's velocity can be modified upon collision with either the slimes, the net, or the left/right walls (this collision modification is carried out by 3 separate functions, the 'collision function for limes, the 'wall function for walls, and the 'net function for the net); and finally the slimes and the ball have their velocities updated each frame by a constant acceleration downward.  This move function is responsible for:
1. Checking that the new position is within the object boundaries (for example the left side of the court for slime 1)
2. If 1==true, setting the new position
3. If the object is not already on the ground, updating the velocity

Although it is not hugely complicated it is very much at the core of our game's functionality, and since I love simple code with a lot of functionality almost as much as I love absurdly complex code with virtually no functionality (which fortunately for your sake we haven't got any of in this project); I am declaring this my Favorite Expression.
```scheme
((eq? op 'move) (begin
                            ((lambda (x y)
                               (if (and (> x left_bound) (< x right_bound))
                                   (set! pos_x x)
                                   (values));does nothing
                               (if  (< y bottom_bound)
                                    (set! pos_y y)
                                    (if (>= y bottom_bound)
                                        (set! pos_y bottom_bound)
                                        (values ))))
                             (+ pos_x vel_x) (+ pos_y vel_y))
                            
                            (if (< pos_y bottom_bound)
                                (set! vel_y (+ vel_y 0.8)) ;gravity
                                (begin
                                  (set! pos_y bottom_bound)
                                  (if jump
                                      (set! vel_y -18)
                                      (set! vel_y 0))))
                            ))
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


######Once you have downloaded and extracted the repository from github:


#####On windows:
Open the source folder and run SlimeGame.rkt using racket or it's gui interface Drracket. 
#####On linux: 
Navigate to the source directory and run the command  ``` racket SlimeGame.rkt```


