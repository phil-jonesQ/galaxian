//Simple Verticle Scroll Shoot 'em up
//Scrolling Star background
//To Do --- Pause on Start
//      --- Enemy to Ship Collision detection and defeat
//      --- Life system (3 live)
//      --- Pause on Defeat/Game over
//      --- Level System (more enemies)


public int scl = 30;
public int enemyRad;
//Obejects
Ship ship;
Laser laser;
Star[] stars = new Star[100];
ArrayList<Enemy> enemy = new ArrayList<Enemy>();
int enemyAmount;

boolean fire;
boolean enemyHit;
boolean dead;

void setup() {
  size(300, 500);
  frameRate(100);
  ship = new Ship();
  ship.dir(0);
  laser = new Laser();
  fire=false;
  enemyHit=false;
  enemyAmount=5;
  enemyRad=20;
  populateEnemies();
  populateStars();
  dead=false;
}


//void keyPressed() {

//  //Pass in direction inputs
//  if (key == ' ') {        
//    fire=true;
//  }
//  if (key == CODED) {
//    if (keyCode == RIGHT && right == true) {
//      ship.dir(3.5);
//      right = false;
//      left = true;
//    }
//    if (keyCode == LEFT && left == true) {
//      ship.dir(-3.5);
//      left = false;
//      right = true;
//    }
//  }
//}

void mousePressed() {
  noLoop();
  init();
  loop();
}

void draw() {
  background(0);
  showStars();
  scrollStars();
  showEnemies();
  moveEnemies();
  ship.show();
  ship.update();
  if (shipHitsEnemy()) {
    dead=true;
  }
  keyScan();
  if (fire) {
    float laserStartX = ship.Xpoint();
    float laserStartY = ship.Ypoint();
    laser.fire(laserStartX, laserStartY, 0);
    if (laserHits()) {
      //laser.fire(laserStartX, laserStartY,0);//Third parameter will be Y pos of enemy to stop laser on impact
      fire=false;
    }
  } else {
    fire=false;
  }
  checkWon();
  if (dead) {
    noLoop();
  }
}

void populateEnemies() {
  for (int i = 0; i < enemyAmount; i++) {
    enemy.add(new Enemy());
  }
}

void populateStars() {
  for (int i = 0; i < stars.length; i++) {
    stars[i]=new Star();
  }
}

void depopulateEnemies() {
  for (int i = enemy.size()-1; enemy.size() > 0; i--) {
    enemy.remove(i);
  }
}

void showEnemies() {

  for (int i = 0; i < enemy.size(); i++) {
    enemy.get(i).show();
  }
}

void showStars() {

  for (int i = 0; i < stars.length; i++) {
    stars[i].show();
  }
}

void scrollStars() {

  for (int i = 0; i < stars.length; i++) {
    stars[i].scroll();
  }
}

void moveEnemies() {
  for (int i = 0; i < enemy.size(); i++) {
    enemy.get(i).update();
  }
}

boolean laserHits() {
  for (int i = 0; i < enemy.size(); i++) {
    float enemyX=enemy.get(i).posX();
    float enemyY=enemy.get(i).posY();
    float shipX=ship.Xpoint();
    float d = dist(enemyX, enemyY, shipX, enemyY);
    //println ("Enemy X=" + enemyX + "Enemy Y=" + enemyY + "Ship X=" +shipX + "Laser Y" + enemyY);
    //println ("Distance=" + d);
    //If distance is less than enemy radius remove it and draw a laser that stops at impact
    if (d < enemyRad/2) {
      float laserStartX = ship.Xpoint();
      float laserStartY = ship.Ypoint();

      laser.fire(laserStartX, laserStartY, enemyY);

      enemy.remove(i);
      return true;
    }
  }
  return false;
}

void keyScan() {
  //ship.dir(0);
  fire=false;
  if (keyPressed) {
    if (keyCode == LEFT) {
      ship.dir(-3.5);
    }
    if (keyCode == RIGHT) {
      ship.dir(+3.5);
    }
    if (keyCode == CONTROL) {
      fire=true;
    }
  }
}

void checkWon() {
  if (enemy.size() < 1) {
    enemyAmount=enemyAmount+5;
    populateEnemies();
  }
}

boolean shipHitsEnemy() {

  for (int i = 0; i < enemy.size(); i++) {
    float enemyX=enemy.get(i).posX();
    float enemyY=enemy.get(i).posY();
    float shipX=ship.Xpoint();
    float shipY=ship.Ypoint();
    float d = dist(enemyX, enemyY, shipX, shipY);
    //println ("Enemy X=" + enemyX + "Enemy Y=" + enemyY + "Ship X=" +shipX + "Laser Y" + enemyY);
    //println ("Distance=" + d);
    //If distance is less than enemy radius remove it and draw a laser that stops at impact
    if (d < enemyRad/2) {
      return true;
    }
  }
  return false;
}

void init () {
  ship = new Ship();
  ship.dir(0);
  laser = new Laser();
  fire=false;
  enemyHit=false;
  enemyAmount=5;
  enemyRad=20;
  depopulateEnemies();
  populateEnemies();
  populateStars();
  dead=false;
}