 PImage img; 

float mx;
float my;
float easing = .75;
int radius = 140;
int edge = 10;
int inner = edge + radius;

void setup() {
  fullScreen();
  noStroke(); 
  //ellipseMode(RADIUS);
  //rectMode(CORNERS);
  img = loadImage("rgb.png");
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
  fill(magColor);
  //square(mouseX - 150, mouseY - 150, 300);
  mx = constrain(mx, inner, width - inner);
  my = constrain(my, inner, height - inner);
  
  //rect(edge, edge, width-edge, height-edge);
   
  square(mx - 150, my - 150, 300);
}
