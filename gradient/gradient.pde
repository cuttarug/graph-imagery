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
  
  int numNodes = 750;
  float nodeSize = 3.0;
  color nodeColor = color(35, 34, 31);
  
  color edgeColor = color(35, 34, 31, 30);
  
  int gridSpacing = 20;
  double minNodeDist = 15.0;
  double maxNodeDist = 75.0;
  
  /***/
  
  size(windowWidth, windowHeight);
  colorMode(RGB);
  background(backgroundColor);
  smooth();
  
  // Set up a dimishing grid
  ArrayList<Node> nodes = new ArrayList();
  int numOmits = 2;
  for(int i=padding; i<windowWidth-padding; i+=gridSpacing) {
    
    ArrayList omits = new ArrayList();
    for(int k=0; k<numOmits; k++) {
      int randPos = (int) random(gridSpacing) * gridSpacing + padding;
      omits.add(randPos);
    }
    
    for(int j=padding; j<windowHeight-padding; j+=gridSpacing) {
      // randomly omit nodes
      if(omits.contains(j)) {
        continue;
      }
      // save nodes in a list
      Node n = new Node(i, j, nodeSize, nodeColor);
      nodes.add(n);
      numNodes--;
    }
    numOmits++;
  }
  
  // Set up nodes at random locations, and make sure they don't intersect
  outer:
  while(numNodes > 0) {
    int x = (int) random(padding*4, windowWidth-padding);
    int y = (int) random(padding/1.2, windowHeight-padding/1.2);
    
    Node n = new Node(x, y, nodeSize, nodeColor);
    
    for(int j=0; j<nodes.size(); j++) {
      if(nodes.get(j).intersects(n)) {
        continue outer;
      }
    }
    
    nodes.add(n);
    numNodes--;
  }
  
  // Draw edges between nodes that are a diminishing distance apart
  System.out.println(nodes.size());
  for(int i=0; i<nodes.size(); i++) {
    for(int j=0; j<nodes.size(); j++) {
      Node a = nodes.get(i);
      Node b = nodes.get(j);
      if(a.getDistance(b) > minNodeDist && a.getDistance(b) < Math.floor(maxNodeDist)) {
        stroke(edgeColor);
        line(a.getX(), a.getY(), b.getX(), b.getY());
      }
    }
    maxNodeDist -= 0.08;
  }
  
  // Draw nodes
  for(int i=0; i<nodes.size(); i++) {
    nodes.get(i).drawNode();
  }
}
