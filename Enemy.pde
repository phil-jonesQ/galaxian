class Enemy {

  float x;
  float y;
  float r;
  float speed;

  Enemy() {
    x=random(15, width-15);
    y=random(0, height/2);
    r=enemyRad;
    speed=2.4;
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

    y=y+speed;

    if (x > width-10) {

      x=0;

    }

    if (y > height) {

      y=0;
    }
  }
}