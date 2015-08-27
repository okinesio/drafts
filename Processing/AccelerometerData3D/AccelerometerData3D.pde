import peasy.*;

PeasyCam cam;

String [] data;
int line = 0;

int [] at = {
};

int [] ax = {
};
int [] ay = {
};
int [] az = {
};

int [] ttail = {
};

float lxyzm;

int s = 0;
int starttime = 0; // start time in millis (set value manually here, or it will be set automatically)

void setup()
{
  size(displayWidth, 600, P3D);
  data = loadStrings("2015-08-26_RUN-2_LOG00140.TXT");
  println("Entries: " + data.length);
  
  //cam = new PeasyCam(this, 100);
  //cam.setMinimumDistance(1);
  //cam.setMaximumDistance(15500);

  background(0);

  for (int i=0; i<data.length; i++)
  {
    String [] entries = data[i].split(",");

    int timecode = int(entries[0]);

    if (i == 0)
      starttime = timecode;

    int t = int(entries[0])-starttime;
    int z = int(entries[1]);
    int x = int(entries[2]);
    int y = int(entries[3]);
    at = append(at, t);
    ax = append(ax, x);
    ay = append(ay, y);
    az = append(az, z);
  }
}

void draw()
{
  background(0);

  translate(width/2, height/2, 0);
  rotateX(-0.3);
  translate(0, 0, 200);
  rotateY(0.7);
  
  translate(-millis()/10.0, 0, 0);
  
  /*
  fill(255, 50);
  pushMatrix();
  //translate(at[at.length-1]/10/2, 0, 0);
  println(at[at.length-1]/10 + " " + at[at.length-1]/10/2);
  rotateX(PI/2.0);
  rect(at[at.length-1]/10/2, 0, at[at.length-1]/10, 100);
  popMatrix();
  */
  
  stroke(100);
  for (int i=0; i<at[at.length-1]/10; i+=100)
  {
    line(i, 0, -300, i, 0, 300);
    pushMatrix();
    translate(i, 0, 0);
    rotateY(-PI/2.0);
    text(i/100, 0, 0);
    popMatrix();
  }
  
  stroke(255);
  noFill();
  beginShape();
  for (int i=0; i<at.length; i+=2)
  {
    curveVertex(at[i]/10.0, ay[i]/10.0, ax[i]/10.0);
  }
  endShape();
  
  stroke(255, 100, 255);
  beginShape();
  for (int i=0; i<at.length; i+=2)
  {
    curveVertex(at[i]/10.0, ay[i]/10.0, 0);
  }
  endShape();
  
  stroke(255, 255, 0);
  beginShape();
  for (int i=0; i<at.length; i+=2)
  {
    curveVertex(at[i]/10.0, 0, ax[i]/10.0);
  }
  endShape();
  
  stroke(100, 255, 0);
  for (int i=0; i<at.length; i+=2)
  {
    pushMatrix();
    translate(at[i]/10.0, 0, 0);
    rotateY(PI/2.0);
    ellipse(0, 0, az[i]/30.0, az[i]/30.0);
    popMatrix();
  }

  /*
    if (line < at.length-1) {
   
   timecode = at[line];
   if (millis() > timecode)
   {
   //println(timecode + " " + millis());
   
   int x = int(entries[1]);
   int y = int(entries[2]);
   int z = int(entries[3]);
   
   float xm, ym, zm;
   
   if (ax.length > 5)
   {
   xm = (ax[line-3]+ax[line-2]+ax[line-1]+ax[line]) / 4.0;
   ym = (ay[line-3]+ay[line-2]+ay[line-1]+ay[line]) / 4.0;
   zm = (az[line-3]+az[line-2]+az[line-1]+az[line]) / 4.0;
   
   float xyzm = sqrt(pow(xm, 2) + pow(ym, 2) + pow(zm, 2));
   
   // threshold tail
   if (ttail.length < 50)
   {
   ttail = append(ttail, int(xyzm));
   } else
   {
   ttail = subset(ttail, 1);
   ttail = append(ttail, int(xyzm));
   }
   
   int tmin = 5000;
   int tmax = -5000;
   float ttres = 0;
   for (int i=0; i<ttail.length; i++)
   {
   if (ttail[i] < tmin)
   tmin = ttail[i];
   if (ttail[i] > tmax)
   tmax = ttail[i];
   }
   ttres = tmin + ((tmax - tmin) / 2.0);
   //println(tmin + " " + tmax + " " + ttres);
   
   if (lxyzm < ttres && xyzm > ttres)
   { 
   // println(millis() + " step");
   //background(255, 100, 255);
   
   s++;
   //frame.setTitle("Counted steps: "+str(s));
   }
   lxyzm = xyzm;
   
   float xyzn = map(xyzm, -2000, 2000, 0, 200);
   float xn = map(xm, -2000, 2000, 0, 200);
   float yn = map(ym, -2000, 2000, 0, 200);
   float zn = map(zm, -2000, 2000, 0, 200);
   
   noFill();
   stroke(255);
   ellipse(line, xyzn, 5, 5);
   //line(line, xn-2, line, xn+2);
   translate(0, 200);
   stroke(255, 100, 255);
   ellipse(line, xn, 5, 5);
   //line(line, xn-2, line, xn+2);
   translate(0, 100);
   stroke(0, 255, 100);
   ellipse(line, yn, 5, 5);
   
   translate(0, 100);
   stroke(255, 255, 100);
   ellipse(line, zn, 5, 5);
   //line(line, xn-2, line, xn+2);
   }
   
   //println(line);
   line++;
   }
   }
   }
   */
}

void keyPressed()
{
 if (key == 'p')
 {
   saveFrame("okinesio_skate_####.png");
 }
}