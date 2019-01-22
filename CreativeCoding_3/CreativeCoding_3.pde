ArrayList<PVector> attractors;
ArrayList<Bird> birdArray;

PVector attractionPt;

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
 
  attractors = new ArrayList<PVector>();
  birdArray = new ArrayList<Bird>();
  t = 0.0;
  
  
  for(int i = 0; i < numBirds; i++){
    initialBirdPos = new PVector(random(0,width),random(0,height));
    birdArray.add(new Bird(initialBirdPos.x, initialBirdPos.y));
   }
  
  clicked = false;
  clickedMousePos = new PVector(0.0, 0.0);
}

void draw()
{
  background(29,13,43);

  
  t += 0.01;

  for(Bird b:birdArray)
  {
    b.flock(birdArray);
    for(PVector a : attractors)
    {
     
       fill(242,178, 27);
      
       pushMatrix();
        translate(a.x, a.y);
        rectMode(CENTER);
       scale((sin(t*3)+3)*0.55);
       
       ellipse(0,0, 20, 20);
      
        popMatrix();
       
       b.attract(a); 
    }
    
    b.update();
    b.render(birdArray);
    
  }

  
 
  if(clicked)
  {
    attractionPt = clickedMousePos;
    attractors.add(attractionPt);
    clicked = false;
  }
  
}

void mouseClicked()
{
  clicked = true;
  clickedMousePos = new PVector(mouseX, mouseY);
  
}