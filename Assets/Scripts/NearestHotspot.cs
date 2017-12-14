using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Maps;
using System.Linq;

public class NearestHotspot : MonoBehaviour {
	public MapFunctionality map;
	public GameObject player;
    public Transform compass;

    private Hotspot[] hotspots;
	private Dictionary<float, Hotspot> distances;
	private float minimumDistance;
    private Hotspot closestHotspot;

    private void Start()
    {
        hotspots = DataController.Instance.player_data.hotspots;
    }
    private void Update()
    {
        Call();
        Vector3 hotspot_pos = map.MapPositionAt((float)closestHotspot.longitude, (float)closestHotspot.latitude);
        compass.LookAt(hotspot_pos, Vector3.up);
    }

    // Finds the minimum distance to the nearest hotspot and the hotspot itself
    private void Call ()
	{
        distances = new Dictionary<float, Hotspot>();
        foreach (Hotspot hotspot in hotspots) {
            if(hotspot.visited == false)
            {
                distances.Add(CalculateDistance(hotspot), hotspot);
            }
		}
		minimumDistance = distances.Keys.Min();
		closestHotspot = distances[distances.Keys.Min()];
	}

	// Returns false if the player is too far from a hotspot, true otherwise
	private bool CloseEnough (float minimum)
	{
		if (minimum < minimumDistance) {
			return false;
		}
		return true;
	}

	// Calculates the distance to the nearest hotspot
	private float CalculateDistance (Hotspot hotspot)
	{
		Vector3 hotspot_pos = map.MapPositionAt((float)hotspot.longitude, (float)hotspot.latitude);
		Vector3 player_pos = player.transform.position;
		return Vector3.Distance(hotspot_pos, player_pos);
	}
}
