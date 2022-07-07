class Flock
{
  ArrayList<Agent> agents;
  
  Flock(){
    agents = new ArrayList<Agent>();
    for (int i=0; i < 200; i++) {
      agents.add(new Agent());
    }
  }
  
  void newState()
  {
    for (Agent p : agents) {
      p.detectEdge();
      p.updateAcceleration(agents);
      p.show();
     }
     
     for (Agent p : agents) {
      p.update();
     }
  }
}
 
