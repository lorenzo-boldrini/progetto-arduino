using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class character_controller : MonoBehaviour
{
    Animator _animCon;

    [Range(0,5)]
    [SerializeField] float speed;
    Vector3 PlayerXpose;
    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.A) && PlayerXpose.x > -2.8f)
        {
            PlayerXpose = new Vector3(transform.position.x - 1.8f, transform.position.y, transform.position.z);
        }
        if (Input.GetKeyDown(KeyCode.D) && PlayerXpose.x < 2.8f)
        {
            PlayerXpose = new Vector3(transform.position.x + 1.8f, transform.position.y, transform.position.z);
        }
        transform.position = new Vector3(Mathf.Lerp(transform.position.x, PlayerXpose.x, speed * Time.deltaTime),transform.position.y,transform.position.z);
    }
}
