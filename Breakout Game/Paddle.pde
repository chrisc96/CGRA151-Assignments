public class Paddle {
  float y;
  float wd;
  float halfwd;
  float halfht;
  float ht;
  
  public Paddle() {
    y = height * 0.85;
    wd = width/7;
    ht = height/30;
    halfwd = wd/2;
    halfht = ht / 2;
  }
  
  public void draw() {
    boolean draw = true;    
    
    // Stopping paddle from going off the screen
    // For RHS
    if (mouseX >= width - halfwd) {
      draw = false;
      rect(width - wd, y, wd, ht);
    }
    
    // For LHS
    if (mouseX <= 0 + halfwd) {
      draw = false;
      rect(0, y, wd, ht);
    }
    
    if (draw) {
      rect(mouseX - halfwd, y, wd, ht);
    }
  }
  
  public void collisionDetection() {
    if (ball.getX() >= mouseX - halfwd && ball.getX() <= mouseX + halfwd) {
      // Top Y Middle X Segment
      if ((ball.getY() >= y - ball.r && ball.getY() <= y) || (ball.getY() >= y + ht && ball.getY() <= y + ht + ball.r)) {
        ball.velocity.y *= -1;  
      }
    }
    
    else if (ball.getX() >= mouseX - halfwd - ball.r && ball.getX() <= mouseX - halfwd) {
      // Top Y Left X Corner Segment
      if ((ball.getY() >= y - ball.r && ball.getY() <= y) || (ball.getY() >= y + ht && ball.getY() <= y + ht + ball.r)) {
        ball.velocity.y *= -1;
        ball.velocity.x *= -1;
      }
      
      // Left X Middle Y Segment
      else if (ball.getY() > y && ball.getY() < y + ht) {
        ball.velocity.x *= -1;
      }
      
      // Bottom Y Left X Corner Segment
      else if (ball.getY() >= y + ht && ball.getY() <= y + ht + ball.r) {
        ball.velocity.y *= -1;
        ball.velocity.x *= -1;
      }
    }
    
    else if (ball.getX() >= mouseX + halfwd && ball.getX() <= mouseX + halfwd + ball.r) {
      // Top Y Right X Corner Segment
      if ((ball.getY() >= y - ball.r && ball.getY() <= y) || (ball.getY() >= y + ht && ball.getY() <= y + ht + ball.r)) {
        ball.velocity.y *= -1;
        ball.velocity.x *= -1;
      }
      
      // Middle Y Right X Segment
      else if (ball.getY() > y && ball.getY() < y + ht) {
        ball.velocity.x *= -1;
      }
      
      // Bottom Y Right X Segment
      else if (ball.getY() >= y + ht && ball.getY() <= y + ht + ball.r) {
        ball.velocity.y *= -1;
        ball.velocity.x *= -1;
      }
    }
  }
}