import ddf.minim.*;
import ddf.minim.ugens.*;
import javax.sound.sampled.AudioFormat;

Minim minim;
//AudioPlayer filePlayer;
//AudioSample file;

MultiChannelBuffer file;
AudioOutput output;
Sampler sampler;

float[] envelope = new float[32];

ArrayList<Grain> grains = new ArrayList<Grain>();

void initAudio () {
  minim = new Minim(this);
  
  output = minim.getLineOut();
  
  float sr = loadSample("0.aif");
  
  updateSampleName();
  updateSampleDuration();
 
  loadHann(envelope);
}

float loadSample(String sample) {
  
  file = new MultiChannelBuffer( 1024, 1 );
  
  selectedSample = sample;
  float sampleRate = minim.loadFileIntoBuffer( "samples/"+selectedSample, file );
 
  if(sampleRate > 0 ) {
    sampler = new Sampler( file, sampleRate, 1 );
    sampler.patch(output);
  
    sampler.trigger();
  }
  return sampleRate;
}