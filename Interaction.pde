final float maxfreq = 6000;
String selectedSample = "";
float[] selection = {-1, -1};

Grain selectedGrain;

// button listener
void saveGrain(float w, float x) {
  if(selection[0] >= 0 && selection[1] >= 0){
    float[] samples = file.getChannel(AudioSample.LEFT);
    int pos1 = (int)map(selection[0], x, x+w, 0, samples.length);
    int pos2 = (int)map(selection[1], x, x+w, 0, samples.length);
    Grain grn = new Grain(abs(pos2-pos1));
    grn.fileName = selectedSample;
    grn.samples = subset(samples, min(pos1, pos2), abs(pos2-pos1));
    randomSeed(millis());
    grn.grainColor = color((int)random(0, 100), (int)random(80, 100), (int)random(20, 60));
    
    brushColor = grn.grainColor;
    
    selectedGrain = grn;
    updateBrush(true);
    
    for( int i = 0; i < grn.samples.length - 1; i++ )
    { 
      float e1 = envelope[(int)map(i, 0, grn.samples.length, 0, envelope.length)];
      float e2 = envelope[(int)map(i+1, 0, grn.samples.length, 0, envelope.length)];
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
  selectedGrain = grains.get(n);
}

// samples dropdown listener
void samples_dropdown(int n) {
  selectedSample = (String)cp5.get(ScrollableList.class, "samples_dropdown").getItem(n).get("name");
  updateSampleName();
  
  filePlayer.close();
  filePlayer = minim.loadFile("samples/"+selectedSample, 1024);
  file = minim.loadSample("samples/"+selectedSample, 1024);
  
  updateSampleDuration();
  
  redraw = true;
  isDrawGrainWave = true;
}

void mouseClicked() {
  
}

void keyPressed() {
  if(key == '1') {
    if ( filePlayer.isPlaying() ) { filePlayer.pause(); }
    else                          { filePlayer.loop();  }
  }
  
  if( key == 'w' ) {
    brushSize+=2;
    brushSize = constrain(brushSize++, 2, 100);
    updateBrush(true);
  }
  else if( key == 's' ) {
    brushSize-=2;
    brushSize = constrain(brushSize--, 2, 100);
    updateBrush(true);
  }
  
  if( key == 'a' ) {
    brushHardness-=2;
    brushHardness = constrain(brushHardness--, 0, 100);
    updateBrush(false);
  }
  else if( key == 'd' ) {
    brushHardness+=2;
    brushHardness = constrain(brushHardness++, 0, 100);
    updateBrush(false);
  }
  
}