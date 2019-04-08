class Pedestrian { 
  color c;
  float xpos;
  float ypos;
  float speedped;
  float speedscreen;
  
  boolean drivingRight;
  int lasttime;
  float StartTime=0;
  boolean isStarted=false;
  
  Pedestrian(float tmpxpos, float tmpypos, boolean tmpdrivingRight) {
    xpos=tmpxpos;
    ypos=tmpypos;
    drivingRight=tmpdrivingRight;
    //if (drivingRight) ypos=ypos+60;
    speedped=2;
    isStarted=false;
  }
  void Display() {
    stroke(0);
    strokeWeight(1);
    fill(color(50,255,50));
    rectMode(CENTER);
    circle(xpos,ypos,20);
  }
  
void Start(){
  if (!isStarted) {
    StartTime=millis();
    countpeds = countpeds+1;
    isStarted=true;  
  }
};

void Stop() {
    isStarted=false;
} 
  
  void Drive() {
// float dist;
//     dist=(millis() - lasttime)*speed;
     
     if (drivingRight) {
       xpos = xpos + speedscreen;
       if (xpos > width) {
         //speed=random(maxspeedcar/1.5, maxspeedcar);
         xpos=0;
         Stop();
       }
     } else {
       xpos=xpos - speedscreen;
       if (xpos < 0) {
         //speed=random(maxspeedcar/1.5, maxspeedcar);
         xpos=width;
         Stop();
       }
     }
     lasttime=millis();
  }
}
