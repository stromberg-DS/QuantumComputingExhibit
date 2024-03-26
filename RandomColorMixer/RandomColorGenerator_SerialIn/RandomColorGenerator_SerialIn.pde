import processing.serial.*;
int buttonPressed;
int currentMillis;
int lastMillis;
int flashSpeed = 150;
Serial myPort;

void setup() {
  //size(800, 800);
  fullScreen();
  colorMode(HSB, 400);
  textAlign(CENTER);

  // I know that the first port in the serial list on my Mac is always my
  // Arduino, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[0], 9600);

  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');
}

void draw() {
  currentMillis = millis();
  int timeSinceFlash = currentMillis-lastMillis;
  // set the background color with the color values:
  if (buttonPressed == 1) {
    if (timeSinceFlash > flashSpeed) {
      background(random(0, 400), 400, 400);
      fill(random(0, 400), 400, 400);
      textSize(200);
      text("Quantum Computing!", width/2, height/2+50);
      lastMillis = currentMillis;
    }
  } else {
    delay(3000);
  }
}

void serialEvent(Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');
  if (inString != null) {
    inString = trim(inString);    //trim off any whitespace
    buttonPressed = int(inString);  //
    println(buttonPressed);
  }
}
