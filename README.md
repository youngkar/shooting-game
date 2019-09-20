# shooting-game
Simple shooting game creating in Processing3, made with Java. 

- User opens program and presses run
- Initial display screen reads directions: “Use arrows to move player. Use mouse to change angle of shot and click mouse to fire.” Below that reads: “Press s to start” (or some other key)
- Game starts; start game screen has the player’s representation at the bottom of the screen, a score in the top left hand corner (starting at 0), and a play/pause button in the right hand corner
- “Enemies” start falling from the top of the screen towards the bottom from random x locations
- User can use left and right arrow keys to move along the bottom of the screen
- User should use mouse movement to change the angle of the player’s shot (player should rotate toward the mouse to show the change)
- Player clicks mouse to fire 
- When player’s shot is fired, a “bullet” moves into the direction where mouse click occurred 
- If player’s shot hits an enemy, the enemy disappears from the game
- If a player’s shot misses, it should continue off the screen and disappear from the game
- As time progresses, enemies being moving faster down the screen, and more appear at the top of the screen
- Game ends when an Enemy is able to pass the player and hit the bottom of the screen. When game is over, display shows “Game over! Score: x. Press s to play again.”
