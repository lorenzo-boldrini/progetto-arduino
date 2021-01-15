using System.Collections;
using System;

using UnityEngine;
using UnityEngine.Audio;

public class audioManager : MonoBehaviour
{

    public audioClass[] sound;

    void Awake()
    {
        foreach(audioClass s in sound)
        {
            s.source = gameObject.AddComponent<AudioSource>();
            s.source.clip = s.clip;

            s.source.volume = s.volume;
            s.source.pitch = s.pitch;
            s.source.loop = s.loop;
        }
    }
    // Start is called before the first frame update
    void Start()
    {
        Play("drone");
        Play("theme");
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void Play(string name)
    {
        audioClass s = Array.Find(sound, sound => sound.name == name);
        s.source.Play();
    }
}
