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
    this.numEdges = (int) random(2,5);
  }
  
  public void draw() {
    stroke(this.c);
    ellipse(this.x, this.y, this.radius, this.radius);
  }
}

void setup() {
  size(960, 609);
  colorMode(RGB);
  background(22,107,186);
  smooth();

  int numNodes = 2000;
  Node[] nodes = new Node[numNodes];
  
  int nodeCounter = 0;
  while(nodeCounter < numNodes) {
    int x = (int) random(960);
    int y = (int) random(680);
    nodes[nodeCounter] = new Node(x, y, 6, color(255, 0.5));
    nodes[nodeCounter].draw();
    nodeCounter++;
  }
  
  for(int i=0; i<numNodes; i++) {
    Node n1 = nodes[i];
    for(int j=i+1; j<numNodes; j++) {
      if(n1.numEdges == 0) {
        break;
      }
      Node n2 = nodes[j];
      double dist = Math.sqrt(Math.pow(n1.x-n2.x, 2) + Math.pow(n1.y-n2.y, 2));
      if(dist < 35.0) {
        stroke(255);
        line(n1.x,n1.y, n2.x,n2.y);
        n1.numEdges--;
      }
    }
  }
}
