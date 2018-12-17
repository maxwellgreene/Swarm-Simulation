import peasy.*;
import controlP5.*;

void setup ()
{
  size(1000,1000,P3D);
  
  createCamera();
  createControllers();
}

void draw()
{
  frameRate(30);
  switch(state)
  {
    case mainMenu:
    {
      drawMenu();
      menuController.draw();
      break;
    }
    case simMenu:
    {
      break;
    }
    case sim:
    {
      simulate();
      if(blobToggle){doBlobs();}
      simGUI();
      if(printData && frame%1==0){storeData(frame);}
      frame++;
      if(movie){saveFrame("MovieStills//frame_###.png");}
      if(frame==maxFrames)
      {if(printData){writeData();}exit();}
      break;
    }
  }
}

//==========TO DO==========
//==
//== Smarter predator movement
//==
//== Smarter predator avoidance
//==
//== Menu improvements, all variables in menu