class Star {
    
  float x;
  float y;
  float r;
  
  Star() {
   
    x=random(0,width);
    y=random(0,height);
    r=random(0.5,2);
  }
  
  void show() {
    
     noStroke();
     fill(248);
     ellipse(x,y,r,r);
  }
  
  void scroll() {
    
     y=y+1.2;
     if (y > height) {
       y = 0;
     }
  }
  
  
  
  
  
  
  
  
  
  
  
  
}