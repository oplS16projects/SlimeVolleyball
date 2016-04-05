# SlimeVolleyball

### Statement
Describe your project. Why is it interesting? Why is it interesting to you personally? What do you hope to learn? 

Slime Volleyball is an addictive 2-D game originally coded in javascript.

### Analysis
Explain what approaches from class you will bring to bear on the project. Be explicit: e.g., will you use recursion? How? Will you use map/filter/reduce? How? Will you use data abstraction? Will you use object-orientation? Will you use functional approaches to processing your data? Will you use state-modification approaches? A combination?

We will use object orientation because each slime and the ball will need to be represented in so coherent object.
We will use state-modification for the status and position of the game pieces on the field.
We will use some functional approaches for the application of gravity.

The idea here is to identify what ideas from the class you will use in carrying out your project. 

### Data set or other source materials
If you will be working with existing data, where will you get those data from? (Dowload it from a website? access it in a database? create it in a simulation you will build....)

We will be modeling tha game off the opensource javascript version of the game which can be found here: https://github.com/marler8997/SlimeJavascript

How will you convert that data into a form usable for your project? 

We will translate the objects and functions into racket, and attempt to interface them with the racket base gui.
The base gui documentation can be found here: https://docs.racket-lang.org/gui/

Do your homework here: if you are pulling data from somewhere, actually go download it and look at it. Explain in some detail what your plan is for accomplishing the necessary processing.

If you are using some other starting materails, explain what they are. Basically: anything you plan to use that isn't code.

### Deliverable and Demonstration
Explain exactly what you'll have at the end. What will it be able to do at the live demo?

We will have a varsion of the game playable here:https://cdn.rawgit.com/marler8997/SlimeJavascript/master/SlimeVolleyballLegacy.html
But written in Scheme. It will be able to be live demo'd because it is (hopefully) a playable game.

What exactly will you produce at the end of the project? A piece of software, yes, but what will it do? Here are some questions to think about (and answer depending on your application).

The game will be fully playable, with both Ai and human players. The two player version will incorporate movement on both the wasd and arrow keys, so two players can play on one machine. The Ai will have different levels so that after beating one Ai, the player can move on to a harder difficulty.

Will it run on some data, like batch mode? Will you present some analytical results of the processing? How can it be re-run on different source data?

We can output the processes to a log, but that will probably reduce the framerate, so it will probably be removed in the final version.

Will it be interactive? Can you show it working? This project involves a live demo, so interactivity is good.

Yes, it will be interactive and playable. If it isn't then the project was not completed as expected.

### Evaluation of Results
How will you know if you are successful? 
If you include some kind of _quantitative analysis,_ that would be good.

We will be successful if the game produced is lightweight enough to run at speed, and there are no bugs with the collisions or movement. The base idea of the game must also be present, and the functionality of the Ai would be nice to have as well. There is really no way to quantitatively analyze the game, as it is a user experience and not a quantitative result. The correct mixture of physics and graphic scale will produce the desired experience. 

## Architecture Diagram
Upload the architecture diagram you made for your slide presentation to your repository, and include it in-line here.
![alt tag](https://raw.githubusercontent.com/oplS16projects/SlimeVolleyball/master/architecture.jpg)
Create several paragraphs of narrative to explain the pieces and how they interoperate.

The final product will be a User Interface accurately replicating that of the javascript game. This will be composed of the base gui and user input functionality, such as keystrokes and mouse actions, as well as the core game objects.

The base gui and ui will be composed locally initially, and if we find that we have extra time, we will attempt to implement multi-machine play. The local input and menus are also included in this part. the gui will also handle the keystrokes, and report them to the objects so that the changes in position can be calculated. The gui will then access the objects to get position and graphical representation of the objects.

The objects themselves will be composed of the physics functions to represent movement, the graphics to be displayed, and the optional Ai may be given the ball's location, and allowed to determine it's movements. There will be two types of objects, Slime and ball.



## Schedule
Explain how you will go from proposal to finished product. 

There are three deliverable milestones to explicitly define, below.

The nature of deliverables depend on your project, but may include things like processed data ready for import, core algorithms implemented, interface design prototyped, etc. 

You will be expected to turn in code, documentation, and data (as appropriate) at each of these stages.

Write concrete steps for your schedule to move from concept to working system. 

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

**Additional instructions for teams of three:** 
* Remember that you must have prior written permission to work in groups of three (specifically, an approved `FP3` team declaration submission).
* The team must nominate a lead. This person is primarily responsible for code integration. This work may be shared, but the team lead has default responsibility.
* The team lead has full partner implementation responsibilities also.
* Identify who is team lead.

In the headings below, replace the silly names and GitHub handles with your actual ones.

### Kenny Sanders @kennysandbum
I will focus on the gui and updating the canvas. I will also work on importing images of the objects to their classes, and the movement of the objects being reflected on the screen. Once we have both finished our respective jobs, we will work together on the Ai.

### Cam Oliver @C4m0
I will be in charge of the physics and interaction between classes. This includes the movement of the ball and collisions with walls and players. I will work to make general getter and setter functions for the classes, and create functional velicities and acceleration for the objects.

### Frank Functions @frankiefunk 
Frank is team lead. Additionally, Frank will work on...   
