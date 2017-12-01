float[] envelope_values = new float[32];

// TODO: Curve Drawing rather than arrays

class EnvelopeCanvas extends Canvas {
  public float x, y;
  public float w, h;
  
  int mx, my;
  boolean mPress;
  int mButton;
  char kKey;
  
  public void setup(PGraphics pg) {
    y = 220+2*marginy+200;
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
    pg.noStroke();
    pg.fill(0);
    pg.rect(x, y, w, h);
    
    if (mx >= x && mx < x+w && my >= y && my < y+h){
      if(mPress && mButton == LEFT) {
        envelope_values[(int)map(mx, x, x+w, 0, envelope_values.length)] = map(my, y, y+h, 1, 0);
        isDrawGrainWave = true;
      }
    }
    
    for(int i = 0; i < envelope_values.length; i++) {
      pg.fill(255);
      pg.rect(x+i*w/envelope_values.length, y+(1-envelope_values[i])*h, w/envelope_values.length, envelope_values[i]*h);
    }
  }
}