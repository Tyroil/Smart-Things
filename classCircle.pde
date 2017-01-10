/*

 Example Processing sketch for Aesthetic code / Smart Things
 2017 Christopher von Nagy
 
 A sketch of a pinball game for Smart Things

*/

class Circle {

  // We need to keep track of a Body and a width and height
  Body body;
  float x;
  float y;
  float r;

  // Class constructor
  Circle(float x_, float y_, float r_, boolean lock) {
    x = x_;
    y = y_;
    r = r_;
    
    // Define and create the body
    makeBody(x, y, r);
    body.setUserData(this);
    
  }

  // Draw the obstacle, if it were at an angle we'd have to do something fancier
  void display() {
    fill(175);
    stroke(0);
    ellipse(x, y, r*2, r*2);  
  }
  
  // Here's our function that adds the ball to the Box2D world
  void makeBody(float x, float y, float r) {
    // Define a body
    BodyDef bd = new BodyDef();
    // Set its position
    bd.position = box2d.coordPixelsToWorld(x, y);
    bd.type = BodyType.STATIC;
    bd.angularDamping = 0.9;
    
    body = box2d.createBody(bd);

    // Make the body's shape a circle
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parameters that affect physics
    fd.density = 10;
    fd.friction = 0.3;
    fd.restitution = 1;

    // Attach fixture to body
    body.createFixture(fd);

    body.setAngularVelocity(0);
  }
}
