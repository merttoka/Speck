boolean isDrawGrainWave = true;

class GrainWaveformCanvas extends Canvas {
  public float x, y;
  public float w, h;
  
  int mx, my;
  boolean mPress;
  int mButton;
  char kKey;
  
  PGraphics wave;
  
  public void setup(PGraphics pg) {
    y = 220+2*marginy+400;
    
    wave = createGraphics(pg.width, pg.height);
  }  

  public void update(PApplet p) {
    x = p.width - (p.width*0.25) + 10;
    
    w = int(p.width*0.19);
    h = 100;
    
    mx = p.mouseX;
    my = p.mouseY;
    mPress = p.mousePressed;
    mButton = p.mouseButton;
    
    kKey = p.key;
  }

  public void draw(PGraphics pg) {
    // background
    pg.noStroke();
    pg.fill(0);
    pg.rect(x, y, w, h);
    
    if(selection[0] >= 0 && selection[1] >= 0 && isDrawGrainWave){
      float[] samples = file.getChannel(AudioSample.LEFT);
      int pos1 = (int)map(selection[0], x, x+w, 0, samples.length);
      int pos2 = (int)map(selection[1], x, x+w, 0, samples.length);
      float[] grain_samples = subset(samples, min(pos1, pos2), abs(pos2-pos1));
      
      wave.beginDraw();
      wave.background(0,0);
      for( int i = 0; i < grain_samples.length - 1; i++ )
      {
        // find the x position of each buffer value
        float x1  = map( i, 0, grain_samples.length, x, x+w );
        float x2  = map( i+1, 0, grain_samples.length, x, x+w );
        float _y  = y + h*0.5;
      
        float e1 = envelope[(int)map(i, 0, grain_samples.length, 0, envelope.length)];
        float e2 = envelope[(int)map(i+1, 0, grain_samples.length, 0, envelope.length)];
      
        wave.stroke(255);
        wave.line( x1, _y + grain_samples[i]*e1*h, x2, _y + grain_samples[i+1]*e2*h);
      }  
      wave.endDraw();
      
      isDrawGrainWave = false;  
    }
    pg.image(wave, 0, 0);
  }
}