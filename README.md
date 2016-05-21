### Summary

Ants that demonstrate emergent behavior based on simple rules. ![demo](https://i.gyazo.com/dd5e0a61b4ec7a990224a3e819c5e987.gif)  
![demo2](https://i.gyazo.com/318399fb463a7b3bd7d738c75c642e5d.gif)

### How it works

Two rules govern how each ant moves:   
1) If the ant is on a white square, it turns left 90 degrees, and moves forward one grid.  
2) If the ant is on a black square, it turns right 90 degrees, and moves forward one grid.  
When the ant leaves a grid, the color of the grid it left is inverted.    

### Customizable options  
`delay`: Milliseconds between each ant move  
`randDir`: Whether or not to initialize ants with a random direction  
`cellSize`: Size of each grid in pixels  

### Controls  
`Click`: Add ant  
`Spacebar`: Toggle pause (also displays step number)  
`R`: Reset
