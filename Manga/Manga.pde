PImage img;
PGraphics output;
int res = 10;
float p = 0.35;
void setup() {
  img = loadImage("C:/Users/larry/Downloads/Images/lain.png");
  img.filter(GRAY);
  output = createGraphics(img.width, img.height);
  output.beginDraw();
  output.fill(255);
  output.noStroke();
  output.background(0);
  PVector edge = new PVector((img.width%res+50)/2, (img.height%res+50)/2);
  for(int y = (int)edge.y; y < img.height; y += res) {
   for(int x = (int)edge.x; x < img.width; x += res) {
    float br = getAverageBrightness(x, y, res, img);
    float r = p*(br/255)*res*sqrt(2);
    output.circle(x, y, r*2);
   } 
  }
  output.endDraw();
  output.save("C:/Users/larry/Desktop/testing2.png");
  exit();
}

float getAverageBrightness(int px, int py, int resolution, PImage image) {
  float sum = 0;
  for(int y = -resolution/2; y <= resolution/2; y++) {
   for(int x = -resolution/2; x <= resolution/2; x++) {  
    sum += brightness(image.pixels[getIndex(edgeCase(px-x,0,image.width), edgeCase(py-y,0,image.height), image.width)]);
    
   } 
  }
  sum /= float(resolution*resolution);
  return sum;
}

int getIndex(int x, int y, int wd) {
 return y*wd+x; 
}

int edgeCase(int input, int lowerB, int higherB) {
 if(input >= higherB) return higherB-1;
 if(input <= lowerB)   return lowerB+1;
 else return input;
}
