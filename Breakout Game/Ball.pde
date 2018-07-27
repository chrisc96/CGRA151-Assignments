public class Ball {
  PVector position;
  PVector velocity;
  float r; // radius
  float diam;
  
  public Ball(float x, float y, float d) {
    position = new PVector(x,y);
    velocity = new PVector(random(3.0,7.5), random(3.0,7.5));
    this.diam = d;
    this.r = this.diam/2;
  }
  
  public float getX() {return position.x;}
  public float getY() {return position.y;}
  
  public void move() {
    position.add(velocity);
  }
  
  public void bounce() {
    if (position.x + r >= width || position.x - r <= 0) {velocity.x *= -1;}
    if (position.y + r >= height || position.y - r <= 0) {velocity.y *= -1;}
  }
  
  public void draw() {
    ellipse(position.x, position.y,this.diam,this.diam);
  }
}