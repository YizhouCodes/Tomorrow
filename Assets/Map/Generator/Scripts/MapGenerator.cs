using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Xml;
using UnityEngine;

namespace Maps
{
    public class MapGenerator : MonoBehaviour
    {
        public TextAsset file;
        [Range(1, 10)]
        public float buildingHeightMultiplier = 1;

        public Color building;
        public Color campusBuilding;
        public Color greenery;
        public Color water;
        public Color ground;
        public Color road;

        private static List<string> greenValues = new List<string>
        {
            "park","wood","forest","valley","grasland","grass","scrub","garden","meadow","cemetery"
        };
        private static List<string> waterValues = new List<string>
        {
            "bay","water","marina","dam","riverbank","fountain"
        };
        private static List<string> groundValues = new List<string>
        {
            "beach","sand","gravel","playground","pitch"
        };
        private static List<string> roadValues = new List<string>
        {
            "parking","pier","footway","asphalt","roundabout","service","driveway","parking_aisle","paved","parking_space"
        };
        private static List<string> campusValues = new List<string>
        {
            "Tampereen yliopisto","Pirkanmaan ammattikorkeakoulu Oy","Tampereen ammattikorkeakoulu","Tampereen teknillinen yliopisto"
        };
        private static List<string> buildingValues = new List<string>
        {
            "tower","chimney","observation","lighting","church","hotel","garages","fast_food","library","school","stadium","monument"
        };
        private static List<string> buildingKeys = new List<string>
        {
            "building","tower:type","rooms"
        };
        private static List<string> nameKeys = new List<string>
        {
            "name","name:en","addr:housenumber"
        };
        private static List<string[]> heightKeysMultipliers = new List<string[]>
        {
            new string[]{"building:levels","4"},new string[]{"height","1"}
        };
        private static List<string> terminateIfSingle = new List<string>
        {
            "residential","name"
        };
        private static List<string> roadlineKeys = new List<string>
        {
            "highway","railway"
        };
        private static List<string> waterlineKeys = new List<string>
        {
            "waterway"
        };
        private static List<string[]> widthKeysMultipliers = new List<string[]>
        {
            new string[]{"lanes","2"},new string[]{"width","1"}
        };

        Material buildingMaterial;
        Material campusBuildingMaterial;
        Material greeneryMaterial;
        Material waterMaterial;
        Material groundMaterial;
        Material roadMaterial;

        public void GenerateMap()
        {
            Map map = MapReader.GetMap(file);

            GameObject mapHolder = new GameObject();
            mapHolder.name = "Map";
            Transform buildings = new GameObject().transform;
            buildings.parent = mapHolder.transform;
            buildings.gameObject.name = "Buildings";
            Transform areas = new GameObject().transform;
            areas.parent = mapHolder.transform;
            areas.gameObject.name = "Areas";
            Transform ways = new GameObject().transform;
            ways.parent = mapHolder.transform;
            ways.gameObject.name = "Ways";

            primeMaterials();
            GenerateBoundaries(map, buildings, areas);
            GenerateLines(map, ways);
            Bounds bounds = map.Bounds;
            mapHolder.AddComponent<MapFunctionality>().SetMapFunctionality(bounds.MinLat, bounds.MaxLat, bounds.MinLon, bounds.MaxLon, bounds.Center);
            mapHolder.AddComponent<TestScript>();
        }

        void GenerateBoundaries(Map map, Transform buildingParent, Transform areaParent)
        {
            foreach (Way boundary in map.Boundaries)
            {
                XmlNodeList tags = boundary.Node.SelectNodes("tag");
                if (tags.Count == 0) continue;
                if (tags.Count == 1)
                {
                    bool doContinue = false;
                    foreach (string val in terminateIfSingle)
                    {
                        if (val == XmlGetter.GetAttribute<string>("k", tags[0].Attributes) ||
                            val == XmlGetter.GetAttribute<string>("v", tags[0].Attributes))
                        {
                            doContinue = true;
                            break;
                        }
                    }
                    if (doContinue) continue;
                }


                bool isBuilding = false;
                bool isCampus = false;
                string name = null;
                float height = 0;
                Material mat = null;

                foreach (XmlNode tag in tags)
                {
                    string key = XmlGetter.GetAttribute<string>("k", tag.Attributes);
                    string val = XmlGetter.GetAttribute<string>("v", tag.Attributes);
                    if (!isBuilding)
                    {
                        foreach (string buildingValue in buildingValues)
                        {
                            if (buildingValue == val)
                            {
                                isBuilding = true;
                                name = val;
                                break;
                            }
                        }
                        foreach (string buildingKey in buildingKeys)
                        {
                            if (buildingKey == key)
                            {
                                isBuilding = true;
                                break;
                            }
                        }
                    }
                    foreach (string[] keyMult in heightKeysMultipliers)
                    {
                        if (key == keyMult[0])
                        {
                            height = float.Parse(Regex.Split(val, @"\s|\D")[0]) * float.Parse(keyMult[1]);
                            isBuilding = true;
                        }
                    }
                    foreach (string nameKey in nameKeys)
                    {
                        if (key == nameKey)
                        {
                            name = val;
                        }
                    }
                    if (!isCampus)
                    {
                        foreach (string campusValue in campusValues)
                        {
                            if (val == campusValue)
                            {
                                isCampus = true;
                                break;
                            }
                        }
                    }

                }
                if (isBuilding)
                {
                    if (name == null) name = "building";
                    if (height == 0) height = 10;
                    mat = isCampus == true ? campusBuildingMaterial : buildingMaterial;
                    GameObject go = BuildSolidBoundary(map, boundary, name, height, mat);
                    go.transform.parent = buildingParent;
                }
                else
                {
                    mat = null;
                    bool typeFound = false;
                    foreach (XmlNode tag in tags)
                    {
                        string key = XmlGetter.GetAttribute<string>("k", tag.Attributes);
                        string val = XmlGetter.GetAttribute<string>("v", tag.Attributes);
                        if (!typeFound)
                        {
                            foreach (string waterValue in waterValues)
                            {
                                if (val == waterValue)
                                {
                                    typeFound = true;
                                    height = 0f;
                                    mat = waterMaterial;
                                    if (name == null) name = val;
                                    break;
                                }
                            }
                            foreach (string greenValue in greenValues)
                            {
                                if (val == greenValue)
                                {
                                    typeFound = true;
                                    height = 0.1f;
                                    mat = greeneryMaterial;
                                    if (name == null) name = val;
                                    break;
                                }
                            }
                            foreach (string groundValue in groundValues)
                            {
                                if (val == groundValue)
                                {
                                    typeFound = true;
                                    height = 0.2f;
                                    mat = groundMaterial;
                                    if (name == null) name = val;
                                    break;
                                }
                            }
                            foreach (string roadValue in roadValues)
                            {
                                if (val == roadValue)
                                {
                                    typeFound = true;
                                    height = 0.3f;
                                    mat = roadMaterial;
                                    if (name == null) name = val;
                                    break;
                                }
                            }
                        }
                    }
                    if (typeFound)
                    {
                        GameObject go = BuildFlatBoundary(map, boundary, name, height, mat);
                        go.transform.parent = areaParent;
                    }
                }
            }
        }

        void GenerateLines(Map map, Transform waysParent)
        {
            foreach (Way line in map.Lines)
            {
                XmlNodeList tags = line.Node.SelectNodes("tag");
                if (tags.Count == 0) continue;
                bool road = false;
                bool water = false;
                float width = 2;
                foreach (XmlNode tag in tags)
                {
                    string key = XmlGetter.GetAttribute<string>("k", tag.Attributes);
                    string val = XmlGetter.GetAttribute<string>("v", tag.Attributes);
                    foreach (string lineKey in roadlineKeys)
                    {
                        if (lineKey == key)
                        {
                            road = true;
                            break;
                        }
                    }
                    foreach (string lineKey in waterlineKeys)
                    {
                        if (lineKey == key)
                        {
                            water = true;
                            break;
                        }
                    }
                    foreach (string[] keyMult in widthKeysMultipliers)
                    {
                        if (key == keyMult[0])
                        {
                            width = float.Parse(Regex.Split(val, @"\s|\D")[0]) * float.Parse(keyMult[1]) * 1.5f;
                        }
                    }
                }
                if (road || water)
                {
                    GameObject go = BuildLine(map, line, "line", width, road ? 0.3f : 0f, road ? roadMaterial : waterMaterial);
                    go.transform.parent = waysParent;
                }
            }
        }

        GameObject BuildLine(Map map, Way line, string name, float width, float height, Material mat)
        {
            Vector3 localOrigin = line.GetCenter();
            GameObject go = PrimeObject(map, line, localOrigin, name, mat);

            List<Vector3> path = GetLocalVectors(line.Nodes, localOrigin);
            go.GetComponent<MeshFilter>().mesh = MeshBuilder.MeshFromLine(path, width, height);
            return go;
        }

        GameObject BuildFlatBoundary(Map map, Way boundary, string name, float height, Material mat)
        {
            Vector3 localOrigin = boundary.GetCenter();
            GameObject go = PrimeObject(map, boundary, localOrigin, name, mat);

            List<Vector3> outline = GetLocalVectors(boundary.Nodes, localOrigin);

            go.GetComponent<MeshFilter>().mesh = MeshBuilder.FlatMeshFromOutline(outline, height);
            return go;
        }

        GameObject BuildSolidBoundary(Map map, Way boundary, string name, float height, Material mat)
        {
            Vector3 localOrigin = boundary.GetCenter();
            GameObject go = PrimeObject(map, boundary, localOrigin, name, mat);

            List<Vector3> outline = GetLocalVectors(boundary.Nodes, localOrigin);

            go.GetComponent<MeshFilter>().mesh = MeshBuilder.SolidMeshFromOutline(outline, height * buildingHeightMultiplier);
            return go;
        }

        GameObject PrimeObject(Map map, Way boundary, Vector3 localOrigin, string name, Material mat)
        {
            GameObject go = new GameObject();
            go.name = name;
            go.transform.position = localOrigin - map.Bounds.Center;

            MeshRenderer mr = go.AddComponent<MeshRenderer>();
            MeshFilter mf = go.AddComponent<MeshFilter>();
            mr.material = mat;
            return go;
        }

        List<Vector3> GetLocalVectors(List<Node> nodes, Vector3 localOrigin)
        {
            List<Vector3> vectors = new List<Vector3>();
            foreach (Node node in nodes)
            {
                vectors.Add(node - localOrigin);
            }
            return vectors;
        }

        void primeMaterials()
        {
            buildingMaterial = CreateMaterial(Shader.Find("Standard"), "_Color", building, "Buildings");
            campusBuildingMaterial = CreateMaterial(Shader.Find("Standard"), "_Color", campusBuilding, "CampusBuildings");
            greeneryMaterial = CreateMaterial(Shader.Find("Standard"), "_Color", greenery, "Greenery");
            waterMaterial = CreateMaterial(Shader.Find("Standard"), "_Color", water, "Water");
            groundMaterial = CreateMaterial(Shader.Find("Standard"), "_Color", ground, "Ground");
            roadMaterial = CreateMaterial(Shader.Find("Standard"), "_Color", road, "Roads");
        }

        Material CreateMaterial(Shader shader, string colorKey, Color color, string name)
        {
            Material material = new Material(shader);
            material.SetColor(colorKey, color);
            material.name = name;
            return material;
        }
    }
}
