//Simple Verticle Scroll Shoot 'em up
//Scrolling Star background
//To Do --- Pause on Start *
//      --- Enemy to Ship Collision detection and defeat *
//      --- Life system (3 live)
//      --- Pause on Defeat/Game over *
//      --- Level System (more enemies) * String to enemy wave system version 1.00
String levelOne;
public int scl = 30;
public int enemyRad;
public int level;

//Obejects
Ship ship;
Laser laser;
Star[] stars = new Star[100];
ArrayList<Enemy> enemy = new ArrayList<Enemy>();
int enemyAmount;
PFont f;

//flags
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
  enemyAmount=10;
  enemyRad=20;
  level =1;
  mapLevel();
  populateEnemies();
  populateStars();
  dead=false;
  f = createFont("Arial", 50, true);
}

void keyPressed() {

  if (key == CODED) {
    if (keyCode == RIGHT) {
      ship.dir(1.5);
    }
    if (keyCode == LEFT) {
      ship.dir(-1.5);
    }
    if (keyCode == UP) {        
      fire=true;
    }
  }
}

void mousePressed() {
  noLoop();
  init();
  loop();
}


void draw() {

  background(0);
  showStars();
  scrollStars();
  mapLevel();
  showEnemies();
  moveEnemies();
  ship.show();
  ship.update();
  if (shipHitsEnemy()) {
    dead=true;
  }
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

  checkWon();
  if (dead) {
    GameOver();
    noLoop();
  }
}

void populateEnemies() {
  //Map chars
  char enemyOn = '1';
  char nextRow = '*';
  char enemyOff = '0';
  //Convert level string to char array
  char [] levelone = levelOne.toCharArray();
  //local vars
  int rowOffset=scl;
  int eX=0;
  int exOffset=scl;
  int counter=0;

  for (int i = 0; i < levelOne.length(); i++) {
    if (levelone[i] == enemyOff) {
      counter=counter+exOffset;
    }
    if (levelone[i] == enemyOn) {
      eX=counter;
      enemy.add(new Enemy(eX, rowOffset));
      //println(eX, rowOffset);
    }
    if (levelone[i] == nextRow) {
      rowOffset=rowOffset+scl;
      counter=0;
    }
  }
}

void depopulateEnemies() {
  for (int i = enemy.size()-1; enemy.size() > 0; i--) {
    enemy.remove(i);
  }
}

void populateStars() {
  for (int i = 0; i < stars.length; i++) {
    stars[i]=new Star();
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
      //fire=false;
      return true;
    }
  }
  return false;
}


void checkWon() {
  if (enemy.size() < 1) {
    level=level+1;
    populateEnemies();
  }
}

boolean shipHitsEnemy() {

  for (int i = 0; i < enemy.size(); i++) {
    float enemyX=enemy.get(i).posX();
    float enemyY=enemy.get(i).posY();
    float shipX=ship.Xpoint();
    float shipY=ship.Ypoint();
    float d1 = dist(enemyX, enemyY, shipX, shipY);
    float d2 = dist(enemyX, enemyY, shipX-scl/2, shipY);
    float d3 = dist(enemyX, enemyY, shipX+scl/2, shipY);
    //println ("Enemy X=" + enemyX + "Enemy Y=" + enemyY + "Ship X=" +shipX + "ship Y" + shipY);
    //println ("Distance=" + d1,d2,d3);
    //Check the point of ship
    if (d1 < enemyRad/2 || d2 < 0.5|| d3 < 0.5) {
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
  level=1;
  mapLevel();
  populateEnemies();
  populateStars();
  dead=false;
}

void GameOver() {
  textFont(f, 12);                  
  fill(255, 0, 0);
  textAlign(CENTER);
  text("GAME OVER!!", width/2, height/2);
  stroke(255);
}

void mapLevel() {

  if (level == 1) {
    levelOne="01001001001001*00110010010010";
  }

  if (level == 2) {
    levelOne="01001001001001*00110010010010*01001001001001";
  }

  if (level == 3) {
    levelOne="*00110010010010*01001001001001*01001001001001*00110010010010*01001001001001";
  }

  if (level == 4) {
    levelOne="*00110010010010*01001001001001*01001001001001*00110010010010*01001001001001*01001001001001*00110010010010";
  }

  if (level == 5) {
    levelOne="*00110010010010*01001001001001*01001001001001*00110010010010*01001001001001*01001001001001*00110010010010*01001001001001*01001001001001";
  }

  if (level == 6) {
    levelOne="*00110010010010*01001001001001*01001001001001*00110010010010*01001001001001*01001001001001*00110010010010*01001001001001*01001001001001*00110010010010*01001001001001*";
  }
}