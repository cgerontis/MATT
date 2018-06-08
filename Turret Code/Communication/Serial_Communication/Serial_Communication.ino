#include <ax12.h>
#include <Servo.h>

Servo tilt;

String command;
int axis;
int intAxis;
int intCommand;

/**************************************/
/*************** SETUP ****************/
/**************************************/
void setup(){ 
  delay(50);
  tilt.attach(16);
  Serial.begin(9600);   // begin Serial communication with Arduino
  //SetPosition(1,0);
}

/**************************************/
/************* MAIN LOOP **************/
/**************************************/
void loop() {
  char inChar;          
  command = "";                        // Initialize the command

if(Serial.available() > 0)
{
    axis = Serial.read();
    intCommand = Serial.read();
    command = Serial.parseInt();

    if(command != "")
    {
      Serial.print("A,C: \t");
      Serial.print(axis);
      Serial.print('\t');
      Serial.println(command);
    }

   
    switch (axis){
      case 'P':
        intCommand = map(intCommand,0,180,0,2048); //1024 turns the servo 90 degrees, so we want double that to be 180
        //SetPosition(1,command);
        Serial.print("Pan set to ");
        Serial.println(command);
        break;
      case 'A':
        intCommand = map(intCommand,0,75,0,15360); //The range is 3.75 rotations, and 3.75*1024*4 = 15360
        //SetPosition(2,intCommand);
        Serial.print("Aperture set to ");
        Serial.print(command);
        Serial.println(" millimeters");
        break;
      case 'T':
        intCommand = map(intCommand,-90,90,0,180); //I'm making the angle 0 be parallel to the ground
        //tilt.write(command);
        Serial.print("Tilt set to ");
        Serial.println(command);
        break;
      default:
        Serial.print("\nCommand not recognized,\nacceptable commands are:\nPan(deg)-'P-(0-180)'\n"
            "Tilt(deg)-'T-(-90-90)'\Aperture(mm)-'A-(0-75)'\n\nExample: T-45\n\n\n");
    }
    delay(10);
}
}



