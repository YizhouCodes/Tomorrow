using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class HotspotTransform : MonoBehaviour {

    public GameObject player;
    public float distance = 1000;

    void Start ()
    {
        gameObject.GetComponent<Renderer>().material.color = Color.blue;
    }
	
	void Update ()
    {
        
        // Changes the hotspot's color to yellow if it's visited
        if (DataController.Instance.player_data.FindHotspot(Int32.Parse(gameObject.name)).visited == true)
        {
            gameObject.GetComponent<Renderer>().material.color = Color.yellow;
            return;
        }
        
        Vector3 PlayerPosition = player.transform.position;
        Vector3 HotspotPosition = transform.position;
        distance = Math.Abs(PlayerPosition.x - HotspotPosition.x) + Math.Abs(PlayerPosition.z - HotspotPosition.z);
        
        // Changes the hotspot's color and rotation according to distance
        if (distance <= 5)
        {
            gameObject.GetComponent<Renderer>().material.color = Color.red;
        }
        else
        {
            gameObject.GetComponent<Renderer>().material.color = Color.blue;
        }
    }
}
