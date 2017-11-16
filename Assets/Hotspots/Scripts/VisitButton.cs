using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class VisitButton : MonoBehaviour {

    public Button button;
    // Use this for initialization
    void Start () {
        button.onClick.AddListener(() => ButtonOnClick(button));
    }

    //Calls the visithotspot class using the id from the latest tapped hotspot
    private void ButtonOnClick(Button button)
    {
        VisitHotspot visit = new VisitHotspot();
        visit.call(HotspotTapped.lastTappedHotspot);
    }
}
