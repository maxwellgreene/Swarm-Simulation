
int state = 0;
final int mainMenu = 0;
final int simMenu = 1;
final int sim = 2;

boolean menuInteract = true;
boolean menuPredator = false;
boolean menuBounds   = true;
boolean menuMovie    = false;
boolean menuData     = false;


int menuDataType1    = 0;
int menuDataType2    = 1;

//=========================================================
//===================DRAWS MAIN MENU=======================
//=========================================================
void drawMenu()
{
  background(25,205,125);
  translate(-500,-500,635);
  
  stroke(255);  fill(255); strokeWeight(1);
  textSize(40); textAlign(TOP,TOP);
  
  text("Main Menu",10,10);
  
  //========INTERACT========
  if(menuInteract){fill(0,255,0);}else{fill(255,0,0);}
  rect(10,100,200,40);
  fill(0); text("Interact",12,98);
  
  //========PREDATOR========
  if(menuPredator){fill(0,255,0);}else{fill(255,0,0);}
  rect(10,150,200,40);
  fill(0); text("Predator",12,148);
  
  //========BOUND========
  if(menuBounds){fill(0,255,0);}else{fill(255,0,0);}
  rect(10,200,200,40);
  fill(0); text("Bound",12,198);
  
  //========MOVIE========
  if(menuMovie){fill(0,255,0);}else{fill(255,0,0);}
  rect(10,250,200,40);
  fill(0); text("Movie",12,248);
  
  //========DATA========
  if(menuData){fill(0,255,0);}else{fill(255,0,0);}
  rect(10,300,200,40);
  fill(0); text("Data",12,298);
  
  /*
      //========FIRST DATA TYPE========
      if(menuData){fill(0,255,0);}else{fill(255,0,0);}
      rect(10,350,200,40);
      fill(0); 
      if(menuDataType1 == 0)text("Data - P",12,348);
      if(menuDataType1 == 1)text("Data - V",12,348);
      if(menuDataType1 == 2)text("Data - AP",12,348);
      if(menuDataType1 == 3)text("Data - AV",12,348);
      if(menuDataType1 == 4)text("Data - PD",12,348);
      //========SECOND DATA TYPE========
      if(menuData){fill(0,255,0);}else{fill(255,0,0);}
      rect(10,400,200,40);
      fill(0); 
      if(menuDataType2 == 0)text("Data - P",12,398);
      if(menuDataType2 == 1)text("Data - V",12,398);
      if(menuDataType2 == 2)text("Data - AP",12,398);
      if(menuDataType2 == 3)text("Data - AV",12,398);
      if(menuDataType2 == 4)text("Data - PD",12,398);
  */
  
  fill(0,255,0);
  rect(900,900,80,80);
  textSize(32); fill(0); textAlign(CENTER,CENTER);
  text("GO!",940,930);
}
//=========================================================
//==============SET VALUES AFTER MAIN MENU=================
//=========================================================
void setMenuValues()
{
  println("Setting menu values.");
  state = 2;
  
  //==SET WORKING BOOLEANS TO MENU BOOLEANS==
  interact = menuInteract;
  movie = menuMovie;
  predator = menuPredator;
  printData = menuData;
  keepInBounds = menuBounds;
  dataType1 = menuDataType1; dataType2 = menuDataType2;
  
  //==SET WORKING VALUES TO MENU VALUES==
  zor = menuController.getController("Repel").getValue();
  zoo = menuController.getController("Orient").getValue();
  zoa = menuController.getController("Attract").getValue();
  alpha = menuController.getController("Alpha").getValue();
  
  //==SET SIM DISPLAY VALUES TO WORKING VALUES==
  repelDisplay.setValue(zor);
  orientDisplay.setValue(zoo);
  attractDisplay.setValue(zoa);
  alphaDisplay.setValue(alpha);
  
  initializeAgents();
  if(predator){initializePredators();}
  if(printData){initializeData();}
  cam.setActive(true);
}
//=========================================================
//====================RUNS SIMULATION======================
//=========================================================
void simulate()
{
  if(numSpecies==1)
  {background(25,205,125);}else{background(35,200,120);}
  translate(-500,-500,500);
  drawBorder();
  if (simDisplay.isMouseOver())
    {cam.setActive(false);}
    else{cam.setActive(true);}
  for(int i = 0;i<numSpecies;i++)
  {
    for(Agent a : a[i])
    {
      a.setGUIValues();
      if(a.alive == true)
      {
      //==PREDATOR INTERACT==
      if (predator && (frame%timeStep)==0 && predAvoidType != 0){a.avoidPredator(i);}
      //==INTERACT==
      if (interact && (frame%timeStep)==0){a.interact(i);}
      //==KEEP IN BOUNDS==
      if (keepInBounds){a.keepInBounds();}
      //==MOVE==
      a.move();
      //==DISPLAY==
      a.displayAgent(i);
      }
    }
  }
  if(predator)
  {
    for(int i = 0;i<numSpecies;i++)
    {
      for(Predator p : p[i])
      {
        p.movePredator(i);
        p.displayPredator();
      }
    }
  }
}