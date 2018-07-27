public static final int WIDTH = 500;
public static final int HEIGHT = 500;
int maxNumberOfVertices = 8;

InfiniteLine line;
Polygon originalPoly;
Polygon clippedPoly;

PVector selectedPoint = new PVector(); // on line

void settings() {
  size(WIDTH,HEIGHT);  
}

void setup() {
  line = new InfiniteLine();
  this.generatePolygon();
}

void draw() {
  background(255);
  
  // Drawing and clipping polygon to line
  originalPoly.constrainPoly();
  originalPoly.display();
  this.clippingToLine();
  clippedPoly.constrainPoly();
  clippedPoly.display();
  originalPoly.drawControlPoints();
  
    // Drawing infinite line
  line.constrainBoxandLine();
  line.calculateLineVars();
  line.calculateWindowIntersections();
  line.displayLine();
  line.drawControlBoxes();
}

void generatePolygon() {
  ArrayList<PVector> pts = new ArrayList<PVector>();
  int numPoints = (int) (random(3,maxNumberOfVertices+1));
  for (int i = 0; i < numPoints; i++) {
    pts.add(new PVector(random(0 + (width * 0.1),width - (width * 0.1)),
                        random(0 + (height * 0.1),height - (height * 0.1))));
  }
  originalPoly = new Polygon(pts, true);
}


/*
This method clips the original polygon to a clipped polygon based upon the existence of
an infinite line.
NOTE:
  if value of kStart or kEnd < 0 then the point is on the outside of the infinite line
  if value of kStart or kEnd > 0 then the point is on the inside of the infinite line
*/
void clippingToLine() {
  clippedPoly = new Polygon(new ArrayList<PVector>(), false);
  for (int i = 0; i < originalPoly.pts.size(); i++) {
    
    int len = originalPoly.pts.size();
    PVector curr = originalPoly.pts.get(i%len);
    PVector next = originalPoly.pts.get((i+1)%len);
    
    float kStart = line.insideOutsideLine(curr.x,curr.y);
    float kEnd = line.insideOutsideLine(next.x,next.y);
    
    // Going from inside line to outside line
    if (kStart > 0 && kEnd < 0) {
      float t = line.getT(curr, next);
      
      PVector intersection = new PVector((1-t)*curr.x + t*next.x,(1-t)*curr.y + t*next.y);
      clippedPoly.pts.add(curr);
      clippedPoly.pts.add(intersection);
    }
    
    else if (kStart < 0 && kEnd > 0) {
      float t = line.getT(curr, next);
      
      PVector intersection = new PVector((1-t)*curr.x + t*next.x,(1-t)*curr.y + t*next.y);
      clippedPoly.pts.add(intersection);
      clippedPoly.pts.add(next);
    }
    
    else if (kStart > 0 && kEnd > 0) {
      clippedPoly.pts.add(curr);
      clippedPoly.pts.add(next);
    }
  }
}

// Handling mouse events
void mousePressed(){
  
  for (PVector point : originalPoly.pts) {
    if (dist(mouseX, mouseY, point.x, point.y) <= Polygon.controlPtWidth) {
      selectedPoint = point;
      return;
    }
  }
  
  if(dist(mouseX, mouseY, line.p0.x, line.p0.y) <= InfiniteLine.controlPtWidth/2){
    selectedPoint = line.p0;
    return;
  }
  
  if(dist(mouseX, mouseY, line.p1.x, line.p1.y) <= InfiniteLine.controlPtWidth/2){
    selectedPoint = line.p1;
    return;
  }
} 

void mouseDragged(){
  if(selectedPoint != null) selectedPoint.set(mouseX, mouseY);  
}

void mouseReleased(){
  selectedPoint = null;
}