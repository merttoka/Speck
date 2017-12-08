boolean isDrawGrainWave = true;

class GrainWaveformCanvas extends Canvas {
  float x, y, w, h;
  int mx, my;
  
  PGraphics wave;
  
  GrainWaveformCanvas(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  public void setup(PGraphics pg) {
    wave = createGraphics(pg.width, pg.height);
  }  

  public void update(PApplet p) {
    mx = p.mouseX;
    my = p.mouseY;
  }

  public void draw(PGraphics pg) {
    // background
    pg.noStroke();
    pg.fill(0);
    pg.rect(x, y, w, h);
    
    if(selection[0] >= 0 && selection[1] >= 0 && isDrawGrainWave){
      float[] samples = file.getChannel(0);
      int pos1 = (int)cmap(selection[0], x, x+w, 0, samples.length);
      int pos2 = (int)cmap(selection[1], x, x+w, 0, samples.length);
      float[] grain_samples = {};
      if(pos1 < pos2)
        grain_samples = subset(samples, pos1, pos2-pos1);
      else if(pos1 > pos2)
        grain_samples = reverse(subset(samples, pos2, pos1-pos2));
      
      float min = min(grain_samples);
      float max = max(grain_samples);
      wave.beginDraw();
      wave.background(0,0);
      for( int i = 0; i < grain_samples.length - 1; i++ )
      {
        // find the x coordinate of each buffer value
        float x1  = cmap( i, 0, grain_samples.length, x, x+w );
        float x2  = cmap( i+1, 0, grain_samples.length, x, x+w );
        float _y  = y + h*0.5;
      
        float e1 = getFloatIndex(envelope, cmap(i, 0, grain_samples.length, 0, envelope.length));
        float e2 = getFloatIndex(envelope, cmap(i+1, 0, grain_samples.length, 0, envelope.length));
      
        float offset1 = map(grain_samples[i  ]*e1, min, max, -h/2, h/2);
        float offset2 = map(grain_samples[i+1]*e2, min, max, -h/2, h/2); 
      
        wave.stroke(255);
        wave.line( x1, _y + offset1, x2, _y + offset2);
      }  
      wave.endDraw();
      
      isDrawGrainWave = false;  
    }
    pg.image(wave, 0, 0);
  }
}