//Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;

namespace TheVegetationEngine
{
    [CanEditMultipleObjects]
    [CustomEditor(typeof(TVEPrefab))]
    public class TVEPrefabInspector : Editor
    {
        private static readonly string excludeProps = "m_Script";

        public override void OnInspectorGUI()
        {
            DrawInspector();

            if (PrefabUtility.HasPrefabInstanceAnyOverrides(Selection.activeGameObject, false))
            {
                EditorGUILayout.HelpBox("Prefab Instance has overrides. The Vegetation Engine works on the prefab root level and not on individual prefab instances. Make sure to apply/revert all overrides to avoid any issues. Transform overrides can be ignored.", MessageType.Warning);
                GUILayout.Space(10);
            }

            GUILayout.BeginHorizontal();

            if (GUILayout.Button("Open Prefab Converter"/*, GUILayout.Width(160)*/))
            {
                TVEPrefabConverter window = EditorWindow.GetWindow<TVEPrefabConverter>(false, "Prefab Converter", true);
                window.minSize = new Vector2(480, 280);
                window.Show();
            }

            if (GUILayout.Button("Open Prefab Settings"/*, GUILayout.Width(160)*/))
            {
                TVEPrefabSettings window = EditorWindow.GetWindow<TVEPrefabSettings>(false, "Prefab Settings", true);
                window.minSize = new Vector2(389, 200);
                window.Show();         
            }

            GUILayout.EndHorizontal();

            GUILayout.Space(5);
        }

        void DrawInspector()
        {
            serializedObject.Update();

            DrawPropertiesExcluding(serializedObject, excludeProps);

            serializedObject.ApplyModifiedProperties();
        }
    }
}


