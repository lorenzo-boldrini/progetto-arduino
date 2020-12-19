// Cristian Pop - https://boxophobic.com/

using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;

namespace TheVegetationEngine
{
    public class TVEMenuCreate
    {
        [MenuItem("GameObject/BOXOPHOBIC/The Vegetation Engine/Manager", false, 9)]
        static void CreateManager()
        {
            if (GameObject.Find("The Vegetation Engine") != null)
            {
                Debug.Log("[Warning][The Vegetation Engine] " + "The Vegetation Engine Manager is already set in your scene!");
                return;
            }

            GameObject manager = new GameObject();
            manager.AddComponent<TVEManager>();
            manager.name = "The Vegetation Engine";

            EditorSceneManager.MarkSceneDirty(EditorSceneManager.GetActiveScene());
        }

        [MenuItem("GameObject/BOXOPHOBIC/The Vegetation Engine/Element", false, 9)]
        static void CreateElement()
        {
            if (GameObject.Find("The Vegetation Engine") == null)
            {
                Debug.Log("[Warning][The Vegetation Engine] " + "The Vegetation Engine manager is missing from your scene. Make sure setup it up first!");
                return;
            }

            GameObject element = MonoBehaviour.Instantiate(Resources.Load<GameObject>("Internal Element"));

            var sceneCamera = SceneView.lastActiveSceneView.camera;

            if (sceneCamera != null)
            {
                element.transform.position = sceneCamera.ViewportToWorldPoint(new Vector3(0.5f, 0.5f, 10f));
            }
            else
            {
                element.transform.localPosition = Vector3.zero;
                element.transform.localEulerAngles = Vector3.zero;
                element.transform.localScale = Vector3.one;
            }

            if (Selection.activeGameObject != null)
            {
                element.transform.parent = Selection.activeGameObject.transform;
            }

            if (EditorSceneManager.IsPreviewSceneObject(element))
            {
                Debug.Log("[Warning][The Vegetation Engine] " + "Elements cannot be created inside prefabs");
            }
            else
            {
                element.name = "Element";
                element.AddComponent<TVEElement>();
            }

            Selection.activeGameObject = element;

            EditorSceneManager.MarkSceneDirty(EditorSceneManager.GetActiveScene());
        }

        //[MenuItem("GameObject/BOXOPHOBIC/The Vegetation Engine/Link", false, 9)]
        //static void CreateLink()
        //{
        //    GameObject link = new GameObject();
        //    link.AddComponent<TVELink>();

        //    if (Selection.activeGameObject != null)
        //    {
        //        link.transform.parent = Selection.activeGameObject.transform;
        //        link.transform.localPosition = Vector3.zero;
        //        link.transform.localEulerAngles = Vector3.zero;
        //        link.transform.localScale = Vector3.one;
        //    }

        //    Selection.activeGameObject = link;

        //    EditorSceneManager.MarkSceneDirty(EditorSceneManager.GetActiveScene());
        //}
    }
}
