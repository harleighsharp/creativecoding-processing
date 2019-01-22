
ArrayList<ParticleSystem> particleSystemsArray;
ParticleSystem particleSystem;

PVector clickedMousePos;
boolean clicked;


void setup()
{
  size(600,600);
  frameRate(60);
  particleSystemsArray = new ArrayList<ParticleSystem>();
  clicked = false;
}

void draw()
{
  
  background(207,220,228);
  PVector mousePos = new PVector(mouseX, mouseY);
   
  if(particleSystemsArray.size() > 0) 
  {
    
    for(ParticleSystem ps:particleSystemsArray)
    {
      //desintation - origin = direction
      PVector psPos = ps.getPosition();
      PVector direction = PVector.sub(psPos, mousePos);
      direction.normalize();
      //float distance = dist(psPos.x, psPos.y, mousePos.x, mousePos.y);
      
      
      if(clicked == false)
      {
        ps.applyGlobalForce(direction);
      }
      
      
      ps.update();
      ps.render();
    }
  }
  
  if(clicked)
  {
    particleSystem = new ParticleSystem(clickedMousePos.x, clickedMousePos.y);
    particleSystem.setPosition(clickedMousePos);
    particleSystemsArray.add(particleSystem);
    clicked = false;
  }
}

void mouseClicked()
{
  clicked = true;
  clickedMousePos = new PVector(mouseX, mouseY);
  
  
  
}