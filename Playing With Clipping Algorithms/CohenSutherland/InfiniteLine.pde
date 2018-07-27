public class InfiniteLine{
  
  private static final int controlPtWidth = 10;
  
  // Fields
  PVector p0, p1; // two control points
  float a; // a = y0 - y1
  float b; // b = x1 - x0
  float c; // (x0 * y1) - (x1 * y0)
  float m; // gradient : y0 - y1 / x1 - x0 OR a/b 
  
  // Fields for infinite line intersections w/ window frame
  float p0Top, p0Left, p0Right, p0Bottom;
  float p1Top, p1Left, p1Right, p1Bottom;
  
  public InfiniteLine(){
    p0 = new PVector(width * 0.8, 0.1 * height);
    p1 = new PVector(width * 0.8, 0.9 * height);
  }
  
  /*
  return a decision variable in the form of a number
  that depicts whether the vertex of the polygon is
  inside, outside or on the line
  */
  float insideOutsideLine(float x, float y) {
    return a*x + b*y + c;
  }
  
  /*
  returns the intersection point of the infinite clipping
  line and two vertices
  */
  float getT(PVector curr, PVector next) {
    return (a*curr.x + b*curr.y + c)/(a*(curr.x - next.x) + b*(curr.y - next.y));
  }
  
  /* 
  For the equation ax + by + c = 0, the
  following calculates the parameters knowing
  x and y for each point.
  This updates whenever the line is moved
  */
  void calculateLineVars(){
    // From lecture notes
    a = p0.y - p1.y;
    b = p1.x - p0.x;
    c = (p1.y * p0.x) - (p1.x * p0.y);
  }
  
  void calculateWindowIntersections() {
    /* 
    By making each four window sides have an equation. E.G: RHS
    x = width (like 750), we can use ax + by + c = 0 plugging in
    x = 750 to solve for the y value using the already calculated
    a,b and c values.
    You have to do this for both control points: to find intersections
    with the window frame
    */
    p0Top = -c/a;
    p0Left = -c/b;
    p0Right = (-a * height - c)/b;
    p0Bottom = (-width * b - c)/a;
    
    p1Top = -c/a;
    p1Left = -c/b;
    p1Right = (-a * height - c)/b;
    p1Bottom = (-width * b - c)/a;
  }
  
  void constrainBoxandLine() { 
    // Limiting the two boxes/control points within the window frame
    if (p0.x-controlPtWidth/2 <= 0) {p0.x = 0 + controlPtWidth/2;}
    if (p0.x+controlPtWidth/2 >= width) {p0.x = width - controlPtWidth/2;}
    if (p0.y-controlPtWidth/2 <= 0) {p0.y = 0 + controlPtWidth/2;}
    if (p0.y+controlPtWidth/2 >= height) {p0.y = height - controlPtWidth/2;}
    
    if (p1.x-controlPtWidth/2 <= 0) {p1.x = 0 + controlPtWidth/2;}
    if (p1.x+controlPtWidth/2 >= width) {p1.x = width - controlPtWidth/2;}
    if (p1.y-controlPtWidth/2 <= 0) {p1.y = 0 + controlPtWidth/2;}
    if (p1.y+controlPtWidth/2 >= height) {p1.y = height - controlPtWidth/2;}
  }
  
  void drawControlBoxes() {
    stroke(#0033CC);
    strokeWeight(2);
    
    rect(p0.x-controlPtWidth/2, p0.y-controlPtWidth/2, controlPtWidth, controlPtWidth);
    rect(p1.x-controlPtWidth/2, p1.y-controlPtWidth/2, controlPtWidth, controlPtWidth);
  }
  
  void displayLine(){
    stroke(#00CCFF);
    strokeWeight(3);
    line(p0.x, p0.y, p1.x, p1.y);
    
    // Draws the extending line from p0 to intersection with respective window
    if(p0Top > 0 && p0Top < width) {line(p0Top, 0, p0.x, p0.y);} 
    if(p0Bottom > 0 && p0Bottom < width) {line(p0Bottom, height, p0.x, p0.y);} 
    if(p0Left > 0 && p0Left < height) {line(0, p0Left, p0.x, p0.y);}
    if(p0Right > 0 && p0Right < height) {line(width, p0Right, p0.x, p0.y);} 
    
    // Draws the extending line from p1 to intersection with respective window
    if(p1Top > 0 && p1Top < width) {line(p1Top, 0, p1.x, p1.y);} 
    if(p1Bottom > 0 && p1Bottom < width) {line(p1Bottom, height, p1.x, p1.y);} 
    if(p1Left > 0 && p1Left < height) {line(0, p1Left, p1.x, p1.y);} 
    if(p1Right > 0 && p1Right < height) {line(width, p1Right, p1.x, p1.y);}
  }
}