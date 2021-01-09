using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class score : MonoBehaviour
{
    public float Score;
    [Range(0,10)]
    public float multiplayerScore;
    public TMP_Text ScoreText;
    public float HightScore;
    public TMP_Text HightScoreTXT;
    // Start is called before the first frame update
    void Start()
    {
        HightScore = PlayerPrefs.GetFloat("HightScore", 0);
        Score = 0;
    }

    // Update is called once per frame
    void Update()
    {
        Score = (Mathf.Round(transform.position.z));
        ScoreText.text = "Score: " + Score.ToString();
    }

    public void setHightScore()
    {
        if(Score > HightScore)
        {
            PlayerPrefs.SetFloat("HightScore", Score);
            HightScoreTXT.text = "Hight Score: " + PlayerPrefs.GetFloat("HightScore", 0).ToString();
        }
        else
        {
            HightScoreTXT.text = "Hight Score: " + PlayerPrefs.GetFloat("HightScore", 0).ToString();
        }
    }
}
