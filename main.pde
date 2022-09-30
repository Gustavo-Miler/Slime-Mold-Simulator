int n;

float maxSpeed;
float maxForce;
float rCoef;

Agent[] agents;

int scale;
int rows;
int cols;
float[][] grid;

float eCoef;

float sensorOffsetDst;
float sensorAngleSpacing;
int sensorSize;
float turnCoef;

void setup() {
  size(1200, 600);
  frameRate(60);
  
  n = 1000;
  maxSpeed = 4;
  maxForce = 1;
  rCoef = 1;
  
  sensorOffsetDst = 20;
  sensorAngleSpacing = 45;
  sensorSize = 2;
  turnCoef = 1;
  
  
  agents = new Agent[n];
  for (int i = 0; i < agents.length; i++) {
    agents[i] = new Agent(new PVector(width/2, height/2), PVector.random2D());
  }
  
  scale = 4;
  rows = width / scale;
  cols = height / scale;
  grid = new float[rows][cols];
  
  eCoef = 0.01;
}

void draw() {
  background(0);
  updateGrid();
  showGrid();
  for (Agent a : agents) {
    a.update();
  }
}

void showGrid() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      noStroke();
      fill(255 * grid[i][j]);
      rect(i * scale, j * scale, scale, scale);
    }
  }
}

void updateGrid() {
  evaporate();
}

void evaporate() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (grid[i][j] > 0) grid[i][j] -= eCoef;
      if (grid[i][j] < 0) grid[i][j] = 0;
    }
  }
}
