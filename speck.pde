long prevTime = millis();
float deltaTime = 0;

void setup() {
  //size(800, 500);
  fullScreen(2);
  
  
  frameRate(30);
  noSmooth();
  
  initControls();
  initAudio();
}

void draw() {
  background(50);
  deltaTime = millis() - prevTime;
  
  // App drawing
 
  prevTime = millis();
}