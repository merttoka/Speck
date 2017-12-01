
import ddf.minim.*;
import ddf.minim.spi.*; // for AudioRecordingStream
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer filePlayer;
AudioSample file;

void initAudio () {
  // create our Minim object for loading audio
  minim = new Minim(this);
  
  filePlayer = minim.loadFile("samples/0.aif", 1024);
  filePlayer.pause();
  
  file = minim.loadSample("samples/0.aif", 1024);
}