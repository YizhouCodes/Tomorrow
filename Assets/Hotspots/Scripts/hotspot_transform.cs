using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class hotspot_transform : MonoBehaviour {

    float abs(float x)
    {
        if (x >= 0) return x;
        else return x * -1;
    }

    public GameObject player;
    public float distance = 1000;

    void Start ()
    {
        gameObject.GetComponent<Renderer>().material.color = Color.blue;
    }
		
	void Update ()
    {
        Vector3 PlayerPosition = player.transform.position;
        Vector3 HotspotPosition = transform.position;
        distance = abs(PlayerPosition.x - HotspotPosition.x) + abs(PlayerPosition.z - HotspotPosition.z);
        if (distance <= 5)
        {
            gameObject.GetComponent<Renderer>().material.color = Color.red;
            transform.Rotate(new Vector3(15, 30, 45) * Time.deltaTime);
        }
        else
        {
            gameObject.GetComponent<Renderer>().material.color = Color.blue;
            Vector3 cur = new Vector3(0,0,0);
            transform.eulerAngles = cur;
        }
    }
}
