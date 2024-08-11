class Gobble {
  // position & trajectory
  private float posX;
  private float posY;
  private Trajectory t = new Trajectory();
  
  // gobble and seek size
  private float radius;
  private float maxRadius = 100;
  private float seekRadius = 150;
  
  // color
  Color c = new Color(200, 50, 20);
  
  // misc
  private boolean auto;
  private boolean seeking = true;
  private int eaten = 0;
  private float closest = 100000;
  private boolean mee;
  
  public Gobble(float posX, float posY, float angle, float speed, boolean auto, boolean mee) {
    this.posX = posX;
    this.posY = posY;
    t.setAngle(angle);
    t.setSpeed(speed);
    this.auto = auto;
    radius = auto ? 5 : 20;
    this.mee = mee;
    if (mee) {
      c = new Color(255, 0, 0);
    }
  }
  
  // just for show
  public Gobble(float posX, float posY, float radius, boolean auto) {
    this.posX = posX;
    this.posY = posY;
    this.radius = radius;
    t.setAngle(0);
    t.setSpeed(0);
    this.auto = auto;
    seeking = false;
  }
  
  public float getX() {
    return posX;
  }
  
  public float getY() {
    return posY;
  }
  
  public float getRadius() {
    return radius;
  }
  
  public float getAngle() {
    return (float)(t.getAngle() / (2 * Math.PI) * 360);
  }
  
  public void bounce(boolean vertical) {
    if (vertical) {
      t.flipY();
    }
    else {
      t.flipX();
    }
  }
  
  private boolean isInside(Pellet p) {
    return Math.sqrt(Math.pow(p.getX() - posX, 2) + Math.pow(p.getY() - posY, 2)) < this.radius + p.getRadius();
  }
  
  public boolean isInsideSeek(Pellet p) {
    return Math.sqrt(Math.pow(p.getX() - posX, 2) + Math.pow(p.getY() - posY, 2)) < seekRadius + (auto ? p.getRadius() : p.getRadius() / 2);
  }
  
  public void seek(LinkedList<Pellet> pList) {
    if (auto) {
      // unset seek will get gobble out of seek mode
      boolean unsetSeek = false;
      for (Pellet p : pList) {
        if (seeking && isInsideSeek(p)) {
          // only go towards the closest pellet; only relevant when
          // gobble eats a pebble within range of others
          if (distanceFrom(p.getX(), p.getY()) < closest) {
            // setting X and Y can give gobble massive speed;
            t.setXY(p.getX() - posX, p.getY() - posY);
            // need to set to 1
            t.setSpeed(1);
            unsetSeek = true;
            // set radius back to 150 and mark this pellet distance as closest
            seekRadius = 150;
            closest = distanceFrom(p.getX(), p.getY());
          }
        }
      }
      if (unsetSeek) { seeking = false; }
      // time to find some pellets
      if (seeking && pList.size() > 0) {
        closest = 100000;
        seekRadius *= 1.001;
      }
    }
    else {
      // follow mouse in control mode
      t.setXY(mouseX - posX, mouseY - posY);
      t.setSpeed(1);   // regular speed
      //t.truncate(0.1); // for zooming around
    }
  }
  
  private float distanceFrom(float x, float y) {
    return sqrt(pow(x - posX, 2) + pow(y - posY, 2));
  }
  
  public void makeSeek() {
    seeking = true;
  }
  
  public boolean isSeeking() {
    return seeking;
  }
  
  public void eat(Pellet p) {
    if (auto) {
      radius += p.getValue();
      if (radius > maxRadius) {
        radius = maxRadius;
      }
    }
    else {
      radius += p.getValue() * 5 * (30 / radius);
      if (radius > maxRadius) {
        radius = maxRadius;
      }
      seekRadius = 150;
    }
    eaten++;
  }
  
  public int getEaten() {
    return eaten;
  }
  
  public void increaseSize() {
    radius++;
  }
  
  public void update() {
    posX += t.getX();
    posY += t.getY();
    t.normalize();
    if (!auto) {
      radius -= 0.09;
    }
  }
  
  public void drawSeekRadius() {
    noStroke();
    if (auto) {
      // draw seek radius as pale gray circle
      fill(0, 0, 0, 10);
      ellipse(posX, posY, seekRadius * 2, seekRadius * 2);
    }
    else {
      // draw seek radius as white circle
      fill(255, 255, 255);
      ellipse(posX, posY, seekRadius * 2, seekRadius * 2);
    }
  }
  
  public void drawGobble() {
    c.doFill();
    ellipse(posX, posY, radius * 2, radius * 2);
    if (mee) {
      cycleRainbow(c, 17);
    }
  }
  
  public void setColor(Color c) {
    this.c = c;
  }
  
  // overriding
  public String toString() {
    return String.valueOf(eaten);
  }
}
