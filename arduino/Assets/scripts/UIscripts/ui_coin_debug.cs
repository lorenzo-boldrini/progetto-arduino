using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class ui_coin_debug : MonoBehaviour
{
    TMP_Text _Coin_debug;
    // Start is called before the first frame update
    void Start()
    {
        _Coin_debug = GetComponent<TMP_Text>();
        PlayerPrefs.SetInt("Coin", 250);
    }

    // Update is called once per frame
    void Update()
    {
        _Coin_debug.text = PlayerPrefs.GetInt("Coin", 0).ToString();
    }
}
