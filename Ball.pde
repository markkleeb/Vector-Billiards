
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


