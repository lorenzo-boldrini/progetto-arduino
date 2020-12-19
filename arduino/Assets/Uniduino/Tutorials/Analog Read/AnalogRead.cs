
using UnityEngine;
using System.Collections;
using Uniduino;


	public class AnalogRead : MonoBehaviour {
		
		public Arduino arduino;
		
		private GameObject cube;
		
		public int pin = 0;
		public int pinValue;
		public float spinSpeed;

		void Start () {
		
			arduino = Arduino.global;
			arduino.Log = (s) => Debug.Log("Arduino: " +s);
			arduino.Setup(ConfigurePins);
			
			cube = GameObject.Find("Cube");
		}
		
		void ConfigurePins()
		{
			arduino.pinMode(pin, PinMode.ANALOG);
			arduino.reportAnalog(pin, 1);
		}
		
		void Update () {
			
			pinValue = arduino.analogRead(pin);
			cube.transform.rotation = Quaternion.Euler(0,pinValue*spinSpeed,0);
			
		}
	}



