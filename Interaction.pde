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
    float x = (float)getField(wc, "x");
    float w = (float)getField(wc, "w");
    
    float[] samples = file.getChannel(0);
    int pos1 = (int)map(selection[0], x, x+w, 0, samples.length);
    int pos2 = (int)map(selection[1], x, x+w, 0, samples.length);
    
    Grain grn = new Grain(abs(pos2-pos1), sampler.sampleRate());
    grn.fileName = selectedSample;
    grn.samples = subset(samples, min(pos1, pos2), abs(pos2-pos1));
    
    colorMode(HSB, maxGrains, 100, 100);
    grn.grainColor = color(grn.uid, 100, 100);
    colorMode(RGB, 255, 255, 255);
    
    selectedGrain = grn;
    
    // apply envelope
    float maxAmp = -999, minAmp = 999;
    for( int i = 0; i < grn.samples.length; i++ )
    { 
      float e1 = getFloatIndex(envelope, cmap(i, 0, samples.length, 0, envelope.length));
      grn.samples[i] *= e1;
      maxAmp = max(grn.samples[i], maxAmp);
      minAmp = min(grn.samples[i], minAmp);
    }  
    
    float mm = -9999;
    for( int i = 0; i < grn.samples.length; i++ )
    { 
      grn.samples[i] *= 1.0/maxAmp;
      mm = max(grn.samples[i], mm);
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
    
    //for (int i = 0; i < sl.getItems().size(); i++) {
    //  CColor c = new CColor();
    //  c.setBackground(grn.grainColor);
    //  sl.getItem(i).put("color", c);
    //}
  }
}

// grain dropdown
void grains_dropdown(int n) {
  selectedGrain = grains.get(n);
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
  if(key == ' ') {
    isPlaying = !isPlaying;
  }
  
  if(key == 'p' && selectedGrain != null) {
    selectedGrain.sample.setSampleRate(selectedGrain.sampleRate * cmap(mouseY, 0, width, 0.1 , 2));
    selectedGrain.sample.trigger();
  }
  
  if(key == 'c') {
    canvas.loadPixels();
    for (int i = 0; i < canvas.pixels.length; i++) {
      canvas.pixels[i] = color(0,0);
    }
    canvas.updatePixels();
  }
  
  if(key == 'i') {
    canvas.blend(im,0,0,im.width,im.height, 0,0,canvas.width,canvas.height, REPLACE);
  }
  
  if(key == 's') {
    canvas.save("images/export"+millis()+".jpg");
  }
  
  // DEBUG KEY
  if(key == 'e') {
    sampler.setSampleRate(44100*cmap(mouseX, 0, width, 0.1 , 2));
    sampler.trigger();
  }
}