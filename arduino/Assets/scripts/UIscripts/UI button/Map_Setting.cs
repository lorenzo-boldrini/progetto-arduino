using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Map_Setting : MonoBehaviour
{

    public GameObject[] Maps;
    public List<bool> purchaismap = new List<bool>();

    public int Mapnum;


    [SerializeField] GameObject RightButton;
    [SerializeField] GameObject LeftButton;
    [SerializeField] GameObject SelectButton;
    [SerializeField] GameObject BuyButton;
    [SerializeField] GameObject price;

    public Porta_seriale putMap;

    // Start is called before the first frame update
    void Start()
    {
        for(int i = 0; i < Maps.Length; i++)
        {
            print(i);
            if (i == 0)
                PlayerPrefs.SetInt("map" + i, 1);
            purchaismap.Add(PlayerPrefs.GetInt("map" + i, 0) == 0 ? false : true);


        }
        SetMap();
        putMap.numeroMappa = 0;
    }


    public void MapSettingsLeft()
    {
        Mapnum++;
        if(Mapnum >= Maps.Length - 1)
        LeftButton.SetActive(false);
        if (Mapnum > 0)
        RightButton.SetActive(true);

        SetMap();


    }

    public void MapSettingsRight()
    {
        Mapnum--;
        if (Mapnum == 0)
        {
            RightButton.SetActive(false);
        }
        if (Mapnum <= Maps.Length)
            LeftButton.SetActive(true);
        SetMap();

    }
    void SetMap()
    {
        print(Mapnum);

        //Character.GetComponent<SkinnedMeshRenderer>().material = Maps[Mapnum];

        if (PlayerPrefs.GetInt("map" + Mapnum, 0) == 1)
        {
            BuyButton.SetActive(false);
            SelectButton.SetActive(true);
        }
        else
        {
            BuyButton.SetActive(true);
            SelectButton.SetActive(false);
        }

    }

    public void buy_Map()
    {
        if (PlayerPrefs.GetInt("Coin", 0) >= 25)
        {
            PlayerPrefs.SetInt("map" + Mapnum, 1);
            SetMap();
            int cash = PlayerPrefs.GetInt("Coin", 0);
            PlayerPrefs.SetInt("Coin", cash - 25);
        }
    }
    

    public void mapset()
    {
        putMap.numeroMappa = Mapnum;
    }

    private void Update()
    {
        int counter = -1;
        foreach(GameObject obj in Maps)
        {
            counter++;
            if(counter == Mapnum)
            {
                obj.SetActive(true);
            }
            else
            {
                obj.SetActive(false);
            }
        }
    }
}



