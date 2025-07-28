/*
Here's a visual for how we want the slider, satPercent, and newBrightness to be mapped:

sliderValue      0--------512---------1024
satPercent       1.0------1.0----------0.0
newBrightness    0--------1024--------1024

*/


PImage img;

import processing.serial.*;
int slideValue = 0;

float mx;
float my;
float easing = .75;
int radius = 140;
int edge = 10;
int inner = edge + radius;
float satPercent;
int newBrightness;
int magColor;

Serial myPort;

void setup() {
  fullScreen();
  noStroke();
  frameRate(30);
  //ellipseMode(RADIUS);
  //rectMode(CORNERS);
  img = loadImage("rgb.png");
  img.resize(1280, 1024);
  colorMode(HSB, 1023);
  noCursor();

  println(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n');
}

void draw() {
  //Here we create a percentage from 100% to 0%
  //It stays at 100% until halfway up the slider, then drops to 0
  satPercent = map(slideValue, 512, 1023, 1.0, 0.0);
  satPercent = constrain(satPercent, 0.0, 1.0);          //keep the percentage betwen 0-1, don't want it smaller or bigger

  //Similarly, we want to go from 0 to 1024 when the slider hits halfway
  //After halfway, we want full brightness
  newBrightness = int(map(slideValue, 0, 512, 0, 1024));
  newBrightness = constrain(newBrightness, 0, 1024);    //keep brightness between 0 and 1024.

  image(img, 0, 0);

  if (abs(mouseX - mx) > 0.01) {
    mx = mx + (mouseX - mx) * easing;
  }
  if (abs(mouseY - my) > 0.01) {
    my = my + (mouseY- my) * easing;
  }

  magColor = img.get(mouseX, mouseY);


  fill(hue(magColor), saturation(magColor)*satPercent, newBrightness);
  print("Raw Slide: ");
  println(slideValue);
  println();

  //square(mouseX - 150, mouseY - 150, 300);
 // mx = constrain(mx, inner, width - inner);
 // my = constrain(my, inner, height - inner);

  //rect(edge, edge, width-edge, height-edge);

  square(mx - 150, my - 150, 300);
   //square(mx - 50, my - 50, 300);
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
