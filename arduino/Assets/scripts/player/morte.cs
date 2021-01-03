using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class morte : MonoBehaviour
{
    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.tag == "Ostacolizzatore")
        {
            Debug.Log("morto");
            Destroy(this.gameObject);
        }
    }
}
