public class Car {

  float x;
  float y;
  float xTangent;
  float yTangent;
  float angle;
  float position;
  int curve = 0;
  int random;
  int len = points.size();
  color c = color((int) random(255),(int) random(255),(int) random(255));

  public Car(int curve, float position) {
    this.curve = curve;
    this.position = position;
  }

  void draw() {
    x = curvePoint(points.get(curve%len).x, points.get((curve+1)%len).x, points.get((curve+2)%len).x, points.get((curve+3)%len).x, position);
    y = curvePoint(points.get(curve%len).y, points.get((curve+1)%len).y, points.get((curve+2)%len).y, points.get((curve+3)%len).y, position);
    xTangent = curveTangent(points.get(curve%len).x, points.get((curve+1)%len).x, points.get((curve+2)%len).x, points.get((curve+3)%len).x, position);
    yTangent = curveTangent(points.get(curve%len).y, points.get((curve+1)%len).y, points.get((curve+2)%len).y, points.get((curve+3)%len).y, position);
    angle = atan2(yTangent, xTangent);

    pushMatrix();  
    translate(x, y);
    rotate(angle);
    fill(c);
    beginShape();
    vertex(0, 0);
    vertex(-10, -10);
    vertex(30, 0);
    vertex(-10, 10);    
    endShape(CLOSE);
    noFill();
    popMatrix();

    this.position += 0.01;
    if (this.position >= 1.0) {
      curve++;
      this.position = 0.0;
    }
  }
}