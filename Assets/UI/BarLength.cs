using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BarLength : MonoBehaviour {

    void Update ()
    {
        transform.localScale = new Vector3(DataController.Instance.player_data.progress, 1, 1);
	}
}
