using UnityEditor;
using UnityEngine;

namespace Maps
{
    [CustomEditor(typeof(MapGenerator))]
    class MapGeneratorEditor : Editor
    {
        public override void OnInspectorGUI()
        {
            DrawDefaultInspector();

            MapGenerator generator = (MapGenerator)target;
            if (GUILayout.Button("Generate Map"))
            {
                generator.GenerateMap();
            }
        }
    }
}
