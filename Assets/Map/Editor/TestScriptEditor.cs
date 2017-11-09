using UnityEditor;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace Maps
{
    [CustomEditor(typeof(TestScript))]
    class TestScriptEditor : Editor
    {
        public override void OnInspectorGUI()
        {
            DrawDefaultInspector();

            TestScript test = (TestScript)target;
            if (GUILayout.Button("Show Area"))
            {
                test.Test();
            }
        }
    }
}
