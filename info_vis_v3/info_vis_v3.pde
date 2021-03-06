import processing.serial.*;
Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port

float zeroDegrees = radians(-90);
int[] graph1 = {20, 50, 140, 32, 63, 190, 130, 82, 140, 160};
    
void setup(){
  size(600, 900);
  smooth();
  String portName = Serial.list()[3]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
}


//======Loop Functions =======
void draw(){
  if (myPort.available() > 0) 
    {  // if data is available,
    val = myPort.readStringUntil('\n');       // read it and store it in val
    }
  println(val);
  
  //set the floats dynamically every loop
  float rawCelsius = 32.3;
  float rawHumidity = 80;
  float rawCarbon = 3;
  
  //map the values to a circle
  float milliSeconds = map(second()/100, 0, 100, 0, 360);
  float seconds = map(second(), 0, 60, 0, 360);
  float minutes = map(minute(), 0, 60, 0, 360);
  float hours = map(hour()-12, 0, 12, 0, 360);
  float celsius = map(rawCelsius, 0, 45, 0, 360);
  float humidity = map(rawHumidity, 0, 100, 0, 360);
//  float light = map(rawLight, 0, 100, 0, 360);
  float carbon = map(rawCarbon, 0, 20, 0, 360);
  
  //draw the results
  background(242);
  drawClock(seconds, minutes, hours);
  drawArc(240, celsius, red);
  drawArc(300, humidity, eggplant);
  drawArc(360, 200, purple);
  drawArc(420, carbon, blue);
  drawGraph();
}




//======HELPER FUNCTIONS ========

//Draw an Arc
void drawArc(int size, float end, int strokeColour[]){
  noFill();
  strokeWeight(32);
  strokeCap(SQUARE);
  stroke(strokeColour[0], strokeColour[1], strokeColour[2]);
  arc(width/2, height/3, size, size, zeroDegrees, radians(end - 90), OPEN);
}

//draw the clock
void drawClock(float seconds, float minutes, float hours){
    drawArc(60, seconds, green);
    drawArc(120, minutes, yellow);
    drawArc(180, hours, orange);
      //make sure you can read the textby inverting the colour 
//    if(second() < 3){fill(green[0], green[1], green[2]);}
//    else{fill(255);}
//    if(second() < 10){text("0"+second(), width/2+2, height/2-25);}   //always display a 2 digit number
//    else{text(second(), width/2+2, height/2-25);}
    
    if(minute() < 2){fill(yellow[0], yellow[1], yellow[2]);}
    else{fill(255);}
    if(minute() <10){text("0"+minute(), width/2+2, height/3-55);}    //always display a 2 digit number
    else{text(minute(), width/2+2, height/3-55);}
    
    if(hour() < 1){fill(orange[0], orange[1], orange[2]);}
    else{fill(255);}
    if(hour() > 12){text((hour()-12), width/2+3, height/3-85);}   //always display a 2 digit number
    else if(hour()-12 < 10 && hour()-12 != 0){ text("0"+hour(), width/2+3, height/3-85);}
    else{text(hour(), width/2+3, height/3-85);}
    
    if(hour() >= 12){
      fill(0);
      text("PM", width/2-8, height/3+4);
    }
}

void drawGraph(){
  //push the matrix to draw the lines in reference to the new origin
  pushMatrix();
  translate(30, (height/4)*3);
  //draw the background
  noStroke();
  fill(230);
  rect(0, 0, 540, 200);
  drawLine(0, 50, 100, 80);
  drawLine(100, 80, 200, 80);
  drawLine(200, 80, 300, 120);
  drawLine(300, 120, 400, 36);
  drawLine(400, 36, 500, 80);
  drawLine(500, 80, 540, 50);
  popMatrix();
}

void drawLine(int startX, int startY, int endX, int endY){
  stroke(0);
  strokeWeight(2);
  line(startX, startY, endX, endY);
}    
