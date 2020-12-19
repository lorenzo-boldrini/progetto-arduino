using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class test_buzer : MonoBehaviour
{
    public Arduino arduino;
    public int selectedPin;

    public int noteA;
    public int noteS;
    public int noteD;
    // Start is called before the first frame update
    void Start()
    {
        arduino.Setup(ConfigurePins);
    }

    void ConfigurePins()
    {
        arduino.pinMode(selectedPin, PinMode.PWM);
        arduino.reportAnalog(selectedPin, 1);
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKey(KeyCode.A))
        {
            arduino.analogWrite(selectedPin,Mathf.Clamp (noteA, 0, 255));
        }
        else if(Input.GetKey(KeyCode.S))
        {
            arduino.analogWrite(selectedPin, Mathf.Clamp(noteS, 0, 255));
        }else if (Input.GetKey(KeyCode.D))
        {
            arduino.analogWrite(selectedPin, Mathf.Clamp(noteD, 0, 255));
        }
        else
        {
            arduino.analogWrite(selectedPin, 0);
        }
        
    }
}
