final float maxfreq = 6000;
String selectedSample = "";
float[] selection = {-1, -1};

int maxGrains = 10;
Grain selectedGrain;

// envelope button listener -- Hann, Hamm, Tri, Custom
void envelope_bar(int n) {
  switch(n) {
    case 0:
      loadHann(envelope);
      break;
    case 1:
      loadHamm(envelope);
      break;
    case 2:
      loadTri(envelope);
      break;
    case 3:
      loadCustom(envelope);
      break;
  }
  isDrawGrainWave = true;
}

// button listener
void saveGrain() {
  if(selection[0] >= 0 && selection[1] >= 0 && grains.size() < maxGrains){
    float x = width * 0.75 + 10;
    float w = width * 0.19;
    
    float[] samples = file.getChannel(0);
    int pos1 = (int)map(selection[0], x, x+w, 0, samples.length);
    int pos2 = (int)map(selection[1], x, x+w, 0, samples.length);
    Grain grn = new Grain(abs(pos2-pos1), sampler.sampleRate());
    grn.fileName = selectedSample;
    grn.samples = subset(samples, min(pos1, pos2), abs(pos2-pos1));
    
    
    colorMode(HSB, maxGrains, 100, 100);
    grn.grainColor = color(grn.uid, 100, 100);
    brushColor = grn.grainColor;
    colorMode(RGB, 255, 255, 255);
    
    selectedGrain = grn;
    updateBrush(true);
    
    // apply envelope
    for( int i = 0; i < grn.samples.length - 1; i++ )
    { 
      float e1 = getFloatIndex(envelope, cmap(i, 0, samples.length, 0, envelope.length));
      float e2 = getFloatIndex(envelope, cmap(i+1, 0, samples.length, 0, envelope.length));
      grn.samples[i]   *= e1;
      grn.samples[i+1] *= e2;
    }  
    
    // create triggerable Sampler
    grn.createGrainSample();
    grains.add(grn);
    
    // repopulate grain dropdown
    String[] ids = new String[grains.size()];
    for(int i = 0; i < grains.size(); i++){
      ids[i] = str(grains.get(i).uid);
    }
    ScrollableList sl = (ScrollableList)cp5.getController("grains_dropdown");
    sl.setItems(ids);
  }
}

// grain dropdown
void grains_dropdown(int n) {
  selectedGrain = grains.get(n);
  brushColor = selectedGrain.grainColor;
  updateBrush(true);
}

// samples dropdown listener
void samples_dropdown(int n) {
  selectedSample = (String)cp5.get(ScrollableList.class, "samples_dropdown").getItem(n).get("name");
  loadSample(selectedSample);
  
  updateSampleName();
  updateSampleDuration();
  updateGrainDuration();
  
  isDrawWave = true;
  isDrawGrainWave = true;
}

void keyPressed() {
  if(key == '1') {
    //if ( filePlayer.isPlaying() ) { filePlayer.pause(); }
    //else                          { filePlayer.loop();  }
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
  
  if(key == ' ') {
    isPlaying = !isPlaying;
  }
  
  if(key == 'p' && selectedGrain != null) {
    println("Triggering");
    selectedGrain.sample.trigger();
  }
  
  if(key == 'e') {
    sampler.setSampleRate(44100*cmap(mouseX, 0, width, 0.1 , 2));
    sampler.trigger();
  }
}