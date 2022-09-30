class Agent {
  PVector pos;
  PVector vel;
  PVector acc;
  
  public Agent(PVector pos, PVector vel) {
    this.pos = pos;
    this.vel = vel;
    acc = new PVector();
    
  }
  
  void update() {
    if (pos.x + vel.x < 0 || pos.x + vel.x > width) vel.x *= -1;
    if (pos.y + vel.y < 0 || pos.y + vel.y > height) vel.y *= -1;
    
    steer();
    vel.add(acc);
    vel.setMag(maxSpeed);
    pos.add(vel);
    lay();
    
  }
  
  void show() {
    stroke(color(255, 0, 0));
    point(pos.x, pos.y);
  }
  
  void lay() {
    int px = int((pos.x / scale + rows) % rows);
    int py = int((pos.y / scale + cols) % cols);
    
    grid[px][py] = 1;
  }
  
  void steer() {
    float weightFoward = sense(this, 0);
    float weightLeft = sense(this, -sensorAngleSpacing);
    float weightRight = sense(this, sensorAngleSpacing);
    
    float randomSteerStrength = random(1);
    
    if (weightFoward > weightLeft && weightFoward > weightRight) {
      vel.rotate(0);
    }else if (weightFoward < weightLeft && weightFoward < weightRight) {
      vel.rotate((randomSteerStrength - 0.5) * 2 * turnCoef);
    } else if (weightRight > weightLeft) {
      vel.rotate(randomSteerStrength * turnCoef);
    } else if (weightLeft > weightRight) {
      vel.rotate(-randomSteerStrength * turnCoef);
    }
  }
  
  float sense(Agent agent, float sensorAngleOffset) {
    float sensorAngle = agent.vel.heading() + sensorAngleOffset;
    PVector sensorDir = new PVector(cos(sensorAngle), sin(sensorAngle));
    PVector sensorCentre = agent.pos.copy();
    sensorCentre.add(sensorDir.mult(sensorOffsetDst));
    
    float sum = 0;
    for (int offsetX = -sensorSize; offsetX <= sensorSize; offsetX++) {
      for (int offsetY = -sensorSize; offsetY <= sensorSize; offsetY++) {
        PVector target = sensorCentre.copy();
        target.add(new PVector(offsetX, offsetY));
        
        if (target.x >= 0 && target.x < width && target.y >= 0 && target.y < height) {
          sum += grid[int((target.x / scale + rows) % rows)][int((target.y / scale + cols) % cols)];
        }
      }
    }
    return sum;
  }
}
