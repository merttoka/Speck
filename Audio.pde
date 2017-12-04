
import ddf.minim.*;
import ddf.minim.ugens.*;
import javax.sound.sampled.AudioFormat;

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
  
  AudioSample sample;
  
  Grain(int l) {
    uid = grains.size();
    
    this.length = l;
    samples = new float[l];  
    
    grains.add(this);  
  }
  
  void createGrainSample() {
    AudioFormat format = new AudioFormat( 44100, // sample rate
                                          16,    // sample size in bits
                                          1,     // channels
                                          true,  // signed
                                          true   // bigEndian
                                        ); 
    sample = minim.createSample( this.samples, // the samples
                                  format,  // the format
                                  1024     // the output buffer size
                                );
  }
};