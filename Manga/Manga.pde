PImage img;
PGraphics output;
Boolean grayscale = false;
int res = 1;
float bm = 1;
float cm = 1;
void setup() {
  img = loadImage("C:/Users/larry/Downloads/Images/1609863861475.jpg");
  if(grayscale) img.filter(GRAY);
  output = createGraphics(img.width, img.height);
  output.beginDraw();
  output.noStroke();
  output.background(0);
  PVector edge = new PVector((img.width%res)/2, (img.height%res)/2);
  for(int y = (int)edge.y; y < img.height; y += res) {
   for(int x = (int)edge.x; x < img.width; x += res) {
    float br = getAverageBrightness(x, y, res, img);
    float r = bm*(br/255)*res*sqrt(2);
    if(grayscale) output.fill(255);
    else {
     PVector rgb = getAverageRGB(x, y, res, img);
     output.fill(rgb.x, rgb.y, rgb.z);
    }
    output.circle(x, y, r*2);
   } 
  }
  output.endDraw();
  //if(!grayscale) output.filter(BLUR);
  output.save("C:/Users/larry/Desktop/testing2.png");
  exit();
}

float getAverageBrightness(int px, int py, int resolution, PImage image) {
  float sum = 0;
  for(int y = -resolution/2; y <= resolution/2; y++) {
   for(int x = -resolution/2; x <= resolution/2; x++) {  
    int index = getIndex(edgeCase(px-x,0,image.width), edgeCase(py-y,0,image.height), image.width);
    //sum += brightness(image.pixels[index])*brightness(image.pixels[index]);
    sum+= brightness(image.pixels[index]);
   } 
  }
  sum /= float(resolution*resolution);
  //sum = sqrt(sum);
  return sum;
}

PVector getAverageRGB(int px, int py, int resolution, PImage image) {
 PVector rgb = new PVector(0,0,0);
 for(int y = -resolution/2; y <= resolution/2; y++) {
   for(int x = -resolution/2; x <= resolution/2; x++) {  
    int index = getIndex(edgeCase(px-x,0,image.width), edgeCase(py-y,0,image.height), image.width);
    rgb.x += red(image.pixels[index])*red(image.pixels[index]);
    rgb.y += green(image.pixels[index])*green(image.pixels[index]);
    rgb.z += blue(image.pixels[index])*blue(image.pixels[index]);
   } 
  }
  rgb.div(resolution*resolution);
  rgb = new PVector(sqrt(rgb.x)*cm, sqrt(rgb.y)*cm, sqrt(rgb.z)*cm);
  return rgb;
}

int getIndex(int x, int y, int wd) {
 return y*wd+x; 
}

int edgeCase(int input, int lowerB, int higherB) {
 if(input >= higherB) return higherB-1;
 if(input <= lowerB)   return lowerB+1;
 else return input;
}
