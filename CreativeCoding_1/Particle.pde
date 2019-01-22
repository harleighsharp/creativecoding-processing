
class Particle{

  private PVector position;
  private PVector acceleration;
  private PVector velocity;
  private float damping;
  
  private float lifetime;
  private float maxLifetime;
  
  private int colorRandomize;
  private int shapeRandomize;
  
  private color pink1;
  private color pink2;
  private color pink3;
  private color petalColor;
  
  private float rotationNoise;
  private float rotation;
  
  
  
  Particle(float x, float y)
  {
    position = new PVector(x, y);
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    rotation = 0.0;
    rotationNoise = 0.0;
    
    
    damping = 0.98;
    lifetime = 0;
    maxLifetime = 200;
    
    pink1 = color(226,115,147);
    pink2 = color(239,170,196);
    pink3 = color(255,196,209);
    
    //randomize which shade of pink and which shape
    colorRandomize = round(random(1,3));
    shapeRandomize = round(random(1,3));
    rotationNoise = 0;
    
    if(colorRandomize == 1){
      petalColor = pink1;
    }
    else if(colorRandomize == 2){
      petalColor = pink2;
    }
    else{
      petalColor = pink3;
    }
    
    
    
  }
  public boolean isAlive()
  {
    return (lifetime < maxLifetime);
  }
  
  public void applyForce(PVector force)
  {
    acceleration.add(force);
  }
   public void setVelocity(PVector vel)
  {
    velocity = vel;
  }


  public PVector getVelocity()
  {
    return velocity.copy();
  }
  
  public PVector getPosition()
  {
    return position;
  }
  public void setLife(float life)
  {
    lifetime = life;
  }
  
  
  public void update()
  {
    
    velocity.add(acceleration);
    position.add(velocity);
    
    acceleration.mult(0);
    velocity.mult(damping);
    lifetime++;
    
    rotationNoise = noise(position.x * 0.003, position.y * 0.003);
    rotation = map(rotationNoise, 0.5, 1.0, 0.0, TWO_PI);
    ScreenWrap();
  }
  
  public void render()
  {
    
    float lifePercent = 1.0 - (lifetime/maxLifetime);
    float angle = velocity.heading() * rotation;
    noStroke();
    fill(petalColor, 255 * lifePercent);
    
    
    pushMatrix();
      translate(position.x, position.y);
      rotate(angle);
      petalShape(shapeRandomize);
    popMatrix();
    
  }
  
  private void petalShape(int shapeType)
  {
    if(shapeType == 1)
    {
        beginShape();
          noStroke();
          vertex(0, 0);
          bezierVertex(-30, 35, 0, 35, 0, 0);
        endShape(CLOSE);
    }
    else if(shapeType == 2)
    {
        beginShape();
          noStroke();
          vertex(0, 0);
          bezierVertex(-45, 35, 30, 35, 0, 0);
        endShape(CLOSE);
    }
    else {
        beginShape();
          noStroke();
          vertex(0, 0);
          bezierVertex(-35, 25, 10, 25, 0, 0);
        endShape(CLOSE);
    }
   
  }
  public void ScreenWrap()
  {
    if(position.x > width)
      position.x = 0;
      
    if(position.x < 0)
      position.x = width;
      
    if(position.y < 0)
      position.y = height;
      
    if(position.y > height)
      position.y = 0;
  }
  
 
}