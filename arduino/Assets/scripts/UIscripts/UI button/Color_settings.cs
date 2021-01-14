using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Color_settings : MonoBehaviour
{
    public GameObject Character;


    public Material[] CharacterColor;
    public List<bool> purchaismat = new List<bool>();

    public int ColorSet;


    [SerializeField] GameObject RightButton;
    [SerializeField] GameObject LeftButton;
    [SerializeField] GameObject SelectButton;
    [SerializeField] GameObject BuyButton;


    // Start is called before the first frame update
    void Start()
    {
        for(int i = 0; i < CharacterColor.Length; i++)
        {
            purchaismat[i] = PlayerPrefs.GetInt("mat" + i, 0) == 0 ? false : true;
        }
    }

   public void ColorSettingsLeft()
    {
        ColorSet++;
        if(ColorSet >= CharacterColor.Length - 1)
        LeftButton.SetActive(false);
        if (ColorSet > 0)
        RightButton.SetActive(true);

        SetColor();


    }

    public void ColorSettingsRight()
    {
        ColorSet--;
        if (ColorSet == 0)
        {
            RightButton.SetActive(false);
        }
        if (ColorSet <= CharacterColor.Length)
            LeftButton.SetActive(true);
        SetColor();

    }
    void SetColor()
    {
        print(ColorSet);
        Character.GetComponent<SkinnedMeshRenderer>().material = CharacterColor[ColorSet];

        if (PlayerPrefs.GetInt("mat" + ColorSet, 0) == 1)
        {
            BuyButton.SetActive(false);
            SelectButton.SetActive(true);
        }
        else
        {
            BuyButton.SetActive(true);
            SelectButton.SetActive(true);
        }

    }

    public void buy_mat()
    {
        PlayerPrefs.SetInt("mat" + ColorSet, 1);
    }
}



