
ArrayList<ParticleSystem> particleSystemsArray;
ParticleSystem particleSystem;

PVector currentMousePos;
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

 
  if(particleSystemsArray.size() > 0) 
  {
    for(ParticleSystem ps:particleSystemsArray)
    {
      ps.update();
      ps.render();
    }
  }
  
  if(clicked)
  {
    particleSystem = new ParticleSystem(currentMousePos.x, currentMousePos.y);
    particleSystem.setPosition(currentMousePos);
    particleSystemsArray.add(particleSystem);
    clicked = false;
  }
}

void mouseClicked()
{
  clicked = true;
  currentMousePos = new PVector(mouseX, mouseY);
  
  
  
}