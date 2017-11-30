using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NearestHotspot : MonoBehaviour {
	public MapFunctionality map;
	public GameObject player;

	private Hotspot[] hotspots = DataController.Instance.player_data.hotspots;
	private Dictionary<float, Hotspot> distances = new Dictionary<float, Hotspot>();
	private Hotspot closestHotspot { get; }
	private float minimumDistance;

	// Finds the minimum distance to the nearest hotspot and the hotspot itself
	public void Call ()
	{
		foreach (Hotspot hotspot in hotspots) {
			distances.Add(CalculateDistance(hotspot), hotspot);
		}
		minimumDistance = distances.Keys.Min();
		closestHotspot = distances[distances.Keys.Min()];
	}

	// Returns false if the player is too far from a hotspot, true otherwise
	public boolean CloseEnough (float minimum)
	{
		if (minimum < minimumDistance) {
			return false;
		}
		return true;
	}

	// Calculates the distance to the nearest hotspot
	private float CalculateDistance (Hotspot hotspot)
	{
		Vector3 hotspot_pos = map.MapPositionAt(hotspot.longitude, hotspot.latitude);
		Vector3 player_pos = player.transform.position;
		return Vector3.Distance(hotspot_pos, player_pos);
	}
}
