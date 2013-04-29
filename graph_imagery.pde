void setup() {
  PImage img;
  img = loadImage("facebook.png");
  img.loadPixels();
  
  size(img.width, img.height);
  colorMode(RGB);
  background(0);
  smooth();
  
  image(img, 0,0);
}
