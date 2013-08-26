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
}

void setup() {
  int windowWidth = 500;
  int windowHeight = 500;
  color backgroundColor = color(59, 89, 152);
  
  /***/
  
  size(windowHeight, windowWidth);
  colorMode(RGB);
  background(backgroundColor);
  smooth();
}
