// TODO: Curve Drawing rather than arrays

float getInterpolation(float index) {
  int lo = floor(index);
  int hi = lo+1;
  float t = index % 1.0;
  if(lo >= 0 && hi < envelope.length) {
    return envelope[lo]*(1-t) + envelope[hi]*t;
  }
  return 0;
}

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
    
    if (mx >= x && mx < x+w && my >= y-30 && my < y+h+30){
      if(mPress && mButton == LEFT) {
        envelope[(int)map(mx, x, x+w, 0, envelope.length)] = constrain(map(my, y, y+h, 1, 0), 0, 1);
        isDrawGrainWave = true;
      }
    }
    
    for(int i = 0; i < envelope.length; i++) {
      pg.fill(255);
      pg.rect(x+i*w/envelope.length, y+(1-envelope[i])*h, w/envelope.length, envelope[i]*h);
    }
  }
}