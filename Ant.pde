class Ant {
  public int r, c, angle; //angle in degrees

  Ant(int r_rhs, int c_rhs, int angle_rhs) {
    r = r_rhs;
    c = c_rhs;
    angle = angle_rhs;
  }

  int getNewLoc(boolean cur_cell) {
    angle += cur_cell? 90 : -90;

    while (angle < 0) { 
      angle += 360;
    }
    angle %= 360;
    
    return angle;
  }
  
  void update(){
     print(angle, "\n"); 
  }
}