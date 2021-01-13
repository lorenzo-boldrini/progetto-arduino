using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class character_controller : MonoBehaviour
{
    Animator _animCon;

    [Range(0,5)]
    [SerializeField] float speed;
    float PlayerXpose;
    // Start is called before the first frame update
    void Start()
    {
        _animCon = GetComponent<Animator>();
    }

    // Update is called once per frame
    void Update()
    {
        
        if (Input.GetKeyDown(KeyCode.A) && PlayerXpose > -2.8f)
        {
            PlayerXpose -= 1.8f; 
        }
        if (Input.GetKeyDown(KeyCode.D) && PlayerXpose < 2.8f)
        {
            PlayerXpose += 1.8f;
        }
        transform.position = new Vector3(Mathf.Lerp(transform.position.x, PlayerXpose, speed * Time.deltaTime),transform.position.y,transform.position.z);
        
        PlayerXpose = -3.6f + (1.8f * numCorsia);
        transform.position = new Vector3(Mathf.Lerp(transform.position.x, PlayerXpose, speed * Time.deltaTime), transform.position.y, transform.position.z);
        PosController();
    }

    /*public void startToRunAnim()
    {
        _animCon.SetBool("StartGame", true);
    }*/

    int numCorsia;
    void PosController()
    {
        float value = Porta_seriale.InputControllerPS.potenziometroValue;
           if(value > 0.8f)
                numCorsia = 4;
           else if (value > 0.6f && value < 0.8f)
                numCorsia = 3;
           
            else if (value > 0.4f && value < 0.6f)
                numCorsia = 2;
        
            else if(value > 0.2f && value < 0.4f)
                numCorsia = 1;
           else
                numCorsia = 0;

        Debug.Log(numCorsia);
    }

    public void jump()
    {
        Debug.Log("salta puttanella");
    }
}
