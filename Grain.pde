class Grain {
  public int uid;
  public int length;
  public float[] samples;
  public float sampleRate;
  
  public String fileName;
  public int startSample;
  public int endSample;
  
  public color grainColor;
  
  Sampler sample;
  MultiChannelBuffer buffer;
  
  Grain(int l, float sr) {
    this.uid = grains.size();
    
    this.sampleRate = sr;
    this.length = l;
    this.samples = new float[l];  
    
    this.buffer = new MultiChannelBuffer( l, 1 );
  }
  
  void createGrainSample() {
    buffer.setBufferSize(samples.length);
    buffer.setChannel(0, samples);
    
    this.sample = new Sampler( buffer, sampleRate, 1 );
    this.sample.patch(output);
    
    println("Grain created: ", buffer.getBufferSize()/sample.sampleRate());
  }
};