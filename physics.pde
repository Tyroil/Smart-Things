/*

 Example Processing sketch for Aesthetic code / Smart Things
 2017 Christopher von Nagy
 
 A sketch of a pinball game for Smart Things

*/

void setupFurniture() {
  
  // Instantiate box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(gravity.x, gravity.y);

  // Turn on collision listening!
  box2d.listenForCollisions();
  
  // Add some boundaries
  boundaries = new ArrayList<Boundary>();
  boundaries.add(new Boundary(width/2,5,width,10));
  boundaries.add(new Boundary(width-5,height/2,10,height));
  boundaries.add(new Boundary(5,height/2,10,height));
  boundaries.add(new Boundary(width/4,height-5,width/2-110,10));
  boundaries.add(new Boundary(3*width/4,height-5,width/2-110,10));
  
  // svgpoly = new SVGPoly("test_curve.svg", 200, 200);

  // Add the obstacles
  obstacles = new ArrayList<Obstacle>();
  for (int i = 0; i < obstacle_count; i++) {
    obstacles.add(new Obstacle(random(60, width-60), random(100, height-200), random(35, 50), random(1, 10)));
  }
  
}

void setupFlippers() {
  
  flipperL = new Flipper(75.0, 725.0, "r");
  flipperR = new Flipper(325,725, "l");
  
}

void releaseBall(float v) {
  
 ball = new Ball(20, 20, 18, random(1, 5), v);
 
}

void doPhysics() {
  
    // Increment through time
  box2d.step();

  // Show the boundaries
  for (Boundary wall: boundaries) {
    wall.display();
  }
  
  // svgpoly.display();

  // Show bumpers
  for (Obstacle bumper: obstacles) {
    bumper.display();
  }
  
  flipperL.display();
  flipperR.display();
  
  if(ball != null){ if(ball.in_bounds()) {ball.display();}}

}
