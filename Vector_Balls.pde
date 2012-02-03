//Mark Kleback - Homework 
//Nature of Code

import java.util.*;  
import java.awt.*;

Mouse m;
ArrayList<Ball> b = new ArrayList();


void setup(){
    size(500, 500);
  
  for(int i = 0; i<50; i++){
    Ball newball = new Ball();
   b.add(newball);
   
  }
  
 
  
}

void draw() {
  
   background(255);
  
  //m.display();
  
  for(int i= 0; i < 50; i++){
 
    Ball thisball = b.get(i);
    
    thisball.display();
     thisball.mov();

  
//  if(m.hits(thisball.rec)){
// 
//    thisball.vel.add(m.vel);
//    
//  }
  }
  
}
