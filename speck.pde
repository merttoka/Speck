float prevTime = millis();
float time = 0;
float deltaTime = 0;

PVector resolution = new PVector(60, 24);
float maxTime = 10000;

void setup() {
  fullScreen(2);
  
  frameRate(30);
  noSmooth();
  
  imageFileName = "containerized_deployments.png";
  
  initControls();
  initAudio();
}

void draw() {
  background(50);
  deltaTime = millis() - prevTime;
 
  // App drawing
 
  prevTime = millis();
}