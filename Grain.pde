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