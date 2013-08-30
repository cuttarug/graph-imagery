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
  String imageFile = "eames.png";
  color backgroundColor = color(56);
  int padding = -20;
  
  int numNodes = 2000;
  float nodeSize = 3.0;
  color nodeColor = color(255);
  
  double maxNodeDistance = 40.0;
  color edgeColor = color(255);
  
  /***/
  
  PImage img;
  img = loadImage(imageFile);
  img.loadPixels();
  int windowWidth = img.width;
  int windowHeight = img.height;
  
  size(windowWidth, windowHeight);
  colorMode(RGB);
  background(backgroundColor);
  smooth();
  
  // Draw a set amount of nodes at random locations, and make sure they don't intersect
  Node[] nodes = new Node[numNodes];
  int nodeCounter = 0;
  outer:
  while(nodeCounter<numNodes) {
    float x = random(padding, windowWidth-padding);
    float y = random(padding, windowHeight-padding);
    
    float b = brightness(img.get((int) x, (int) y));
    if(b > 200) {
      continue;
    }
    
    Node n = new Node(x, y, nodeSize, nodeColor);

    for(int j=0; j<nodeCounter; j++) {
      if(nodes[j].intersects(n)) {
        continue outer;
      }
    }

    nodes[nodeCounter] = n;
    nodeCounter++;
  }
  
  // Draw edges between nodes that are set distance apart
  for(int i=0; i<numNodes; i++) {
    for(int j=i; j<numNodes; j++) {
      if(nodes[i].getDistance(nodes[j]) < maxNodeDistance) {
        stroke(edgeColor);
        line(nodes[i].getX(), nodes[i].getY(), nodes[j].getX(), nodes[j].getY());
      }
    }
  }
  
  // Draw all nodes
  for(int i=0; i<numNodes; i++) {
    nodes[i].drawNode();
  }
  
  //save("eames.png");
}
