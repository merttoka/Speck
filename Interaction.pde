final float maxfreq = 6000;
String selectedSample = "";
float[] selection = {-1, -1};


// button listener
void saveGrain(float w, float x) {
  if(selection[0] >= 0 && selection[1] >= 0){
    float[] samples = file.getChannel(AudioSample.LEFT);
    int pos1 = (int)map(selection[0], x, x+w, 0, samples.length);
    int pos2 = (int)map(selection[1], x, x+w, 0, samples.length);
    Grain grn = new Grain(abs(pos2-pos1));
    grn.fileName = selectedSample;
    grn.samples = subset(samples, min(pos1, pos2), abs(pos2-pos1));
    
    for( int i = 0; i < grn.samples.length - 1; i++ )
    { 
      float e1 = envelope_values[(int)map(i, 0, grn.samples.length, 0, envelope_values.length)];
      float e2 = envelope_values[(int)map(i+1, 0, grn.samples.length, 0, envelope_values.length)];
      grn.samples[i]   *= e1;
      grn.samples[i+1] *= e2;
    }  
    
    
    String[] ids = new String[grains.size()];
    for(int i = 0; i < grains.size(); i++){
      ids[i] = str(grains.get(i).uid);
    }
    ScrollableList sl = (ScrollableList)cp5.getController("grains_dropdown");
    sl.setItems(ids);
  }
}

// TODO: Grains dropdown
void grains_dropdown(int n) {

}

// samples dropdown listener
void samples_dropdown(int n) {
  selectedSample = (String)cp5.get(ScrollableList.class, "samples_dropdown").getItem(n).get("name");
  
  filePlayer.close();
  filePlayer = minim.loadFile("samples/"+selectedSample, 1024);
 
  file = minim.loadSample("samples/"+selectedSample, 1024);
  
  updateSampleDuration();
  
  redraw = true;
  isDrawGrainWave = true;
}

void mouseClicked() {
  //if ( shapes.get(current_index) != null ) {
  //  PShape s = shapes.get(current_index);
  //  s.beginShape();
  //  s.vertex(mouseX, mouseY);
  //  s.endShape();
    
  //  sendMessage("/ptosc", map(log(mouseY), log(1), log(height-10), maxfreq, 0));
  //}
}

void keyPressed() {
  if(key == '1') {
    if ( filePlayer.isPlaying() ) { filePlayer.pause(); }
    else                          { filePlayer.loop();  }
  }
  //if( key == '+' ) {
  //  current_index++;
  //  if (current_index >= shapes.size()) {
  //    addDefaultShape();
  //  }
  //}
  //else if( key == '-' ) {
  //  current_index--;
  //}
  
  //current_index = constrain(current_index,0,10);
}