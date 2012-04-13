/*
Light an LED when switch contact is made
*/

const int ledPin = 12;
const int inputPin = 2;
int highFlag;
int randomInteger;

void setup()
{
   pinMode( ledPin,OUTPUT );
   pinMode( inputPin,INPUT ); 
   Serial.begin(9600);
   highFlag = 0;
}

void loop()
{
  int val = digitalRead( inputPin );
  if( val == HIGH && highFlag == 0 ) 
  {
    digitalWrite(ledPin, HIGH); //LED turns on
    Serial.print('H'); //header value
    //first value
    randomInteger = random(255);
    Serial.write(lowByte(randomInteger));
    Serial.write(highByte(randomInteger));
    //second value
    randomInteger = random(255);
    Serial.write(lowByte(randomInteger));
    Serial.write(highByte(randomInteger));
    //third value
    randomInteger = random(255);
    Serial.write(lowByte(randomInteger));
    Serial.write(highByte(randomInteger));
    delay(500);
    highFlag = 1;
  }
  else if( val == LOW && highFlag == 1)
  {
    digitalWrite(ledPin, LOW); //LED turns off
    highFlag = 0;
  }
}
