using System.Collections;
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
    public float[] PosXobstacle;
    public bool obstacleActive;

    public int contatore;

    public GameObject coin;

    public int worldSet;
    // Start is called before the first frame update
    void Start()
    {
        counter = 0;
    }

    // Update is called once per frame
    void Update()
    {
        while (counter <= 30)
        {
            if (/*counter < 10*/ worldSet == 0)
            {
                int IndiceRandomico = Random.Range(0, bioma1.Length);
                DistanceCounter = distance * counterPos;
                Vector3 distance_pos = new Vector3(0, 0, DistanceCounter);
                var obj = Instantiate(bioma1[IndiceRandomico], distance_pos, Quaternion.identity);
                if (counter > 1)
                    generate_obstacle(distance_pos, obj);
                counter++;
                counterPos++;
                contatore++;
            }
            else if (/*counter >= 10 && counter < 20*/ worldSet == 1)
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
            else if (/*counter >= 20 && counter < 30*/ worldSet == 2)
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


    void generate_obstacle(Vector3 posizione_base, GameObject PhaderGM)
    {
        if (obstacleActive)
        {
            int random_obstaclePos = Random.Range(0, PosXobstacle.Length);
            posizione_base = posizione_base + new Vector3(PosXobstacle[random_obstaclePos], 0.3f, 0);
            int random_obstacle_obj = Random.Range(0, obstacle.Length);
            Instantiate(obstacle[random_obstacle_obj], posizione_base, transform.rotation, PhaderGM.transform.parent);
            int percentualeCoinSpoun = Random.Range(0, 100);
            if(percentualeCoinSpoun >= 50)
            {
                if(random_obstacle_obj == 2)
                Instantiate(coin, posizione_base + new Vector3(0, 0.5f, 0), transform.rotation);
                else if(random_obstaclePos >= 1)
                {
                    Instantiate(coin, posizione_base + new Vector3(0, 0.5f, -1), transform.rotation);

                }
            }
        }
    }

    public void WorldGen()
    {
        if (worldSet == 0)
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
        else if (worldSet == 1)
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
        else if (worldSet == 2)
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
