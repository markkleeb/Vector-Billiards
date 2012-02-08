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




class Ball {

  // We need to keep track of a Body and a width and height
  Body body;
  float w;
  float h;
  int c = color(random(0,255), random(0,255), random(0,255));

  
  Ball(float x, float y) {
    w = 10;
    h = w;
    // Adds ball to the box2d world
    makeBody(new Vec2(x,y),w,h);
  }

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }

  // Is the particle ready for deletion?
  boolean lose() {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);  
    // Check if it's in the center of the screen
    if (pos.y > height/2-25 && pos.y < height/2+25 && pos.x > width/2-25 && pos.x < width/2+25) {
      killBody();
      return true;
    }
    return false;
  }
  boolean win(){
        Vec2 pos = box2d.getBodyPixelCoord(body);  
     if (pos.y > height-40 && pos.y < height-20 && pos.x > width/2-10 && pos.x < width/2+10) {
      killBody();
      return true;
    }
    return false;
  }

  void attract(float x,float y) {
    // From BoxWrap2D example
    Vec2 worldTarget = box2d.coordPixelsToWorld(x,y);   
    Vec2 bodyVec = body.getMemberWorldCenter();
    // First find the vector going from this body to the specified point
    worldTarget.subLocal(bodyVec);
    // Then, scale the vector to the specified force
    worldTarget.normalize();
    worldTarget.mulLocal((float) 100);
    // Now apply it to the body's center of mass.
    body.applyForce(worldTarget, bodyVec);
  }


  // Drawing the ball
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();

    ellipseMode(CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(c);
    strokeWeight(1);
    stroke(0);
    ellipse(0,0,w,h);
    popMatrix();
  }

  // This function adds the ball to the box2d world
  void makeBody(Vec2 center, float w_, float h_) {

    // Define a polygon (any shape)
    PolygonDef sd = new PolygonDef();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    // Parameters that affect physics
    sd.density = 15.0f; //mass? heavier=slower
    sd.friction = 0.3f; //friction
    sd.restitution = 0.5f; //bounciness

    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createShape(sd);
    body.setMassFromShapes();

  }
}


// A fixed boundary class

class Boundary {

  // A boundary is a simple rectangle with x,y,width,and height
  float x;
  float y;
  float w;
  float h;
  // But we also have to make a body for box2d to know about it
  Body b;

  Boundary(float x_,float y_, float w_, float h_, float angle) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;

    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    Vec2 center = new Vec2(x,y);

    // Define the polygon
    PolygonDef sd = new PolygonDef();
    sd.setAsBox(box2dW, box2dH);
    sd.density = 0;    // No density means it won't move!
    sd.friction = 0.3f;

    // Create the body
    BodyDef bd = new BodyDef();
    bd.position.set(box2d.coordPixelsToWorld(center));
    bd.angle = angle;
    b = box2d.createBody(bd);
    b.createShape(sd);
  }

  //Draw boundaries
  void display() {
    fill(0);
    stroke(0);
    rectMode(CENTER);
   
    float a = b.getAngle();
    
    pushMatrix();
    translate(x,y);
    rotate(-a);
     rect(0,0,w,h);
    popMatrix();  

}

}



