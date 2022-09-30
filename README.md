# Slime-Mold-Simulator

This is a slime mold simulator

It has a fixed number of "agents" moving around the map, each agent leaves a trail of pheromones that evaporate through time
Each agent have a sensor that returns the amount of pheromones at certain points in front of the agent
Based on the valued that is returned by the sensors the agent might change it's tragetory

As I'm writing this code in a weak machine there is no dissipate function for smoothness in the trails

Variables you can mess around with:
width, height, scale: change the window size and grid size
n: number of agents
maxSpeed: max speed of agents
eCoef: speed which pheromone evaporation occurs
sensorOffsetDst, sensorAngleSpacing, sensorSize, turnCoef: pheromone train sensoring


