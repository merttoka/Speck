import controlP5.*;
import java.util.*;

ControlP5 cp5;
ControlWindow controlWindow;
Canvas gc, wc, ec;

int marginx = 30;
int marginy = 45;

void initControls() {
  cp5 = new ControlP5(this);
  
  gc = new GrainCanvas();
  gc.pre(); // use cc.post(); to draw on top of existing controllers.
  cp5.addCanvas(gc); 
  
  Group grainListGroup = cp5.addGroup("grainListGroup")
                            .setPosition(width - (width * 0.35), marginy)
                            .setTitle("Grains List")
                            .setWidth(int(width*0.1 - marginx))
                            .setBackgroundHeight(height - 2*marginy)
                            .setBackgroundColor(color(255,50));              
  cp5.addBang("A-1")
     .setPosition(10,20)
     .setSize(80,20)
     .setGroup(grainListGroup);
          
  cp5.addBang("A-2")
     .setPosition(10,60)
     .setSize(80,20)
     .setGroup(grainListGroup);
  
  Group grainEditGroup = cp5.addGroup("grainEditGroup")
                            .setPosition(width - (width * 0.25), marginy)
                            .setTitle("Create and edit grains")
                            .setWidth(int(width*0.25 - 3*marginx))
                            .setBackgroundHeight(height - 2*marginy)
                            .setBackgroundColor(color(255,50));              
  //cp5.addTextfield("path")
  //   .setPosition(10,10)
  //   .setSize(int(width*0.19), 25)
  //   .setFocus(false)
  //   .setGroup(grainEditGroup);
  
  //cp5.addBang("A-3")
  //   .setPosition(10,50)
  //   .setSize(int(width*0.19),20)
  //   .setGroup(grainEditGroup);
          
  //cp5.addBang("A-4")
  //   .setPosition(10,90)
  //   .setSize(int(width*0.19),20)
  //   .setGroup(grainEditGroup);
  
  String[] filenames = listFileNames(sketchPath()+"/samples");
  cp5.addScrollableList("samples_dropdown")
     .setPosition(10, 10)
     .setSize(int(width*0.19), 200)
     .setBarHeight(20)
     .setItemHeight(20)
     .addItems(Arrays.asList(filenames))
     .setType(ControlP5.LIST)
     .setGroup(grainEditGroup);
     
  wc = new WaveformCanvas();
  wc.pre(); // use cc.post(); to draw on top of existing controllers.
  cp5.addCanvas(wc); 
  
  ec = new EnvelopeCanvas();
  ec.pre(); // use cc.post(); to draw on top of existing controllers.
  cp5.addCanvas(ec); 
  
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