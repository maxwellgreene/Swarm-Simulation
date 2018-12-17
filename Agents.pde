class Agent
{
  PVector velocity, position;
  PVector di,dR,dO,dA;
  PVector tempVect = new PVector (0,0,0);PVector tempAdj = new PVector (0,0,0);
  boolean dRBool, alive;
  float tempMag,tempRandom;
  float distance,predDist,avgDist,angleBetween;
  float Azor,Azoo,Azoa,Aalpha;
  
  Agent(PVector initposition, PVector initvelocity, boolean bool, PVector tempdi, PVector tempdR, PVector tempdO, PVector tempdA, float tempzor, float tempzoo, float tempzoa, float tempAlpha, boolean tempalive)
  {
    position = initposition;
    velocity = initvelocity;
    di = tempdi; dR = tempdR; dO = tempdO; dA = tempdA;
    dRBool = bool;
    Azor = tempzor;
    Azoo = tempzoo;
    Azoa = tempzoa;
    Aalpha = tempAlpha;
    alive = tempalive;
  }

//===========================================================
//=================MOVE AGENTS BY VELOCITY===================
//===============ALSO ADDS NOISE TO MOVEMENT=================
//===========================================================
void move()
{
  if(alive == false)
  {velocity.setMag(0);}
  tempMag = velocity.mag();
  velocity.x *= random(1-noise,1+noise);
  velocity.y *= random(1-noise,1+noise);
  velocity.z *= random(1-noise,1+noise);
  velocity.setMag(tempMag);
  
  
  position.x += velocity.x;
  position.y += velocity.y;
  position.z += velocity.z;
}

//===========================================================
//=====================DISPLAY AGENTS========================
//===========================================================
void displayAgent(int i)
{
  strokeWeight(5);
  if(numSpecies>1)
  {stroke((255*(numSpecies-i)/numSpecies));}else{stroke((1000+int(position.z))/4,-int(position.z)/4,-int(position.z)/4);}
  point(position.x,position.y,position.z);
}

//===========================================================
//===========BIOLOGICALLY RELEVANT INTERACTION===============
//===========================================================
void interact(int i)
{
  dR.set(0,0,0);  dO.set(0,0,0);  dA.set(0,0,0);
  for(int j=0; j < a[i].length; j++)
  {
      distance = PVector.dist(position,a[i][j].position);
      if(distance<zoa   &   position.x!=a[i][j].position.x && a[i][j].getAlive() == true)
      {
        tempVect.set(a[i][j].position.x-position.x,a[i][j].position.y-position.y,a[i][j].position.z-position.z);
        angleBetween = (180/PI)*(PVector.angleBetween(velocity,tempVect));
        
        if(angleBetween < (180-alpha))
        {
        //====ZOR====
          if(distance<Azor)
          {dR.sub(tempVect.normalize());}
          //===========
          
          //====ZOO====
          if(distance<Azoo & distance>Azor)
          {tempVel.set(a[i][j].velocity);dO.add(tempVel.normalize());}
          //===========
          
          //====ZOA====
          if(distance<Azoa & distance>Azoo)
          {dA.add(tempVect.normalize());}
          //===========
        }
      }
  }
  tempMag = velocity.mag();
  if(dR.mag() > 0){di.set(dR);}else{di.set((PVector.add(dO,dA)).mult(.5));}
  
  
  if(PVector.angleBetween((PVector.add(di,velocity)),velocity) > turningRate)
  {
    tempVect.set(velocity);tempVect.setMag(di.mag());
    tempAdj.set(di.x-velocity.x,di.y-velocity.y,di.z-velocity.z);
    tempAdj.setMag(tan(turningRate)*(di.mag()));
    di.set(tempAdj);
  }
  di.setMag(tempMag);
  velocity.add(di);
  velocity.setMag(tempMag);
}

//===========================================================
//=================KEEP AGENTS IN ARENA======================
//===========================================================
  void keepInBounds()
  {
    //====CHECK X====
    if(position.x<=((width/2)-borderRadius)){position.x = (width/2)-borderRadius+.1; velocity.x = -(velocity.x);}
    if(position.x>=((width/2)+borderRadius)){position.x = (width/2)+borderRadius-.1; velocity.x = -(velocity.x);}
    //====CHECK Y====
    if(position.y<=((height/2)-borderRadius)){position.y = (height/2)-borderRadius+.1; velocity.y = -(velocity.y);}
    if(position.y>=((height/2)+borderRadius)){position.y = (height/2)+borderRadius-.1; velocity.y = -(velocity.y);}
    //====CHECK Z====
    if(position.z>=((depth/2)+borderRadius)){position.z = (depth/2)+borderRadius-.1; velocity.z = -(velocity.z);}
    if(position.z<=((depth/2)-borderRadius)){position.z = (depth/2)-borderRadius+.1; velocity.z = -(velocity.z);}
  }
//===========================================================
//==============AVOIDS PREDATORS OF SPECIES==================
//===========================================================

  void avoidPredator(int speciesNum)
  {
    for(int i=0;i<p[speciesNum].length;i++)
    {
      predDist = (PVector.dist(position,p[speciesNum][i].position));
      if(predDist<pOrient && predAvoidType >= 3)
      {
        Azor = pzor;
        Azoo = pzoo;
        Azoa = pzoa;
      }else{
        Azor = zor;
        Azoo = zoo;
        Azoa = zoa;
      }
      if(predDist<pRepel && predAvoidType >= 2)
      {
        tempMag = velocity.mag();
        velocity.sub(predAvoidMult*(p[speciesNum][i].position.x-position.x),predAvoidMult*(p[speciesNum][i].position.y-position.y),predAvoidMult*(p[speciesNum][i].position.z-position.z));
        velocity.setMag(tempMag);
      }
      if(predDist<pKill && predAvoidType >=1)
      {alive = false;}
    }
  }
//===========================================================
void setGUIValues()
{
  Azor = zor;
  Azoo = zoo;
  Azoa = zoa;
  Aalpha = alpha;
}


  boolean getAlive()
  {return alive;}
}