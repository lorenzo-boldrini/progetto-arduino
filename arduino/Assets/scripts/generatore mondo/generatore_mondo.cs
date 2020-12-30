using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class generatore_mondo : MonoBehaviour
{
    public GameObject[] bioma1;
    public GameObject[] bioma2;
    public GameObject[] bioma3;

    public score RefScore;

    public float TimeToInstanitiate;
    float timer;

    public float distance;
    public int counter = 0;
    public int counterPos = 1;
    float DistanceCounter;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        int IndiceRandomico = Random.Range(0, bioma1.Length);
        timer += 1 * Time.deltaTime;
        if(counter < 10)
        {
            DistanceCounter = distance * counterPos;
            Instantiate(bioma1[IndiceRandomico],new Vector3(0, 0, DistanceCounter), Quaternion.identity);
            timer = 0;
            counter++;
            counterPos++;
        }
        else if(counter >= 10 && counter < 20)
        {
            DistanceCounter = distance * counterPos;
            Instantiate(bioma2[IndiceRandomico], new Vector3(0, 0, DistanceCounter), Quaternion.identity);
            timer = 0;
            counter++;
            counterPos++;
        }
        else if(counter >= 20 && counter < 30)
        {
            DistanceCounter = distance * counterPos;
            Instantiate(bioma3[IndiceRandomico], new Vector3(0, 0, DistanceCounter), Quaternion.identity);
            timer = 0;
            counter++;
            counterPos++;
        }
    }
}
