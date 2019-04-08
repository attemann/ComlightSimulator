class Car { 
  color c;
  float xpos;
  float ypos;
  float speed0;
  float speedcar;
  float speedscreen;
  
  boolean drivingRight;
  int lasttime;
  float StartTime=0;
  boolean isStarted=false;
  
  Car(float tmpxpos, float tmpypos, float tmpspeed0, boolean tmpdrivingRight) {
    xpos=tmpxpos;
    ypos=tmpypos;
    drivingRight=tmpdrivingRight;
    if (drivingRight) ypos=ypos+60;

    speed0   = tmpspeed0;
    speedcar = tmpspeed0 + random(-0.2 * speed0, 0.2 * speed0) ;
    isStarted=false;
  }
  void Display() {
    stroke(0);
    strokeWeight(1);
    fill(color(50,255,50));
    rectMode(CENTER);
    rect(xpos,ypos,40,20);
  }
  
void Start(){
  if (!isStarted) {
    StartTime=millis();
    countcars = countcars+1;
    isStarted=true;  
  }
};

void Stop() {
    isStarted=false;
} 
  
  void Drive() {     
     if (drivingRight) {
       xpos = xpos + speedscreen;
       if (xpos > width) {
         speedcar= speed0 + random(-0.2 * speed0, 0.2 * speed0);
         xpos=-random(100);
         Stop();
       }
     } else {
       xpos=xpos - speedscreen;
       if (xpos < 0) {
         speedcar= speed0 + random(-0.2 * speed0, 0.2 * speed0);
         xpos=width+random(100);
         Stop();
       }
     }
     lasttime=millis();
     
     fill(0);
     text(speedcar,xpos,ypos);
  }
  
  Boolean Overtaking(Car other) {
     if (drivingRight == other.drivingRight) { 
       if (abs(xpos - other.xpos) < 60) {
         speedcar = other.speedcar*0.97;  
         return true;
         // xpos=other.xpos+50;
       }
       else return false;
     } else return false;
  } 
}
