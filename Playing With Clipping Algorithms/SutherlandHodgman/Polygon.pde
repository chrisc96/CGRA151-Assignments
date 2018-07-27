public class Polygon {
  
  // Fields
  private static final int controlPtWidth = 15;
  ArrayList<PVector> pts;
  
  public Polygon(ArrayList<PVector> pts) {
    this.pts = pts; 
  }
  
  void display(color stroke, color fill) {
    noFill();
    if (pts.size() == 0) return;
    stroke(stroke);
    fill(fill);
    strokeWeight(4);
    beginShape();
    for (PVector point : this.pts) {
      vertex(point.x, point.y);
    }
    endShape(CLOSE);
  }
  
  void drawControlPoints(color stroke) {
    noFill();
    stroke(stroke);
    for (PVector point : this.pts) {
        rect(point.x - controlPtWidth/2,point.y - controlPtWidth/2, controlPtWidth,controlPtWidth);
    }
  }

  void constrainPoly() {
      for (PVector point : this.pts) {
        if (point.x-controlPtWidth/2 <= 0) {point.x = 0 + controlPtWidth/2;}
        if (point.x+controlPtWidth/2 >= width) {point.x = width - controlPtWidth/2;}
        if (point.y-controlPtWidth/2 <= 0) {point.y = 0 + controlPtWidth/2;}
        if (point.y+controlPtWidth/2 >= height) {point.y = height - controlPtWidth/2;}
      }
  }
}