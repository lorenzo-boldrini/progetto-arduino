using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Destroyer : MonoBehaviour
{
    public generatore_mondo GeneratoreMondo;
    int contatore_tiles;
    private void OnTriggerExit(Collider other)
    {
        if(other.gameObject.tag == "Bioma")
        {
            Destroy(other.gameObject);
            contatore_tiles++;
            GeneratoreMondo.WorldGen();
            if(contatore_tiles >= 30)
            {
                GeneratoreMondo.counter = 0;
                GeneratoreMondo.contatore = 0;
                contatore_tiles = 0;
            }
        }

        if(other.gameObject.tag == "Ostacolizzatore")
        {
            Destroy(other.gameObject);
        }
    }
}
