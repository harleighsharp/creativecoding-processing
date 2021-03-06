class ParticleSystem
{
  private ArrayList<Particle> particles;
  private PVector position;
  private PVector gravity;
  private int maxParticles;
  private int numParticles;

 
  
  
  ParticleSystem(float x, float y)
  {
    position = new PVector(x, y);
    particles = new ArrayList<Particle>();
    gravity = new PVector(0.0, 0.03);
    maxParticles = 50;
    
  }
  
  public void setPosition(PVector p)
  {
    position = p;
  }
  
  public void update()
  {
    ArrayList<Particle> toRemove = new ArrayList<Particle>();
    
    
     if(numParticles <= maxParticles){
       addParticle();
       numParticles++;
     }
    
    for(Particle p:particles)
    {
      p.applyForce(gravity);
      p.update();
      
      if(!p.isAlive())
      {
        //add it to be removed list
        toRemove.add(p);
      }
    }
    
    particles.removeAll(toRemove);
    
    
    
    
    
  }
  
  public void render()
  {
    for(Particle p:particles)
    {
        p.render();
    }
  }
  
  public void addParticle()
  {
    Particle particleObj = new Particle(position.x, position.y);
    particles.add(particleObj);
    
    PVector randomVelocity = new PVector(random(-2.0, 2.0), random(0.0, 6.0));
    particleObj.setVelocity(randomVelocity);
    particleObj.setLife(0.0);
    
 
  
  }
}