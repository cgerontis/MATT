
#include <AFMotor.h>


String input;
String number;
double pos = 1.8;
double ratio50 = 11.5;
double ratio75 = 8;
double ratio = 0;

// Connect a stepper motor with 48 steps per revolution (7.5 degree)
// to motor port #2 (M3 and M4)
AF_Stepper motor(50, 2);

void moveAperture(double command,double diam) 
{

  if(diam == 75) ratio = ratio75;
  if(diam == 50) ratio = ratio50;
  
  motor.setSpeed(100);  // RPM

    command = command-pos;
    
    command = command*ratio;
    
  if(command > 0)motor.step(command, BACKWARD, MICROSTEP);
  if(command < 0)motor.step(abs(command), FORWARD, MICROSTEP);

  pos = pos + (command/ratio);

  if(input.equals("H")) pos = 1.8;

    
    Serial.println("Command= ");
    Serial.println(command);
    Serial.println("Position= ");
    Serial.println(pos);
  command = 0;
  
}

void calibrate(double diam)
{
  motor.setSpeed(100);
  
  if(diam == 75)
  {
    ratio = ratio75;
    motor.step(75*ratio,FORWARD,SINGLE);
    pos = 0;
  }
  else if(diam == 50)
  {
    ratio = ratio50;
    motor.step(50*ratio,FORWARD,SINGLE);
    pos = 1.8;
  }
}


