final float maxfreq = 6000;
String selectedSample = "";

void samples_dropdown(int n) {
  selectedSample = (String)cp5.get(ScrollableList.class, "samples_dropdown").getItem(n).get("name");
  
  filePlayer.close();
  filePlayer = minim.loadFile("samples/"+selectedSample, 1024);
 
  file = minim.loadSample("samples/"+selectedSample, 1024);
  
  redraw = true;
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