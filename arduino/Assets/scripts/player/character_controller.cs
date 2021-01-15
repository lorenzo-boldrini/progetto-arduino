using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class character_controller : MonoBehaviour
{
    Animator _animCon;

    [Range(0,5)]
    public float speed;
    float PlayerXpose;
    Rigidbody _RG;

    [Range(0, 10)]
    public float JumpForce;
    public bool canJump;
    public float value;
    // Start is called before the first frame update
    void Start()
    {
        _animCon = GetComponent<Animator>();
        _RG = GetComponent<Rigidbody>();
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


    }

    public void jump()
    {
        
        if (canJump)
        {
            Debug.Log("salta puttanella");
            _RG.AddForce(new Vector3(0, JumpForce, 0), ForceMode.Impulse);
            canJump = false;
        }
    }
    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.tag == "Bioma")
            canJump = true;
    }

    public void stepSound(string name)
    {
        FindObjectOfType<audioManager>().Play(name);
    }
}
