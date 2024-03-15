class Pellet {
  private float radius;
  private float posX;
  private float posY;
  private int value = 1;
  
  public Pellet(float x, float y) {
    posX = x;
    posY = y;
    radius = 3;
  }
  
  public Pellet(float x, float y, float radius) {
    posX = x;
    posY = y;
    this.radius = radius;
  }
  
  public float getRadius() {
    return radius;
  }
  
  public float getX() {
    return posX;
  }
  
  public float getY() {
    return posY;
  }
  
  public int getValue() {
    return value;
  }
  
  public void drawPellet() {
    noStroke();
    fill(180, 180, 0);
    ellipse(posX, posY, radius * 2, radius * 2);
  }
}
