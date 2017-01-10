/*

 Example Processing sketch for Aesthetic code / Smart Things
 2017 Christopher von Nagy
 
 A sketch of a pinball game for Smart Things

*/

class Ball {

  // Declare objects and variables
  Body body;
  color col;
  float x;
  float y;
  float r;
  float l1;
  float l2;

  // Class constructor
  Ball( float x_, float y_, float r_, float l1_, float l2_) {

    x = x_;
    y = y_;
    r = r_;
    l1 = l1_;
    l2 = l2_;
    
    makeBody(x, y, r, l1, l2);
    body.setUserData(this);
    col = color(175);
    
  }

  // Destroy the ball when it has fallen outside of the boundaries
  void killBody() {
    box2d.destroyBody(body);
  }

  // Do something when the ball bounces
  void change() {
    col = color(255, 0, 0);
  }
  
  // Is the ball in the play field?
  boolean in_bounds() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if (pos.y <= height+r*2) {
      return true;
    }
    return false;
  }


  // Is the ball ready for deletion?
  boolean done() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if (pos.y > height+r*2) {
      killBody();
      return true;
    }
    return false;
  }

  void setAngularVelocity(float a) {
    body.setAngularVelocity(a); 
  }
  
  void setVelocity(Vec2 v) {
     body.setLinearVelocity(v);
  }
  
  void setLocation(float x, float y) {
    Vec2 pos = body.getWorldCenter();
    Vec2 target = box2d.coordPixelsToWorld(x,y);
    Vec2 diff = new Vec2(target.x-pos.x,target.y-pos.y);
    diff.mulLocal(50);
    setVelocity(diff);
    setAngularVelocity(0);
  }


  // Show the ball 
  void display() {
    
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    fill(col);
    stroke(0);
    strokeWeight(0.5);
    ellipse(0, 0, r*2, r*2);
    line(0, 0, r, 0);
    popMatrix();
    
  }

  // Here's our function that adds the ball to the Box2D world
  void makeBody(float x, float y, float r, float l1, float l2) {
    // Define a body
    BodyDef bd = new BodyDef();
    // Set its position
    bd.position = box2d.coordPixelsToWorld(x, y);
    bd.type = BodyType.DYNAMIC;
    bd.bullet = true;
    
    body = box2d.createBody(bd);
    body.setLinearVelocity(new Vec2(l1, l2));
    body.setAngularVelocity(5);

    // Make the body's shape a circle
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parameters that affect physics
    fd.density = 8;
    fd.friction = 1;
    fd.restitution = 0.3;

    // Attach fixture to body
    body.createFixture(fd);

  }
  
}
