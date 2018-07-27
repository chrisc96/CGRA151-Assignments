public class Brick {
  
  // Fields for objects
  float x;
  float y;
  color c;
  int count;

  public Brick(float x, float y, int count) {
    this.x = x;
    this.y = y;
    this.count = count;
  }
  
  void colAdjust() {
    // RGB
    if (this.count == 1) {this.c = color(0,255,0);}
    else if (this.count == 2) {this.c = color(255,255,0);}
    else if (this.count == 3) {this.c = color(255,0,0);}
  }
  
  void display() {
    this.colAdjust();
    fill(this.c);
    rect(this.x, this.y,brickWd, brickHt);
    fill(255);
  }
  
  color getCol() {
    return this.c;
  }
  
  int getCount() {
    return this.count;
  }
  
  void collisionDetection() {
    
    // Detecting collision on top and bottom of brick
    if (ball.getX() >= this.x && ball.getX() <= this.x + brickWd) {
      if (ball.getY() - ball.r <= this.y + brickHt && ball.getY() - ball.r >= this.y + brickHt/1.5 ||  // Bottom 
          ball.getY() + ball.r >= this.y && ball.getY() + ball.r <= this.y + brickHt*0.1) { // Top 
            ball.velocity.y *= -1;
            this.count++;
      }
    }
    
    // Detecting collision on left and right side of brick
    if (ball.getY() >= this.y &&  ball.getY() <= this.y + brickHt) {
      if (ball.getX() + ball.r >= this.x && ball.getX() + ball.r <= this.x + brickWd * 0.1 || // Left Side  
          ball.getX() - ball.r <= this.x + brickWd && ball.getX() - ball.r >= this.x + brickWd * 0.9) { // Right Side
            ball.velocity.x *= -1;
            this.count++;
      }
    }
  }
}