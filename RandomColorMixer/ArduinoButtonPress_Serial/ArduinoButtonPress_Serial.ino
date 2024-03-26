const int butPin = 10;

void setup() {
  Serial.begin(9600);
  pinMode(butPin, INPUT_PULLUP);
}

void loop() {
  int buttonPress = digitalRead(butPin);

  Serial.print(buttonPress);
  Serial.println();
}
