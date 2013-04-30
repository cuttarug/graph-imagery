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
      stroke(255);
      ellipse(x,y, 2,2);
      brightNodes--;
    }
  }
  
  while(darkNodes > 0) {
    int x = (int) random(img.width);
    int y = (int) random(img.height);
    
    float b = brightness(img.get(x,y));
    if(b < 200) {
      stroke(27,199,245);
      ellipse(x,y, 2,2);
      darkNodes--;
    }
  }
}
