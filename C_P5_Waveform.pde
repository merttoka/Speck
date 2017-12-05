boolean isDrawWave = true;
class WaveformCanvas extends Canvas {
  public float x, y, w, h;
  
  int mx, my;
  boolean mPress;
  int mButton;
  char kKey;
  
  PGraphics wave;
  
  WaveformCanvas(float x, float y, float w, float h) {
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
    mPress = p.mousePressed;
    mButton = p.mouseButton;
    
    kKey = p.key;
    if(p.keyPressed && p.key == '0') {
      selection[0] = -1;
      selection[1] = -1;
      
      filePlayer.setLoopPoints(0, filePlayer.length());
    }
  }

  public void draw(PGraphics pg) {
    pg.noStroke();
    pg.fill(0);
    pg.rect(x, y, w, h);
    
    if (mx >= x && mx < x+w && my >= y && my < y+h){
      pg.stroke(200, 0, 0, 150);
      pg.line(mx, y, mx, y+h);
      
      if(mPress && mButton==LEFT && filePlayer != null) {
        float pos = map(mx, x, x+w, 0, filePlayer.length());
        selection[0] = mx;
        selection[1] = -1;
        filePlayer.cue((int)pos);
        updateGrainDuration();
      }
      else if(mPress && mButton==RIGHT && filePlayer != null) {
        selection[1] = mx;
        
        isDrawGrainWave = true;
        
        // limit to 1/fps seconds chops
        float pos1 = map(selection[0], x, x+w, 0, filePlayer.length());
        float pos2 = map(selection[1], x, x+w, 0, filePlayer.length());
        if(abs(pos2-pos1) > file.sampleRate()/frameRate) {
          selection[1] = map(pos1+file.sampleRate()/frameRate, 0, filePlayer.length(), x, x+w);
        }
        
        // Redraws grain duration
        updateGrainDuration();
      }
    }
    
    // Draw loop selections
    if(selection[0] >= 0) {
      pg.stroke(200, 180, 0);
      pg.line(selection[0], y, selection[0], y+h);
    } 
    if(selection[1] >= 0) {
      pg.stroke(180, 200, 0);
      pg.line(selection[1], y, selection[1], y+h);
    }
    if(selection[0] >= 0 && selection[1] >= 0) {
      pg.noStroke();
      pg.fill(190, 190, 0, 50);
      pg.rect(selection[0], y, selection[1]-selection[0], h);
      filePlayer.setLoopPoints((int)map(selection[0], x, x+w, 0, filePlayer.length()),
                               (int)map(selection[1], x, x+w, 0, filePlayer.length()));
    }
    
    // Draw player cue (position)
    if(filePlayer.isPlaying()) {
      float songPos = map( filePlayer.position(), 0, filePlayer.length(), x, x+w);
      pg.stroke(169, 200, 90, 150);
      pg.line(songPos, y, songPos, y+h);
    }
    
    // Draw waveshape
    if(filePlayer != null && file != null && isDrawWave) {
      float[] samples = file.getChannel(AudioSample.LEFT);
      wave.beginDraw();
      wave.background(0,0);
      for( int i = 0; i < samples.length - 1; i++ )
      {
        // find the x position of each buffer value
        float x1  = map( i, 0, samples.length, x, x+w );
        float x2  = map( i+1, 0, samples.length, x, x+w );
        float _y  = y + h*0.5;
      
        wave.stroke(255);
        wave.line( x1, _y + samples[i]*h*0.6, x2, _y + samples[i+1]*h*0.6);
      }  
      wave.endDraw();
      isDrawWave = false;
    }
    pg.image(wave, 0, 0);
  }
}