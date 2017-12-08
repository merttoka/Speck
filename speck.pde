long prevTime = millis();
float deltaTime = 0;

// TODO:
// - Prevent clipping
// - Phase Vocoder for phase shifting
// - Canvas drawing improvements and introduction of brightness saturation and alpha on playback and drawing
// + Draw normalized grain wave 
// + Reverse sample playback on selection


void setup() {
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