
import ddf.minim.*;
import ddf.minim.spi.*; // for AudioRecordingStream
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer filePlayer;
AudioSample file;

ArrayList<Grain> grains = new ArrayList<Grain>();

void initAudio () {
  // create our Minim object for loading audio
  minim = new Minim(this);
  
  filePlayer = minim.loadFile("samples/0.aif", 1024);
  filePlayer.pause();
  
  file = minim.loadSample("samples/0.aif", 1024);
}

class Grain {
  public int uid;
  public int length;
  public float[] samples;
  
  public String fileName;
  public int startSample;
  public int endSample;
  
  public float freqShift = 0;
  
  Grain(int l) {
    uid = grains.size();
    
    this.length = l;
    samples = new float[l];  
    
    grains.add(this);  
  }
};