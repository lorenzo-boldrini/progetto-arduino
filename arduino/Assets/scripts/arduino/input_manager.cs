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

    [Header("stati")]
    public bool IsConnected;
    public bool jumpKeyPressed;
    public float SliderValue;

    [Header("arduino par")]
    public Arduino MyArduino;
    public int jumpButtonPin = 6;
    public int sliderPin = 0;

    bool jumpones;
    float DeathZone;
    private void OnEnable()
    {
        if (Singleton != null)
            Destroy(this);
        else
            Singleton = this;
        if(MyArduino == null)
        {
            MyArduino = GameObject.Find("Uniduino").GetComponent<Arduino>();
            Time.timeScale = 0;
        }
    }
    // Start is called before the first frame update
    void Start()
    {
        MyArduino.Setup(configurArduino);
    }

    void configurArduino()
    {
        MyArduino.pinMode(jumpButtonPin, PinMode.INPUT);
        MyArduino.reportDigital((byte)(jumpButtonPin / 8), 1);

        MyArduino.pinMode(sliderPin, PinMode.ANALOG);
        MyArduino.reportAnalog(sliderPin, 1);
    }
    // Update is called once per frame
    void Update()
    {
        IsConnected = MyArduino.Connected;
        jumpManager();
        startGame();
    }

    void startGame()
    {
        if (MyArduino != null)
        {
            Time.timeScale = 1;
        }
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

    void slidercon()
    {
        SliderValue = (float)MyArduino.analogRead(sliderPin)/1048;      


    }
}
