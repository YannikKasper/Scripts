

#include <Wire.h>
#include <Adafruit_PWMServoDriver.h>

// called this way, it uses the default address 0x40
Adafruit_PWMServoDriver pwm = Adafruit_PWMServoDriver();

#define SERVOMIN  70 // this is the 'minimum' pulse length count (out of 4096)
#define SERVOMAX  450 // this is the 'maximum' pulse length count (out of 4096)



void setup() {
  Serial.begin(9600);
 

  pwm.begin();
  
  pwm.setPWMFreq(60);  // Analog servos run at ~60 Hz updates
 
  
  
}



void loop() {
  delay(2000);
  pwm.setPWM(0,0,400);
  pwm.setPWM(1,0,400);
  delay(3000);
  
  pwm.setPWM(0,0,50);
  pwm.setPWM(1,0,50);
 

}
