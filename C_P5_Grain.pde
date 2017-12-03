
int brushSize = 100;
int brushHardness = 0;

PImage brush;
color brushColor = color(255, 255, 255);

float scalex = 20;
float scaley = 20;

void updateBrush(boolean reinstantiate) {
  if(reinstantiate)
    brush = new PImage(brushSize, brushSize, ARGB);
    
  brush.loadPixels();
  for(int i = 0; i < brushSize; i++){
    for(int j = 0; j < brushSize; j++){
      brush.pixels[i*brushSize+j] = color(red(brushColor), green(brushColor), blue(brushColor), 
                                          map(dist(j,i, brushSize*0.5,brushSize*0.5), 
                                              brushSize*0.5*map(brushHardness, 0, 100, 0, 1), brushSize*0.5, 
                                              50, 0));
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
    w = pg.width*.65-2*marginx;
    h = (pg.height-2*marginy)*0.9;
    canvas = createImage(int(w/scalex), int(h/scaley), ARGB);
    
    updateBrush(true);
    
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
                     int((mx-marginx-brushSize/2)/scalex), int((my-marginy-brushSize/2)/scaley), int(brushSize/scalex), int(brushSize/scaley),
                     ADD);
      }
    }
  }

  public void draw(PGraphics pg) {
    // Background
    pg.fill(27);
    pg.rect(x, y, w, h);
    
    pg.image(canvas, x, y, w, h*0.9);
    
    if (mx > x && mx < x+w && my > y && my < y+h*0.9){
      if(selectedGrain != null) {
        pg.stroke(map(brushHardness, 0, 100, 255, 100));
        pg.noFill();
        pg.image(brush, mx-brushSize*0.5, my-brushSize*0.5);
        pg.ellipse(mx-brushSize*0.5, my-brushSize*0.5, brushSize, brushSize);
      }
    }
    
    
  }
}