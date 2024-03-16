import java.util.Random;
import java.util.LinkedList;

// CUSTOM MOUSE CLICKING TOOL
boolean mouseChoose = false;
void mouseReleased() {
  mouseChoose = true;
  // set to false at the end of drawing phase
}

// for rainbow changer
Color rainbow = new Color(255, 0, 0);

String mode;
int foodCount;

Random r = new Random();

// normal mode display
LinkedList<Pellet> autoDisplayPellets = new LinkedList<Pellet>();
Gobble autoDisplayGob = new Gobble(r.nextInt(50, 325), r.nextInt(50, 650), 30, true);

// infinite mode display
LinkedList<Pellet> controlDisplayPellets = new LinkedList<Pellet>();
Gobble controlDisplayGob = new Gobble(r.nextInt(675, 950), r.nextInt(50, 650), 30, false);

LinkedList<Pellet> pellets = new LinkedList<Pellet>();
Gobble gob;

Color baseGobColor = new Color(200, 50, 20);
Color gobColor;

boolean modeChosen = false;
boolean gameOver = false;
boolean mouseMoved = false;

boolean firstPiece = false;
boolean secondPiece = false;
boolean masterEasterEgg = false;

void setup() {
  size(1000, 700);
  for (int i = 0; i < 15; i++) {
    autoDisplayPellets.add(new Pellet(r.nextInt(480) + 10, r.nextInt(680) + 10, 10));
  }
  for (int i = 0; i < 50; i++) {
    controlDisplayPellets.add(new Pellet(r.nextInt(480) + 510, r.nextInt(680) + 10, 10));
  }
  
  gobColor = baseGobColor;
}

void draw() {
  // modes display
  if (!modeChosen) {
    if (!mouseMoved) {
      if (pmouseX != mouseX || pmouseY != mouseY) {
        mouseMoved = true;
      }
    }
    noStroke();
    fill(255);
    rect(0, 0, 1000, 700);
    // auto mode
    
    // pellets
    for (Pellet p : autoDisplayPellets) {
      p.drawPellet();
    }
    
    // gobble
    autoDisplayGob.drawSeekRadius();
    autoDisplayGob.drawGobble();
    
    // text
    textSize(80);
    textAlign(CENTER);
    fill(0);
    text("Auto", 250, 350);
    
    
    // control mode
    noStroke();
    fill(0);
    rect(500, 0, 1000, 700);
    
    // draw seek radius first
    controlDisplayGob.drawSeekRadius();
    
    // then pellets
    for (Pellet p : controlDisplayPellets) {
      if (controlDisplayGob.isInsideSeek(p)) {
        p.drawPellet();
      }
    }
    
    // then gobble
    controlDisplayGob.drawGobble();
    
    // text
    textSize(80);
    textAlign(CENTER);
    fill(150);
    text("Control", 750, 350);
    
    if (mouseX < 500) {
      noStroke();
      fill(0, 0, 0, 100);
      rect(500, 0, 1000, 700);
    }
    else {
      noStroke();
      fill(0, 0, 0, 100);
      rect(0, 0, 500, 700);
    }
    
    if (mouseChoose && mouseMoved) {
      mode = mouseX < 500 ? "AUTO" : "CONTROL";
      gob = new Gobble(500, 350, (float)(Math.PI / 4), 1, mode == "AUTO", masterEasterEgg);
      gob.setColor(gobColor);
      foodCount = mode == "AUTO" ? 20 : 30;
      for (int i = 0; i < foodCount; i++) {
        pellets.add(new Pellet(r.nextInt(1000), r.nextInt(700)));
      }
      modeChosen = true;
      mouseMoved = false;
    }
  }
  
  // gameplay
  else {
    if (!mouseMoved) {
      if (pmouseX != mouseX || pmouseY != mouseY) {
        mouseMoved = true;
      }
    }
    if (!gameOver) {
      if (mousePressed && mouseMoved) {
        if (mode == "AUTO") {
          background(200);
        }
        else {
          background(0);
        }
      }
      else {
        background(mode == "AUTO" ? 255: 0);
      }
      
      // draw gob and pellets
      gob.drawSeekRadius();
      for (Pellet p : pellets) {
        if (gob.isInsideSeek(p) || mode == "AUTO") {
          p.drawPellet();
        }
      }
      gob.drawGobble();
      
      if (mousePressed && mouseMoved) { // pause
        if (mode == "AUTO") {
          fill(255, 0, 0);
        }
        else {
          fill(150);
        }
        textSize(100);
        textAlign(CENTER);
        text(gob.toString(), 500, 350);
      }
      
      else {                            // play
        if (gob.getRadius() <= 0) {
          gameOver = true;
        }
        gob.seek(pellets);
        gob.update();
      }
      
      // Stuff that happens always, paused or unpaused:
      for (Pellet p : pellets) {
        if (gob.isInside(p)) {
          gob.eat(p);
          pellets.remove(p);
          if (mode == "CONTROL") {
            pellets.add(new Pellet(r.nextInt(1000), r.nextInt(700)));
          }
          gob.makeSeek();
          return;
        }
      }
      
      // bouncing
      if (gob.getX() > 1000) {
        gob.bounce(false);
      }
      else if (gob.getX() < 0) {
        gob.bounce(false);
      }
      if (gob.getY() > 700) {
        gob.bounce(true);
      }
      else if (gob.getY() < 0) {
        gob.bounce(true);
      }
    }
    else {
      background(0);
      for (Pellet p : pellets) {
        p.drawPellet();
      }
      textSize(150);
      fill(255, 255, 255);
      textAlign(CENTER);
      text("Gob's Dead!!", 500, 350);
      
      // easter eggs :)
      textSize(40);
      String msg = "I guess " + gob.toString() + " wasn't enough...";
      gobColor = baseGobColor;
      if (gob.getEaten() == 8) { // easter egg 1: my birth month
        fill(255, 100, 0);
        msg = "I guess my birth month wasn't enough...";
        firstPiece = true;
        gobColor = new Color(255, 100, 0);
      }
      else if (gob.getEaten() == 26) { // easter egg 2: my birth day
        fill(255, 100, 0);
        msg = "I guess my birth day wasn't enough...";
        if (firstPiece) {
          secondPiece = true;
        }
        gobColor = new Color(255, 100, 0);
      }
      else if (gob.getEaten() == 69) { // easter egg 3: nice
        fill(255, 100, 200);
        msg = "nice";
        gobColor = new Color(255, 100, 200);
      }
      else if (gob.getEaten() == 420) { // easter egg 4: how
        fill(0, 200, 0);
        msg = "blaze it";
        gobColor = new Color(0, 200, 0);
      }
      else if (gob.getEaten() == 2000) { // easter egg 5: my birth year
        fill(255, 100, 0);
        msg = "I guess my birth year wasn't enough...";
        if (firstPiece && secondPiece) {
          masterEasterEgg = true;
        }
        gobColor = new Color(255, masterEasterEgg ? 0 : 100, 0);
      }
      else if (gob.getEaten() > 9000) { // easter egg 6: internet legends
        rainbow.doFill();
        msg = "[insert early 2000's joke here]";
        cycleRainbow(rainbow, 15);
        masterEasterEgg = true;
      }
      text(msg, 500, 400);
      if (mouseChoose) {
        modeChosen = false;
        gameOver = false;
        mouseMoved = false;
        pellets.clear();
      }
    }
  }
  mouseChoose = false;
}
