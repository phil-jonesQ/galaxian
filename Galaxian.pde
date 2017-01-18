//Simple Verticle Scroll Shoot 'em up
public int scl = 30;
public int enemyRad;
//Obejects
Ship ship;
Laser laser;
ArrayList<Enemy> enemy = new ArrayList<Enemy>();
int enemyAmount;

boolean fire;

void setup() {
  size(300, 500);
  frameRate(100);
  ship = new Ship();
  ship.dir(0);
  laser = new Laser();
  fire=false;
  enemyAmount=15;
  enemyRad=20;
  populateEnemies();
}


void keyPressed() {

  //Pass in direction inputs
  if (key == CODED) {
    if (keyCode == RIGHT) {
      ship.dir(3.5);
    }
    if (keyCode == LEFT) {
      ship.dir(-3.5);
    }
    if (keyCode == UP) {        
      fire=true;
    }
  }
}

void draw() {
  background(0);
  showEnemies();
  moveEnemies();
  ship.show();
  ship.update();
  if (fire) {
    //Get the current ships front point and pass into laser object
    float laserStartX = ship.Xpoint();
    float laserStartY = ship.Ypoint();
    //println(laserStartX,laserStartY);
    //If Laser hasn't hit an enemy draw full length
    if (!checkLaserHits()) {
    laser.fire(laserStartX, laserStartY, 0);//Third parameter will be Y pos of enemy to stop laser on impact
    fire=false;
    }
    
  }
}

void populateEnemies() {

  for (int i = 0; i < enemyAmount; i++) {

    enemy.add(new Enemy());
  }
}

void showEnemies() {

  for (int i = 0; i < enemy.size(); i++) {
    enemy.get(i).show();
  }
}

void moveEnemies() {
    
   for (int i = 0; i < enemy.size(); i++) {
    enemy.get(i).update();
  }
  
}

boolean checkLaserHits() {

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
      fire=false;
      return true;
    }
  }
  return false;
}