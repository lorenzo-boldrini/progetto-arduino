using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class input_manager : MonoBehaviour
{
    public static input_manager Singleton;

    [Header("events")]
    public UnityEvent jumpKeyDownEvent;
    public UnityEvent jumpKeyUpEvent;
    public UnityEvent ArduinoIsConnected;

    [Header("stati")]
    public bool IsConnected;
    public bool jumpKeyPressed;
    public float SliderValue;

    [Header("arduino par")]
    public Arduino MyArduino;
    public int jumpButtonPin = 6;
    public int sliderPin = 0;
    public int lightPin = 6;

    bool jumpones;
    float DeathZone;
    private void OnEnable()
    {
        if (Singleton != null)
            Destroy(this);
        else
            Singleton = this;
    }
    // Start is called before the first frame update
    void Start()
    {
        MyArduino = GameObject.Find("Uniduino").GetComponent<Arduino>();
        MyArduino.Setup(configurArduino);
    }

    void configurArduino()
    {
        MyArduino.pinMode(jumpButtonPin, PinMode.INPUT);
        MyArduino.reportDigital((byte)(jumpButtonPin / 8), 1);

        MyArduino.pinMode(sliderPin, PinMode.ANALOG);
        MyArduino.reportAnalog(sliderPin, 1);

        MyArduino.pinMode(lightPin, PinMode.ANALOG);
        MyArduino.reportAnalog(lightPin, 1);
    }
    // Update is called once per frame
    void Update()
    {
        IsConnected = MyArduino.Connected;
        StartToRun();
        slidercon();
        light_controller();
    }
    void jumpManager()
    {
        if (MyArduino.digitalRead(jumpButtonPin) > 0.5f)
        {
            if (!jumpones)
            {
                jumpKeyPressed = true;
                jumpKeyDownEvent.Invoke();

                jumpones = true;
            }
            else
            {
                if (jumpones)
                {
                    jumpKeyPressed = false;
                    jumpKeyUpEvent.Invoke();

                    jumpones = false;
                }
            }
        }
    }

    void StartToRun()
    {
        if (IsConnected)
        {
            ArduinoIsConnected.Invoke();
        }
    }
    void slidercon()
    {
        SliderValue = (float)MyArduino.analogRead(sliderPin) / 1048;

    }

    void light_controller()
    {
        print(MyArduino.analogRead(lightPin));
    }
}
