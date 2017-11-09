using System;
using UnityEngine;
namespace Maps{
	public class MapFunctionality : MonoBehaviour {
        [HideInInspector, SerializeField]
        float MinLat, MaxLat, MinLon, MaxLon;
        [HideInInspector, SerializeField]
        Vector3 Center;

        public void SetMapFunctionality(float minLat, float maxLat, float minLon, float maxLon, Vector3 center)
        {
            MinLat = minLat;
            MaxLat = maxLat;
            MinLon = minLon;
            MaxLon = maxLon;
            Center = center;
            ShowMapArea((MaxLon + MinLon) / 2, (MaxLat + MinLat) / 2, 4000);
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
            foreach (Transform transform in transform.GetComponentsInChildren<Transform>())
            {
                if(transform.parent != this.transform && transform != this.transform)
                {
                    transform.gameObject.SetActive(Vector3.Distance(transform.localPosition, position) < radius);
                }
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
