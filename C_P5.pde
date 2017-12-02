import controlP5.*;
import java.util.*;

ControlP5 cp5;
ControlWindow controlWindow;
Canvas gc, wc, ec, sc, gwc;

int marginx = 30;
int marginy = 45;

void initControls() {
  cp5 = new ControlP5(this);
  
  // Canvas
  gc = new GrainCanvas();
  gc.pre(); // use cc.post(); to draw on top of existing controllers.
  cp5.addCanvas(gc);
  
  printArray(PFont.list());
  PFont font = createFont("Ubuntu Mono Bold", 11);
  cp5.setFont(font);
  textFont(font);
  
  // Editors
  initListWindow();
  initEditWindow();
}

void initListWindow() {
  Group grainListGroup = cp5.addGroup("grainListGroup")
                            .setPosition(width - (width * 0.35), marginy)
                            .setTitle("Grains List")
                            .setWidth(int(width*0.1 - marginx))
                            .setBackgroundHeight(height - 2*marginy)
                            .setBackgroundColor(color(255,50));              
  grainListGroup.disableCollapse();
  grainListGroup.getCaptionLabel().setVisible(false);
  
  cp5.addScrollableList("grains_dropdown")
     .setPosition(10, 10)
     .setSize(int(width*0.1 - marginx)-20, height - 2*marginy - 20)
     .setBarHeight(20)
     .setItemHeight(20)
     .setType(ControlP5.LIST)
     .setGroup(grainListGroup);
}

void initEditWindow() {
  Group grainEditGroup = cp5.addGroup("grainEditGroup")
                            .setPosition(width - (width * 0.25), marginy)
                            .setTitle("Create and edit grains")
                            .setWidth(int(width*0.25 - 3*marginx))
                            .setBackgroundHeight(height - 2*marginy)
                            .setBackgroundColor(color(255,50));              
  grainEditGroup.disableCollapse();
  grainEditGroup.getCaptionLabel().hide();
 
  String[] filenames = listFileNames(sketchPath()+"/samples");
  cp5.addScrollableList("samples_dropdown")
     .setPosition(10, 10)
     .setSize(int(width*0.19), 200)
     .setBarHeight(20)
     .setItemHeight(20)
     .addItems(Arrays.asList(filenames))
     .setType(ControlP5.LIST)
     .setGroup(grainEditGroup);
  
  // Sample Player
  wc = new WaveformCanvas();
  wc.pre(); // use cc.post(); to draw on top of existing controllers.
  cp5.addCanvas(wc); 
  
  
  cp5.addTextlabel("samplenamelabel")
    .setText("Sample Name: "+selectedSample)
    .setPosition(10,200+150+30)
    .setGroup(grainEditGroup);
  cp5.addTextlabel("sampledurationlabel")
    .setText("Sample Length: 0 ms")
    .setPosition(10,200+150+50)
    .setGroup(grainEditGroup);
  cp5.addTextlabel("graindurationlabel")
    .setText("Selection Length: 0 ms")
    .setPosition(10,200+150+70)
    .setGroup(grainEditGroup);

  // TODO: Put buttons for common envelopes (hamming, hanning)
  ec = new EnvelopeCanvas();
  ec.pre(); // use cc.post(); to draw on top of existing controllers.
  cp5.addCanvas(ec); 
  
  // Waveshape of the grain
  gwc = new GrainWaveformCanvas();
  gwc.pre(); // use cc.post(); to draw on top of existing controllers.
  cp5.addCanvas(gwc); 
  
  
  // Save grain button
  sc = new GrainSaveCanvas();
  sc.pre(); // use cc.post(); to draw on top of existing controllers.
  cp5.addCanvas(sc); 
}


class GrainSaveCanvas extends Canvas {
  public float x, y;
  public float w, h;
  
  private float animTime = 500;
  
  private float prevTime = millis();
  private float timeElapsed = 0;
  
  int mx, my;
  public void setup(PGraphics pg) {
    h = 50;
    y = height-marginy-10-h;
  }  

  public void update(PApplet p) {
    x = p.width * 0.75 + 10;
    w = p.width*0.19;
    
    mx = p.mouseX;
    my = p.mouseY;
    
    if(timeElapsed < animTime && p.keyPressed && p.key == 'k'){
      timeElapsed += (millis() - prevTime);
    }
    
    if(timeElapsed > animTime)
    {
      timeElapsed = 0;
      saveGrain(w, x);
    }
    if(timeElapsed < 0)
      timeElapsed = 0;
    
    if(!p.keyPressed || p.key != 'k')
      timeElapsed -= timeElapsed/10;
    prevTime = millis();
  }

  public void draw(PGraphics pg) {
    pg.fill(27);
    pg.rect(x, y, w, h);
    
    pg.fill(timeElapsed > animTime ? 255 : map(timeElapsed, 0, animTime, 27, 200));
    pg.rect(x, y, map(timeElapsed, 0, animTime, 0, w), h);
    
    pg.textAlign(CENTER,CENTER);
    pg.textSize(16);
    pg.fill(map(timeElapsed, 0, animTime, 255, -100));
    pg.text("Press and Hold 'K' button", x+w*0.5, y+h*0.5);
  }
}


String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}