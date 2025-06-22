#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <DHT.h>

const char* ssid     = "wifi-ssid"; // Wifi details
const char* password = "wifi-password";
const char* mqtt_server = "mqtt"; // MQTT server

const int motorPin = D3;
const int motorSpeedPin = D2;

const int dhtPin = D1;
const int dhtType = DHT11;

// defaults, we can set these later (and have the MQTT server retain them)
byte fanspeed = 128;
float triggerTemp = 22.0;
int triggerHumidity = 70;

byte mode = 0; //0 = Off, 1= Auto, 2 = On

int iteration = 0;
WiFiClient espClient;
PubSubClient client(espClient);
DHT dht(dhtPin, dhtType);

void setup_wifi() {
  delay(10);
  // We start by connecting to a WiFi network

  WiFi.mode(WIFI_STA);
  WiFi.setHostname("BedCooler");
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
  }

  randomSeed(micros());
}

void callback(char* topic, byte* payload, unsigned int length) {
  //message 'payload' arrived to topic 'topic'

  char command[length + 1];
  memcpy(command, payload, length);
  command[length] = '\0';

  if (strcmp(topic, "BedCooler/SetTriggerTemp") == 0) {
    triggerTemp = atof(command);
    Serial.println("Setting trigger temp");
    Serial.println(triggerTemp);
  } else if (strcmp(topic, "BedCooler/SetTriggerHumidity") == 0) {
    triggerHumidity = atoi(command);
    Serial.println("Setting trigger humidity");
    Serial.println(triggerHumidity);
  } else if (strcmp(topic, "BedCooler/SetSpeed") == 0) {
    fanspeed = atoi(command);
    analogWrite(motorSpeedPin, fanspeed);
    Serial.println("Setting speed");
    Serial.println(fanspeed);
    
  } else if (strcmp(topic, "BedCooler/SetMode") == 0) {
    if (strcmp(command, "On") == 0) {
      mode = 2;
      digitalWrite(motorPin, HIGH);
      Serial.println("On mode");
    } else if (strcmp(command, "Off") == 0) {
      mode = 0;
      digitalWrite(motorPin, LOW);
      Serial.println("Off mode");
    } else if (strcmp(command, "Auto") == 0) {
      mode = 1;
      Serial.println("Auto mode");
    }
  }
}

void reconnect() {
  // Loop until we're reconnected
  digitalWrite(BUILTIN_LED, LOW);
  while (!client.connected()) {
    String clientId = "BedCooler";
    
    if (client.connect(clientId.c_str(), "BedCooler/LWT", 2, true, "Offline")) {
      client.publish("BedCooler/LWT", "Online", true);
      
      client.subscribe("BedCooler/SetTriggerTemp"); //26.5
      client.subscribe("BedCooler/SetTriggerHumidity"); //70
      client.subscribe("BedCooler/SetSpeed"); //128
      client.subscribe("BedCooler/SetMode"); //On Auto Off
    } else {
      delay(5000);
    }
  }
  digitalWrite(BUILTIN_LED, HIGH);
}

void setup() {
  pinMode(BUILTIN_LED, OUTPUT);
  pinMode(motorPin, OUTPUT);
  pinMode(motorSpeedPin, OUTPUT);
  digitalWrite(motorPin, LOW);
  analogWrite(motorSpeedPin, fanspeed);

  Serial.begin(9600);
  setup_wifi();

  client.setServer(mqtt_server, 1883);
  client.setCallback(callback);

  dht.begin();
  
}


void loop() {
  if (!client.connected()) {
    reconnect();
  }
  client.loop();
  delay(1000);
  

  if (iteration == 0) {

    if (mode == 1) {
      float temp = dht.readTemperature();
      int humidity = dht.readHumidity();
      
      Serial.println("Compare Temp/Humidity to Trigger");
      if (temp >= triggerTemp || humidity >= triggerHumidity) {
        digitalWrite(motorPin, HIGH);
        analogWrite(motorSpeedPin, fanspeed);
      } else {
        digitalWrite(motorPin, LOW);
      }
      
      Serial.println("Publish Temp and Humidity to MQTT");
      char result[10];
      dtostrf(temp, 2, 1, result);
      client.publish("BedCooler/Temperature", result, true);
      dtostrf(humidity, 2, 0, result);
      client.publish("BedCooler/Humidity", result, true);
    }
    
  }

  iteration = (iteration + 1) % 30;
}
