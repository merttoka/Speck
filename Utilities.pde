
// Math
static float log10 (float x) {
  return (log(x) / log(10));
}
static float cmap(float v, float x1, float y1, float x2, float y2) {
  return constrain(map(v, x1, y1, x2, y2), min(x2, y2), max(x2, y2));
}

// Audio functions
static public float mtof(float m) {
  return 8.175799f * (float)pow(2.0f, m / 12.0f);
}
static public float ftom(float f){
  return 12.0f * log(f / (float)8.175799);
}
static public float dbtoa(float db) {
  return 1.0f * pow(10.0f, db / 20.0f);
}
public float atodb(float a) {
  return 20.0f * log10(a / 1.0f);
}

// Float indexing
static float getFloatIndex(float arr[], float index) {
  int lo = floor(index);
  int hi = lo+1;
  float t = index % 1.0;
  if(lo >= 0 && hi < arr.length) {
    return arr[lo]*(1-t) + arr[hi]*t;
  }
  return 0;
}

// Envelope functions
void loadHann(float arr[]){
  for(int i = 0; i < arr.length; i++) {
    arr[i] = 0.5 * (1 - cos(TWO_PI*i/(arr.length - 1)));
  }
}
void loadHamm(float arr[]){
  float alpha = 0.54;
  float beta = 1-alpha;
  for(int i = 0; i < arr.length; i++) {
    arr[i] = alpha - beta * cos(TWO_PI*i/(arr.length - 1));
  }
}
void loadTri(float arr[]){
  for(int i = 0; i < arr.length; i++) {
    arr[i] = 1 - abs(cmap(i, 0, arr.length, 1, -1));
  }
}
void loadCustom(float arr[]){
  for(int i = 0; i < arr.length; i++) {
    arr[i] = 0.5;
  }
}

// File
static String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}