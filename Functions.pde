//=========================================================
PVector tempPos,tempVel = new PVector();
PVector zero = new PVector (0,0,0);
float tempPredDist=0;
float least = 0;
//=========================================================
//=================CREATES AGENT ARRAY=====================
//=========================================================
void initializeAgents()
{
  for(int i = 0; i<a.length; i++)
  {
  for(int j=0;j<a[i].length;j++)
  {
    float tempx = random((width/2)-startRadius,(width/2)+startRadius); 
    float tempy = random((height/2)-startRadius,(height/2)+startRadius); 
    float tempz = random((depth/2)-startRadius,(depth/2)+startRadius);
    float tempvx = random(-2,2); float tempvy = random(-2,2); float tempvz = random(-2,2);
    tempPos = new PVector(tempx,tempy,tempz);  
    tempVel = new PVector(tempvx,tempvy,tempvz);
    a[i][j] = new Agent(tempPos,tempVel,false,zero,zero,zero,zero,zor,zoo,zoa,alpha,true);
    //a[i][j].velocity.setMag(3);
  }
  }
}
//=========================================================
//===============CREATES PREDATOR ARRAY====================
//=========================================================
void initializePredators()
{
  for(int j=0;j<p.length;j++)
  {
    for(int i = 0; i<p[j].length; i++)
    {
      float tempPx = random(width/2-borderRadius,width/2+borderRadius);//(width/2)-borderRadius+50;
      float tempPy = random(height/2-borderRadius,height/2+borderRadius);//(height/2)-borderRadius+50;
      float tempPz = random(depth/2-borderRadius,depth/2+borderRadius);//(depth/2)-borderRadius+50;
      p[j][i] = new Predator(tempPx,tempPy,tempPz);
    }
  }
}
//=========================================================
//==========STORES AND WRITES DATA TO TEXT FILE============
//=========================================================
void initializeData()
{
  AverageNumWithinWriter = createWriter("Data\\avgNumWithin.txt");
  for(int i=0;i<numSpecies;i++)
    {
      AgentPositionWriter[i]   = createWriter("Data\\AgentPositions Species #"+(i+1)+".txt");
      AgentVelocityWriter[i]   = createWriter("Data\\AgentVelocities Species #"+(i+1)+".txt");
      AveragePositionWriter[i] = createWriter("Data\\AveragePositions Species #"+(i+1)+".txt");
      AverageVelocityWriter[i] = createWriter("Data\\AverageVelocities Species #"+(i+1)+".txt");
      AveragePredDistWriter[i] = createWriter("Data\\AveragePredDist Species #"+(i+1)+".txt");
    }
}

void storeData(int frame)
{
  //=========================================================
  //==============INDIVIDUAL WRITERS=========================
  //=========================================================
    
  for(int i=0;i<a.length;i++)
  {
    if(frame == 0)
    {
      AgentPositionWriter[i].println("This is for species #"+i);
      AgentVelocityWriter[i].println("This is for species #"+i);
      AveragePositionWriter[i].println("This is for species #"+i);
      AverageVelocityWriter[i].println("This is for species #"+i);
      AveragePredDistWriter[i].println("This is for species #"+i);
    }
    for(int j=0;j<a[i].length;j++)
    {
      AgentPositionWriter[i].print("Agent #"+j+":  "+ a[i][j].position+"     ");
      AgentVelocityWriter[i].print("Agent #"+j+":  "+ a[i][j].position+"     ");
      tempPos.add(a[i][j].position);
      tempVel.add(a[i][j].velocity);
      if(predator)tempPredDist += dist(p[i][0].position.x,p[i][0].position.y,p[i][0].position.z,a[i][j].position.x,a[i][j].position.y,a[i][j].position.z);
    }
    tempPos.div(a[i].length);
    tempVel.div(a[i].length);
    if(predator)tempPredDist /= a[i].length;
    AgentPositionWriter[i].println();
    AgentVelocityWriter[i].println();
    AveragePositionWriter[i].println("Frame #"+frame+": "+tempPos);
    AverageVelocityWriter[i].println("Frame #"+frame+": "+tempVel);
    if(predator)AveragePredDistWriter[i].println("Frame #"+frame+": "+tempVel);
    tempPos.set(0,0,0);tempVel.set(0,0,0);tempPredDist=0;
  }
  if(frame ==0)
  {AverageNumWithinWriter.println("These are the average number of agents in a blob.");}
  AverageNumWithinWriter.println(avgNumWithin);
}

void writeData()
{
  AverageNumWithinWriter.flush();
  AverageNumWithinWriter.close();

  for(int i=0;i<numSpecies;i++)
  {
    AgentPositionWriter[i].flush();
    AgentVelocityWriter[i].flush();
    AveragePositionWriter[i].flush();
    AverageVelocityWriter[i].flush();
    AveragePredDistWriter[i].flush();
    
    AgentPositionWriter[i].close();
    AgentVelocityWriter[i].close();
    AveragePositionWriter[i].close();
    AverageVelocityWriter[i].close();
    AveragePredDistWriter[i].close();
  }
}


Slider repelDisplay,orientDisplay,attractDisplay,alphaDisplay;
Button buttonTest;
void createControllers()
{
  menuController = new ControlP5(this);
  menuController.setAutoDraw(false);
  menuController.addSlider("Repel",0,200,zor,10,450,200,40);
  menuController.addSlider("Orient",0,200,zoo,10,500,200,40);
  menuController.addSlider("Attract",0,200,zoa,10,550,200,40);
  menuController.addSlider("Alpha",0,180,alpha,10,600,200,40);
  
  simDisplay = new ControlP5(this);
  simDisplay.setAutoDraw(false);
  repelDisplay = simDisplay.addSlider("Repel",0,200,zor,10,10,300,50);
  orientDisplay = simDisplay.addSlider("Orient",0,200,zoo,10,70,300,50);
  attractDisplay = simDisplay.addSlider("Attract",0,200,zoa,10,130,300,50);
  alphaDisplay = simDisplay.addSlider("Alpha",0,200,alpha,10,190,300,50);
}

void createCamera()
{
  cam = new PeasyCam(this,500);
  cam.setMinimumDistance(1500);
  cam.setMaximumDistance(2000);
  cam.setActive(false);
}