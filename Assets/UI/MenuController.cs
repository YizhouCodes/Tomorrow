using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class MenuController : MonoBehaviour {

	public Text username;
	public Text progress;

	void Update () {
		username.text = DataController.Instance.player_data.username;

		string visited_count = DataController.Instance.player_data.visited_count.ToString();
		string hotspots_count = DataController.Instance.player_data.hotspots_count.ToString();
		progress.text = "You've visited " + visited_count + " out of " + hotspots_count + " hotspots";
	}
}
