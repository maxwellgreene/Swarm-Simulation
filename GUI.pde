//=========================================================
//===============DRAWS BORDERS OF BOX======================
//=========================================================
void drawBorder()
{
  stroke(0); strokeWeight(1);
  //noFill();
  
  //====X TOP REAR====
  line((width/2)-borderRadius,(height/2)-borderRadius,(depth/2)-borderRadius,(width/2)+borderRadius,(height/2)-borderRadius,(depth/2)-borderRadius);
  //====X TOP FRONT====
  line((width/2)-borderRadius,(height/2)-borderRadius,(depth/2)+borderRadius,(width/2)+borderRadius,(height/2)-borderRadius,(depth/2)+borderRadius);
  //====X BOTTOM REAR====
  line((width/2)-borderRadius,(height/2)+borderRadius,(depth/2)-borderRadius,(width/2)+borderRadius,(height/2)+borderRadius,(depth/2)-borderRadius);
  //====X BOTTOM FRONT====
  line((width/2)-borderRadius,(height/2)+borderRadius,(depth/2)+borderRadius,(width/2)+borderRadius,(height/2)+borderRadius,(depth/2)+borderRadius);
  //====Z TOP LEFT====
  line((width/2)-borderRadius,(height/2)-borderRadius,(depth/2)-borderRadius,(width/2)-borderRadius,(height/2)-borderRadius,(depth/2)+borderRadius);
  //====Z BOTTOM LEFT====
  line((width/2)-borderRadius,(height/2)+borderRadius,(depth/2)-borderRadius,(width/2)-borderRadius,(height/2)+borderRadius,(depth/2)+borderRadius);
  //====Z TOP RIGHT====
  line((width/2)+borderRadius,(height/2)-borderRadius,(depth/2)-borderRadius,(width/2)+borderRadius,(height/2)-borderRadius,(depth/2)+borderRadius);
  //====Z BOTTOM RIGHT====
  line((width/2)+borderRadius,(height/2)+borderRadius,(depth/2)-borderRadius,(width/2)+borderRadius,(height/2)+borderRadius,(depth/2)+borderRadius);
  //====Y LEFT REAR====
  line((width/2)-borderRadius,(height/2)-borderRadius,(depth/2)-borderRadius,(width/2)-borderRadius,(height/2)+borderRadius,(depth/2)-borderRadius);
  //====Y LEFT FRONT====
  line((width/2)-borderRadius,(height/2)-borderRadius,(depth/2)+borderRadius,(width/2)-borderRadius,(height/2)+borderRadius,(depth/2)+borderRadius);
  //====Y RIGHT REAR====
  line((width/2)+borderRadius,(height/2)-borderRadius,(depth/2)-borderRadius,(width/2)+borderRadius,(height/2)+borderRadius,(depth/2)-borderRadius);
  //====Y RIGHT FRONT====
  line((width/2)+borderRadius,(height/2)-borderRadius,(depth/2)+borderRadius,(width/2)+borderRadius,(height/2)+borderRadius,(depth/2)+borderRadius);
  //box(1000);
}

void simGUI()
{
  textSize(20);
  fill(0);
  textAlign(LEFT,LEFT);
  text("s - Restart",width-200,50);
  text("p - Menu",width-200,70);
  text("Blob Threshold: "+blobThreshold,width-200,30);
  
  simDisplay.draw();
  
  zor = simDisplay.getController("Repel").getValue();
  zoo = simDisplay.getController("Orient").getValue();
  zoa = simDisplay.getController("Attract").getValue();
  alpha = simDisplay.getController("Alpha").getValue();
}

//=========================================================
//===========A COUPLE GUI THINGS WHEN CLICK================
//=========================================================
void keyPressed()
{
  if(keyCode == 80)//p
  {state = mainMenu;cam.setActive(false);}
  if(keyCode == 83)//s
  {state = sim;setMenuValues();}
  if(keyCode == UP){blobThreshold++;}
  if(keyCode == DOWN){blobThreshold--;}
  //println(blobThreshold);
  if(keyCode == 66)
  {blobToggle = !blobToggle;}
}

void mouseClicked()
{
  switch (state)
  {
    case mainMenu:
    {
      if(mouseX>10 && mouseX<210)
      {
        if(mouseY>100 && mouseY<140)
        {menuInteract = !menuInteract;}
        //========
        if(mouseY>150 && mouseY<190)
        {menuPredator = !menuPredator;}
        //========
        if(mouseY>200 && mouseY<240)
        {menuBounds = !menuBounds;}
        //========
        if(mouseY>250 && mouseY<290)
        {menuMovie = !menuMovie;}
        //========
        if(mouseY>300 && mouseY<340)
        {menuData = !menuData;}
        /*
        //========
        if(mouseY>350 && mouseY<390)
        {menuDataType1 = (menuDataType1+1)%5;}
        //========
        if(mouseY>400 && mouseY<440)
        {menuDataType2 = (menuDataType2+1)%5;}
        //========
        */
      }
      
      if(mouseX>900 && mouseX<980 && mouseY>900 && mouseY<980)
      {setMenuValues();}
    }
    case simMenu:
    {
      
    }
    case sim:
    {
      if(mouseX<100 & mouseY>height-100){save("ScreenShots//ScreenShot_####.png");println("Screenshot Captured!!");}
    }
  }
}