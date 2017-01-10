/*

 Example Processing sketch for Aesthetic code / Smart Things
 2017 Christopher von Nagy
 
 A sketch of a pinball game for Smart Things

*/

class Poly {

  // We need to keep track of a Body and a width and height
  Body body;
  Vec2[] vector;
  Vec2[] vertices;
  boolean lock;
  String chirality;
  

  // Constructor
  Poly(float x, float y, String chirality_, boolean lock_) {
    lock = lock_;
    chirality = chirality_;
    makeBody(new Vec2(x, y));
  }


  // Drawing the box
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();

    Fixture f = body.getFixtureList();
    PolygonShape ps = (PolygonShape) f.getShape();


    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(127);
    stroke(0);
    strokeWeight(2);
    beginShape();
    //println(vertices.length);
    // For every vertex, convert to pixel vector
    for (int i = 0; i < ps.getVertexCount(); i++) {
      Vec2 v = box2d.vectorWorldToPixels(ps.getVertex(i));
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
    popMatrix();
  }

  // This function adds the flipper polygon to the box2d world
  void makeBody(Vec2 center) {
    
    Vec2[] vertices = new Vec2[5];
    
    if (chirality == "r") { 
    vertices[0] = box2d.vectorPixelsToWorld(new Vec2(-15, 25));
    vertices[1] = box2d.vectorPixelsToWorld(new Vec2(15, 0));
    vertices[2] = box2d.vectorPixelsToWorld(new Vec2(75, -15));
    vertices[3] = box2d.vectorPixelsToWorld(new Vec2(75, -18));
    vertices[4] = box2d.vectorPixelsToWorld(new Vec2(-10, -10));
    } else { 
    vertices[0] = box2d.vectorPixelsToWorld(new Vec2(15, 25));
    vertices[1] = box2d.vectorPixelsToWorld(new Vec2(-15, 0));
    vertices[2] = box2d.vectorPixelsToWorld(new Vec2(-75, -15));
    vertices[3] = box2d.vectorPixelsToWorld(new Vec2(-75, -18));
    vertices[4] = box2d.vectorPixelsToWorld(new Vec2(10, -10));
    }

    // Define a polygon (this is what we use for a rectangle)
    PolygonShape ps = new PolygonShape();
    ps.set(vertices, vertices.length);

    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    if (lock) bd.type = BodyType.STATIC;
    else bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    body = box2d.createBody(bd);

    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 10;

    // body.createFixture(ps, 1.0);
    body.createFixture(fd);
    
  }
}
