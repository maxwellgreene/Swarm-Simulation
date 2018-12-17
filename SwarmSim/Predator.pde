class Predator
{
  int counter;
  PVector position; PVector averagePosition = new PVector(0,0,0);
  Predator(float predatorStartX,float predatorStartY,float predatorStartZ)
  {
    position = new PVector(predatorStartX,predatorStartY,predatorStartZ);
  }
//===========================================================
//==============MOVES PREDATOR TOWARD ...====================
//===========================================================
  void movePredator(int speciesNum)
  {
    //This section moves predator toward average point
    if(predMoveType == 0)
    {
      counter = 0;
      averagePosition.set(0,0,0);
      for(int i=0;i<a[speciesNum].length;i++)
        {
          if(a[speciesNum][i].getAlive() == true)
          {
            counter++;
            averagePosition.add(a[speciesNum][i].position.x-position.x,a[speciesNum][i].position.y-position.y,a[speciesNum][i].position.z-position.z);
          }
        }
      println(counter);
      averagePosition.div(counter);
      averagePosition.setMag(predatorVelocity);
      position.add(averagePosition);
    }
    //This section moves predator to first alive point (until it dies)
    if(predMoveType == 1)
    {
      counter = 0;
      averagePosition.set(0,0,0);
      for(int i=0; i<a[speciesNum].length;i++)
      {
        if(a[speciesNum][i].getAlive() == true)
        {
          averagePosition.add(a[speciesNum][i].position.x-position.x,a[speciesNum][i].position.y-position.y,a[speciesNum][i].position.z-position.z);
          break;
        }
      }
      averagePosition.setMag(predatorVelocity);
      position.add(averagePosition);
      for(int i=0; i<a[speciesNum].length;i++)
      {if(a[speciesNum][i].getAlive() == true){counter++;}}
      println("There are   "+counter+"   agents still alive!");
    }
  }
//===========================================================
//=============DISPLAYS EACH PREDATOR========================
//===========================================================
  void displayPredator()
  {
    strokeWeight(20);stroke(0);
    point(position.x,position.y,position.z);
  }
}