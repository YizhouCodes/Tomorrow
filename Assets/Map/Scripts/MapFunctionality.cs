using System;
using UnityEngine;
namespace Maps{
	public class MapFunctionality : MonoBehaviour {
        float MinLat;
        float MaxLat;
        float MinLon;
        float MaxLon;
        Vector3 Center;
        private Transform buildingsHolder;
        private Transform[] buildings;
        private Transform areasHolder;
        private Transform[] areas;
        private Transform linesHolder;
        private Transform[] lines;
        private Transform mapBase;

        public void SetMapFunctionality(Bounds bounds, Transform buildingsHolder, Transform areasHolder, Transform linesHolder, Material mapBaseMaterial)
        {
            MinLat = bounds.MinLat;
            MaxLat = bounds.MaxLat;
            MinLon = bounds.MinLon;
            MaxLon = bounds.MaxLon;
            Center = bounds.Center;
            this.buildingsHolder = buildingsHolder;
            buildings = buildingsHolder.GetComponentsInChildren<Transform>();
            this.areasHolder = areasHolder;
            areas = areasHolder.GetComponentsInChildren<Transform>();
            this.linesHolder = linesHolder;
            lines = linesHolder.GetComponentsInChildren<Transform>();

            mapBase = GameObject.CreatePrimitive(PrimitiveType.Cylinder).transform;
            mapBase.name = "MapBase";
            mapBase.position = new Vector3(0, -1, 0);
            mapBase.parent = transform;
            mapBase.gameObject.GetComponent<MeshRenderer>().material = mapBaseMaterial;
        }

		public void PlaceOnMap(Transform obj, float lon, float lat)
		{
			PlaceAtMap (obj, lon, lat);
			obj.parent = transform;
		}

		public void PlaceAtMap(Transform obj, float lon, float lat)
		{
            Vector3 position = MapPosition(lon, lat);
            obj.position = position;
        }

		public void ShowMapArea(float lon, float lat, float radius)
		{
            Vector3 position = MapPosition(lon, lat);
            foreach (Transform building in buildings)
            {
                ToggleTransform(building, position, radius);
            }
            buildingsHolder.gameObject.SetActive(true);
            foreach (Transform area in areas)
            {
                ToggleTransform(area, position, radius);
            }
            areasHolder.gameObject.SetActive(true);
            foreach (Transform line in lines)
            {
                ToggleTransform(line, position, radius + 50);
            }
            linesHolder.gameObject.SetActive(true);
            mapBase.position = new Vector3(position.x, mapBase.position.y, position.z);
            mapBase.localScale = new Vector3(radius * 2, mapBase.localScale.y, radius * 2);
        }

        void ToggleTransform(Transform transform, Vector3 position, float radius)
        {
            if (Vector3.Distance(transform.position, position) < radius)
            {
                transform.gameObject.SetActive(true);
            }
            else
            {
                transform.gameObject.SetActive(false);
            }
        }
			
		Vector3 MapPosition(float lon, float lat){
			bool inLat = lat >= MinLat && lat <= MaxLat;
			bool inLon = lon >= MinLon && lon <= MaxLon;
			if (inLat && inLon)
			{
				return new Vector3 (
					(float)MercatorProjection.lonToX (lon),
					transform.position.y,
                    (float)MercatorProjection.latToY(lat)
                ) - Center;
			} 
			else {
				throw new Exception ("Position not inside bounds!");
			}
		}
	}
}
