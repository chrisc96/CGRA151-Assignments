public class ClippingPolygon{
  private static final int controlPtWidth = 15;
  
  // Fields
  float a; // a = y0 - y1
  float b; // b = x1 - x0
  float c; // (x0 * y1) - (x1 * y0)
  ArrayList<PVector> pts;
  
  public ClippingPolygon(ArrayList<PVector> pts){
    this.pts = pts;
  }
  
  void display(color stroke) {
    if (pts.size() == 0) return;
    
    noFill();
    stroke(stroke);
    
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
  
  
  void calculateLineVars(PVector p0, PVector p1){
    // From lecture notes
    this.a = p0.y - p1.y;
    this.b = p1.x - p0.x;
    this.c = (p1.y * p0.x) - (p1.x * p0.y);
  }
  
  float insideOutsideLine(float x, float y) {
    return a*x + b*y + c;
  }
  
  float getT(PVector curr, PVector next) {
    return (a*curr.x + b*curr.y + c)/(a*(curr.x - next.x) + b*(curr.y - next.y));
  }
  
  void constrainClippingPoly() {
      for (PVector point : this.pts) {
        if (point.x-controlPtWidth/2 <= 0) {point.x = 0 + controlPtWidth/2;}
        if (point.x+controlPtWidth/2 >= width) {point.x = width - controlPtWidth/2;}
        if (point.y-controlPtWidth/2 <= 0) {point.y = 0 + controlPtWidth/2;}
        if (point.y+controlPtWidth/2 >= height) {point.y = height - controlPtWidth/2;}
      }
  }
  
}