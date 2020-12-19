using UnityEngine;
using System.Collections;
using Uniduino;


	
	public class BlinkButton : MonoBehaviour {
		
		public Arduino arduino;
		
		public int blink_pin = 13;
		// Use this for initialization
		void Start () {
		
			arduino = Arduino.global;
			arduino.Log = (s) => Debug.Log("Arduino: " +s);
			
			arduino.Setup(ConfigurePins);

			ConfigurePins ();
		}

		void ConfigurePins ()
		{
			Debug.Log("set pin mode");
			arduino.pinMode(blink_pin, PinMode.OUTPUT);
		}
				
		void OnGUI()
		{
			GUILayout.BeginArea(new Rect(100, 100, Screen.width-100, Screen.height-100));
			if (GUILayout.Button("Press me", GUILayout.Width(200)))
			{			
				StartCoroutine(BlinkButtonDelay());					
			} 
			GUILayout.EndArea();
			
		}
		
		IEnumerator BlinkButtonDelay(){
			gameObject.GetComponent<MeshRenderer>().material.color = Color.red;	
			arduino.digitalWrite(blink_pin, Arduino.HIGH);
			yield return new WaitForSeconds(1);
			gameObject.GetComponent<MeshRenderer>().material.color = Color.black;
			arduino.digitalWrite(blink_pin, Arduino.LOW);
		}
		
		// Update is called once per frame
		void Update () {
		
		}
	}
