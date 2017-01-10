/*

 Example Processing sketch for Aesthetic code / Smart Things
 2017 Christopher von Nagy
 
 A sketch of a pinball game for Smart Things

*/

// import necessary libaries
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import java.util.Calendar;
// import controlP5.*;

// Declare our physical simulator
Box2DProcessing box2d;
Vec2 gravity = new Vec2(0, -9.8);

// Declare elements of the 
// physical world
ArrayList<Boundary> boundaries;
ArrayList<Obstacle> obstacles;
SVGPoly svgpoly;
Flipper flipperL;
Flipper flipperR;
//SVGPoly leftFlipper;
//SVGPoly rightFlipper;

int obstacle_count = 4;

// Declare the ball
Ball ball = null;

// Background image
PImage b_img;

// Text display
PFont f;
int score = 0;

// Set up the game
 void setup() {

  size(400,800);
  b_img = loadImage("road-street-forest-fog.jpg");
  background(b_img);
  setupGUI();
  setupFurniture();
  setupFlippers();

}

 void draw() {

  background(b_img);
  drawGUI(score);
  doInteraction();
  doPhysics();
  score += 1;

}
