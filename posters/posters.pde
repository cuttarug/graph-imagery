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
}

void setup() {
  int windowWidth = 500;
  int windowHeight = 500;
  color backgroundColor = color(59, 89, 152);
  
  int numNodes = 250;
  float nodeSize = 7.0;
  color nodeColor = color(255);
  
  /***/
  
  size(windowHeight, windowWidth);
  colorMode(RGB);
  background(backgroundColor);
  smooth();
  
  Node[] nodes = new Node[numNodes];
  int nodeCounter = 0;
  outer:
  while(nodeCounter<numNodes) {
    float x = random(padding, windowWidth-padding);
    float y = random(padding, windowHeight-padding);
    Node n = new Node(x, y, nodeSize, nodeColor);

    for(int j=0; j<nodeCounter; j++) {
      if(nodes[j].intersects(n)) {;
        continue outer;
      }
    }

    nodes[nodeCounter] = n;
    nodeCounter++;
  }
  
  for(int i=0; i<numNodes; i++) {
    nodes[i].drawNode();
  }
}
