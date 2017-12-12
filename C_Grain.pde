//////////////////////////////////
float DEBUG_TIME = 0; 
float[] DEBUG_TIME_ARRAY =  new float[(int)resolution.x];
//////////////////////////////////

boolean isPlaying = false;
int current_timestamp = -1;

PImage canvas;
PImage im;

String imageFileName = "";

class GrainCanvas extends Canvas {
  public float x, y, w, h;
  
  int mx, my;
  
  color[] getPixelsAt(int _x) {
    color[] ys = new int[canvas.height];
    
    int j = 0;
    for(int i = _x; i < canvas.pixels.length; i+=canvas.width) {
      ys[j++] = canvas.pixels[i];  
    }
    
    return ys;
  }
  void loadImageInCanvas(String filename, boolean normalizeColors) {
    im = loadImage("images/"+filename);
    im.resize(int(resolution.x), int(resolution.y));
    
    if(normalizeColors) {
      colorMode(HSB, maxGrains, 100, 100);
      im.loadPixels();
      for (int i = 0; i < im.pixels.length; i++) {
        color c = im.pixels[i];
        im.pixels[i] = color(0,0);
        if(alpha(c) > 5) {
          int hue = hue(c) % 1.0f > 0.5 ? ceil(hue(c)) : floor(hue(c));
          im.pixels[i] = color(hue, 100, 100);
        }
      }
      im.updatePixels();
      colorMode(RGB, 255, 255, 255);
    }
  }
  
  public GrainCanvas(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    canvas = createImage(int(resolution.x), int(resolution.y), ARGB);
    
    //loadImageInCanvas("sign.png", true);
    loadImageInCanvas(imageFileName, true);
  }
  
  public void setup(PGraphics pg) {}  

  public void update(PApplet p) {
    w = p.width * 0.65 - 2*marginx;
    h = p.height - 2*marginy;
    
    mx = p.mouseX;
    my = p.mouseY;
    
    if (mx >= x && mx < x+w && my >= y && my < y+h){
      try {
        int pixdex = int((my-marginy)/(h/resolution.y)) * canvas.width + int((mx-marginx)/(w/resolution.x));
        if(p.mousePressed && p.mouseButton == LEFT && selectedGrain != null) {
          canvas.loadPixels();
          canvas.pixels[pixdex] = selectedGrain.grainColor;
          canvas.updatePixels();
        }
        else if(p.mousePressed && p.mouseButton == RIGHT) {
          canvas.loadPixels();
          canvas.pixels[pixdex] = color(0, 0);
          canvas.updatePixels();
        }
      } catch(Exception e) {
        print(",");
      }
    }
    
    if (isPlaying) {
      time += deltaTime;
      
      // trig samples only on integer time
      int timestamp_location = int(map(time, 0, maxTime, 0, canvas.width));
      if(timestamp_location > current_timestamp) {
         current_timestamp = timestamp_location;
         
         
         ///////D_TIMING////////////
         try{
           println(DEBUG_TIME +" ms/"+(maxTime/resolution.x)+" ms");
           DEBUG_TIME_ARRAY[current_timestamp] = DEBUG_TIME;
           DEBUG_TIME = 0;
           if(current_timestamp == resolution.x - 1) DEBUG_TIME_ARRAY = new float[(int)resolution.x];
         } catch(Exception e) {}
         ///////////////////////////
         
         color[] arr = getPixelsAt(current_timestamp);
         colorMode(HSB, maxGrains, 100, 100);
         for(int i = 0; i < arr.length; i++) {
           if(arr[i] != 0) {
             int id = int(hue(arr[i]));
             if( id < grains.size()){
               Grain g = grains.get(id);
               
               g.sample.setSampleRate(g.sampleRate * cmap(i, 0, arr.length, 0.1 , 2));
               g.sample.trigger();
             }
           }
         }
         colorMode(RGB, 255, 255, 255);
      }
      ///////D_TIMING////////////
      else {
        DEBUG_TIME += deltaTime;
      }
      ///////////////////////////
        
      if(time > maxTime) { 
        time -= maxTime; 
        current_timestamp = -1;
      }
    }
  }

  public void draw(PGraphics pg) {
    // Background
    pg.fill(27);
    pg.rect(x, y, w, h);
    
    // draw the grid
    pg.stroke(255, 20);
    for(int i = 0; i < resolution.x; i++) {
      float _x = x + w/resolution.x*i;
      pg.line(_x, y, _x, y+h);
    }
    for(int j = 0; j < resolution.y; j++) {
      if(j < resolution.y*0.5)
        pg.stroke(255, map(j, 0, resolution.y*0.5, 2, 15));
      else if (j == resolution.y*0.5)
        pg.stroke(255, 50);
      else
        pg.stroke(255, map(j, resolution.y*0.5, resolution.y, 15, 2));
        
      float _y = y + h/resolution.y*j;
      pg.line(x, _y, x+w, _y);
    }
    
    pg.image(canvas, x, y, w, h);
    
    // draw timer
    float _x = x + map(time, 0, maxTime, 0, w);
    pg.stroke(255, isPlaying ? 150 : 50);
    pg.line(_x, y, _x, y+h);
    
    ////////////////////////////////////////
    //pg.fill(0);
    //pg.rect(x,y,w*0.2, h*0.1);
    //pg.noStroke();
    //pg.fill(200);
    //for(int i=0; i < current_timestamp;i++) {
    //  float _h = cmap(DEBUG_TIME_ARRAY[i], min(DEBUG_TIME_ARRAY), max(DEBUG_TIME_ARRAY), 0, h*0.1);
    //  pg.rect(x + i*w*0.2/DEBUG_TIME_ARRAY.length,
    //          y + h*0.1 - _h, 
    //          w*0.2/DEBUG_TIME_ARRAY.length, 
    //          _h);
    //}
    ////////////////////////////////////////
  }
}