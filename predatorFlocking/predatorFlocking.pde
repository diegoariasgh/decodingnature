// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Demonstration of Craig Reynolds' "Flocking" behavior
// See: http://www.red3d.com/cwr/
// Rules: Cohesion, Separation, Alignment

// Click mouse to add boids into the system

Flock flock;

//just add a predator class which does everything,
//everything else stays the same
Predator predator;

void setup() {
  size(640,360);
  flock = new Flock();
  // Add an initial set of boids into the system
  for (int i = 0; i < 200; i++) {
    Boid b = new Boid(width/2,height/2);
    flock.addBoid(b);
  }
  predator = new Predator(width/3, height/2);
}

void draw() {
  background(255);
  //predator moves via perlin noise
  PVector predatorMovement = new PVector((noise(frameCount*.01)-.5),(noise(frameCount*.03)-.5));
  predator.applyForce(predatorMovement);
  //pass in all the boids to the predator
  predator.predate(flock.boids);
  
  flock.run();
  
  // Instructions
  fill(0);
  text("Drag the mouse to generate new boids.",10,height-16);
}

// Add a new boid into the System
void mouseDragged() {
  flock.addBoid(new Boid(mouseX,mouseY));
}