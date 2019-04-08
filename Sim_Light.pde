class Light {
  float xpos;
  float ypos;
  
  boolean islit;  // y/n
  float littime;  // time last lit
  float turnofftime;
  float sumlit;   // sum all lit
  int xholdtime;
  int index;
  float pctdimdown=1.0;
  boolean alwayson=false;
  
  int installedeffect=140;
  float pctmax=1.0;
  float pctmin=0.2;
  
  Light (float tmpxpos, float tmpypos, int tmpindex, boolean tmpalwayson) {
    xpos=tmpxpos;
    ypos=tmpypos;

    islit=false;
    littime=0;
    sumlit=0;
    index=tmpindex;
    alwayson=tmpalwayson;
  }
  
  int Holdtime() {
    return xholdtime;
  }
  
  void SwitchOn(int tmpholdtime) {
    xholdtime = tmpholdtime/speedup;
    if (!islit) {
      littime = millis(); // start timer
    }
    if ((millis()+xholdtime) > turnofftime) {
      turnofftime=millis()+xholdtime;
    }
    islit = true;
  }
        
  void Show() {
    
      textFont(f,10);
      textAlign(CENTER);
      fill(255);
    
      stroke(0);
      strokeWeight(1);
      rectMode(CENTER);
      
      if (islit) {
        fill(color(255,180,0));
        if (alwayson) {
          turnofftime=millis()+1000;
          sumlit=appstart;
        }
        if (millis() > turnofftime) {
           sumlit = sumlit + (millis() - littime); 
           littime=0;
           islit=false;
        }
      } else {
        fill(color(255,255,255));
      }  
      
      circle(xpos,ypos,20);
    
      fill(0);
      text(index, xpos, ypos-15);
      
      if (!islit) {
        pctdimdown = sumlit;
      } else {
        pctdimdown = sumlit+millis()-littime;
      }
      pctdimdown = 1 - (pctdimdown / (millis()-appstart));
      
      //pctdimdown=pctdimdown/speedup;
      
      
      if (alwayson) pctdimdown=0.0;
      
      rectMode(TOP);
      fill(color(255,255,255));
      int h=300;
      int yoffset=50;
      float x1=xpos-10;
      float x2=xpos+10;
      float y1=ypos+yoffset+h;
      float y2=ypos+yoffset;
      
      rect(x1,y1,x2,y2);
      fill(color(255,180,0));
      rect(x1,y1,x2,y1+((1-pctdimdown)*(y2-y1)));
      
      fill(0);
      text(int(pctdimdown*100) + "%", xpos, ypos+yoffset-10);
}
}
