# Building Tic-Tac-Toe in H/C/J - 1.25.17
## By Ian Candy

### Components

The first thing we want to do is break down our game into components. In this example we want the following:

- Game - to wrap all the logic and other compnents
- Board - contains all the squares
- Square - is set to either (-, x, o)

### Board

We can store the positions of the squares in an array which will represent our board, we can add a '+' to initialize it with a neutral value.

We can add a `render()` method to add the array to the DOM and style the squares with padding to separate them.

### Handling Interaction

We now want to attach a click handler to our squares so that they can change to a different value.

We should put the logic in the Game class so that we can keep the state for other actions.

We should render the board from the TicTacToe class then add the handler in a callback to the board render function.

In the handler we should change the text of the square to 'x'

### Actions up, Data down

[further reading](http://www.samselikoff.com/blog/data-down-actions-up/)

We should try to have top level classes controlling the data and actions from lower classes sending up actions.

### 
