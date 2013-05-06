public class Node {
  public int x;
  public int y;
  private int radius;
  private color c;
  public int numEdges;
  
  public Node(int i, int j, int radius, color c) {
    this.x = i;
    this.y = j;
    this.radius = radius;
    this.c = c;
    this.numEdges = (int) random(1,3);
  }
  
  public void draw() {
    stroke(this.c);
    ellipse(this.x, this.y, this.radius, this.radius);
  }
}

public class Edge {
  public Node from;
  public Node to;
  public color c;
  
  public Edge(Node from, Node to, color c) {
    this.from = from;
    this.to = to;
    this.c = c;
  }
  
  public void draw() {
    stroke(this.c);
    line(this.from.x, this.from.y, this.to.x, this.to.y);
  }
}

void setup() {
  PImage img;
  img = loadImage("../facebook.png");
  img.loadPixels();
  
  size(img.width, img.height);
  colorMode(RGB);
  background(0);
  smooth();

  int numBrightNodes = 8000;
  int numDarkNodes = 3000;  
  Node[] brightNodes = new Node[numBrightNodes];
  Node[] darkNodes = new Node[numDarkNodes];
  
  int brightCounter = 0;
  while(brightCounter < numBrightNodes) {
    int x = (int) random(img.width);
    int y = (int) random(img.height);
    
    float b = brightness(img.get(x,y));
    if(b > 200) {
      brightNodes[brightCounter] = new Node(x,y,2,255);
      brightCounter++;
    }
  }
  
  int darkCounter = 0;
  while(darkCounter < numDarkNodes) {
    int x = (int) random(img.width);
    int y = (int) random(img.height);
    
    float b = brightness(img.get(x,y));
    if(b < 200) {
      darkNodes[darkCounter] = new Node(x, y, 2, color(27,199,245));
      darkCounter++;
    }
  }
  
  for(int i=0; i<numDarkNodes; i++) {
    Node n1 = darkNodes[i];
    for(int j=i+1; j<numBrightNodes; j++) {
      if(n1.numEdges == 0) {
        break;
      }
      Node n2 = brightNodes[j];
      double dist = Math.sqrt(Math.pow(n1.x-n2.x, 2) + Math.pow(n1.y-n2.y, 2));
      if(dist < 280.0) {
        stroke(27,199,245,85);
        line(n1.x,n1.y, n2.x,n2.y);
        n1.numEdges--;
      }
    }
  }
  
  for(int i=0; i<numBrightNodes; i++) {
    Node n1 = brightNodes[i];
    for(int j=i+1; j<numBrightNodes; j++) {
      if(n1.numEdges == 0) {
        break;
      }
      Node n2 = brightNodes[j];
      double dist = Math.sqrt(Math.pow(n1.x-n2.x, 2) + Math.pow(n1.y-n2.y, 2));
      if(dist > 10.0 && dist < 80.0) {
        stroke(27,199,245,85);
        line(n1.x,n1.y, n2.x,n2.y);
        n1.numEdges--;
      }
    }
  }
  
  for(int i=0; i<numBrightNodes; i++) {
    brightNodes[i].draw();
  }
  
  for(int i=0; i<numDarkNodes; i++) {
    darkNodes[i].draw();
  }
  
  save("output.png");
}
