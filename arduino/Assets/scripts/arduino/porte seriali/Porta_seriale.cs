using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.IO.Ports;
using System.Threading;

public class Porta_seriale : MonoBehaviour
{
    public static Porta_seriale InputControllerPS;
    SerialPort PortaSerialeArduino;
    Thread TredArduino;

    public float potenziometroValue;
    public bool ButtonValue;


    string potenziometroValueString = "";
    // Start is called before the first frame update
    void Start()
    {
        inizializeArduino();
        TredArduino = new Thread(ArduinoSerialRead);
        TredArduino.Start();
        InputControllerPS = this;
    }

    void inizializeArduino()
    {
        PortaSerialeArduino = new SerialPort("COM3", 9600);
        PortaSerialeArduino.Open();
    }

    void ArduinoSerialRead()
    {
        while (true)
        {
           potenziometroValueString =  PortaSerialeArduino.ReadLine();
        }
    }
    // Update is called once per frame
    void Update()
    {
        if (potenziometroValueString.Contains("Data"))
        {
            string[] SerialDataArduino = potenziometroValueString.Split('/');
            potenziometroValue = (float.Parse(SerialDataArduino[1])/1024);
            ButtonValue = int.Parse(SerialDataArduino[2]) == 1 ? true : false;
        }
        if (Input.GetKey(KeyCode.Space))
            PortaSerialeArduino.WriteLine("hello" + 1.ToString());
        else
            PortaSerialeArduino.WriteLine("hello" + 0.ToString());
    }

    private void OnDisable()
    {
        if (PortaSerialeArduino != null && PortaSerialeArduino.IsOpen)
            PortaSerialeArduino.Close();
        if (PortaSerialeArduino != null && TredArduino.IsAlive)
            TredArduino.Abort();
    }
}
