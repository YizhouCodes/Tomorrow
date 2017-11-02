using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SetPlayerColor {

	// It's saving the passed username
	public void call (string color) {
		GameController.Instance.player_data.player_color = color;
		GameController.Instance.Save();
	}
}
