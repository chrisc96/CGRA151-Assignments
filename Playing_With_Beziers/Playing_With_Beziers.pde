int numSplines = 12; // Has to be greater than three to close the curve - can't close a curve with two splines
int rectWd = 15;
PVector selectedRect;
int selectedIndex;
int count = 1;
ArrayList<PVector> points = new ArrayList<PVector>();


ArrayList<Car> cars = new ArrayList<Car>();


void settings() {
  size(1600, 900);
}

void setup() {
  this.generateCatmull();
  this.generateCars();
  noFill();
}

void draw() {
  background(192);
  this.update(40, 255); // Draws white curve behind dark grey
  this.update(30, 64); // Draws dark grey curve
  this.drawLines();
  this.drawSquares();
  this.drawCars();
}

// Generates initial Catmull-rom bezier curve
void generateCatmull() {  
  for (int i = 0; i < numSplines; i++) {
    float x = random(0 + 20, width - 200);
    float y = random(0 + 20, height - 200);
    PVector pt = new PVector(x, y);
    points.add(pt);
  }
}

void drawCars() {
  for (int i=0; i<cars.size(); i++) {
    cars.get(i).draw();
  }
}

void generateCars() {
  Car c = new Car((int) random(0, 11), random(0.0, 1.0));
  cars.add(c);
}

// Passes in strokeWeight and Colour
void update(int weight, int colour) {
  beginShape();
  stroke(colour);
  strokeWeight(weight);
  for (int i = 0; i < numSplines; i++) {
    curveVertex(points.get(i).x, points.get(i).y);
  }
  // This closes the shape
  for (int i = 0; i < 3; i++) {
    curveVertex(points.get(i).x, points.get(i).y);
  }
  endShape();
}

// Draws the squares on each control point on curve
void drawSquares() {
  strokeWeight(2);
  stroke(255, 128, 0, 128);
  for (PVector pt : points) {
    rect(pt.x - rectWd/2, pt.y - rectWd/2, rectWd, rectWd);
  }
}


// Draws lines that connect each point of curve
void drawLines() {
  strokeWeight(2);
  stroke(255, 128, 0, 128);
  for (int i = 0; i < points.size() - 1; i++) {
    PVector one = points.get(i);
    PVector two = points.get(i+1);
    line(one.x, one.y, two.x, two.y);
  }

  // The curve starts at second point and ends at the second
  // to last point. This connects the first and last point
  // up by the line
  PVector first = points.get(0);
  PVector last = points.get(numSplines - 1);
  line(first.x, first.y, last.x, last.y);
}

// Generates a new car on mouse click
void mouseClicked() {
  this.generateCars();
}

void mousePressed() {
  // Remembers the rectangle that was clicked and moves that relative to mouseX/Y.
  // On mouse release forgets the selected rectangle
  // Stops issue with mouse needing to be inside the rectangle for it to move with cursor
  if (count == 1) {
    selectedIndex = this.findClosestPoint(mouseX, mouseY);
    count = 2; // setting so doesn't execute again
  }
}

// Event handling
void mouseDragged() {
  if (selectedIndex >= 0) {
    points.get(selectedIndex).x = mouseX;
    points.get(selectedIndex).y = mouseY;
    selectedRect = points.get(selectedIndex);
    this.rectPos();
  }
}

void mouseReleased() {
  count = 1;
  selectedIndex = 0;
  selectedRect = null;
}

// Method for finding the nearest rectangle control point.
// Checks with a radius of the width of the rectangles.
// Thus only selects if within the rectangle
int findClosestPoint(float x, float y) {
  for (int i = 0; i < numSplines; i++) {
    // If the x/y value passed in (mouseClicked) are within the box of the control
    // point then return the respective integer index, otherwise, keep going through
    if ((abs(x - points.get(i).x)) <= rectWd/2 && (abs(y - points.get(i).y) <= rectWd/2)) {
      selectedIndex = i;
      return i; // returns index
    }
  }
  return -1;
}

// Stops control points from going outside of window
void rectPos() {
  if (points.get(selectedIndex).x + rectWd >= width) {
    points.get(selectedIndex).x = width - rectWd/2;
  } else if (points.get(selectedIndex).x - rectWd <= 0) {
    points.get(selectedIndex).x = 0 + rectWd/2;
  } else if (points.get(selectedIndex).y + rectWd >= height) {
    points.get(selectedIndex).y = height - rectWd/2;
  } else if (points.get(selectedIndex).y - rectWd <= 0) {
    points.get(selectedIndex).y = 0 + rectWd/2;
  }
}  