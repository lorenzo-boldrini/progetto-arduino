using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Color_settings : MonoBehaviour
{
    public GameObject Character;
    public Material[] CharacterColor;
    
    public int ColorSet;


    [SerializeField] GameObject RightButton;
    [SerializeField] GameObject LeftButton;
    [SerializeField] GameObject SelectButton;
    [SerializeField] GameObject BuyButton;
    // Start is called before the first frame update
    void Start()
    {
        
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
        Character.GetComponent<SkinnedMeshRenderer>().material = CharacterColor[ColorSet];
    }
}
