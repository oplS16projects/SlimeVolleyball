# SlimeVolleyball

### Statement

Slime Volleyball is an addictive 2-D game originally coded in javascript. We aim to write it in Racket so that it may be played offline. 

### Analysis

We will use object orientation because each slime and the ball will need to be represented in so coherent object.
We will use state-modification for the status and position of the game pieces on the field.
We will use some functional approaches for the application of gravity.

### Data set or other source materials

We will be modeling tha game off the opensource javascript version of the game which can be found here: https://github.com/marler8997/SlimeJavascript

How will you convert that data into a form usable for your project? 

We will translate the objects and functions into racket, and attempt to interface them with the racket base gui.
The base gui documentation can be found here: https://docs.racket-lang.org/gui/

### Deliverable and Demonstration
Explain exactly what you'll have at the end. What will it be able to do at the live demo?

We will have a varsion of the game playable here:https://cdn.rawgit.com/marler8997/SlimeJavascript/master/SlimeVolleyballLegacy.html
But written in Scheme. It will be able to be live demo'd because it is (hopefully) a playable game.

The game will be fully playable, with both Ai and human players. The two player version will incorporate movement on both the wasd and arrow keys, so two players can play on one machine. The Ai will have different levels so that after beating one Ai, the player can move on to a harder difficulty.

We can output the processes to a log, but that will probably reduce the framerate, so it will probably be removed in the final version.

It will be interactive and playable. If it isn't then the project was not completed as expected.

### Evaluation of Results

We will be successful if the game produced is lightweight enough to run at speed, and there are no bugs with the collisions or movement. The base idea of the game must also be present, and the functionality of the Ai would be nice to have as well.

## Architecture Diagram
![alt tag](https://raw.githubusercontent.com/oplS16projects/SlimeVolleyball/master/architecture.jpg)

The final product will be a User Interface accurately replicating that of the javascript game. This will be composed of the base gui and user input functionality, such as keystrokes and mouse actions, as well as the core game objects.

The base gui and ui will be composed locally initially, and if we find that we have extra time, we will attempt to implement multi-machine play. The local input and menus are also included in this part. the gui will also handle the keystrokes, and report them to the objects so that the changes in position can be calculated. The gui will then access the objects to get position and graphical representation of the objects.

The objects themselves will be composed of the physics functions to represent movement, the graphics to be displayed, and the optional Ai may be given the ball's location, and allowed to determine it's movements. There will be two types of objects, Slime and ball.

## Schedule
Explain how you will go from proposal to finished product. 

### First Milestone (Fri Apr 15)
Beginnings of the gui, hopefully functionality for ball and player movement.

### Second Milestone (Fri Apr 22)
What exactly will be turned in on this day? 
gui and ball and player movement should be complete. Ai should be somewhat complete.

### Final Presentation (last week of semester)
What additionally will be done in the last chunk of time?
Menu screens and options for legacy mode and slow-mo will be added if we have the time.

## Group Responsibilities
Here each group member gets a section where they, as an individual, detail what they are responsible for in this project. Each group member writes their own Responsibility section. Include the milestones and final deliverable.

### Kenny Sanders @kennysandbum
I will focus on the gui and updating the canvas. I will also work on importing images of the objects to their classes, and the movement of the objects being reflected on the screen. Once we have both finished our respective jobs, we will work together on the Ai.

### Cam Oliver @C4m0
I will be in charge of the physics and interaction between classes. This includes the movement of the ball and collisions with walls and players. I will work to make general getter and setter functions for the classes, and create functional velicities and acceleration for the objects.
