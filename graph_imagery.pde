public class Node {
  public int x;
  public int y;
  private int radius;
  private color c;
  
  public Node(int i, int j, int radius, color c) {
    this.x = i;
    this.y = j;
    this.radius = radius;
    this.c = c;
  }
  
  public void draw() {
    stroke(this.c);
    ellipse(this.x, this.y, this.radius, this.radius);
  }
}

void setup() {
  PImage img;
  img = loadImage("facebook.png");
  img.loadPixels();
  
  size(img.width, img.height);
  colorMode(RGB);
  background(0);
  smooth();
  
  int brightNodes = 3000;
  int darkNodes = 3000;
  
  while(brightNodes > 0) {
    int x = (int) random(img.width);
    int y = (int) random(img.height);
    
    float b = brightness(img.get(x,y));
    if(b > 200) {
      Node n = new Node(x,y,2,255);
      n.draw();
      brightNodes--;
    }
  }
  
  while(darkNodes > 0) {
    int x = (int) random(img.width);
    int y = (int) random(img.height);
    
    float b = brightness(img.get(x,y));
    if(b < 200) {
      Node n = new Node(x, y, 2, color(27,199,245));
      n.draw();
      darkNodes--;
    }
  }
}
