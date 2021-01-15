using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.IO.Ports;
using System.Threading;
using UnityEngine.Events;
using UnityEngine.SceneManagement;

public class Porta_seriale : MonoBehaviour
{
    public static Porta_seriale InputControllerPS;
    SerialPort PortaSerialeArduino;
    Thread TredArduino;

    public float potenziometroValue;
    public bool ButtonValue;
    public score Score_Ref;
    public coin_player_counter coin_ref;
    public character_controller playerController;
    
    GameObject Refplayer;
    GameObject GenWorldRef;

    string potenziometroValueString = "";

    public UnityEvent buttonPressed;
    public UnityEvent buttonDown;
    public UnityEvent buttonUp;

    public bool buttonDownA;


    public Material playerMat;
    public int numeroMappa;
    // Start is called before the first frame update
    void Start()
    {
        if (SceneManager.GetActiveScene().name == "test_vegetation")
        {
            Refplayer = GameObject.Find("Fairy@Running 1");
            Score_Ref = Refplayer.GetComponent<score>();
            coin_ref = Refplayer.GetComponent<coin_player_counter>();
            playerController = Refplayer.GetComponent<character_controller>();
        }
        DontDestroyOnLoad(this.gameObject);
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
        TakePlayerData();
        if (potenziometroValueString.Contains("Data"))
        {
            string[] SerialDataArduino = potenziometroValueString.Split('/');
            potenziometroValue = (float.Parse(SerialDataArduino[1])/1024);
            ButtonValue = int.Parse(SerialDataArduino[2]) == 1 ? true : false;
        }
        if (SceneManager.GetActiveScene().name == "test_vegetation")
        {
            playerController.value = potenziometroValue;
            buttonFunction();
            if(Refplayer.activeSelf)
            PortaSerialeArduino.WriteLine("dt" + Score_Ref.Score.ToString() + "/" + coin_ref.coinForScreen.ToString() + "/");
            else
            PortaSerialeArduino.WriteLine("d");
        }
    }

    private void OnDisable()
    {
        if (PortaSerialeArduino != null && PortaSerialeArduino.IsOpen)
            PortaSerialeArduino.Close();
        if (PortaSerialeArduino != null && TredArduino.IsAlive)
            TredArduino.Abort();
    }

    void buttonFunction()
    {
        if (ButtonValue)
        {
            buttonPressed.Invoke();
            if (!buttonDownA)
            {
                buttonDown.Invoke();
                buttonDownA = true;
                playerController.jump();
            }
        }
        else
        {
            buttonDownA = false;
            buttonUp.Invoke();
        }
    }

    void TakePlayerData()
    {
        if (SceneManager.GetActiveScene().buildIndex != 0 )
        {
            if (Refplayer == null || Score_Ref == null || coin_ref == null || playerController == null)
            {
                Debug.Log(SceneManager.GetActiveScene().buildIndex);
                Refplayer = GameObject.Find("Fairy@Running 1");
                GenWorldRef = GameObject.Find("generatore_mondo");
                GenWorldRef.GetComponent<generatore_mondo>().worldSet = numeroMappa;
                GameObject.Find("Group49690").GetComponent<SkinnedMeshRenderer>().material = playerMat;
                Score_Ref = Refplayer.GetComponent<score>();
                coin_ref = Refplayer.GetComponent<coin_player_counter>();
                playerController = Refplayer.GetComponent<character_controller>();
            }
        }
    }
}
