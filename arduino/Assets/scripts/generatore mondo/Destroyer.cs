using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Destroyer : MonoBehaviour
{
    public generatore_mondo GeneratoreMondo;
    int contatore_tiles;
    private void OnTriggerExit(Collider other)
    {
        if(other.gameObject.tag == "Bioma" || other.gameObject.tag == "Ostacolizz" +
            "atore")
        {
            Destroy(other.gameObject);
            contatore_tiles++;
            if(contatore_tiles >= 20)
            {
                GeneratoreMondo.counter = 0;
                GeneratoreMondo.contatore -= 20;
                contatore_tiles = 0;
            }
        }
    }
}
