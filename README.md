# SlimeVolleyball

### Statement

Slime Volleyball is an addictive 2-D game originally coded in javascript. We aim to write it in Racket so that it may be played offline. 

###Updates
As of Fri Apr 22:
Working out the final kinks in movement. Stutter has been fixed, and movement is starting to feel like the original. 
We have added menu functionality for 1 or 2 player mode, and will hopefully have time to add the AI.
The scoreboard is functional, and a small message is currently played describng who earned a point, and will be enlarged
and centered soon. The collisions are almost done, with the only remaining ones to be the walls and net.
We have added a single bitmap background to reduce calls to draw as much as possible.
The slime's eyes were added earlier in the week, and are fully operatonal.

As of Fri Apr 15:
We have movement mostly down, and just need to figue out why it's stuttering when the left and right keys are held.
Game is currently two player, with WASD functioning for player two.
Gravity is functional, and ball Y directional movement and collisions are working.
Graphics are in the works, and we have slime templates now so it is fairly simply to create new ones. The main challenge is keeping screen updates to a minimum, as the base/gui begins to cause flicker.
Hopefully collisions and the kinks with the gui and keyboard sutter will be solved soon, and we can begin on Ai and scorekeeping/gameplay.

### Usage

You need to have racket installed. Look here for further details -> https://docs.racket-lang.org/getting-started/
In the SlimeVolleyball directory, open /Source/SlimeGame.rkt using racket or it's gui interace Drracket.
On linux, this can be achieved easily by running
...
racket /Source/SlimeGame.rkt
...
in the SlimeVolleyball directory.

### Analysis

We will use object orientation because each slime and the ball will need to be represented as an independent object.
We will use state-modification for the status and position of the game pieces on the field.
We will use some functional approaches to determine the motion of the objects.

### Data set or other source materials

We will be modeling tha game off the opensource javascript version of the game which can be found here: https://github.com/marler8997/SlimeJavascript

We will translate the objects and functions into racket, and attempt to interface them with the racket base gui.
The base gui documentation can be found here: https://docs.racket-lang.org/gui/

### Deliverable and Demonstration 

We will have a version of the game playable here:https://cdn.rawgit.com/marler8997/SlimeJavascript/master/SlimeVolleyballLegacy.html
But written in Scheme. It will be able to be live demo'd because it is (hopefully) a playable game.

The game will be fully playable, with both Ai and human players. The two player version will incorporate movement on both the wasd and arrow keys, so two players can play on one machine. The Ai will have different levels so that after beating one Ai, the player can move on to a harder difficulty.

We can output the processes to a log, but that will probably reduce the framerate, so it will probably be removed in the final version.

It will be interactive(playable). If it isn't then the project was not completed as expected.

### Evaluation of Results

We will be successful if the game produced is lightweight enough to run at speed, and there are no bugs with the collisions or movement. The base idea of the game must also be present, and the functionality of the Ai would be nice to have as well.

## Architecture Diagram
![alt tag](https://raw.githubusercontent.com/oplS16projects/SlimeVolleyball/master/architecture.jpg)

The final product will be a User Interface accurately replicating that of the javascript game. This will be composed of the base gui and user input functionality, such as keystrokes and mouse actions, as well as the core game objects.

The base gui and ui will be composed locally initially, and if we find that we have extra time, we will attempt to implement multi-machine play. For a networked approach, all functional computation would be carried out server-side, while user input and rendering graphics would be handled client-side: the UI would run locally and would report inputs to the server, the server would collect inputs from both users and calculate updated object positions/velocities accordingly, then the server would send the updated positions to the local machines which will update the graphics according to their new positions.

The objects themselves will be composed of the physical functions to represent motion, the graphics to be displayed, and the optional Ai may be given the ball's location, and allowed to determine it's movements. There will be two types of objects, Slime and ball.

## Schedule
Explain how you will go from proposal to finished product. 

### First Milestone (Fri Apr 15)
Beginnings of the gui, hopefully functionality for ball and player movement.

### Second Milestone (Fri Apr 22)
gui and ball and player movement should be complete. Ai should be somewhat complete.

### Final Presentation (last week of semester)
Menu screens and options for legacy mode and slow-mo will be added if we have the time.

## Group Responsibilities
Here each group member gets a section where they, as an individual, detail what they are responsible for in this project. Each group member writes their own Responsibility section. Include the milestones and final deliverable.

### Kenny Sanders @kennysandbum
I will focus on the gui and updating the canvas. I will also work on importing images of the objects to their classes, and the movement of the objects being reflected on the screen. Once we have both finished our respective jobs, we will work together on the Ai.

### Cam Oliver @C4m0
I will be in charge of the physics and interaction between classes. This includes the movement of the ball and collisions with walls and players. I will work to make general getter and setter functions for the classes, and create functional velocities and acceleration for the objects.
