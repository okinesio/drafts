// okinesio 2015 //
// This work is licensed under a Creative Commons Attribution 4.0 International License. //
// https://creativecommons.org/licenses/by/4.0/ //

#include <Streaming.h>
#include <Arduino.h>
#include <SPI.h>

int16_t slaveSelectPin = 10;

struct accelData {
  int16_t x;
  int16_t y;
  int16_t z;
};

void setup() {

  //Initialize GPIO for CS/SS
  pinMode(slaveSelectPin, OUTPUT);
  digitalWrite(slaveSelectPin, HIGH);

  // begin SPI init
  SPI.begin();

  //Initialize serial for debugging
  Serial.begin(115200);
  delay(100);

  //Initialize the IMU. Add your initializations in there
  imuInit();

  // Hello
  Serial.println("// okinesio bmi160 breakout board //"); 
  // Print the chip ID
  Serial << "Chip ID: " << imuGetChipId() << endl;
}

void loop()
{
  struct accelData myAccData;
  imuGetAccelData(&myAccData);
  Serial << "Acc X: " << myAccData.x << " Acc Y: " << myAccData.y <<  " Acc Z: " << myAccData.z << endl;
  delay(100);
}
