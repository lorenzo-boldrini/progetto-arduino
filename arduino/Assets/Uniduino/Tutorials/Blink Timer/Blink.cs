
using UnityEngine;
using System.Collections;
using Uniduino;
using System;


	public class Blink : MonoBehaviour {
		
		public Arduino arduino;
		
		public int blink_pin = 13;
		// Use this for initialization
		void Start () {
		
			arduino = Arduino.global;			
			arduino.Log = (s) => Debug.Log("Arduino: " +s);
			arduino.Setup(ConfigurePins);
			StartCoroutine(BlinkLoop());
		}

		void ConfigurePins ()
		{
			arduino.pinMode(blink_pin, PinMode.OUTPUT);
		}
		
		IEnumerator BlinkLoop()
		{
			while(true)
			{					
				gameObject.GetComponent<MeshRenderer>().material.color = Color.red;			
				arduino.digitalWrite(blink_pin, Arduino.HIGH); // led ON			
				yield return new WaitForSeconds(1);
				
				gameObject.GetComponent<MeshRenderer>().material.color = Color.black;			
				arduino.digitalWrite(blink_pin, Arduino.LOW); // led OFF
				yield return new WaitForSeconds(1);					
			}
			
		}
	}
