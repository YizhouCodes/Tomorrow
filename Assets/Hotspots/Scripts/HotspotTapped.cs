using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class HotspotTapped : MonoBehaviour {

    public static int lastTappedHotspot;

    //Saves the id of the hotspot in lasttapped static variable
    private void OnMouseDown()
    {
        lastTappedHotspot = Int32.Parse(gameObject.name);
    }
}
