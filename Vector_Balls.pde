//Mark Kleback
//Nature of Code 2012
//Box2D Vector Balls

import pbox2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

// A reference to our box2d world
PBox2D box2d;

// A list we'll use to track fixed objects
ArrayList<Boundary> boundaries;
// List for ball objects
ArrayList<Ball> balls;
int counter;

void setup() {
  size(400,300);
  smooth();
counter =0;
  // Initialize box2d physics and create the world
  box2d = new PBox2D(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, 0);

  // Create ArrayLists	
  balls = new ArrayList<Ball>();
  boundaries = new ArrayList<Boundary>();

  // Add a bunch of fixed boundaries
  boundaries.add(new Boundary(width/2, 5,width, 10,0f));
  boundaries.add(new Boundary(width/2,height-5,width,10,0f));
  boundaries.add(new Boundary(width-5,height/2,10,height,0f));
  boundaries.add(new Boundary(5,height/2,10,height,0f));
  boundaries.add(new Boundary(50, 100, 10, 120, -0.5f));
   boundaries.add(new Boundary(width-100, 70, 10, 100, 0.5f));
   boundaries.add(new Boundary(100, height-70, 10, 100, 0.5f));
    boundaries.add(new Boundary(width-100, height-70, 10, 100, -0.5f));
      boundaries.add(new Boundary(width/2, height/2+50, 220, 10, 0f));



}

void draw() {
  background(255);

  // We must always step through time!
  box2d.step();

fill(0);
stroke(255, 0, 0);
strokeWeight(3);
  ellipse(width/2, height/2, 50, 50);
  fill(0, 255, 0);
  stroke(0);
  ellipse(width/2, height-30, 20, 20);
  
 

  if(mousePressed){
    for(Ball b: balls){
      b.attract(mouseX, mouseY);
  }
  }
  
  else{
  
    for (Ball b: balls) {
     b.attract(width/2,height/2);
    }
    
  }
  

  // Display all the boundaries
  for (Boundary wall: boundaries) {
    wall.display();
  }

  // Display all the balls
  for (Ball b: balls) {
    b.display();
  }

//Remove balls that are sucked into center

  for (int i = balls.size()-1; i >= 0; i--) {
    Ball b = balls.get(i);
    if (b.lose()) {
      balls.remove(i);
      counter --;  
  }
  if(b.win()){
  balls.remove(i);
  counter++;
  
  }
  }
  
  if(counter > 9)
  {
    fill(255, 0, 0);
  
   text("You Win!", width/2-50, height/2-50); 
   for (int i = balls.size()-1; i >= 0; i--) {
    Ball b = balls.get(i);
    balls.remove(i);
   }
   text("Play Again?", width/2-50, height/2 - 30);

if(mousePressed && mouseX > width/2 -50 && mouseX < width/2+50 && mouseY> height/2-50 && mouseY < height/2 -40){
println("Sucess!");
  restart();
}  

}

else  if(frameCount%120 ==1){

  Ball p = new Ball(15, 15);
  balls.add(p);
  
}  
  
  fill(0);
  text("Score: " + counter,20,25);
}

void restart(){
 
 counter = 0;
 redraw(); 
  
}



