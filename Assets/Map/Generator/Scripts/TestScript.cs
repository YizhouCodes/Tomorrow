using Maps;
using UnityEngine;

namespace Maps
{
    public class TestScript : MonoBehaviour
    {

        public float lat;
        public float lon;
        public int area;

        public void Test()
        {
            MapFunctionality mapFunc = transform.GetComponent<MapFunctionality>();
            mapFunc.ShowMapArea(lon, lat, area);
        }
    }
}
