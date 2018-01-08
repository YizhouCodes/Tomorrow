using System;
using System.Collections.Generic;
using UnityEngine;
namespace Maps{
	public class MapFunctionality : MonoBehaviour {
        [HideInInspector, SerializeField]
        float MinLat, MaxLat, MinLon, MaxLon;
        [HideInInspector, SerializeField]
        Vector3 Center;
        [HideInInspector, SerializeField]
        Way[] Buildings, Areas, Lines;

        public Material building;
        public Material campusBuilding;
        public Material greenery;
        public Material water;
        public Material ground;
        public Material road;

        public GameObject[] greeneryObjects;

        [Range(1, 10)]
        public float buildingHeightMultiplier = 1;
        [Range(0, 1000)]
        public float minClutterArea = 1;

        Material[] materials;
        Transform mapObjects;
        
        private void Awake()
        {
            primeMaterials();
            primeMapObjects();
        }
        
        public void SetMapFunctionality(Bounds bounds, Way[] buildings, Way[] areas, Way[] lines)
        {
            MinLat = bounds.MinLat;
            MaxLat = bounds.MaxLat;
            MinLon = bounds.MinLon;
            MaxLon = bounds.MaxLon;
            Center = bounds.Center;
            Buildings = buildings;
            Areas = areas;
            Lines = lines;
        }

        public void ShowMapArea(Vector3 globalPosition, float radius)
        {
            primeMapObjects();
            Vector3 position = mapObjects.transform.InverseTransformPoint(globalPosition);
            foreach (Way building in Buildings)
            {
                if (Vector3.Distance(building.Center - Center, position) < radius)
                {
                    PrimeObject(building, building.Center, mapObjects).GetComponent<MeshFilter>().mesh =
                        MeshBuilder.SolidMeshFromOutline(GetLocalVectors(building.Nodes, building.Center), building.Height * buildingHeightMultiplier);
                }
            }
            foreach (Way area in Areas)
            {
                if (Vector3.Distance(area.Center - Center, position) < radius)
                {
                    GameObject go = PrimeObject(area, area.Center, mapObjects);
                    go.GetComponent<MeshFilter>().mesh =
                        MeshBuilder.FlatMeshFromOutline(GetLocalVectors(area.Nodes, area.Center), area.Height);
                    if (area.Type == Way.WayType.Greenery)
                    {
                        ClutterArea(go, greeneryObjects);
                    }
                }
            }
            foreach (Way line in Lines)
            {
                if (Vector3.Distance(line.Center - Center, position) < radius)
                {
                    PrimeObject(line, line.Center, mapObjects).GetComponent<MeshFilter>().mesh =
                        MeshBuilder.MeshFromLine(GetLocalVectors(line.Nodes, line.Center), line.Width, line.Height);
                }
            }
        }

        public Vector3 MapPositionAt(float lon, float lat)
        {
            bool inLat = lat >= MinLat && lat <= MaxLat;
            bool inLon = lon >= MinLon && lon <= MaxLon;
            if (inLat && inLon)
            {
                return mapObjects.TransformPoint(new Vector3(
                    (float)MercatorProjection.lonToX(lon),
                    transform.position.y,
                    (float)MercatorProjection.latToY(lat)
                ) - Center);
            }
            else
            {
                throw new Exception("Position not inside bounds!");
            }
        }

        List<Vector3> GetLocalVectors(Node[] nodes, Vector3 localOrigin)
        {
            List<Vector3> vectors = new List<Vector3>();
            foreach (Node node in nodes)
            {
                vectors.Add(node - localOrigin);
            }
            return vectors;
        }

        GameObject PrimeObject(Way way, Vector3 localOrigin, Transform parent)
        {
            GameObject go = new GameObject(way.Name);
            go.transform.position = localOrigin - Center;
            go.transform.parent = parent;
            go.transform.localPosition = go.transform.position;
            go.transform.localRotation = go.transform.rotation;
            go.transform.localScale = go.transform.lossyScale;

            MeshRenderer mr = go.AddComponent<MeshRenderer>();
            MeshFilter mf = go.AddComponent<MeshFilter>();
            mr.material = materials[(int)way.Type];
            return go;
        }

        void ClutterArea(GameObject go, GameObject[] clutter)
        {
            Mesh mesh = go.GetComponent<MeshFilter>().mesh;
            Vector3[] vertices = mesh.vertices;
            int[] indices = mesh.triangles;
            for (int i = 0; i < indices.Length; i += 3)
            {
                Vector3 a = vertices[indices[i]];
                Vector3 b = vertices[indices[i + 1]];
                Vector3 c = vertices[indices[i + 2]];

                float area = Vector3.Magnitude(b - a) * Vector3.Magnitude(c - a) / 2;
                if (area > minClutterArea * 10)
                {
                    float r1 = UnityEngine.Random.value;
                    float r2 = UnityEngine.Random.value;
                    Vector3 point = Vector3.Scale(new Vector3(
                        (1 - Mathf.Sqrt(r1)) * a.x + (Mathf.Sqrt(r1) * (1 - r2)) * b.x + (Mathf.Sqrt(r1) * r2) * c.x,
                        a.y,
                        (1 - Mathf.Sqrt(r1)) * a.z + (Mathf.Sqrt(r1) * (1 - r2)) * b.z + (Mathf.Sqrt(r1) * r2) * c.z), go.transform.lossyScale);
                    Transform g = Instantiate(clutter[UnityEngine.Random.Range(0, clutter.Length - 1)], go.transform.position + point, Quaternion.identity, go.transform).transform;
                    g.localScale *= UnityEngine.Random.Range(0.5f, 1.5f);
                }
            }
        }

        Transform PrimeTransform(string name, Vector3 scale, Transform parent)
        {
            Transform go = new GameObject(name).transform;
            go.localScale = scale;
            go.parent = parent;
            return go;
        }

        void primeMaterials()
        {
            materials = new Material[] { building, campusBuilding, greenery, water, ground, road };
        }

        void primeMapObjects()
        {
            if (mapObjects != null)
            {
                GameObject.Destroy(mapObjects.gameObject);
            }
            mapObjects = PrimeTransform("MapObjects", transform.localScale, transform);
        }
    }
}
