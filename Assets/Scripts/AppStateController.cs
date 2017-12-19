using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AppStateController : MonoBehaviour {

    public GameObject [] screens;

    // Use this for initialization
    void Awake () {
        InputManager.Instance.back += Close;
	}
	
    public void Close()
    {
        foreach(GameObject screen in screens)
        {
            if (screen.activeSelf)
            {
                screen.SetActive(false);
                return;
            }
        }
        Application.Quit();
    }
	// Update is called once per frame
	void Update () {
		
	}
}
