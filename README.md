Minesweeper *(...but different!)*
---
Starting off you can play the normal minesweeper game (grey background)...    
pressing space switches not only the background color but the game mode as well    

What this means is that instead of revealing in a 9x9 grid around the clicked tile (and counting the bombs in those tiles), it can reveal a variety of different paths.

For example...    
The red background is a flower pattern -- the spaces revealed will have a 1 tile gap between the clicked tiles. 

Here are the gamemodes right now:
1. normal (grey)
2. flower (red)
3. diagonals (green)
4. [Knight's Path](https://en.wikipedia.org/wiki/Knight%27s_tour) (blue)

You can add additional gamemodes if you choose to fork+clone this repo. In the PATHS array in Minesweeper.pde, just add a link to your image file. The path is represented by a black image with the clicked tile in the middle and the revealed/counted tiles in red.

```
TO-DO:
*Add animations/reveal to bomb click
*Put all of this info into the actual program
*Make it run faster (there are a few redundant loops that could be made more efficient)
*Clean up syntax/excess variables

````