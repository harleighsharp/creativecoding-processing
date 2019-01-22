class Bird{

  private PVector position;
  private PVector acceleration;
  private PVector velocity;
  
  private float maxSpeed;
  private float maxSteeringForce;
  
  private float separationDistance;
  private float searchDistance;
  
  private float separationWeight;
  private float alignmentWeight;
  private float cohesionWeight;
  private float attractWeight;
  
  private float radius;
  
  public Bird(float x, float y)
  {
    position = new PVector(x, y);
    velocity = new PVector(0.0, 0.0);
    acceleration = new PVector(0.0, 0.0);
    
    maxSpeed = 2.0;
    maxSteeringForce = 0.04;
    
    separationDistance = 60.0;
    searchDistance = 80.0;
    
    cohesionWeight= 0.9;
    alignmentWeight = 0.7;
    separationWeight = 0.9;
    attractWeight = 0.6;
    
    radius = random(6, 12);
  
  }
  
  public void applyForce(PVector force)
  {
    acceleration.add(force);
  }
  
  public void ScreenWrap()
  {
    if(position.x - radius > width)
      position.x = -radius;
      
    if(position.x + radius < 0)
      position.x = width + radius;
      
    if(position.y + radius < 0)
      position.y = height + radius;
      
    if(position.y - radius > height)
      position.y = -radius;
  }
  public void flock(ArrayList<Bird> birds)
  {
    //calculate forces
    PVector separationForce = calcSeparation(birds);
    PVector alignmentForce = calcAlignment(birds);
    PVector cohesionForce = calcCohesion(birds);
    
    //multiply resulting force by weights
    separationForce.mult(separationWeight);
    alignmentForce.mult(alignmentWeight);
    cohesionForce.mult(cohesionWeight);
    
    //apply forces to birds
    applyForce(separationForce);
    applyForce(alignmentForce);
    applyForce(cohesionForce);
   
    
  }

  public PVector calcSeparation(ArrayList<Bird> birds)
  {
    PVector steerVec = new PVector(0.0, 0.0, 0.0);
    int counter = 0;
    
    for(Bird b:birds)
    {
     float distance = PVector.dist(position, b.position);
     
     //distance is less than the desired sep dist but also more than 0 (same bird)
     if(distance < separationDistance && distance > 0)
     {
       PVector delta = PVector.sub(position, b.position);
       delta.normalize();
       delta.div(distance);
       steerVec.add(delta);
       counter++;
     }  
    }
    
    if(counter > 0)
    {
      steerVec.div((float)counter);
    }
    if(steerVec.mag() > 0)
    {
      steerVec.normalize();
      steerVec.mult(maxSpeed);
      steerVec.sub(velocity);
      steerVec.limit(maxSteeringForce);
    }
    return steerVec;
  }
  public PVector calcAlignment(ArrayList<Bird> birds)
  {
    PVector sum = new PVector(0.0, 0.0);
    int counter = 0;
    
    for(Bird b:birds)
    {
      float distance = PVector.dist(position, b.position);
      
      if(distance > 0 && distance < searchDistance)
      {
        sum.add(b.velocity);
        counter++;
      }
    }
    
    if(counter > 0)
    {
      sum.div((float)counter);
      sum.normalize();
      sum.mult(maxSpeed);
      PVector steerVec = PVector.sub(sum, velocity);
      steerVec.limit(maxSteeringForce);
      return steerVec;      
    }
    return new PVector(0.0, 0.0);
  }
  
  public PVector calcCohesion(ArrayList<Bird> birds)
  {
    PVector sum = new PVector(0.0, 0.0);
    int counter = 0;
    
    for(Bird b:birds)
    {
      float distance = PVector.dist(position, b.position);
      
      if (distance > 0 && distance < searchDistance)
      {
        sum.add(b.position);
        counter++;
      }
    }
    
    if(counter > 0)
    {
      sum.div((float)counter);
      PVector desired = PVector.sub(sum, position);
      desired.normalize();
      desired.mult(maxSpeed);
      
      PVector steerVec = PVector.sub(desired, velocity);
      steerVec.limit(maxSteeringForce);
      return steerVec;
    }
    return new PVector(0,0);
  }
  
  
  public void attract(PVector attractionPoint)
  {
    
    PVector attractPoint = attractionPoint;
    float distance = PVector.dist(position, attractPoint);
    
    if (distance > 0 && distance < searchDistance)
    {
      PVector desired = PVector.sub(attractPoint, position);
      desired.normalize();
      desired.mult(maxSpeed);
    
      PVector steerVec = PVector.sub(desired, velocity);
      steerVec.limit(maxSteeringForce);
      steerVec.mult(attractWeight);
      applyForce(steerVec);
    }
    else {
      applyForce(new PVector(0.0, 0.0));
    }
  }
  
  public void update()
  {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);
    
    acceleration.mult(0);
    ScreenWrap();
  }
  
  public void render(ArrayList<Bird> birds)
  {
    float speed = velocity.mag() / maxSpeed;
    noStroke();
    fill(222 * speed, 229 * speed, 226 * speed );
    
    float maxDistance = 50.0;
     for(Bird b:birds)
     {
          float distance = PVector.dist(position, b.position);
           if(distance < maxDistance && distance > 0)
           {
              pushMatrix();
                stroke(255);
                strokeWeight(0.25);
                line(position.x, position.y, b.position.x,b.position.y);
              popMatrix();
           }
        }
   pushMatrix();
     beginShape(TRIANGLES);
        noStroke();
        translate(position.x, position.y);
        rotate(velocity.heading());
        scale((1.0 * speed)+0.25);
        vertex(-radius, -radius);
        vertex(radius, 0);
        vertex(-radius, radius);
      endShape();
   popMatrix();
  }
  
 
}