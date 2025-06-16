# Bed Cooler

This is a test prototype of a home made bed cooler, that blows cold air at your feet when they get too hot. I don't know if it'll work.

![CAD image](picture.png)

The STL files expect a MALM bed from Ikea and a 75mm OD PVC pipe, cut to an appropriate length.
For my MALM bed and Ikea mattress, this length is 28cm.

BedCooler.ino is Arduino code for the thermostat, you will need to specify your Wifi details and local MQTT server address.

I'm using a Wemos D1 mini clone microcontroller, a DHT11 temperature sensor, and a L298N motor controller.

This project is in no way ready for you to just build one unless you're comfortable with tweaking all the parts.


## MQTT topics

**BedCooler/LWT**: will write Online and Offline as appropriate

**BedCooler/SetTriggerTemp**: set the degrees Celsius to turn the fan on at

**BedCooler/SetMode**: set this as On, Off, or Auto.
On turns on the fan, Off turns off the fan, Auto turns on the fan when the temperature is greater than the Trigger temp (off otherwise)

**BedCooler/SetSpeed**: Takes a PWM value between 1-255. On my motor controller/fan this makes a whining noise so I'm instead supplying the L298N with between 5-12 volts of power in order to set the speed.

**BedCooler/Temperature**: In Auto mode, this will publish the current temperature every 30 seconds

**BedCooler/Humidity**: In Auto mode, this will publish the current humidity every 30 seconds (currently unused but maybe a humidistat function is a good idea for sweaty people)


