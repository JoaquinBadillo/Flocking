// This will represent a member of the flock (bird, fish, ... you name it)
// The agents are based on Craig Reynolds algorithm
// That means they will obey the rules of separation, alignment and cohesion

class Agent
{
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  // Radius of perception
  float radius = 60;
  
  float maxSpeed = 5;
  
  // Force weights
  float separationForce = 1.9; 
  float alignmentForce = 0.7;
  float cohesionForce = 0.4;
  
  // RGB values (these will be randomized to make the simulation look good)
  float r;
  float g;
  float b;

 Agent() {
    position = new PVector(random(width), random(height));
    velocity = new PVector(random(-1, 1), random(-1,1));
    acceleration = new PVector(0,0);
    
    r = random(100, 255);
    g = random(100, 255);
    b = random(100, 255);
  }
  
  void detectEdge() {
    // Check x coordinate
    if (position.x > width) {
      position.x = 0;
    }
    else if (position.x < 0) {
      position.x = width;
    }
    
    // Check y coordinate
    if (position.y > height) {
      position.y = 0; 
    }
    else if (position.y < 0) {
      position.y = height;
    }
  }
  
// Get alignment force based on the average velocity of neighbours
// A.K.A. follow the flow principle
  PVector align(ArrayList<Agent> agents) {
    PVector steeringForce = new PVector();
    
    // Number of neighbours
    float total = 0;
    
    // Get average velocity
    for (Agent p : agents) {
     float d = dist(position.x, position.y, p.position.x, p.position.y);
      if (p != this && d < radius)
      {
        steeringForce.add(p.velocity);
        total++;
      }
    }
    
    // Steering Force = Average Velocity - Agent Velocity
    if (total > 0)
    {
      steeringForce.div(total);
      steeringForce.sub(velocity);
      steeringForce.limit(alignmentForce);
    }
    
    return steeringForce;
  }
  
// Get cohesion force based on the average position of neighbours
// A.K.A agents together strong principle
  PVector cohesion(ArrayList<Agent> agents) {    
    PVector steeringForce = new PVector();
    
    // Number of neighbours
    float total = 0;
    
    // Get average position
    for (Agent p : agents) {
     float d = dist(position.x, position.y, p.position.x, p.position.y);
      if (p != this && d < radius)
      {
        steeringForce.add(p.position);
        total++;
      }
    }
    
    if (total > 0)
    {
      steeringForce.div(total);
      steeringForce.sub(position);
      steeringForce.limit(cohesionForce);
    }
    
    return steeringForce;
  }
  
// Get separation force based on the average position of neighbours
// A.K.A. I don't want to crash principle
  PVector separation(ArrayList<Agent> agents) {    
    PVector steeringForce = new PVector();
    
    // Number of neighbours
    float total = 0;
    
    // Get average position
    for (Agent p : agents) {
     float d = dist(position.x, position.y, p.position.x, p.position.y);
      if (p != this && d < radius)
      {
        PVector difference = PVector.sub(position, p.position);
        difference.div(d);
        steeringForce.add(difference);
        total++;
      }
    }
    
    if (total > 0)
    {
      steeringForce.div(total);
      steeringForce.sub(velocity);
      steeringForce.limit(separationForce);
    }
    
    return steeringForce;
  }
  
  // Update acceleration to match net force (mass = 1 in our unit system xd)
  void updateAcceleration(ArrayList<Agent> agents) {
    PVector f1 = align(agents);
    PVector f2 = cohesion(agents);
    PVector f3 = separation(agents);
    acceleration.add(f1);
    acceleration.add(f2);
    acceleration.add(f3);
  }
  
  // Update this object's state (updates occur in the end, once all accelerations are obtained)
  void update() {
    velocity.setMag(maxSpeed);
    position.add(velocity);
    velocity.add(acceleration);
    acceleration.mult(0);
  }
  
  void show() {
    strokeWeight(12);
    stroke(r, g, b);
    point(position.x, position.y);
  }
}
