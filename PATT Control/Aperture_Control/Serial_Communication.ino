#include <ax12.h>
#include <BioloidController.h>
#include <Servo.h>


int pan = 1;
int ap = 2;
int tilt = 16;
int tiltOffset = 7;
int diam = 50;

float command;
int axis;
int intAxis;
int intCommand;
int desiredPosition;

Servo tiltServo;

/**************************************/
/*************** SETUP ****************/
/**************************************/
void setup(){ 

  tiltServo.attach(16);
  tiltServo.write(90+tiltOffset);
  Serial.begin(9600);   // begin Serial communication with Arduino

  
}

/**************************************/
/************* MAIN LOOP **************/
/**************************************/
void loop() {
    

  char inChar;          

if(Serial.available() > 0)
{
    axis = Serial.read();

    command = Serial.parseFloat();

    if(axis != "")
    {
      Serial.print("Axis,Command: \t");
      Serial.print(char(axis));
      Serial.print('\t');
      Serial.println(command);
    }

   
    switch (axis){
      case '\r':
        break;
      case '\n':
        break;
      case 'H':
        if(command == 75)
        {
          diam = 75;
        }else if(command == 50)
        {
          diam = 50;
        }
        Serial.println("Homing aperture");
        calibrate(ap,diam);
        break;   
      case '?':
        Serial.print("P.A.T: \t");
        Serial.print(getPanPosition(pan));
        Serial.print("\t,");
        Serial.print(getAperturePosition(ap,diam));
        Serial.print("\t,");
        Serial.println(tiltServo.read()-(90+tiltOffset));
      case 'P':
        movePan(pan, command);
        break;
      case 'A':
        moveAperture(ap, command,diam); 
        break;
      case 'T':
        command = command+tiltOffset;
        if(command > 90)
        {
          Serial.println("Value too high");
          break ;
        }else if (command < -90)
        {
           Serial.println("Value too low");
           break ;
         }
        tiltServo.write(command+90);
        delay(10);
        break;
      default:
        Serial.print("\nCommand not recognized,\nacceptable commands are:\nPan(deg)-'P-(0-180)'\n"
            "Tilt(deg)-'T-(-90-90)'\Aperture(mm)-'A-(0-75)'\n\nExample: T-45\n\n\n");
    }
    delay(10);
}
}



