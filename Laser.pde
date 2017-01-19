class Laser {

  float x;
  float y;
  float stop;
  Laser() {
    stop=0;
  }
  void fire(float xstart, float ystart, float yend) {
    x=xstart;
    y=ystart;
    stop=yend;
    //println("In laser.." + x,y);
    stroke(255, 0, 0);
    strokeWeight(5);
    line(x, y, x, 0+stop);
  }
}