using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DisplayUIOnClick : MonoBehaviour {

    public GameObject close_screen, far_screen , player;
    public float distance;

    float abs(float x)
    {
        if (x >= 0) return x;
        else return x * -1;
    }

    private void Start()
    {
        close_screen.SetActive(false);
        far_screen.SetActive(false);
    }

    void OnMouseDown()
    {
        if(distance <= 5)
        {
            close_screen.SetActive(true);
            far_screen.SetActive(false);
        }
        else
        {
            close_screen.SetActive(false);
            far_screen.SetActive(true);
        }
    }

    private void Update()
    {
        Vector3 PlayerPosition = player.transform.position;
        Vector3 HotspotPosition = transform.position;
        distance = abs(PlayerPosition.x - HotspotPosition.x) + abs(PlayerPosition.z - HotspotPosition.z);
    }
}
