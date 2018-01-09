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
    if(pos1 < pos2)
      grn.samples = subset(samples, pos1, pos2-pos1);
    else if(pos1 > pos2)
      grn.samples = reverse(subset(samples, pos2, pos1-pos2));
    
    colorMode(HSB, maxGrains, 100, 100);
    grn.grainColor = color(grn.uid, 100, 100);
    colorMode(RGB, 255, 255, 255);
    
    selectedGrain = grn;
    
    // apply envelope
    float maxAmp = -1;
    for( int i = 0; i < grn.samples.length; i++ )
    { 
      float e1 = getFloatIndex(envelope, cmap(i, 0, samples.length, 0, envelope.length));
      grn.samples[i] *= e1;
      maxAmp = max(grn.samples[i], maxAmp);
    }  
    for( int i = 0; i < grn.samples.length; i++ ) grn.samples[i] *= 1.0/maxAmp;
    
    
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

void keyPressed(KeyEvent e) {
  // toogle playing 
  if(key == ' ') {
    isPlaying = !isPlaying;
  }
  // clears canvas 
  else if(key == 'c') {
    canvas.loadPixels();
    for (int i = 0; i < canvas.pixels.length; i++) canvas.pixels[i] = color(0,0);
    canvas.updatePixels();
  }
  // loads image on canvas
  else if(key == 'i') {
    canvas.blend(im,0,0,im.width,im.height, 0,0,canvas.width,canvas.height, REPLACE);
  }
  // saves current canvas
  else if(key == 's') {
    canvas.save("images/export"+millis()+".jpg");
  }
  // plays currently selected grain (pitch shift on Mouse Y)
  else if(key >= '0' && key <= '9') {
    if ( int(key)-48 < grains.size() ) grains.get(int(key)-48).sample.trigger();
  }
  
  // Scrubbing right and left 
  if(keyCode == LEFT) {
    int coeff = e.isShiftDown() ? 2 : 1;
    coeff *= isPlaying ? 2 : 1;
    time -= coeff*deltaTime;
    time = constrain(time, 0, maxTime);
    current_timestamp = int(map(time, 0, maxTime, 0, canvas.width));
  }
  else if(keyCode == RIGHT) {
    int coeff = e.isShiftDown() ? 2 : 1;
    time += coeff*deltaTime;
    time = constrain(time, 0, maxTime);
  } else if (keyCode == UP) {
    timeCoefficient += 0.2;  
  } else if (keyCode == DOWN) {
    timeCoefficient -= 0.2;
  }
}