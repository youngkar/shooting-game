/*    Karli Young -- Programming Basics Project 2
      
      A simple single-player interactive shooting game. Use 's' to start the game,
      and space to shoot. 
*/

// Variables
PShape enemy;
PShape player;
PShape bullet;
float score = 0;
int state = 0;
int lives = 3;
long lastTime;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
Player p1;

// setup ----------------------------------------
void setup() {
  size(600, 600);
  shapeMode(CENTER);
  
  player = createShape(RECT, 0, 0, 50, 50);
  fill(200, 0, 0);
  enemy = createShape(RECT, 0, 0, 30, 30);
  fill(100);
  bullet = createShape(RECT, 0, 0, 8, 15);
  lastTime = millis();
  
  enemies.add(makeEnemy());
  p1 = new Player(width/2, height - 50);
}

// draw -----------------------------------------
void draw() {
  background(0);
  changeState();
}


// Classes --------------------------------------
// Represents an Enemy
class Enemy {
  float x;
  float y;
  float yVel = 0.5;
  boolean hit = false;
  
  Enemy(float x, float y){
    this.x = x;
    this.y = y;
    // Makes the enemies fall faster when the score is higher
    this.yVel = this.yVel + (score / 20);
  }
  
  // draws the enemy on the screen 
  void drawEnemy() {
    shape(enemy, this.x, this.y);
  }
  
  // moves the enemy down the screen by its yVel
  void move() {
    this.y = this.y + this.yVel;
  }
  
  // if a player loses, will either take away a life or end the game
  void justLost() {
    if (this.y > height) {
      if (lives == 1) {
        state = 3;
      } else {
        lives--;
        score = 0;
        state = 1;
        enemies = new ArrayList<Enemy>();
        enemies.add(makeEnemy());
        bullets = new ArrayList<Bullet>();
      }
    } 
  }
}

// Represents the player
class Player {
  float x;
  float y;
  
  Player(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  // draws the player on the screen
  void drawPlayer() {
    shape(player, this.x, this.y);
  }
  
  // moves the player left/right based on the user pressing the left/right arrow keys
  void movePlayer() {
    if (key == CODED) {
      if (keyCode == RIGHT && this.x < width - 50) {
        this.x = this.x + 7;
      }
      if (keyCode == LEFT && this.x > 0) {
        this.x = this.x - 7;
      }
    }
  }
}

// Represents a bullet
class Bullet {
  float x;
  float y;
  float yVel = -5;
  boolean hit = false;
  
  Bullet() {
    this.x = p1.x + 20;
    this.y = p1.y;
  }
  
  // moves the bullet up the screen by its yVel
  void move() {
    this.y = this.y + this.yVel;
    shape(bullet, this.x, this.y);
  }
}


// Utility functions: ----------------------------------------

// Creates a new enemy at the top of the canvas, at a random x location
Enemy makeEnemy() {
  return new Enemy(Math.round(random(0, width - 30)), 0);
}

// Fills the game with new enemies as time goes on
void fillEnemies() {
  if (millis() > lastTime+4000) {
    enemies.add(enemies.size(), makeEnemy());
    lastTime = millis();
  }
}

// Finds and removes enemies and bullets that have collided, 
// and bullets that have left the screen
void update() {
  for (Enemy e : enemies) {
    for (Bullet b : bullets) {
      if (b.x >= e.x - 10 && b.x <= e.x + 30 && b.y <= e.y + 30) {
        b.hit = true;
        e.hit = true;
        score++;
      }
      if (b.y < 0) {
        b.hit = true;
      }
    }
  }
  
  for (Enemy e : enemies) {
    if(e.hit){
      enemies.remove(e);
      break;
    }
  }
  for (Bullet b : bullets) {
    if(b.hit){
      bullets.remove(b);
      break;
    }
  }
}


// Handles each of the game states
void changeState() {
  textAlign(CENTER);
  switch (state) {
    
  // Start screen
  case 0:
  String start = "Instructions:\n Use arrow keys to move left and right. Press space to shoot.";  
  fill(255);
  textSize(30);
  text(start, width/4, height/4, width/2, height/2);
  text("Press s to start", width/2, height*3/4);
  break;
  
  // Game play
  case 1:
  p1.drawPlayer();
  fill(100);
  text("Score: " + score, 120, 32);
  text("Lives: " + lives, width - 80, 32);
  textSize(25);
  rect(20, 10, 25, 25);
  fill(255);
  rect(25, 15, 5, 15);
  rect(35, 15, 5, 15);
  fillEnemies();
  update();
  for (Enemy e : enemies) {
    e.drawEnemy();
    e.move();
    e.justLost();
  }
  for (Bullet b : bullets) {
    b.move();
  }
  break;
  
  // Pause
  case 2:
  fill(100);
  rect(20, 10, 25, 25);
  fill(255);
  triangle(25, 15, 25, 30, 40, 22);
  text("Game paused! Press play button to resume", width/2, height/2);
  break;
  
  // Game end 
  case 3:
  String end = "Game over!\nPress s to start over";
  textSize(30); 
  text(end, width/2, height/2);
  break;
  default:
  text("The game broke :(", width/2, height/2);
  break; 
  }
}

// Handles key presses to start game, restart game,
// fire a bullet, and move the player 
void keyPressed() {
  if (key == 's') {
    if (state == 0) {
      state = 1;
    }
    if (state == 3) {
      enemies = new ArrayList<Enemy>();
      enemies.add(makeEnemy());
      score = 0;
      bullets = new ArrayList<Bullet>();
      state = 1;
      lives = 3;
    }
  }
  if (key == ' ') {
    bullets.add(new Bullet());
  }
  p1.movePlayer();
}

// Handles mouse press for when the user wants to pause
// and resume the game
void mousePressed() {
  if (state == 1 && mouseX > 20 && mouseX < 45 
  && mouseY > 10 && mouseY < 35 && mousePressed) {
    state = 2;
  } else if (state == 2 && mouseX > 20 && mouseX < 45 
  && mouseY > 10 && mouseY < 35 && mousePressed) {
    state = 1;
  } 
}
