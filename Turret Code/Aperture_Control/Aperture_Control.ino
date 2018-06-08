/***************************
 * Aperture Control
 * 0 is 0 and 15000 is 75mm, so
 * 200 ticks is 1mm
 ***************************/

//import ax12 library to send DYNAMIXEL commands
#include <ax12.h>
#include <BioloidController.h>
#define fast 800

int desiredPosition = 30*200;  //The 200 is the multiplier, the first number is millimeters
int load = 0;
int maxLoad = 66;
int offset;

void setup()
{
    
    Serial.begin(9600);
    delay(5000);
    offset = initialize();
    Serial.println("Done initializing");
    ax12SetRegister2 (2 , AX_GOAL_POSITION_L, desiredPosition);
    delay(30000);
    Relax(2);
    delay(100);

}

void loop()
{
      Serial.println(GetPosition(2));
      delay(2000);

}

double initialize()
{
    double offset;

    ax12SetRegister2(2, 20, 0);
    ax12SetRegister2 (2 , AX_CW_ANGLE_LIMIT_L, 0);
    ax12SetRegister2 (2 , AX_CCW_ANGLE_LIMIT_L, 0);   
    ax12SetRegister2 (2 , AX_GOAL_SPEED_L,1023+ fast);
    delay(200);
    
    while(load < maxLoad)
    {
      load = ax12GetRegister(2 , AX_PRESENT_LOAD_L,1);
      Serial.print("Position: ");
      Serial.println(GetPosition(2));
      Serial.print("Load: ");
      Serial.println(load);
      delay(20);
    }
    Serial.println("Out");
    delay(50);
    ax12SetRegister2(2, AX_TORQUE_ENABLE, 0);
    delay(100);
    Serial.println("Aperture initialized");
    delay(500);
    ax12SetRegister2(2,AX_CCW_ANGLE_LIMIT_L,4095);
    ax12SetRegister2(2,AX_CW_ANGLE_LIMIT_L,4095);
    delay(100);
    ax12SetRegister2(2, AX_TORQUE_ENABLE, 1);
    delay(1000);
    Serial.println(GetPosition(2));
    double pos = GetPosition(2);
    delay(500);
    offset = -1*(pos+450);
    Serial.println(GetPosition(2));
    Serial.print("offset: ");
    Serial.println(offset);
    ax12SetRegister2(2, 20, offset);
    delay(1000);
    ax12SetRegister2 (2 , AX_GOAL_POSITION_L, 0);
    delay(5000);
    return offset;
    

}



