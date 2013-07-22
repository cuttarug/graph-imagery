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
  size(500, 500);
  colorMode(RGB);
  background(240, 238, 217);
  smooth();
  
  int x1 = (int) random(5, 30);
  int y1 = (int) random(5, 30);
  Node a = new Node(x1, y1, 4, color(127, 71, 79));
  
  int x2 = x1 + (int) random(20, 40);
  int y2 = y1 + (int) random(20, 40);
  Node b = new Node(x2, y2, 4, color(127, 71, 79));
  
  fill(127, 71, 79);
  a.draw();
  b.draw();
  
  stroke(127, 71, 79);
  line(x1,y1, x2,y2);
  
  for(int i=0; i<50; i++) {
    double slope = (double) (b.y-a.y) / (b.x-a.x);
    double nr = -1/slope;
    double midx = (double) (a.x+b.x)/2;
    double midy = (double) (a.y+b.y)/2;
    double intercept = midy - (nr * midx);
    
    double x3 = midx + random(20, 40);
    double y3 = (nr * x3) + intercept;
    Node c = new Node((int) x3, (int) y3, 4, color(127, 71, 79));
    c.draw();
    
    stroke(127, 71, 79);
    line(a.x,a.y, (int) x3, (int) y3);
    line(b.x,b.y, (int) x3, (int) y3);
    
    a = b;
    b = c;
  }
  
  /*make node 1
  make node 2
  set a as node 1
  set b as node 2
  draw a
  
  draw b
  make a node 3 at midpoint between a and b
  draw node 3
  set a = b
  set b = node 3
  */
  
  
}
