
int brushSize = 100; 
PImage brush;
color brushColor = color(255, 255, 255);

void updateBrush() {
  brush.loadPixels();
  for(int i = 0; i < brushSize; i++){
    for(int j = 0; j < brushSize; j++){
      brush.pixels[i*brushSize+j] = color(red(brushColor), green(brushColor), blue(brushColor), 
                                          map(dist(j,i, brushSize*0.5,brushSize*0.5), 0, brushSize*0.5, 255, 0));
    }
  }
  brush.updatePixels();
}

class GrainCanvas extends Canvas {
  public float x, y;
  public float w, h;
  
  private PImage canvas;
  
  int mx, my;
  public void setup(PGraphics pg) {
    canvas = createImage(int(pg.width*.65-2*marginx), int((pg.height-2*marginy)*0.9), ARGB);
    brush = createImage(brushSize, brushSize, ARGB);
    
    updateBrush();
    
    x = marginx;
    y = marginy;
  }  

  public void update(PApplet p) {
    w = p.width * 0.65 - 2*marginx;
    h = p.height - 2*marginy;
    
    mx = p.mouseX;
    my = p.mouseY;
    
    if (mx >= x && mx < x+w && my >= y && my < y+h){
      if(p.mousePressed && p.mouseButton == LEFT) {
        canvas.blend(brush, 
                     0, 0, (int)brushSize, (int)brushSize, 
                     int(mx-marginx-brushSize/2), int(my-marginy-brushSize/2), (int)brushSize, (int)brushSize,
                     ADD);
      }
    }
  }

  public void draw(PGraphics pg) {
    // Background
    pg.fill(27);
    pg.rect(x, y, w, h);
    
    pg.image(canvas, x, y);
    
    if (mx > x && mx < x+w && my > y && my < y+h*0.9){
      if(selectedGrain != null) {
        pg.stroke(255);
        pg.noFill();
        pg.image(brush, mx-brushSize*0.5, my-brushSize*0.5);
        pg.ellipse(mx-brushSize*0.5, my-brushSize*0.5, brushSize, brushSize);
      }
    }
    
    
  }
}