long prevTime = millis();
float deltaTime = 0;

// TODO:
// - Prevent clipping
// - Phase Vocoder for phase shifting
//
// - Image selection
// - Editing Grains (delete, manipulate)
// - Show associated colors on the list
// - Labels under the canvas
// - Canvas drawing improvements and introduction of brightness saturation and alpha on playback and drawing
//
// + Assign numbers to play grains
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