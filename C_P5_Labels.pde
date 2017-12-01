float sampleDuration = 0;
float grainDuration = 0;

void updateSampleName() {
  cp5.get(Textlabel.class, "samplenamelabel").setText("Sample Name: " + selectedSample);
}

void updateSampleDuration() {
  sampleDuration = file.getChannel(AudioSample.LEFT).length/file.sampleRate();
  cp5.get(Textlabel.class, "sampledurationlabel").setText("Sample Length: " + nfc(sampleDuration*1000, 2) + " ms");
}

// TODO: Fix bugs
void updateGrainDuration(float x1, float x2) {
  float pos1 = map(selection[0], x1, x2, 0, file.getChannel(AudioSample.LEFT).length);
  float pos2 = map(selection[1], x1, x2, 0, file.getChannel(AudioSample.LEFT).length);
  
  grainDuration = selection[1] >= 0 ? abs(pos2-pos1)/file.sampleRate() : 0;
  cp5.get(Textlabel.class, "graindurationlabel").setText("Selection Length: " + nfc(grainDuration*1000, 2) + " ms");
}