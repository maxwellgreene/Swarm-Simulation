PeasyCam cam;
ControlP5 menuController;
ControlP5 simDisplay;
ControlP5 button;

//=========================================================
int numAgents      = 1000;  
int numPredators   = 1;
int numSpecies     = 1;
float borderRadius = 500;
float startRadius  = 500;
float blobThreshold = 60;

float depth = -1000;
Agent[][] a = new Agent[numSpecies][numAgents];
Predator[][] p = new Predator [numSpecies][numPredators];
ArrayList <Blob> blobs = new ArrayList<Blob>();
//=========================================================
float zor = 25;    float pzor = 20;      float pKill = 50;
float zoo = 70;    float pzoo = 35;      float pRepel = 100;  float predAvoidMult = .3;
float zoa = 120;   float pzoa = 40;      float pOrient = 150;
float alpha = 80;  float palpha = 10;

float turningRate = 180*(PI/180);
float timeStep    =  6;
float noise       = .1;
float predatorVelocity = 3;
//=========================================================
boolean interact     = true;
boolean keepInBounds = true;
boolean movie        = false;
boolean predator     = true;

int predMoveType = 1;
    //== 0 for move to center @ predatorVelocity
    //== 1 for move to first alive @predatorVelocity
int predAvoidType = 3;
    //== 0 for no avoidance
    //== 1 for kill
    //== 2 for kill, repel
    //== 3 for kill, repel, change behavior
//=========================================================
int frame = 0; int maxFrames = 500;

//=========================================================
boolean printData = false;
PrintWriter [] AgentPositionWriter = new PrintWriter [numSpecies];
PrintWriter [] AgentVelocityWriter = new PrintWriter [numSpecies];
PrintWriter [] AveragePositionWriter = new PrintWriter [numSpecies];
PrintWriter [] AverageVelocityWriter = new PrintWriter [numSpecies];
PrintWriter [] AveragePredDistWriter = new PrintWriter [numSpecies];
PrintWriter AverageNumWithinWriter; float avgNumWithin;

float dataType1 = 0;
float dataType2 = 1;