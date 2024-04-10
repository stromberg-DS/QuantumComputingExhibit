void setup(){
  size(600,600);
}

void draw(){
  for(int x=0; x<width; x++){
    for(int y=0; y<height; y++){
      stroke(map(x, 0, width, 0, 255), map(y, 0, height, 0, 255), map(y, 0, height, 255,0));
      point(x,y);
    }
  }
  
  int magColor = get(mouseX, mouseY);
  
  noStroke();
  fill(magColor);
  circle(mouseX, mouseY, 100);
  
  
}
