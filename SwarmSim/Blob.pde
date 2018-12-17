int blobCounter = 0;
float numWithinCounter = 0;
boolean blobToggle = true;
class Blob
{
  float minx,miny,minz;
  float maxx,maxy,maxz;
  int id;
  boolean taken;
  
  Blob(float x,float y,float z)
  {
    id = 0;
    minx = x;
    miny = y;
    minz = z;
    maxx = x;
    maxy = y;
    maxz = z;
  }
  
  boolean isNear(PVector a)
  {
    if(a.x>(minx-blobThreshold) && a.x<(maxx+blobThreshold) && 
       a.y>(miny-blobThreshold) && a.y<(maxy+blobThreshold) && 
       a.z>(minz-blobThreshold) && a.z<(maxz+blobThreshold))
    {return true;}else
    {return false;}
  }
  
  void update(PVector a)
  {
    minx = min(minx,a.x);
    miny = min(miny,a.y);
    minz = min(minz,a.z);
    
    maxx = max(maxx,a.x);
    maxy = max(maxy,a.y);
    maxz = max(maxz,a.z);
  }
  
  
  float Size()
  {
    return abs(maxx-minx)*abs(maxy-miny)*abs(maxz-minz);
  }
    
  void drawBlob(int id)
  {
    stroke(0);
    strokeWeight(2);
    
    text(id,minx+20,miny+20,maxz);
    
    line(minx,miny,minz,maxx,miny,minz);
    line(maxx,miny,minz,maxx,maxy,minz);
    line(minx,maxy,minz,maxx,maxy,minz);
    line(minx,maxy,minz,minx,miny,minz);
    
    line(minx,miny,maxz,maxx,miny,maxz);
    line(maxx,miny,maxz,maxx,maxy,maxz);
    line(minx,maxy,maxz,maxx,maxy,maxz);
    line(minx,maxy,maxz,minx,miny,maxz);
    
    line(minx,miny,minz,minx,miny,maxz);
    line(minx,maxy,minz,minx,maxy,maxz);
    line(maxx,maxy,minz,maxx,maxy,maxz);
    line(maxx,miny,minz,maxx,miny,maxz);
  }
  
  
  PVector getCenter()
  {
    float x = (maxx - minx)*0.5+minx;
    float y = (maxy - miny)*0.5+miny;
    float z = (maxz - minz)*0.5+minz;
    
    return new PVector(x,y,z);
  }
  void become(Blob other)
  {
    minx = other.minx;
    maxx = other.maxx;
    miny = other.miny;
    maxy = other.maxy;
    minz = other.minz;
    maxz = other.maxz;
  }
}
ArrayList <Blob> currentBlobs = new ArrayList<Blob>();
void doBlobs()
{
  
  numWithinCounter=0;
  currentBlobs.clear();
  for(int i=0;i<(a.length);i++)
  {
    for(int j=0;j<a[i].length;j++)
    {
      boolean found = false;
      for(Blob b : currentBlobs)
      {
        if(b.isNear(a[i][j].position))
        {
          b.update(a[i][j].position);
          found = true;
          numWithinCounter++;
          break;
        }
      }
      if(!found)
      {
        Blob c = new Blob(a[i][j].position.x,a[i][j].position.y,a[i][j].position.z);
        currentBlobs.add(c);
      }
    }
  }
  combineBlobs();
  
  compareBlobs();
  
  
  
  for(Blob b : blobs)
  {
    if(b.Size()>50)
    {
      b.drawBlob(b.id);
      //println(currentBlobs.size() + "   "+blobs.size());
    }
  }
  avgNumWithin = numWithinCounter/blobs.size();
  println(numWithinCounter/blobs.size());
}

void combineBlobs()
{
  for(int i=0;i<currentBlobs.size();i++)
  {
    for(int j=0;j<currentBlobs.size();j++)
    {
      if(
          (currentBlobs.get(j).minx>currentBlobs.get(i).minx && currentBlobs.get(j).maxx<currentBlobs.get(i).maxx) &&
          (currentBlobs.get(j).miny>currentBlobs.get(i).miny && currentBlobs.get(j).maxy<currentBlobs.get(i).maxy) &&
          (currentBlobs.get(j).minz>currentBlobs.get(i).minz && currentBlobs.get(j).maxz<currentBlobs.get(i).maxz)
          
          )
          {
            currentBlobs.get(i).minx = min (currentBlobs.get(i).minx,currentBlobs.get(j).minx);
            currentBlobs.get(i).maxx = max (currentBlobs.get(i).maxx,currentBlobs.get(j).maxx);
            
            currentBlobs.get(i).miny = min (currentBlobs.get(i).miny,currentBlobs.get(j).miny);
            currentBlobs.get(i).maxy = max (currentBlobs.get(i).maxy,currentBlobs.get(j).maxy);
            
            currentBlobs.get(i).minz = min (currentBlobs.get(i).minz,currentBlobs.get(j).minz);
            currentBlobs.get(i).maxz = max (currentBlobs.get(i).maxz,currentBlobs.get(j).maxz);
            
            if(i!=j)currentBlobs.remove(j);
          }
    }
  }
}

//==========PERSISTENT BLOB FUNCTIONS==========

void compareBlobs()
{
  //== Possiblity #1 - there are no blobs
  if(blobs.isEmpty() && currentBlobs.size() > 0)
  {
    //println("Adding Blobs!");
    for(Blob b : currentBlobs)
    {
      b.id = blobCounter;
      blobs.add(b);
      blobCounter++;
    }
  }else
  
  //== Possiblity #2 - there are equal amounts of blobs and currentBlobs
  if(blobs.size() <= currentBlobs.size())
  {
    //==Match wahtever blobs you can match
    for(Blob b : blobs)
    {
      float recordDistance = 2000;
      Blob matched = null;
      for(Blob cb : currentBlobs)
      {
        float d = (b.getCenter().sub(cb.getCenter()).mag());
        if(d < recordDistance && !cb.taken)
        {
          recordDistance = d;
          matched = cb;
        }
      }
      matched.taken = true;
      b.become(matched);
    }
    //==Whatver is left over make new blobs
    for(Blob b : currentBlobs)
    {
      if(!b.taken)
      {
        b.id = blobCounter;
        blobs.add(b);
        blobCounter++;
      }
    }
  }else
  //== Possiblity #3 - There are more blobs than currentBlobs
  if(blobs.size() > currentBlobs.size())
  {
    for(Blob b : blobs)
    {b.taken = false;}
    // Match whatever blobs you can match
    for (Blob cb : currentBlobs) {
      float recordD = 1000;
      Blob matched = null;
      for (Blob b : blobs) {
        //b.taken = false;
        PVector centerB = b.getCenter();
        PVector centerCB = cb.getCenter();         
        float d = PVector.dist(centerB, centerCB);
        if (d < recordD && !b.taken) {
          recordD = d; 
          matched = b;
        }
      }
      if (matched != null) {
        matched.taken = true;
        matched.become(cb);
      }
    }
    // Remove the rest
    for (int i = blobs.size() - 1; i >= 0; i--) {
      Blob b = blobs.get(i);
      if (!b.taken) {
        blobs.remove(i);
      }
    }
  }
}