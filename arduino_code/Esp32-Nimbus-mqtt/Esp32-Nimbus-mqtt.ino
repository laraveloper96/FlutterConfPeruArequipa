/*
  Arm Robotic is Called Nimbuz

  This project was created to demonstrate that 
  Robotics can be used with Flutter and was 
  used exclusively for the 
  Flutter Conf Latam conference
  Arequipa - Peru.
  https://www.arduino.cc/en/Main/Products

  Created 31 Agu 2024
  by Cristhian Lara

  If you need some problems with this project please contact me.
  email: cristhianlara1996@gmail.com
*/

// ********************************
// ******* IMPORTS REQUIRED *******
// ********************************
#include <ARM_CTRL.h>
#include <MQTT_ROBOT.h>
#include <ArduinoJson.h>

//// ********************************
//// *********** ARM PINS ***********
//// ********************************
#define GRIPPER_GPIO23 23         // Pin GRIPPER
#define WRIST_PITCH_GPIO22 22     // Pin WRIST PITCH
#define WRIST_ROLL_GPIO15 15      // Pin WRIST ROLL
#define ELBOW_GPIO33 33           // Pin ELBOW
#define SHOULDER_GPIO32 32        // Pin SHOULDER
#define WAIST_GPIO13 13           // Pin WAIST
//
//// ********************************
//// *********** MQTT CONFIG ********
//// ********************************
const char *mqttServer = "10.240.210.85";
const int mqttPort = 1883;
const char *mqttUser = "";
const char *mqttPass = "";
const char *rootMoveTopicSubscribe = "robot/movement";
const char *rootRegisterTopicPublish = "human/register/robot";

// ********************************
// *********** WIFI CONFIG ********
// ********************************

const char* ssid = "Globant Guest";
const char* pass = "V1s1t0r-930";
String macEsp32;    // the MAC address of your Wifi shield

//// ********************************
//// *********** GLOBALS ************
//// ********************************
ARM_CTRL ARM;
MQTT_ROBOT MQTT;
WiFiClient espClient;
String clientName;
String clientId;
DynamicJsonDocument doc(1024); // Create the JSON object, JSON object size (adjust according to your needs)

//// ********************************
//// *********** FUNCTIONS **********
//// ********************************
  
void publishTopic(const char* topic){
  Serial.println("[callback] publishTopic");
  if (MQTT.connected()) {
    // Convert the JSON object to a string
    String jsonString;
    serializeJson(doc, jsonString);
    // Publish the JSON string to MQTT
    MQTT.publish(topic, jsonString.c_str());
    delay(300);
  }
}

void callback(char* topic, byte* payload, unsigned int length) {
  doc.clear();
  String jsonPayload = "";
  Serial.print("Message arrived [");
  Serial.print(topic);
  Serial.print("] ");
  for (int i=0;i<length;i++) {
    jsonPayload += (char)payload[i];
  }
  jsonPayload.trim();
  Serial.println("Message -> "+jsonPayload);
  // Parse the received JSON
  DeserializationError error = deserializeJson(doc, jsonPayload);
  if (error) {
    Serial.print("Failure to Analize the JSON: ");
    Serial.println(error.c_str());
    return;
  }

  // Read the values ​​of the JSON object
  const char* id = doc["client_id"];
  const char* command = doc["command"];
  const int val = doc["value"];

  // Show data received
  Serial.print("ID: ");
  Serial.println(id);
  Serial.print("Command: ");
  Serial.println(command);
  Serial.print("Val: ");
  Serial.println(val);
  moveRobot(id, command, val);
}

void reconnect() {
  Serial.println("[callback] reconnect");
  // Loop until we're reconnected
  while (!MQTT.connected()) {
    Serial.print("Attempting MQTT connection...");
    // Create client ID
    clientName = "Lara";
    clientId = clientName;
    // Attempt to connect
    doc.clear();
    if (MQTT.connect(clientId.c_str(),mqttUser, mqttPass)) {
      Serial.println("connected!");
      doc["id"] = macEsp32;
      doc["client_id"] = clientId;
      doc["client_name"] = clientName;
      doc["status"] = true;
      publishTopic(rootRegisterTopicPublish);
      if(MQTT.subscribe(rootMoveTopicSubscribe)){
        Serial.println("Subscribe OK");
      }else{
        Serial.println("Fail Subscribe");
      }
    } else {
      Serial.print("failed, rc=");
      Serial.print(MQTT.state());
      Serial.println(" try again in 5 seconds");
      doc["id"] = macEsp32;
      doc["client_id"] = clientId;
      doc["client_name"] = clientName;
      doc["status"] = false;
      publishTopic(rootRegisterTopicPublish);
      // Wait 5 seconds before retrying
      delay(5000);
    }
  }
}

void moveRobot(const char* id,const char* command, const int val){
  Serial.println("[callback] moveRobot");
  char charClientId[clientId.length() + 1]; // Convert the String to a char array
  clientId.toCharArray(charClientId, sizeof(charClientId));
  bool isOK  = strcmp(id, charClientId) == 0 || strcmp(id, "all") == 0;
  if(isOK){
    // Use the switch statement with the char array
    switch (*command) {
      case 'r': // reset
        Serial.println("Initial Position");
        ARM.setupInitPosition();
        break;
      case 'g': // gripper
        Serial.println("Gripper");
        ARM.moveGripper(val);
        break;
      case 'p': // wrist pitch        
        Serial.println("Wrist Pitch");
        ARM.moveWristPitch(val);
        break;
      case 'o': // wrist roll
        Serial.println("wrist roll");
        ARM.moveWristRoll(val);
        break; 
      case 'e': // elbow
        Serial.println("Elbow");
        ARM.moveElbow(val);
        break;     
      case 's': // shoulder
        Serial.println("Shoulder");
        ARM.moveShoulder(val);
        break;  
      case 'w': // waist
        Serial.println("Waist");
        ARM.moveWaist(val);
        break;
      case 'v': // velocity
        Serial.println("Velocity");
        ARM.setVelocity(val);
        break;  
      default:
        Serial.println("command unknown");
      }  
  }
}

void setup()
{
  Serial.println("[callback] setup");
  Serial.begin(115200); // Initializing the serial connection for debugging
  MQTT.MQTT_setupWifi(ssid, pass);
  macEsp32 = MQTT.getMacAddress();
  MQTT.setClient(espClient);
  MQTT.setServer(mqttServer, mqttPort);
  MQTT.setCallback(callback);
  ARM.ARM_init(GRIPPER_GPIO23, WRIST_PITCH_GPIO22, WRIST_ROLL_GPIO15,ELBOW_GPIO33,SHOULDER_GPIO32,WAIST_GPIO13); // I initialize the servos with the names and what is their associated pin
  ARM.setupInitPosition();                          
}

void loop() {
  MQTT.loop(reconnect);
}
