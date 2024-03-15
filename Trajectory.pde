class Trajectory {
  /*
    Meant to keep track of the angle and speed of an object.
    You can set the angle and speed directly or through x and y.
    You can only instantiate with angle and speed, not x or y.
    To do so, first instantiate without any parameters then use setXY().
  */
  private float angle;
  private float speed;
  
  public Trajectory() {
    angle = 0;
    speed = 0;
  }
  
  public Trajectory(float angle, float speed) {
    this.angle = angle;
    this.speed = speed;
  }
  
  public float getAngle() {
    return angle;
  }
  
  public void setAngle(float angle) {
    this.angle = angle;
  }
  
  public void flipX() {
    angle += Math.PI / 2;
    angle *= -1;
    angle -= Math.PI / 2;
  }
  
  public void flipY() {
    angle *= -1;
  }
  
  public void normalize() {
    while (angle >= (Math.PI * 2)) {
      angle -= (Math.PI * 2);
    }
    while (angle < 0) {
      angle += (Math.PI * 2);
    }
  }
  
  public float getSpeed() {
    return speed;
  }
  
  public void setSpeed(float speed) {
    this.speed = speed;
  }
  
  public void truncate(float factor) {
    speed *= factor;
  }
  
  public float getX() {
    return (float)(speed * Math.cos(angle));
  }
  
  public float getY() {
    return (float)(speed * Math.sin(angle));
  }
  
  public void setXY(float x, float y) {
    angle = (float)Math.atan2(y, x);
    speed = (float)Math.sqrt(Math.pow(x, 2) + Math.pow(y, 2));
  }
}
