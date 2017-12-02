//ArrayList<PShape> shapes = new ArrayList<PShape>();
//int current_index = 0;

void setup() {
  //size(800, 500);
  fullScreen(1);
  frameRate(30);
  noSmooth();
  initControls();
  initAudio();
  
  //addDefaultShape();
  
  initNetwork(12000, 57120);
  
  textAlign(CENTER, CENTER);
  textSize(8);
}

void draw() {
  background(50);
  
  //drawGrid();
  
  //text(current_index + " / " + shapes.size() ,  width-40, 30);
  //text(frameRate, width-40, 15);
  
  //for (int i = 0; i < shapes.size(); i++) {
  //  PShape s = shapes.get(i);
    
  //  if(i != current_index) {
  //    fill (255);
  //  }
    
  //  shape(s, 0, 0);
  //}
}

//void drawGrid() {
//  for(int i = 1; i < 25; i++) {
//    stroke(255, 15);
//    float y = map(log(i), log(1), log(25), height-10, 0);
//    line(0, y, width, y);
//    text(map(i, 1, 25, 0, maxfreq), 18, y);
//  }
//}

//void addDefaultShape() {
//  PShape s = createShape();
//  s.beginShape();
//  s.colorMode(HSB, 360, 100, 100);
//  s.fill(map(shapes.size(), 0, 12, 0, 360), 56, 80, 150);
//  s.stroke(0, 0, 100);
//  s.endShape();
//  shapes.add(s);
//}