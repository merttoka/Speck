
class GrainCanvas extends Canvas {
  public float x, y;
  public float w, h;
  
  int mx, my;
  public void setup(PGraphics pg) {
    x = marginx;
    y = marginy;
  }  

  public void update(PApplet p) {
    w = p.width * 0.65 - 2*marginx;
    h = p.height - 2*marginy;
    
    mx = p.mouseX;
    my = p.mouseY;
  }

  public void draw(PGraphics pg) {
    // renders a square with randomly changing colors
    // make changes here.
    pg.fill(27);
    pg.rect(x, y, w, h);
  }
}