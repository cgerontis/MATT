/***************************
 * AXSimpleTest
 * This sketch sends positional commands to the AX servo 
 * attached to it - the servo must set to ID # 1
 * The sketch will send a value, i, to the servo.
 * 'For' loops are used to increment and decrement the value of 'i'
 ***************************/

//import ax12 library to send DYNAMIXEL commands
#include <ax12.h>
#include <Servo.h>

Servo tilt;

void setup()
{
//    tilt.attach(16);   
    Serial.begin(9600); 
    ax12SetRegister2(1,AX_TORQUE_LIMIT_L,200);   
    delay(100);
    SetPosition(1,0); //set the position of servo # 1 to '0'
    delay(5000);//wait for servo to move
//    tilt.write(97);
    Serial.println("Set");

    
}

void loop()
{
  Serial.println("movin'");
  //increment from 0 to 1023
  for(int i=0;i<2048;i++)
  {
//    tilt.write(i);
    SetPosition(1,i); //set the position of servo #1 to the current value of 'i'
    delay(5);//wait for servo to move
      Serial.println(i);

  }
  delay(2000);
  Serial.println("movin'back");
  //decrement from 1024 to 0
  for(int i=2048;i>0;i--)
  {
//    tilt.write(i);
    SetPosition(1,i);//set the position of servo #1 to the current value of 'i'
    delay(5);//wait for servo to move
    Serial.println(i);

  }
  delay(2000);
}




