class EnvelopeCanvas extends Canvas {
  float x, y, w, h;
  int mx, my;
  
  public EnvelopeCanvas(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  public void setup(PGraphics pg) {}  

  public void update(PApplet p) {
    mx = p.mouseX;
    my = p.mouseY;
    
    // update envelope on draw
    if (mx >= x && mx < x+w && my >= y && my < y+h){
      if(p.mousePressed && p.mouseButton == LEFT) {
        envelope[(int)map(mx, x, x+w, 0, envelope.length)] = cmap(my, y, y+h, 1, 0);
        isDrawGrainWave = true;
      }
    }
  }

  public void draw(PGraphics pg) {
    pg.noStroke();
    pg.fill(0);
    pg.rect(x, y, w, h);
    
    // draw the envelope
    for(int i = 0; i < envelope.length; i++) {
      pg.fill(255);
      pg.rect(x+i*w/envelope.length, y+(1-envelope[i])*h, w/envelope.length, envelope[i]*h);
    }
  }
}