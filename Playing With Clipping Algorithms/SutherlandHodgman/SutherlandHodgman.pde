// Constants
public static final int WIDTH = 1000;
public static final int HEIGHT = 1000;

// Object declarations
PVector selectedPoint; // for selecting control points
ClippingPolygon clipping;
Polygon p;
Polygon clipped;

// Editable variables to alter program
int maxNumPolyVertices = 3;  // maximum number of vertices for input polygon

void settings() {
  size(WIDTH, HEIGHT);
}

void setup() {
  this.generateClippingPoly();
  this.generatePoly();
}

void draw() {
  background(255);
  p.constrainPoly();
  p.display(color(64,219,105), color(189,240,203));

  clipping.constrainClippingPoly();
  this.clipAlgo();
  clipped.display(color(90,120,219), color(189,201,240));
  p.drawControlPoints(color(64,219,105));
  
  clipping.drawControlPoints(color(0));
  clipping.display(color(0));
}

void generateClippingPoly() {
  ArrayList<PVector> pts = new ArrayList<PVector>();
    pts.add(new PVector(0.4*width, 0.4*height)); // top left
    pts.add(new PVector(0.4*width, 0.6*height)); // bottom left
    pts.add(new PVector(0.6*width, 0.6*height)); // bottom right
    pts.add(new PVector(0.6*width, 0.4*height)); // top right
    clipping = new ClippingPolygon(pts);
}

void generatePoly() {
  ArrayList<PVector> pts = new ArrayList<PVector>();
  
  int numPoints = (int) (random(3, maxNumPolyVertices+1));
  for (int i = 0; i < numPoints; i++) {
    pts.add(new PVector(random(0 + (width * 0.1), width - (width * 0.1)),
      random(0 + (height * 0.1), height - (height * 0.1))));
  }
  p = new Polygon(pts);
}

void clipAlgo() {
  int len = clipping.pts.size();
  ArrayList<PVector> outputList = new ArrayList<PVector>(p.pts);
  
  for (int i = 0; i < clipping.pts.size(); i++) {
    // p0 and p1 represent one edge
    PVector EdgeP0 = clipping.pts.get((i)%len);
    PVector EdgeP1 = clipping.pts.get((i+1)%len);
    clipping.calculateLineVars(EdgeP0,EdgeP1); // setting a,b,c for respective clipping edge
    
    ArrayList<PVector> changingInputs = new ArrayList<PVector>(outputList);
    outputList.clear();

    for (int j = 0; j < changingInputs.size(); j++) {
      
      int len1 = changingInputs.size();
      if (len1 == 0) {
        clipped = new Polygon(p.pts);
        return;
      }
      
      PVector curr = changingInputs.get((j)%len1);
      PVector next = changingInputs.get((j+1)%len1);
      
      float kStart = clipping.insideOutsideLine(curr.x,curr.y);
      float kEnd = clipping.insideOutsideLine(next.x,next.y);
      
      // inside to outside
      if (kStart < 0 && kEnd > 0) {
        float t = clipping.getT(curr,next);
        PVector intersection = new PVector((1-t)*curr.x + t*next.x,(1-t)*curr.y + t*next.y);
        outputList.add(intersection);
      }
      
      // outside to inside
      else if (kStart > 0 && kEnd < 0) {
        float t = clipping.getT(curr,next);
        PVector intersection = new PVector((1-t)*curr.x + t*next.x,(1-t)*curr.y + t*next.y);
        outputList.add(intersection);
        outputList.add(next);
      }
      
      // inside to inside
      else if (kStart < 0 && kEnd < 0) {
        outputList.add(next);
      }
    }
  }
  clipped = new Polygon(outputList);
}

// Handling mouse/key events
void keyPressed() {
    if (keyCode == 'I') {
      // Inserts a new random point into the polygon
      p.pts.add(new PVector(random(0 + (width * 0.1), width - (width * 0.1)),
      random(0 + (height * 0.1), height - (height * 0.1))));
    } 
    else if (keyCode == 'R') {
      // Removes the last listed vertex unless the size is = 3
      // as polygon cannot be achieved with 2 points
      if (p.pts.size() > 3) {
        p.pts.remove(p.pts.size()-1);
      }
    }
}

void mousePressed() {  
  for (PVector point : clipping.pts) {
    if (dist(mouseX, mouseY, point.x, point.y) <= ClippingPolygon.controlPtWidth) {
      selectedPoint = point;
      return;
    }
  }

  for (PVector point : p.pts) {
    if (dist(mouseX, mouseY, point.x, point.y) <= Polygon.controlPtWidth) {
      selectedPoint = point;
      return;
    }
  }
} 

void mouseDragged() {
  if (selectedPoint != null) selectedPoint.set(mouseX, mouseY);
}

void mouseReleased() {
  selectedPoint = null;
}