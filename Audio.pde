
import ddf.minim.*;
import ddf.minim.spi.*; // for AudioRecordingStream
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer filePlayer;
AudioSample file;

float[] envelope = new float[32];

ArrayList<Grain> grains = new ArrayList<Grain>();

void initAudio () {
  // create our Minim object for loading audio
  minim = new Minim(this);
  
  String defaultSample = selectedSample = "0.aif";
  filePlayer = minim.loadFile("samples/"+defaultSample, 1024);
  file = minim.loadSample("samples/"+defaultSample, 1024);
  //filePlayer.pause();
  
  updateSampleName();
  updateSampleDuration();
  
  // Default is Hann
  for(int i = 0; i < envelope.length; i++) {
    envelope[i] = 0.5 * (1 - cos(TWO_PI*i/(envelope.length - 1)));
  }
}

class Grain {
  public int uid;
  public int length;
  public float[] samples;
  
  public String fileName;
  public int startSample;
  public int endSample;
  
  public color grainColor;
  
  public float freqShift = 0;
  
  Grain(int l) {
    uid = grains.size();
    
    this.length = l;
    samples = new float[l];  
    
    grains.add(this);  
  }
};