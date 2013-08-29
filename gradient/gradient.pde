public class Node {
  private float x;
  private float y;
  private float r;
  private color c;

  public Node(float i, float j, float rad, color col) {
    this.x = i;
    this.y = j;
    this.r = rad;
    this.c = col;
  }
  
  public float getX() {
    return this.x;
  }

  public float getY() {
    return this.y;
  }

  public float getRadius() {
    return this.r;
  }
  
  public void drawNode() {
    stroke(this.c);
    fill(this.c);
    ellipse(this.x, this.y, this.r, this.r);
  }
  
  /**
   * Determines whether this node and another node intersect.
   * Two nodes intersect if sum of radii >= distance between centers.
   */
  public boolean intersects(Node n) {
    double sumRadii = Math.pow((this.r + n.getRadius()), 2);
    double distanceCenters = Math.pow((this.x - n.getX()), 2) + Math.pow((this.y - n.getY()), 2);
    return sumRadii >= distanceCenters;
  }
  
  /**
   * Find the distance between this node and another node
   */
  public double getDistance(Node n) {
    double sumOfSquares = Math.pow((this.x - n.getX()), 2) + Math.pow((this.y - n.getY()), 2);
    return Math.sqrt(sumOfSquares);
  }
}

void setup() {
  int windowWidth = 960;
  int windowHeight = 465;
  color backgroundColor = color(233, 228, 209);
  int padding = 40;
  
  float nodeSize = 3.0;
  color nodeColor = color(35, 34, 31);
  
  color edgeColor = color(35, 34, 31, 30);
  
  int gridSpacing = 20;
  
  /***/
  
  size(windowWidth, windowHeight);
  colorMode(RGB);
  background(backgroundColor);
  smooth();
  
  ArrayList<Node> nodes = new ArrayList();
  
  // draw a perfect grid up till breakpoint
  for(int i=0; i<5; i++) {
    int x = i*gridSpacing + padding;
    
    int omit1 = (int) random(20);
    int omit2 = (int) random(20);
    
    for(int j=0; j<20; j++) {
      if(j == omit1 || j == omit2) {
        continue;
      }
      int y = j*gridSpacing + padding;
      Node n = new Node(x, y, nodeSize, nodeColor);
      nodes.add(n);
    }
  }
  
  // draw a messy grid after breakpoint
  for(int i=5; i<40; i++) {
    int x = i*gridSpacing + padding;
    
    int omit1 = (int) random(20);
    int omit2 = (int) random(20);
    int omit3 = (int) random(20);
    int omit4 = (int) random(20);
    //int omit5 = (int) random(20);
    
    for(int j=0; j<20; j++) {
      if(j == omit1 || j == omit2 || j == omit3 || j == omit4 ){//|| j == omit5) {
        continue;
      }
      int y = j*gridSpacing + padding;
      int randX = (int) random(-8,8);
      int randY = (int) random(-8,8);
      Node n = new Node(x+randX, y+randY, nodeSize, nodeColor);
      nodes.add(n);
    }
  }
  
  // Draw edges between nodes that are a diminishing distance apart
  double maxNodeDist = 70.0;
  for(int i=0; i<nodes.size(); i++) {
    for(int j=0; j<nodes.size(); j++) {
      Node a = nodes.get(i);
      Node b = nodes.get(j);
      if(a.getDistance(b) > 20 && a.getDistance(b) < maxNodeDist) {
        stroke(edgeColor);
        line(a.getX(), a.getY(), b.getX(), b.getY());
      }
    }
    maxNodeDist -= 0.068;
  }
  
  // Draw nodes
  for(int i=0; i<nodes.size(); i++) {
    nodes.get(i).drawNode();
  }
  
  //save("gradient.png");
}
