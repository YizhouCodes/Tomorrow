using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class bar_length : MonoBehaviour {

    public float hotspots_visited, total_hotspots;
	void Start ()
    {
        

        transform.localScale = new Vector3(hotspots_visited / total_hotspots, 1, 1);

	}
	
}
