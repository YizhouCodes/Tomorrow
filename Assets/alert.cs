using System.Collections;
using System.Collections.Generic;
using UnityEngine;



public class alert : MonoBehaviour {

    float abs(float x)
    {
        if (x >= 0) return x;
        else return x * -1;
    }

    public GameObject hotspot;
    public float distance = 1000;
    public GameObject AlertText;

    public void Start()
    {
        AlertText.gameObject.SetActive(false);
    }

    void Update ()
    {
        Vector3 PlayerPosition = transform.position;
        Vector3 HotspotPosition = hotspot.transform.position;
        distance = abs(PlayerPosition.x - HotspotPosition.x) + abs(PlayerPosition.z - HotspotPosition.z);
        if(distance <= 5)
        {
            AlertText.SetActive(true);
        }
        else
        {
            AlertText.SetActive(false);
        }
    }
}
