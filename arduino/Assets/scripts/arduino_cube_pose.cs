using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Uniduino;

public class arduino_cube_pose : MonoBehaviour
{
    public Arduino arduino;

    public int SelectAnalogPin;
    public float NormalizePotValue;

    public float treshold;
    bool lighton;

    public Light LightTest;
    // Start is called before the first frame update
    void Start()
    {
        arduino.Setup(ConfigurePins);
        LightTest.enabled = false;
    }

    void ConfigurePins()
    {
        arduino.pinMode(SelectAnalogPin, PinMode.ANALOG);
        arduino.reportAnalog(SelectAnalogPin, 1);
    }

    // Update is called once per frame
    void Update()
    {
        print(arduino.analogRead(0));

        NormalizePotValue = (float)arduino.analogRead(SelectAnalogPin) / 1023;


    }
}
