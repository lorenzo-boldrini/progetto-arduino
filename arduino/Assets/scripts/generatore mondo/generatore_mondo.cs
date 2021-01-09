﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class generatore_mondo : MonoBehaviour
{
    public GameObject[] bioma1;
    public GameObject[] bioma2;
    public GameObject[] bioma3;

    public score RefScore;

    
    public float distance;
    public int counter = 0;
    public int counterPos = 1;
    float DistanceCounter;

    public GameObject[] obstacle;
    public float PosXObstacle;
    public bool obstacleActive;

    public int contatore;
    // Start is called before the first frame update
    void Start()
    {
        for(int i = 0; i <= 30; i++)
        {
            if (counter < 10)
            {
                int IndiceRandomico = Random.Range(0, bioma1.Length);
                DistanceCounter = distance * counterPos;
                Vector3 distance_pos = new Vector3(0, 0, DistanceCounter);
                var obj = Instantiate(bioma1[IndiceRandomico], distance_pos, Quaternion.identity);
                generate_obstacle(distance_pos, obj);
                counter++;
                counterPos++;
                contatore++;
            }
            else if (counter >= 10 && counter < 20)
            {
                int IndiceRandomico = Random.Range(0, bioma2.Length);
                DistanceCounter = distance * counterPos;
                Vector3 distance_pos = new Vector3(0, 0, DistanceCounter);
                var obj = Instantiate(bioma2[IndiceRandomico], new Vector3(0, 0, DistanceCounter), Quaternion.identity);
                generate_obstacle(distance_pos, obj);
                counter++;
                counterPos++;
                contatore++;
            }
            else if (counter >= 20 && counter < 30)
            {
                int IndiceRandomico = Random.Range(0, bioma3.Length);
                DistanceCounter = distance * counterPos;
                Vector3 distance_pos = new Vector3(0, 0, DistanceCounter);
                var obj = Instantiate(bioma3[IndiceRandomico], new Vector3(0, 0, DistanceCounter), Quaternion.identity);
                generate_obstacle(distance_pos, obj);
                counter++;
                counterPos++;
                contatore++;
            }
        }
        counter = 0;
    }

    // Update is called once per frame
    void Update()
    {
      
    }


    void generate_obstacle(Vector3 posizione_base, GameObject PhaderGM)
    {
        if (obstacleActive)
        {
            posizione_base = posizione_base + new Vector3(Random.Range(-PosXObstacle, PosXObstacle), 0.3f, 0);

            Instantiate(obstacle[Random.Range(0, obstacle.Length)], posizione_base, transform.rotation, PhaderGM.transform.parent);
        }
    }

    public void WorldGen()
    {
        if (counter < 10)
        {
            int IndiceRandomico = Random.Range(0, bioma1.Length);
            DistanceCounter = distance * counterPos;
            Vector3 distance_pos = new Vector3(0, 0, DistanceCounter);
            var obj = Instantiate(bioma1[IndiceRandomico], distance_pos, Quaternion.identity);
            generate_obstacle(distance_pos, obj);
            counter++;
            counterPos++;
            contatore++;
        }
        else if (counter >= 10 && counter < 20)
        {
            int IndiceRandomico = Random.Range(0, bioma2.Length);
            DistanceCounter = distance * counterPos;
            Vector3 distance_pos = new Vector3(0, 0, DistanceCounter);
            var obj = Instantiate(bioma2[IndiceRandomico], new Vector3(0, 0, DistanceCounter), Quaternion.identity);
            generate_obstacle(distance_pos, obj);
            counter++;
            counterPos++;
            contatore++;
        }
        else if (counter >= 20 && counter < 30)
        {
            int IndiceRandomico = Random.Range(0, bioma3.Length);
            DistanceCounter = distance * counterPos;
            Vector3 distance_pos = new Vector3(0, 0, DistanceCounter);
            var obj = Instantiate(bioma3[IndiceRandomico], new Vector3(0, 0, DistanceCounter), Quaternion.identity);
            generate_obstacle(distance_pos, obj);
            counter++;
            counterPos++;
            contatore++;
        }
    }
}
