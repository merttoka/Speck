import controlP5.*;
import java.util.*;

ControlP5 cp5;
Canvas gc, wc, ec, sc, gwc;

int marginx = 30;
int marginy = 45;

// Initializes the GUI components
void initControls() {
  cp5 = new ControlP5(this);
  
  // Canvas
  gc = new GrainCanvas(marginx, marginy, 
                       width*.65-2*marginx, height-2*marginy);
  gc.pre();
  cp5.addCanvas(gc);
  
  // Setup font systemwide
  PFont font = createFont("Courier New", 11);
  cp5.setFont(font);
  textFont(font);
  textAlign(CENTER, CENTER);
  
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
  
  ScrollableList sl = cp5.addScrollableList("grains_dropdown")
                       .setPosition(10, 10)
                       .setSize(int(width*0.1 - marginx)-20, height - 2*marginy - 20)
                       .setBarHeight(20)
                       .setItemHeight(20)
                       .setType(ControlP5.LIST)
                       .setGroup(grainListGroup);
}

void initEditWindow() {
  PVector container_position = new PVector(width - (width * 0.25), marginy);
  
  int container_margin = 10;
  int container_width = int(width*0.25 - 3*marginx);
  int container_height = int(height - 2*marginy);
  
  PVector element_position = new PVector(container_position.x+container_margin,
                                         container_position.y+container_margin);
  int element_width = int(container_width - 2*container_margin);
  int item_height = 200;
  
  Group grainEditGroup = cp5.addGroup("grainEditGroup")
                            .setTitle("Create and edit grains")
                            .setPosition(container_position.x, container_position.y)
                            .setWidth(container_width)
                            .setBackgroundHeight(container_height)
                            .setBackgroundColor(color(255,50))
                            .disableCollapse();
  grainEditGroup.getCaptionLabel().hide();
 
  String[] filenames = listFileNames(sketchPath()+"/samples");
  cp5.addScrollableList("samples_dropdown")
     .setPosition(container_margin, container_margin)
     .setSize(element_width, item_height)
     .setBarHeight(20)
     .setItemHeight(20)
     .addItems(Arrays.asList(filenames))
     .setType(ControlP5.LIST)
     .setGroup(grainEditGroup);
  element_position.y += item_height+container_margin;
  
  // Sample Player
  item_height = 150;
  wc = new WaveformCanvas(element_position.x, 
                          element_position.y, 
                          element_width, 
                          item_height);
  wc.pre();
  cp5.addCanvas(wc); 
  element_position.y += item_height+container_margin - marginy;
  
  // Info Labels
  item_height = 20;
  cp5.addTextlabel("samplenamelabel")
    .setText("Sample Name: "+selectedSample)
    .setPosition(container_margin, element_position.y)
    .setGroup(grainEditGroup);
  cp5.addTextlabel("sampledurationlabel")
    .setText("Sample Length: 0 ms")
    .setPosition(container_margin, element_position.y+item_height)
    .setGroup(grainEditGroup);
  cp5.addTextlabel("graindurationlabel")
    .setText("Selection Length: 0 ms")
    .setPosition(container_margin, element_position.y+2*item_height)
    .setGroup(grainEditGroup);
  element_position.y += 3*item_height+container_margin;

  // Envelope defaults
  item_height = 20;
  cp5.addButtonBar("envelope_bar")
     .setPosition(container_margin, element_position.y)
     .setSize(element_width, item_height)
     .addItems(split("Hann Hamm Tri Custom", ' '))
     .setGroup(grainEditGroup);
  element_position.y += item_height + marginy;
     
  // Envelope canvas
  item_height = 100;
  ec = new EnvelopeCanvas(element_position.x, 
                          element_position.y, 
                          element_width,
                          item_height);
  ec.pre();
  cp5.addCanvas(ec); 
  element_position.y += item_height + container_margin;
  
  // Waveshape of the grain
  item_height = 100;
  gwc = new GrainWaveformCanvas(element_position.x, 
                                element_position.y, 
                                element_width,
                                item_height);
  gwc.pre(); 
  cp5.addCanvas(gwc); 
  element_position.y += item_height + container_margin - marginy;
  
  // Save grain button
  item_height = 50;
  cp5.addButton("saveGrain")
     .setPosition(container_margin, element_position.y)
     .setSize(element_width, item_height)
     .setGroup(grainEditGroup);
}