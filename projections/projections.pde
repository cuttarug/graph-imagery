public class Node {
  private float x;
  private float y;
  private float r;
  private color c;
  private int numEdges;
  
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
  
  public void incrementNumEdges(int i) {
    this.numEdges += i;
  }
  
  public int getNumEdges() {
    return this.numEdges;
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
  String imageFile = "facebook.png";
  color backgroundColor = color(0);
  int padding = -20;
  
  float nodeSize = 2.0;
  int numBrightNodes = 6000;
  color brightNodeColor = color(255);
  int numDarkNodes = 3000;
  color darkNodeColor = color(27,199,245);
  
  color darkEdgeColor = color(27,199,245,85);
  color brightEdgeColor = color(27,199,245,85);
  
  double maxDarkBrightDistance = 280.0;
  int maxDarkBrightEdges = 1;
  double maxBrightBrightDistance = 80.0;
  int maxBrightBrightEdges = 3;
  
  /***/
  
  PImage img;
  img = loadImage(imageFile);
  img.loadPixels();
  int windowWidth = img.width;
  int windowHeight = img.height;
  
  size(windowWidth, windowHeight);
  colorMode(RGB);
  background(0);
  smooth();
  
  //Draw a set amount of nodes at random locations, and make sure they don't intersect
  Node[] brightNodes = new Node[numBrightNodes];
  int brightNodeCounter = 0;
  outer:
  while(brightNodeCounter < numBrightNodes) {
    int x = (int) random(padding, windowWidth-padding);
    int y = (int) random(padding, windowHeight-padding);
    
    float b = brightness(img.get(x,y));
    if(b < 200) {
      continue;
    }
    
    Node n = new Node(x, y, nodeSize, brightNodeColor);
    
    /*for(int j=0; j<brightNodeCounter; j++) {
      if(brightNodes[j].intersects(n)) {
        continue outer;
      }
    }*/
    
    brightNodes[brightNodeCounter] = n;
    brightNodeCounter++;
  }
  
  Node[] darkNodes = new Node[numDarkNodes];
  int darkNodeCounter = 0;
  outer:
  while(darkNodeCounter < numDarkNodes) {
    int x = (int) random(padding, windowWidth-padding);
    int y = (int) random(padding, windowHeight-padding);
    
    float b = brightness(img.get(x,y));
    if(b > 200) {
      continue;
    }
    
    Node n = new Node(x, y, nodeSize, darkNodeColor);
    
    for(int j=0; j<darkNodeCounter; j++) {
      if(darkNodes[j].intersects(n)) {
        continue outer;
      }
    }
    
    darkNodes[darkNodeCounter] = n;
    darkNodeCounter++;
  }
  
  //Draw edges between nodes that are a set distance apart
  //dark-bright nodes
  for(int i=0; i<numDarkNodes; i++) {
    for(int j=i; j<numBrightNodes; j++) {
      if(darkNodes[i].getNumEdges() == maxDarkBrightEdges) {
        break;
      }
      if(darkNodes[i].getDistance(brightNodes[j]) < maxDarkBrightDistance) {
        stroke(darkEdgeColor);
        line(darkNodes[i].getX(), darkNodes[i].getY(), brightNodes[j].getX(), brightNodes[j].getY());
        darkNodes[i].incrementNumEdges(1);
      }
    }
  }
  
  //bright-bright nodes
  for(int i=0; i<numBrightNodes; i++) {
    for(int j=i; j<numBrightNodes; j++) {
      if(brightNodes[i].getNumEdges() == maxBrightBrightEdges) {
        break;
      }
      if(brightNodes[i].getDistance(brightNodes[j]) < maxBrightBrightDistance) {
        stroke(brightEdgeColor);
        line(brightNodes[i].getX(), brightNodes[i].getY(), brightNodes[j].getX(), brightNodes[j].getY());
        brightNodes[i].incrementNumEdges(1);
      }
    }
  }
  
  //Draw nodes
  for(int i=0; i<numBrightNodes; i++) {
    brightNodes[i].drawNode();
  }
  
  for(int i=0; i<numDarkNodes; i++) {
    darkNodes[i].drawNode();
  }
  
  //save("projections.png");
}
