using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Maps;

public class HotspotGenerator : MonoBehaviour {

    public MapFunctionality map;
    public GameObject hotspot;

    //Create a single hotspot using the position vector3 and the name of the hotspot
    private void createHotspot(Vector3 position, string name)
    {
        Object newHotspot = Instantiate(hotspot, position, Quaternion.identity);
        newHotspot.name = name;
    }

    //Create all hotspots, even those outside of the map
    public void createAllHotspots()
    {
        Hotspot[] hotspots = DataController.Instance.player_data.hotspots;
        foreach(Hotspot hotspot in hotspots)
        {
            Vector3 position = map.MapPositionAt((float)hotspot.longitude, (float)hotspot.latitude);
            createHotspot(position, hotspot.name);
        }
    }

    private void Start()
    {
        createAllHotspots();
    }
}
