class Color {
  int r;
  int g;
  int b;
  
  public Color(int r, int g, int b) {
    this.r = r;
    this.g = g;
    this.b = b;
  }
  
  public void setRGB(int r, int g, int b) {
    this.r = r;
    this.g = g;
    this.b = b;
  }
  
  public int getR() {
    return r;
  }
  
  public int getG() {
    return g;
  }
  
  public int getB() {
    return b;
  }
  
  public void upR(int amt) {
    r += amt;
  }
  
  public void downR(int amt) {
    r -= amt;
  }
  
  public void upG(int amt) {
    g += amt;
  }
  
  public void downG(int amt) {
    g -= amt;
  }
  
  public void upB(int amt) {
    b += amt;
  }
  
  public void downB(int amt) {
    b -= amt;
  }
  
  // custom Processing drawing
  public void doFill() {
    fill(r, g, b);
  }
  
  public void doStroke() {
    stroke(r, g, b);
  }
}
