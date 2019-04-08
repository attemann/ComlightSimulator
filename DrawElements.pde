void DrawRoad(float rc, float rw, float pc, float pw) { 
  stroke(0);
  strokeWeight(1);
  rectMode(LEFT);
  fill(color(180));
  rect(-1, rc-(rw/2), width+1, rc+(rw/2)); // ROAD
  rect(-1, pc-(pw/2), width+1, pc+(pw/2)); // PATH
  
  stroke(color(255,255,0));
  strokeWeight(4);
  line(0,rc,width,rc);
}

void DrawImages() {    
  image(logo, width - logo.width- 20, 10);
  image(banner, width - banner.width- 20, height - banner.height - 10);
  
}
  
void DrawAverageLine() {
  int yoffset=350;
float y;
  rectMode(LEFT);
  fill(0);
  strokeWeight(3);
  y = lights[0].ypos + yoffset - ((1-avgdim) * 3 * 100);
  line(0,y,width,y);
  text(int(avgdim*100)+" %", 15,y-5);
}

void DrawCaptions () {
int x;
int y;

  x=width/3;
  y=50;

  DrawImages();
  x=20;
  if (captions) {
    DrawSavings(x, y);    x=x+200;
    DrawInfoCars(x, y);   x=x+200;
    DrawInfoPeds(x, y);   x=x+200;
    DrawInfoLights(x, y); x=x+200;
    DrawExplain(20,160,width-40,400);
  }
  DrawHelp();
}

void DrawSavings(int x, int y) {
  float save;
  String s;
  float ydt=0;
  float secs=0;
  
    ydt=0;
    secs=(millis()-appstart)/1000;

    if (secs>5) {
      ydt=countcars / (secs/(60*60*24));
      secs=secs/speedup;
    }
    save=11*365*(((1-avgdim)*lights[0].pctmin) + ((avgdim)*lights[0].pctmax))*100/1000;
    s="Average dim=" + int(avgdim*100) + " %\n" ;   
    s=s+"Year save "+int(save) +" kWh/lamp\n";
    s=s+"Year save "+int(numlights*save)+" kWh\n";
    s=s+countcars+" cars, " + countpeds + " pedestrians\n";
    s=s+"YDT estimate=" + int(ydt) ;
    
    fill(0);
    textFont(f,fontsize);
    textAlign(LEFT);
    text(s,x,y);
}

void DrawInfoCars(int x, int y) {
String s;
    s=numcars + " cars\n";
    s=s+aheadcars + " lights ahead\n";
    s=s+holdtimecars/1000 + " sec holdtime\n";
    s=s+nfc(speedcar*3.6,1) + " km/h speed\n";
    
    textFont(f,fontsize);
    textAlign(LEFT);
    fill(0);
    text(s,x,y);
}

void DrawInfoPeds(int x, int y) {
String s;
    s=numpeds + " pedestrians\n";
    s=s+aheadpeds + " lights ahead\n";
    s=s+holdtimepeds/1000 + " sec holdtime\n";
    s=s+nfc(speedped*3.6,1) + " km/h speed\n";
    
    textFont(f,fontsize);
    textAlign(LEFT);
    fill(0);
    text(s,x,y);
}

void DrawInfoLights(int x, int y) {
String s;
    s=numlights + " lights \n";
    s=s+lights[0].installedeffect + " W lamps\n";
    s=s+int(lights[0].pctmax*100) + " % max dim\n";
    s=s+int(lights[0].pctmin*100) + " % min dim\n";
    
    textFont(f,fontsize);
    textAlign(LEFT);
    fill(0);
    text(s,x,y);
}


void DrawExplain(int x, int y, int w, int h) {
String s="";
    switch (language) {
    case 1: 
    s="Comlight benytter avansert teknologi for å styre gatelys. Når det ikke er biler eller fotgjengere tilstede, dimmes lyset ned til f.eks 20%. ";
    s=s+"Systemet kan ettermonteres i eksisterende gatelys. Systemet passer like godt til parker, parkeringsplasser eller lysløyper! Når bevegelse oppdages, ";    
    s=s+"økes lyset til full styrke. Unikt med Comlight teknologi er at lyktene forover i kjeden tennes. Dermed ledes bilister og fotgjengere av en bølge ";
    s=s+"med lys. I gjennomsnitt er lyset dimmet ned ca 70% av tiden på natten. Vi sparer miljøet, gjør veiene sikrere for store og små trafikanter, og ";
    s=s+"sparer energi! Modellen viser hvordan systemet fungerer på en vei (øverst) med gang- og sykkelsti (nederst), sammen med tid dimmet %. Basert på 11 timer lys om natten.";
    break;
    
    case 0: 
    s="Comlight uses advanced and well-tried technology to control street lights. When there are no cars or pedestrians, lights are dimmed down to e.g. 20%. ";
    s=s+"When movement is detected, light strength increase to 100%. The system can be retrofitted in existing street lights. A unique feature with Comlight ";    
    s=s+"technology is forward trigging, lighting up the road ahead. Cars and pedestrians are led by a wave of light! The system is perfect also for parks, parking ";
    s=s+"lots or walking paths! On average, lights are dimmed down 70% of time during night. This saves the environment, makes roads safer by giving full ";
    s=s+"light where and when needed, and saves energy! This model shows how the system works - road (on top), walkway (bottom). Bars show % time dimmed down. ";
    s=s+"Savings based on 11 hours light during night.";
    break;
    }
    
    textFont(f,fontsize);
    textAlign(LEFT, TOP);
    fill(0);
    text(s, x,y,w,h);
}

void DrawHelp() {
    textFont(f,fontsize);
    textAlign(LEFT);
    fill(0);
    text("I = Show Info\nS = Speed ("+speedup+")\nL = Language\nR = Reset",10, height-100);
    
}
