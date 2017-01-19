class Enemy {

  float x;
  float y;
  float r;
  float speed;
  float randomDrop;
  boolean right;
  boolean left;
  boolean rightEdge;
  boolean leftEdge;
  float randomizer;

  Enemy(float ex, float ey) {
    x=ex;
    y=ey;
    r=enemyRad;
    speed=2.4;
    right=true;
    left=false;
    rightEdge=false;
    leftEdge=false;
    // seed random drop
    randomizer=random(1, 10);
    if ( randomizer >0 && randomizer <1) {
      randomDrop=scl;
    }
    if ( randomizer >1 && randomizer <3) {
      randomDrop=scl*2;
    }
    if ( randomizer >3 && randomizer <4) {
      randomDrop=scl*3;
    }
    if ( randomizer >4 && randomizer <5) {
      randomDrop=scl*4;
    }
    if ( randomizer >5 && randomizer <6) {
      randomDrop=scl*5;
    }
    if ( randomizer >6 && randomizer <7) {
      randomDrop=scl*6;
    }
    if ( randomizer >7 && randomizer <8) {
      randomDrop=scl*7;
    }
    if ( randomizer >8 && randomizer <9) {
      randomDrop=scl*8;
    }
    if ( randomizer >9 && randomizer <10) {
      randomDrop=scl*9;
    }
    //println(randomDrop);
  }


  void show() {

    noStroke();
    fill(0, 255, 255);
    ellipse (x, y, r, r);
  }

  float posX() {
    return x;
  }

  float posY() {

    return y;
  }

  void update() {

    if (right) {
      x = x + speed;
    }

    if (left) {
      x = x - speed;
    }

    if (rightEdge) {
      y=y+scl;
      rightEdge=false;
    }
    if (leftEdge) {
      y=y+scl;
      leftEdge=false;
    }

    if (x > width-10 && right) {
      left=true;
      right=false;
      rightEdge=true;
      leftEdge=false;
    }

    if (x < 10 && left) {

      left=false;
      right=true;
      leftEdge=true;
      rightEdge=false;
    }

    if (y > height) {      
      y = 0;
    }

    if (y > 50+randomDrop*2) {
      //Level engine...
      if (level > 1) {
        x = randomDrop;
      } else {
        x = width/2;
      }



      y = y + speed;
    }
  }
}