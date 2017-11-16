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
        
        public Color building;
        public Color campusBuilding;
        public Color greenery;
        public Color water;
        public Color ground;
        public Color road;

        [Range(1, 10)]
        public float buildingHeightMultiplier = 1;

        Material[] materials;
        Transform buildingsHolder, areasHolder, linesHolder;
        
        private void Awake()
        {
            primeMaterials();
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

        public void ShowMapArea(Vector3 position, float radius)
        {
            primeHolders();
            foreach (Way building in Buildings)
            {
                if (Vector3.Distance(building.Center - Center, position) < radius)
                {
                    PrimeObject(building, building.Center, buildingsHolder).GetComponent<MeshFilter>().mesh =
                        MeshBuilder.SolidMeshFromOutline(GetLocalVectors(building.Nodes, building.Center), building.Height * buildingHeightMultiplier);
                }
            }
            foreach (Way area in Areas)
            {
                if (Vector3.Distance(area.Center - Center, position) < radius)
                {
                    PrimeObject(area, area.Center, areasHolder).GetComponent<MeshFilter>().mesh =
                        MeshBuilder.FlatMeshFromOutline(GetLocalVectors(area.Nodes, area.Center), area.Height);
                }
            }
            foreach (Way line in Lines)
            {
                if (Vector3.Distance(line.Center - Center, position) < radius)
                {
                    PrimeObject(line, line.Center, linesHolder).GetComponent<MeshFilter>().mesh =
                        MeshBuilder.MeshFromLine(GetLocalVectors(line.Nodes, line.Center), line.Width, line.Height);
                }
            }
        }

        public void ShowMapArea(float lon, float lat, float radius)
        {
            ShowMapArea(MapPositionAt(lon, lat), radius);
        }

        public Vector3 MapPositionAt(float lon, float lat)
        {
            bool inLat = lat >= MinLat && lat <= MaxLat;
            bool inLon = lon >= MinLon && lon <= MaxLon;
            if (inLat && inLon)
            {
                return Vector3.Scale(new Vector3(
                    (float)MercatorProjection.lonToX(lon),
                    transform.position.y,
                    (float)MercatorProjection.latToY(lat)
                ) - Center, transform.lossyScale);
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

        Transform PrimeTransform(string name, Vector3 scale, Transform parent)
        {
            Transform go = new GameObject(name).transform;
            go.localScale = scale;
            go.parent = parent;
            return go;
        }

        void primeMaterials()
        {
            materials = new Material[6];
            Color[] colors = new Color[] {building, campusBuilding, greenery, water, ground, road};
            for(int i = 0; i < colors.Length; i++)
            {
                Material material = new Material(Shader.Find("Standard"));
                material.SetColor("_Color", colors[i]);
                materials[i] = material;
            }
        }

        void primeHolders()
        {
            if(buildingsHolder != null)
            {
                Destroy(buildingsHolder.gameObject);
            }
            if (areasHolder != null)
            {
                Destroy(areasHolder.gameObject);
            }
            if (linesHolder != null)
            {
                Destroy(linesHolder.gameObject);
            }
            buildingsHolder = PrimeTransform("Buildings", transform.localScale, transform);
            areasHolder = PrimeTransform("Areas", transform.localScale, transform);
            linesHolder = PrimeTransform("Lines", transform.localScale, transform);
        }
    }
}
