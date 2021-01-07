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
    // Start is called before the first frame update
    void Start()
    {
        Score = 0;
    }

    // Update is called once per frame
    void Update()
    {
        Score = (Mathf.Round(transform.position.z * 10));
        ScoreText.text = "Score: " + Score.ToString();
    }
}
