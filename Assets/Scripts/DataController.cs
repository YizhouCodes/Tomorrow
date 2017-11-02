﻿using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;
using UnityEngine;

public class DataController : GenericSingleton<DataController> {

	public PlayerData player_data;

	private string jsonString;

	// Calls Load() function
	void Start () {
		Load();
		// Debug.Log("USERNAME: " + player_data.username);
		// SetUsername setting = new SetUsername();
		// setting.call("Tomorrow!");
		// Debug.Log("USERNAME: " + player_data.username);
		// Debug.Log(player_data.hotspots[1].visited);
		// Debug.Log(player_data.progress);
		// VisitHotspot visit = new VisitHotspot();
		// visit.call(123);
		// Debug.Log(player_data.hotspots[1].visited);
		// Debug.Log(player_data.progress);
	}


	// If it's the first time that user opens the game, it calls FirstLoad function
	// otherwise, it loads the saved data from `playerInfo.dat` file
	void Load () {
		// When Game has been opened before
		if (File.Exists(Application.persistentDataPath + "/playerData.dat")) {
			BinaryFormatter bf = new BinaryFormatter();
			FileStream file = File.Open(Application.persistentDataPath + "/playerData.dat", FileMode.Open);
			player_data = (PlayerData)bf.Deserialize(file);
			file.Close();
		}
		else { // When the app starts for the first time
			FirstLoad();
		}
	}

	// Gets called when user opens the app for the first time
	// loads, parses and saves the json into `playerInfo.dat` file
	void FirstLoad () {
		jsonString = File.ReadAllText(Application.dataPath + "/Resources/hotspots_list.json");
		player_data = JsonUtility.FromJson<PlayerData>(jsonString);
		player_data.hotspots_count = player_data.hotspots.Length;
		BinaryFormatter bf = new BinaryFormatter();
		FileStream file = File.Create(Application.persistentDataPath + "/playerData.dat");
		bf.Serialize(file, player_data);
		file.Close();
	}

	// Saves the current `player_data` into the file
	public void Save () {
		BinaryFormatter bf = new BinaryFormatter();
		FileStream file = File.Open(Application.persistentDataPath + "/playerData.dat", FileMode.Open);
		bf.Serialize(file, player_data);
		file.Close();
	}
}