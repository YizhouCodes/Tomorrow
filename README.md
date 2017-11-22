# Tomorrow
An AR game

## Setup instructions

1. Add MapGenerator script to any gameObject
2. Download a openstreetmap map file
3. Add the map file to the script
4. Generate map; this generates a map object
5. Remove MapGenerator component from the gameObject
6. Scale the map x to 0.1 y to 0.1 and z to 0.1
7. Set the map colors and the map height multiplier as you want
8. Add EventSystem UI object
9. Add the following prefabs to the scene: 
	PlayerHolder
	Hero
	UniversalObject
	NearbyHotspotScreen
	StartScreens
10. Add (Farmer) controller to Hero and scale the hero x to 0.1 y to 0.1 and z to 0.1
11. Add HotspotGenerator scrip to UniversalObject
12. Assign the following objects to the script:
	Map to Map
	Hotspot prefab to Hotspot
	NearbyHotspot (far) to Far_screen
	NearbyHotspot (close) to Close_screen
	Hero to Player
13. Assign the following objects to the MapCameraController script:
	Hero to Player Transform
	Main Camera to Camera Transform
	Map to Map
	
	
	
