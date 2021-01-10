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
    }

    public void startToRunAnim()
    {
        _animCon.SetBool("StartGame", true);
    }
}
