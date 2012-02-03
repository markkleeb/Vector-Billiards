class Ball{

PVector loc;
PVector vel;
PVector acc = new PVector(0,0);
Rectangle rec;

int c = color(random(0,255), random(0,255), random(0,255));


Ball(){
 
  loc = new PVector(random(0,width), random(0,height));  
  vel = new PVector(0, 0);  
  
  constrain(loc.x, 0, width);
  constrain(loc.y, 0, height);

 rec = new Rectangle(int(loc.x), int(loc.y), 10, 10);
  
}

void display(){
  
 smooth();
 fill(c);
 ellipse(loc.x, loc.y, 10, 10);
 

}

void mov(){
  
  acc.x = -vel.x/10;
  acc.y = -vel.y/10;
  
 vel.add(acc);
 loc.add(vel);
  
  if(loc.x == 0 || loc.x == width){
   
    vel.x *=-1;
    
  }
  
  if(loc.y ==0 || loc.y == height){
   
   vel.y *=-1;
  
    
  }
  
}

}



