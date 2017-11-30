using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class DisplayUIOnClick : MonoBehaviour {

    public GameObject close_screen, far_screen , player;
    public float distance;
    public static int lastTappedHotspot;

    private void Start()
    {
        close_screen.SetActive(false);
        far_screen.SetActive(false);
    }

    //Activates the nearby screens on tap
    void OnMouseDown()
    {
        lastTappedHotspot = Int32.Parse(gameObject.name);
        if (distance <= 5)
        {
            close_screen.SetActive(true);
            close_screen.GetComponent<NearbyScreenController>().title.text = DataController.Instance.player_data.FindHotspot(Int32.Parse(gameObject.name)).name;
            close_screen.GetComponent<NearbyScreenController>().description.text = DataController.Instance.player_data.FindHotspot(Int32.Parse(gameObject.name)).description;
        }
        else
        {
            far_screen.SetActive(true);
            far_screen.GetComponent<NearbyScreenController>().title.text = DataController.Instance.player_data.FindHotspot(Int32.Parse(gameObject.name)).name;
            far_screen.GetComponent<NearbyScreenController>().description.text = DataController.Instance.player_data.FindHotspot(Int32.Parse(gameObject.name)).description;
        }
    }

    private void Update()
    {
        Vector3 PlayerPosition = player.transform.position;
        Vector3 HotspotPosition = transform.position;
        distance = Math.Abs(PlayerPosition.x - HotspotPosition.x) + Math.Abs(PlayerPosition.z - HotspotPosition.z);
    }
}
