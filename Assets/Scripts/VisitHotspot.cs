using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VisitHotspot {

	private PlayerData player_data;
	private int visited_count;

	// Called when a hotspot needs to be marked as visited
	// changes the `visited` value to true
	public void call (int hotspot_id) {
		player_data = DataController.Instance.player_data;
		foreach (Hotspot hotspot in player_data.hotspots) {
			if (hotspot_id == hotspot.id) {
				hotspot.visited = true;
				player_data.visited_count++;
				setProgress();
				break;
			}
		}
		DataController.Instance.Save();
	}

	private void setProgress () {
		player_data.progress = (float)player_data.visited_count/player_data.hotspots_count;
	}
}
