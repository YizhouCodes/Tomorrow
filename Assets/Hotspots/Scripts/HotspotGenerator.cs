using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Maps;

public class HotspotGenerator : MonoBehaviour {

    public MapFunctionality map;
    public GameObject hotspot;
    public GameObject far_screen, close_screen, player;

    //Create a single hotspot using the position vector3 and the name of the hotspot
    private void CreateHotspot(Vector3 position, int id)
    {
        GameObject newHotspot = Instantiate(hotspot, position, Quaternion.identity);
        newHotspot.name = id.ToString();
        newHotspot.GetComponent<DisplayUIOnClick>().player = player;
        newHotspot.GetComponent<HotspotTransform>().player = player;
        newHotspot.GetComponent<DisplayUIOnClick>().far_screen = far_screen;
        newHotspot.GetComponent<DisplayUIOnClick>().close_screen = close_screen;
    }

    //Create all hotspots, even those outside of the map
    public void CreateAllHotspots()
    {
        Hotspot[] hotspots = DataController.Instance.player_data.hotspots;
        foreach (Hotspot hotspot in hotspots)
        {
            Vector3 position = map.MapPositionAt((float)hotspot.longitude, (float)hotspot.latitude);
            position[1] += 5;
            CreateHotspot(position, hotspot.id);
        }
    }

    private void Start()
    {
        CreateAllHotspots();
    }
}
