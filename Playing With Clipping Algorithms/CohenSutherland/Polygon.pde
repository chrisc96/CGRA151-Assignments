public class Polygon {
  
  // Fields
  private static final int controlPtWidth = 10;
  ArrayList<PVector> pts;
  boolean original;
  
  public Polygon(ArrayList<PVector> pts, boolean original) {
    this.pts = pts; 
    this.original = original;
  }
  
  void display() {
    if (pts.size() == 0) return;
    if (original) {stroke(#D3DBD4);}
    else {stroke(#26F04B);}
    beginShape();
    for (PVector point : this.pts) {
      vertex(point.x, point.y);
    }
    endShape(CLOSE);
  }
  
  void drawControlPoints() {
    if (original) {  
      for (PVector point : this.pts) {
          rect(point.x - controlPtWidth/2,point.y - controlPtWidth/2, controlPtWidth,controlPtWidth);
      }
    }
  }

  void constrainPoly() {
      // Limiting the two boxes/control points within the window frame
      for (PVector point : this.pts) {
        if (point.x-controlPtWidth/2 <= 0) {point.x = 0 + controlPtWidth/2;}
        if (point.x+controlPtWidth/2 >= width) {point.x = width - controlPtWidth/2;}
        if (point.y-controlPtWidth/2 <= 0) {point.y = 0 + controlPtWidth/2;}
        if (point.y+controlPtWidth/2 >= height) {point.y = height - controlPtWidth/2;}
      }
  }
}