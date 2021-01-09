using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class morte : MonoBehaviour
{
    coin_player_counter _SommaMonete;
    score _HightScoreRegistration;
    public GameObject CMCam, Uiplay, deathUI;

    private void Start()
    {
        _SommaMonete = GetComponent<coin_player_counter>();
        _HightScoreRegistration = GetComponent<score>();
        deathUI.SetActive(false);
    }
    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.tag == "Ostacolizzatore")
        {
            Debug.Log("morto");
            _SommaMonete.add_coin();
            _HightScoreRegistration.setHightScore();
            gameObject.SetActive(false);
            CMCam.SetActive(false);
            Uiplay.SetActive(false);
            deathUI.SetActive(true);
        }
    }
}
