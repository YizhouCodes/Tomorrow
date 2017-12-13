using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.IO;

public class StartScreensController : MonoBehaviour {
    private GameObject firstScreen;

    public void controllFirstScreen () {
        if (DataController.Instance.player_data.registrationCompleted == true)
        {
            firstScreen = transform.GetChild(0).gameObject;
            firstScreen.SetActive(false);
        }
    }

	public void MarkRegistrationCompleted()
    {
        DataController.Instance.player_data.registrationCompleted = true;
        DataController.Instance.Save();
    }
	
}
