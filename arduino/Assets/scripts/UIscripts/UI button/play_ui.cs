using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class play_ui : MonoBehaviour
{
   public void replay()
    {
        SceneManager.LoadScene("test_vegetation");
    }

    public void Main_Menu()
    {
        SceneManager.LoadScene("Menu");
    }
}
