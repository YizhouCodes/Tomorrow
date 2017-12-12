using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SetPlayerColor {

	// It's saving the passed username
	public void call (string color) {
		DataController.Instance.player_data.player_color = color;
        DataController.Instance.player_data.player_character = color;
        DataController.Instance.Save();
	}
}
