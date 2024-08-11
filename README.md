# The Gobbler
The Gobbler is a small red circle that gets bigger the more it eats.
It doesn't have very good sight, however. This isn't a problem in its automatic mode, but things get dangerous when you have to pilot it...
<br>
<br>

## Getting Started
Before you play around with the Gobbler, you'll first need to download the Processing IDE. You can get it <a href="https://processing.org/" target="_blank">here</a>.
This particluar version uses Java.<br>
<br>
Be sure to get familiar with the environment if you want to make any changes to my code. It's quite a simple environment, but
there are lots of reserved keywords you'll want to avoid. Check out the [reference](https://processing.org/reference) tab for more info.<br>
<br>
Inside of the directory that Processing adds for you, find the "Projects" folder (or make one yourself if it's not there).
Clone this repository into it:
```
git clone https://github.com/Pingpong403/Gobbler
```
You should be set!

## Having Fun with The Gobbler
Once everything is set up you can run the code! The first screen asks you whether you want to run it in "Auto" (automatic) mode or "Control" mode.
### Auto Mode
In this mode, the Gobbler moves itself around using its "seek radius", the gray circle around it.
The Gobbler knows nothing about its environment and bumbles along until it spots a Pellet, its food source. Eating a Pellet causes it to grow.<br>
<br>
The Gobbler will continue in Auto mode until all the Pellets are gone, after which it will just bounce on the walls endlessly.<br>
<br>
This mode is more of a proof of concept than anything, so let's look at the better mode.
### Control Mode
This mode allows you, the user, to control where the Gobbler moves with your mouse! It will chase your cursor at a set speed.
Use these controls to feed it, making sure it doesn't die.<br>
<br>
While the Gobbler is immortal in the Auto mode, it rapidly loses health in this mode. Eating pellets replenishes some health and allows it to keep on eating.<br>
<br>
There are a handful of easter eggs/mechanics to learn and discover, so don't be afraid to dig around the code to learn how best to play!

## My Code
Now that you've gotten familiar with how Processing works, I'll let you in on a secret: I don't add too much onto what the IDE gives you.<br>
<br>
Here's a complete (unofficial) list of everything I implement:
- Gobble - a class to represent the Gobbler
- Pellet - a class to represent the Gobbler's food source
- Color - a simple class to represent an RGB color
- Trajectory - a class represent velocity
- cycleRainbow() - a function that takes a Color on the rainbow's spectrum and moves it along<br>
<br>
On top of that, I made two boolean variables to make clicking much easier for the user: mouseChoose and mouseMoved.

## Changes I Need to Make
- The Gobbler class's name should reflect what it is, not what it does.
- Trajectories are arcs. The Trajectory class should be changed to Velocity.
