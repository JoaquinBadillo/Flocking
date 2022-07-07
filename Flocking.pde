Flock flock;

void setup() {
  size(1920, 1080);
  flock = new Flock();
}

void draw() {
  background(0, 0, 40);
  flock.newState();
  //rec();
}

/*void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}*/
