class Ship {
  
  float x;
  float x1;
  float x2;
  float y;
  float y1;
  float y2;
  float shipWidth;
  float shipHeight;
  float xspeed;
  
 Ship(){
   
   shipHeight = scl;
   shipWidth = scl;
   x = width/2;
   y = height;
   x1 = width/2+(shipWidth/2);
   y1 = height-shipHeight;
   x2= width/2+shipWidth;
   y2 = height;
   
 }
  
  void show() {   
     noStroke();
     fill(255);
     //triangle(30, 75, 58, 20, 86, 75);
     triangle(x, y, x1, y1, x2, y2);
  }
  
  void dir(float x) {
    xspeed = x;
  }
  
  void update() {    
    x+=xspeed;
    x1+=xspeed;
    x2+=xspeed; 
    //Constrain triangle ship
    if (x2 > width) {       
      x2=width;
      x1=width-(shipWidth/2);
      x=width-shipWidth;  
    }    
    if (x < 0) {     
      x=0;
      x1=0+(shipWidth/2);
      x2=0+shipWidth;
    }
    
  }
  
 float Xpoint(){
   
   return x1;
 }
 
 float Ypoint() {
    
   return y1;
 }
  
}