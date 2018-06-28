/***************************
 * Pan Control
 * 0 is 0 degrees and 2048 is 180 degrees, so 11.37 ticks is 1 degree
 ***************************/
#include <ax12.h>
#include <BioloidController.h>

double panRatio = 1024/87.5; //Ratio of values/degree. The current setup is 11.37 values/mm

 
void movePan(int id, double desiredPosition)
{
  double ratio;
  
  if(desiredPosition > 185)
  {
    Serial.println("Value too high");
    return;
  }else if (desiredPosition < -5)
  {
    Serial.println("Value too low");
    return;
  }
  
  desiredPosition = desiredPosition*panRatio;  //Converting the commanded position from degrees to values, which can be sent to servo
  
  ax12SetRegister2 (id , AX_GOAL_POSITION_L, desiredPosition);
  
  delay(10);

}

double getPanPosition(int id)
{
  return (GetPosition(id)/panRatio);
}

