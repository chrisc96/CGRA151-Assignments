Ball ball;
Paddle paddle;
Brick[][] bricks;
int wd = 600;
int ht = 600;

// Global Variables for Bricks
// Dynamic width and height of Bricks that are centered
public int brickWd;
public int brickHt;
public int numBricks;
public float xOffset;
public int numRows = 5; // Constant

void settings() {
  size(wd, ht);
}

void setup() {
  // Initialising global vars
  brickWd = (int) width /3; // E.G 550 / 15 = 36 (int)
  brickHt = (int) height / 30;
  numBricks = (int) width / brickWd; // E.G 550 / 36 = 15 (int)
  xOffset = ((width % (width/15))/2); 
  
  // Creating Objects
  ball = new Ball(100, brickHt * numRows + 20, 30);
  paddle = new Paddle();
  bricks = new Brick[numRows][numBricks];
  this.createBricks();
  frameRate(90);
}

void draw() {
  background(0);
  ball.bounce(); // Bounce off sides
  paddle.collisionDetection();
  ball.move(); // Moves ball position by velocity vector
  paddle.draw();
  ball.draw();
  this.displayBricks();
}

void createBricks() {
  for (int row = 0; row < bricks.length; row++) {
    for (int col = 0; col < bricks[0].length; col++) {
      bricks[row][col] = new Brick(xOffset + col*brickWd, row*brickHt, 1);
    }
  }
}

void displayBricks() {
  for (int row = 0; row < bricks.length; row++) {
    for (int col = 0; col < bricks[0].length; col++) {
      if (bricks[row][col] != null) {
        bricks[row][col].display();
        bricks[row][col].collisionDetection();
        
        if (bricks[row][col].getCount() > 3) {
          bricks[row][col] = null;
        }
      }
    }
  }
}