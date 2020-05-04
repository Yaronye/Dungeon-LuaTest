# Dungeon Generation in Lua
Author: **Ronya Budak**
## Description
Dungeon generation in ASCII style that prints to the console/terminal. Rooms are randomly generated and placed and a random amount of openings, "doors" are created for each room. Hallways are drawn in the same direction the door is facing until it meets another hallway or room and is joined with it, or if it reaches the border of the matrix it will become a dead end. 

The player is drawn as a **@** symbol and is moved using **aswd** keys and the program is ended by inputting the **z** key. The move function for the player is simple and collision detection has not been implemented, so be wary of where you walk.\
#### Output examples:

<img src="https://github.com/Liwow/LuaTest/blob/master/images/dungeon_example1.png" height="450">
<img src="https://github.com/Liwow/LuaTest/blob/master/images/dungeon_example2.png" height="450">
<img src="https://github.com/Liwow/LuaTest/blob/master/images/dungeon_example3.png" height="450">

## Want to fix
This algorithm tries to fill most of the board with rooms before drawing hallways, and with the right amount of tries and max number of doors a room can have, it is incredibly unlikely that there will be an unreachable part of the dungeon for the player. HOWEVER this does not guarantee it, and so a function was to be added that would remove rooms that were disconnected. It was left out due to trouble with the class and time restraints.

The doors were supposed to be saved with the room class objects but this was troublesome to implement however and a last minute fix had to be used with saving the doors x and y positions to seperate tables in main with no co-relation to their room objects. This is one of the bigger problems with this version as this meant a more complex algorithm could not be implemented due to this. Given more time this is an easy fix, to simply add them to the room class and it would then have a door attribute that would be a single table that contained tuples of the coordinates for the doors.

The algorithm currently implemented is very naive, given time I would have wished to implement an A* algorithm to draw the hallways due to this algorithm being easy to implement and giving nice optimal path between nodes, and using Delaunay triangulation for room placement . 

I lost a lot of time coding my room class for the program. The first implementation resulted in each object being reset to null whenever a new object was created which would have been an easy fix for someone who has programmed in Lua before which I had not. After this was fixed the class methods did not work and had to be re-defined as functions in the main file instead to be used.

## Known Bugs
Due to time restraints the following bugs are left in the program:

Some doors may be left when the dungeon is drawn with the "D" doortile and have not been made into a hallway, unclear where the problem lies but most likely in the hallways function.\
<img src="https://github.com/Liwow/LuaTest/blob/master/images/door_bug.png" height="200">

In rare occurances hallways may end up with a floor tile and accomplanying walls missing. Unclear why this happens, but may have to to with the while loop in the hallway function.
