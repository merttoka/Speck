long prevTime = millis();
float deltaTime = 0;

void setup() {
  //size(800, 500);
  fullScreen(1);
  
  frameRate(30);
  noSmooth();
  
  initControls();
  initAudio();
  
  textAlign(CENTER, CENTER);
  textSize(8);
}

void draw() {
  background(50);
  deltaTime = millis() - prevTime;
  
  // App drawing
 
  prevTime = millis();
}