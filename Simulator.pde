PImage logo;
PImage sensor;
PImage banner;
PFont f;
int fontsize=15;
boolean captions=true;

int speedup=5;

int distpoles=40;

int language=0;

int numcars=3;
int numpeds=1;
int aheadcars=5;
int aheadpeds=2;
float avgdim=0;

int numlights=64;

int holdtimecars=5000;
int holdtimepeds=45000;

int countcars=0;
int countpeds=0;

float speedcar=20; // 20 m/s =72.0 kmh
float speedped=1.5;

int appstart=0;
float rc=0;
float rw=0;
float pc=0;
float pw=0;

Light[]      lights = new Light[numlights];
Car[]        cars   = new Car[numcars];
Pedestrian[] peds   = new Pedestrian[numpeds];

void setup() {
boolean drivingRight;

  fullScreen();

  banner=loadImage("Sim_Graphics.jpg");
  banner.resize(int(1018),int(111));
  
  logo=loadImage("Sim_logo.jpg");
  logo.resize(280,120);

  f = createFont("Arial",16,true); // Arial, 16 point, anti-aliasing on
  appstart=millis();

  rc=(height/3);
  rw=height/8;
  pc=rc+rw-(rw/3);
  pw=30;

  float x;
  for (int i = 0; i < numlights; i++) {
      x = 50 + (i*(width/(numlights+1)));
      if ((i==0) || (i==numlights-1)) {
        lights[i] = new Light(x, pc + 75, i+1, true);
      } else {
        lights[i] = new Light(x, pc + 75, i+1, false);
      }
  }

  drivingRight = (random(1) > 0.5);
  //drivingRight=true;
  for (int i = 0; i < numcars; i++) {
    if (drivingRight) {
      x = -((i*100) + random(50));
    } else {
      x = width + ((i*100) + random(50));
    }
    cars[i] = new Car(x, rc-30, speedcar, drivingRight);
    drivingRight = !drivingRight; // turn direction
  }
  for (int i = 0; i < numpeds; i++) {
    if (drivingRight) {
      x = -(random(50));
    } else {
      x = width + (random(50));
    }
    peds[i] = new Pedestrian(x,pc, drivingRight);
    drivingRight = !drivingRight; // turn direction
  }

  countcars=0;
  countpeds=0;
}

void draw() {
  background(255);

  DrawRoad(rc,rw,pc,pw);
  DrawCaptions();

  for (int i=0; i < numlights; i++) {
    // check cars
    for (int j=0; j < numcars; j++) {
      if (TriggedbyCar(lights[i], cars[j])) {
       for (int k=i-aheadcars; k <= i+aheadcars; k++) {
         if (k >= 0 && k < numlights) lights[k].SwitchOn(holdtimecars);
         }
       }
      }    //check peds
    for (int j=0; j < numpeds; j++) {
      if (TriggedbyPed(lights[i], peds[j])) {
       for (int k=i-aheadpeds; k <= i+aheadpeds; k++) {
         if (k >= 0 && k < numlights) lights[k].SwitchOn(holdtimepeds);
       }
      }
    }
  }


  // Average dim%
  avgdim=0;
  for (int i=0; i<numlights;i++) {
    lights[i].Show();
    avgdim=avgdim+lights[i].pctdimdown;
  }
  avgdim=avgdim/numlights;

  DrawAverageLine();

  for (int i=0; i< numcars; i++) {
    cars[i].speedscreen = GetScreenSpeed(cars[i].speedcar);
    cars[i].Drive();
    cars[i].Display();
  }
  for (int i=0; i< numpeds; i++) {
    peds[i].speedscreen = GetScreenSpeed(peds[i].speedped);
    peds[i].Drive();
    peds[i].Display();
  }

/*  for (int i=0; i< numcars; i++) {
    for (int j=0; j< numcars; j++) {
      if (i != j) {
        if (cars[i].drivingRight == cars[j].drivingRight) {
         if (cars[i].Overtaking(cars[j])) break;
        }
      }
    }
  }
  */
}

float GetScreenSpeed(float v) {
float vs=0;
//time in secs between poles
  float t;
  t=distpoles/v;
  vs=(lights[1].xpos - lights[0].xpos) / t;
  vs=vs/frameRate;
  vs=vs*speedup;
  return vs;
}

boolean TriggedbyCar(Light aLight, Car aCar) {
  if (abs(aCar.xpos - aLight.xpos) < 10) {
      if (aCar.drivingRight && !aCar.isStarted && aLight.index==1) {
          aCar.Start();
      }
      if (!aCar.drivingRight && !aCar.isStarted && aLight.index==numlights) {
          aCar.Start();
      }
      return true;
  } else {
      return false;
  }
}

boolean TriggedbyPed(Light aLight, Pedestrian aPed) {
  if (abs(aPed.xpos - aLight.xpos) < 10) {
      if (aPed.drivingRight && !aPed.isStarted && aLight.index==1) {
          aPed.Start();
      }
      if (!aPed.drivingRight && !aPed.isStarted && aLight.index==numlights) {
          aPed.Start();
      }
      return true;
  } else {
      return false;
  }
}

void keyPressed() {
    if (key=='r' || key == 'R') {
      setup();
    }
    if (key=='i' || key == 'I') {
      captions = !captions;
    }
    if (key=='l' || key == 'L') {
      language = language+1;
      if (language>1) language=0;
    }
    if (key=='s' || key == 'S') {
      speedup = speedup+1;
      if (speedup>10) speedup=1;
    }
}
