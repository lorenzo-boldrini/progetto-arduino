using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Uniduino;

public class turn_on_light : MonoBehaviour
{
    public Arduino arduino;
    public int selectedPin;
    // Start is called before the first frame update
    void Start()
    {
        arduino.Setup(ConfigurePins);
    }

    void ConfigurePins()
    {
        arduino.pinMode(selectedPin, PinMode.OUTPUT);
        arduino.reportAnalog(selectedPin, 1);
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKey(KeyCode.Space))
            arduino.digitalWrite(selectedPin, Arduino.HIGH);
        else
            arduino.digitalWrite(selectedPin, Arduino.LOW);
    }
}
