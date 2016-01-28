/**********************************************************************
* okinesio 2015 - 2016
* http://okinesio.org
*
* This work is licensed under a Creative Commons Attribution 4.0 International License.
* https://creativecommons.org/licenses/by/4.0/
*
**********************************************************************/

#include <Streaming.h>
#include <Arduino.h>
#include <SPI.h>

int16_t slaveSelectPin = 10;

struct accelData {
  int16_t x;
  int16_t y;
  int16_t z;
};

uint8_t c = 0; // counted steps


void setup() {

  // Initialize GPIO for CS/SS
  pinMode(slaveSelectPin, OUTPUT);
  digitalWrite(slaveSelectPin, HIGH);

  // Begin SPI init
  SPI.begin();

  // Initialize serial for debugging
  Serial.begin(115200);
  delay(100);

  // Initialize the sensor. Add your initializations in there
  initBMI160();

  // Hello
  delay(1000);
  Serial << ">> okinesio - BMI160 Breakout Board <<\n" << endl;
}

void loop()
{
  struct accelData acc;
  imuGetAccelData(&acc);

  // Print accelerometer data (X, Y and Z)
  Serial << "ACC:\t" << acc.x << "\t" << acc.y <<  "\t" << acc.z << "\t\t";
  
  // Get current steps
  Serial << "STEPS:\t" << getStepCount() << endl;

  // Get current step count (updates only if a step is counted)
  /*
  if (c != getStepCount()) {
    Serial << "STEPS:\t" << getStepCount() << endl;
    c = getStepCount();
  }
  */

  // Delay for better readability of serial monitor
  delay(100);
}
