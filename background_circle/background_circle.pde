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
  public double getDistanceBetweenNodes(Node n) {
    double sumOfSquares = Math.pow((this.x - n.getX()), 2) + Math.pow((this.y - n.getY()), 2);
    return Math.sqrt(sumOfSquares);
  }
  
  /**
   * Find the distance between this node and the edge of a circle
   */
  public double getDistanceFromPerimeter(int circleCenterX, int circleCenterY, int circleRadius) {
    double distFromCenter = Math.sqrt(Math.pow((this.x-circleCenterX), 2) + Math.pow((this.y-circleCenterY), 2));
    return circleRadius - distFromCenter;
  }
}

void setup() {
  int circleRadius = 400;
  color backgroundColor = color(3, 64, 92);
  int padding = -10;
  
  int numNodes = 1100;
  float nodeSize = 4.0;
  color nodeColor = color(173, 219, 200);
  
  double maxNodeDistance = 50.0;
  color edgeColor = nodeColor;
  
  /***/
  
  int windowWidth = (circleRadius * 2) + 20;
  int windowHeight = (circleRadius * 2) + 20;
  int circleCenterX = windowWidth / 2; 
  int circleCenterY = windowHeight / 2;
  
  size(windowWidth, windowHeight);
  colorMode(RGB);
  background(backgroundColor);
  smooth();
  
  // Draw a set amount of nodes at random locations within a circle, and make sure they don't intersect
  Node[] nodes = new Node[numNodes];
  int nodeCounter = 0;
  outer:
  while(nodeCounter<numNodes) {
    float x = random(padding, windowWidth-padding);
    float y = random(padding, windowHeight-padding);
    
    // don't make a node if its not inside the circle
    // if (x - center_x)^2 + (y - center_y)^2 < radius^2, its in the circle
    if((Math.pow((x-circleCenterX), 2) + Math.pow((y-circleCenterY), 2)) > Math.pow(circleRadius, 2)) {
      continue;
    }
    
    Node n = new Node(x, y, nodeSize, nodeColor);

    for(int j=0; j<nodeCounter; j++) {
      if(nodes[j].intersects(n)) {;
        continue outer;
      }
    }

    nodes[nodeCounter] = n;
    nodeCounter++;
  }
  
  // Draw edges between nodes that are set distance apart
  for(int i=0; i<numNodes; i++) {
    // if the node is close to the circle's edge, only draw one edge; else draw as many edges as possible
    boolean perimeterFlag = false;
    double distI = nodes[i].getDistanceFromPerimeter(circleCenterX, circleCenterY, circleRadius);
    if(distI < maxNodeDistance) {
      perimeterFlag = true;
    }
    
    // find a node that is [1] a set distance from the node and [2] a set distance from the circle perimeter
    if(perimeterFlag) {
      for(int j=0; j<numNodes; j++) {
        double distBetweenNodes = nodes[i].getDistanceBetweenNodes(nodes[j]);
        double distFromPerimeter = nodes[j].getDistanceFromPerimeter(circleCenterX, circleCenterY, circleRadius);
        if((distBetweenNodes < (2*maxNodeDistance)) && (distFromPerimeter > maxNodeDistance)) {
          stroke(edgeColor);
          line(nodes[i].getX(), nodes[i].getY(), nodes[j].getX(), nodes[j].getY());
          break;
        }
      }
    }
    
    else {
      for(int j=i; j<numNodes; j++) {
        if(nodes[i].getDistanceBetweenNodes(nodes[j]) < maxNodeDistance) {
          stroke(edgeColor);
          line(nodes[i].getX(), nodes[i].getY(), nodes[j].getX(), nodes[j].getY());
        }
      }
    }
  }
  
  // Draw all nodes
  for(int i=0; i<numNodes; i++) {
    nodes[i].drawNode();
  }
  
  //save("background_circle.png");
}
