using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VisitHotspot {

	private PlayerData player_data;
	private int visited_count;

	// Called when a hotspot needs to be marked as visited
	// changes the `visited` value to true
	public void call (int hotspot_id) {
		player_data = GameController.Instance.player_data;
		visited_count = GameController.Instance.visited_count;
		foreach (Hotspot hotspot in player_data.hotspots) {
			if (hotspot_id == hotspot.id) {
				hotspot.visited = true;
				visited_count++;
				break;
			}
		}
		GameController.Instance.Save();
	}
}
