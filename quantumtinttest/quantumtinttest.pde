 PImage img; 
 
import processing.serial.*;
int slideValue = 0;

float mx;
float my;
float easing = .75;
int radius = 140;
int edge = 10;
int inner = edge + radius;

Serial myPort;

void setup() {
  fullScreen();
  noStroke(); 
  //ellipseMode(RADIUS);
  //rectMode(CORNERS);
  img = loadImage("rgb.png");
  
  
  colorMode(HSB, 1024);
  
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n');
  
}

void draw() { 
   {
  image(img, 0, 0, 1920, 1080);
}
  if (abs(mouseX - mx) > 0.01) {
    mx = mx + (mouseX - mx) * easing;
  }
  if (abs(mouseY - my) > 0.01) {
    my = my + (mouseY- my) * easing;
  }
  int magColor = get(mouseX, mouseY);
  
  //Below maxes the brightness but doesn't get to white
  fill(hue(magColor), saturation(magColor), slideValue);
  //square(mouseX - 150, mouseY - 150, 300);
  mx = constrain(mx, inner, width - inner);
  my = constrain(my, inner, height - inner);
  
  //rect(edge, edge, width-edge, height-edge);
   
  square(mx - 150, my - 150, 300);
}

void serialEvent(Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    
    slideValue = int(inString);

  }
}
