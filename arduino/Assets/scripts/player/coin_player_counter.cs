using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class coin_player_counter : MonoBehaviour
{
    public TMP_Text countercoin;
    public int coin_counter;
    public TMP_Text totalCoin;
    public int total_coin;

    public int coinForScreen;
    private void Start()
    {
        total_coin = PlayerPrefs.GetInt("Coin", 0);
        coinForScreen = PlayerPrefs.GetInt("Coin", 0);
    }
    private void OnTriggerEnter(Collider other)
    {
        if(other.gameObject.tag == "Coin")
        {
            coin_counter++;
            coinForScreen = PlayerPrefs.GetInt("Coin", 0);
            Destroy(other.gameObject);
        }
    }

    public void add_coin()
    {
        coin_counter += total_coin;
        PlayerPrefs.SetInt("Coin", coin_counter);
        totalCoin.text = "total Coin: " + PlayerPrefs.GetInt("Coin", 0).ToString();
    }

    private void Update()
    {
        countercoin.text = "Coin: " + coin_counter.ToString();
    }
}
