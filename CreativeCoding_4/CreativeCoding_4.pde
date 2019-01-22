ArrayList<PVector> repeller;
ArrayList<Bird> birdArray;

PVector repelPt;
float repelPtSize;
float repelDir;

boolean clicked;
PVector clickedMousePos;

PVector initialBirdPos;
int numBirds;
float t;



void setup()
{
  size(600,600);
  frameRate(60);
  numBirds = 60;
 
  repeller = new ArrayList<PVector>();
  birdArray = new ArrayList<Bird>();
  
  for(int i = 0; i < numBirds; i++){
    initialBirdPos = new PVector(random(0,width),random(0,height));
     birdArray.add(new Bird(initialBirdPos.x, initialBirdPos.y));
   }
  
  clicked = false;
  clickedMousePos = new PVector(0.0, 0.0);
  
  
  repelDir = random(TWO_PI);
  
}

void draw()
{
  background(29,13,43);

   t += 0.01;

  for(Bird b:birdArray)
  {
    b.flock(birdArray);
    for(PVector a : repeller)
    {
       float repelOffset = random(-0.005, 0.005);
       repelDir += repelOffset;
       a.x += cos(repelDir) * 0.05;
       a.y += sin(repelDir) * 0.05;
      
       fill(242,178, 27);
      
       pushMatrix();
        translate(a.x, a.y);
       scale((sin(t*3)+3)*0.55);
       
       ellipse(0,0, repelPtSize, repelPtSize);
      
       popMatrix();
        repelScreenWrap();

      b.repel(a); 
    }
    
    b.update();
    b.render(birdArray);
  }
 
  if(clicked)
  {
    newRepelPt(clickedMousePos);
    repeller.add(repelPt);
    clicked = false;
  }
 
  
}

void mouseClicked()
{
  clicked = true;
  clickedMousePos = new PVector(mouseX, mouseY);
  
}
void newRepelPt(PVector pos)
{
  repelPt = new PVector(pos.x, pos.y);
  repelPtSize = 20.0;
  repelDir = random(TWO_PI);
  
}
void repelScreenWrap()
{

  //screen wrapping
  if(repelPt.x - repelPtSize/2 > width)
    repelPt.x = -repelPtSize/2;
    
  if(repelPt.x + repelPtSize/2 < 0)
    repelPt.x = width + repelPtSize/2;
    
  if(repelPt.y + repelPtSize/2 < 0)
    repelPt.y = height + repelPtSize/2;
    
  if(repelPt.y - repelPtSize/2 > height)
    repelPt.y = -repelPtSize/2;
  
}