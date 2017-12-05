import ddf.minim.*;
import ddf.minim.ugens.*;
import javax.sound.sampled.AudioFormat;

Minim minim;
AudioPlayer filePlayer;
AudioSample file;

float[] envelope = new float[32];

ArrayList<Grain> grains = new ArrayList<Grain>();

void initAudio () {
  minim = new Minim(this);
  
  String defaultSample = selectedSample = "0.aif";
  filePlayer = minim.loadFile("samples/"+defaultSample, 1024);
  file = minim.loadSample("samples/"+defaultSample, 1024);
  
  updateSampleName();
  updateSampleDuration();
 
  loadHann(envelope);
}