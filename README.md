# Connect 4

A command line version of connection board game Connect 4. 

Live demo on [Replit](https://replit.com/@gregolive/Connect-Four) 👈

## Functionality

Connect 4 played between 2 human players:
- On launch, both players enter their name and choose the color of their game disc. Player 2 is prohibited from choosing the same color disc as player 1.
- A player is randomly chosen to go first, and the players take turns selecting what column (1-7) in the game board they want to add their disc to.
- The game board has 6 rows and when a player attempts to add their disc to a full column and error is thrown, and they are prompted to select a new column.
- After a turn, the board is checked to see if the player has won. To increase efficiency, win condition checks are not done until after round 6 since a player must play at least 4 moves to win.
- To check the diagonal win condition, a #diagonals_from_right and #diagonals_from_left are used to create arrays of the grid diagonals in both directions. These methods iterate through the embedded array board and with incremented padding on each pass to pull the diagonal elements. An example is shown below...

If we had a grid-like array:

        [ [00, 01, 02], 
          [10, 11, 12], 
          [20, 21, 22]  ]

A basic version of #diagonals_from_left method would first look at the first row with a padding value of 0 to push '00' into the output array. The padding is incremented to 1 before the method looks at the second row, pulling '11' and adding it to the output array. Finally, the padding is incremented to 2 so that in the third row of the array, the method identifies '22'. One of the returned arrays from the method would therefore be:

        [00, 11, 22]

## Reflection

The actual game logic and Ruby knowledge required for the functionality of Connect 4 not much of a challenge, but a great way to practice writing more concise methods. At first I was actually overthinking the problem and tried to implement a board using data structures to test myself, but soon realized how impractical that was compared to a simple embedded, grid-like array. One of the more challenging problems was checking for diagonal win conditions, and the solution explained above for diagonal checking ended up being much more versatile than how I did it for the Tic Tac Toe game.

The main point of this project, though, was to practice Test Driven Development (TTD) with rspec. It was quite difficult to remember/force myself to write tests for methods before writing the methods themselves, but I did come to understand the benefits of TDD after doing so. One big difference I noticed was that methods I made using the TTD procedure were more concise and more focused on a single problem compared to many of the methods I usually write. Even the times I forgot to write the test beforehand or wanted to do some trial and error with the logic of the method prior to writing the test, going back afterwords for testing usually ending up in breaking down a method into smaller chunks to simplify the tests. 

Although I'm not totally sold on the need to write tests beforehand 100% of the time, I definitely see the big draw to testing with rspec and hope to learn about it more in the future. For now, I still found myself going back to some example problems to understand rsepc s
syntax and logic and do not feel overly confident in my grasp of it yet.

-Greg Olive