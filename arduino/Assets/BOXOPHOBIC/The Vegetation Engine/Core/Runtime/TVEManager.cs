// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using Boxophobic.StyledGUI;
using System.Collections.Generic;

#if UNITY_EDITOR
using UnityEditor.SceneManagement;
#endif

namespace TheVegetationEngine
{
    [ExecuteInEditMode]
    public class TVEManager : StyledMonoBehaviour
    {
        public static TVEManager Instance;

        [StyledBanner(0.890f, 0.745f, 0.309f, "The Vegetation Engine", "", "https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.hbq3w8ae720x")]
        public bool styledBanner;

        int assetVersion = 200;
        [HideInInspector]
        public int userVersion;

        [HideInInspector]
        public bool isInitialized = false;

        [HideInInspector]
        public TVEGlobalMotion globalMotion;
        [HideInInspector]
        public TVEGlobalShading globalShading;
        [HideInInspector]
        public TVEGlobalSeasons globalSeasons;
        [HideInInspector]
        public TVEGlobalOverlay globalOverlay;
        [HideInInspector]
        public TVEGlobalWetness globalWetness;
        [HideInInspector]
        public TVEGlobalSizeFade globalSizeFade;
        [HideInInspector]
        public TVEGlobalVolume globalVolume;

#if !UNITY_2019_3_OR_NEWER
        [StyledSpace(5)]
        public bool styledSpace0;
#endif

        void OnEnable()
        {
            Instance = this;

            if (globalMotion == null)
            {
                GameObject go = new GameObject();

                go.AddComponent<MeshFilter>();
                go.GetComponent<MeshFilter>().mesh = Resources.Load<Mesh>("ArrowMesh");

                go.AddComponent<MeshRenderer>();
                go.GetComponent<MeshRenderer>().sharedMaterial = Resources.Load<Material>("ArrowMotion");

                go.AddComponent<TVEGlobalMotion>();

                SetParent(go);

                go.transform.localPosition = new Vector3(0, 2f, 0);

                globalMotion = go.GetComponent<TVEGlobalMotion>();
                globalMotion.enabled = true;
            }

            if (globalShading == null)
            {
                GameObject go = new GameObject();
                go.AddComponent<TVEGlobalShading>();
                SetParent(go);

                globalShading = go.GetComponent<TVEGlobalShading>();

                SetGlobalLightingMainLight();
            }

            if (globalSeasons == null)
            {
                GameObject go = new GameObject();
                go.AddComponent<TVEGlobalSeasons>();
                SetParent(go);

                globalSeasons = go.GetComponent<TVEGlobalSeasons>();
            }

            if (globalOverlay == null)
            {
                GameObject go = new GameObject();
                go.AddComponent<TVEGlobalOverlay>();

                SetParent(go);

                globalOverlay = go.GetComponent<TVEGlobalOverlay>();
            }

            if (globalWetness == null)
            {
                GameObject go = new GameObject();
                go.AddComponent<TVEGlobalWetness>();
                SetParent(go);

                globalWetness = go.GetComponent<TVEGlobalWetness>();
            }

            if (globalSizeFade == null)
            {
                GameObject go = new GameObject();
                go.AddComponent<TVEGlobalSizeFade>();
                SetParent(go);

                globalSizeFade = go.GetComponent<TVEGlobalSizeFade>();
            }

            if (globalVolume == null)
            {
                GameObject go = new GameObject();
                go.AddComponent<TVEGlobalVolume>();
                SetParent(go);

                go.transform.localScale = new Vector3(200, 200, 200);

                globalVolume = go.GetComponent<TVEGlobalVolume>();
                globalVolume.globalMotion = globalMotion.gameObject;

                SetGlobalVolumeDefaultBuffers();
            }

            if (isInitialized == false)
            {
                Debug.Log("[The Vegetation Engine] " + "The Vegetation Engine is set in the current scene! Check the Documentation for the next steps!");
                userVersion = assetVersion;
                isInitialized = true;
            }

            if (userVersion < 150)
            {
                UpgradeTo150();
            }

            if (userVersion < 200)
            {
                UpgradeTo200();
            }
        }

        void Start()
        {
            if (userVersion < 150)
            {
                userVersion = 150;
#if UNITY_EDITOR
                Debug.Log("[The Vegetation Engine] The Scene Manager has been ugraded to 1.5.0!");

                if (Application.isPlaying == false)
                {
                    EditorSceneManager.MarkSceneDirty(EditorSceneManager.GetActiveScene());
                }
#endif
            }

            if (userVersion < 200)
            {
                userVersion = 200;
#if UNITY_EDITOR
                Debug.Log("[The Vegetation Engine] The Scene Manager has been ugraded to 2.0.0!");

                if (Application.isPlaying == false)
                {
                    EditorSceneManager.MarkSceneDirty(EditorSceneManager.GetActiveScene());
                }
#endif
            }
        }

        //void Update()
        //{
        //    if (gameObject.name != "The Vegetation Engine")
        //    {
        //        gameObject.name = "The Vegetation Engine";
        //    }
        //}

        void SetParent(GameObject go)
        {
            go.transform.parent = gameObject.transform;
            go.transform.localPosition = Vector3.zero;
            go.transform.eulerAngles = Vector3.zero;
            go.transform.localScale = Vector3.one;
        }

        void SetParentAndYOffset(GameObject go)
        {
            go.transform.parent = gameObject.transform;
            go.transform.localPosition = new Vector3(0, 25, 0);
            go.transform.eulerAngles = Vector3.zero;
            go.transform.localScale = Vector3.one;
        }

        void SetGlobalVolumeDefaultBuffers()
        {
            globalVolume.volumeBuffers = new List<TVEVolumeData>();
            globalVolume.volumeBuffers.Add(Resources.Load<TVEVolumeData>("Default Colors Buffer"));
            globalVolume.volumeBuffers.Add(Resources.Load<TVEVolumeData>("Default Extras Buffer"));
            globalVolume.volumeBuffers.Add(Resources.Load<TVEVolumeData>("Default Motion Buffer"));
        }

        void SetGlobalLightingMainLight()
        {
            var allLights = FindObjectsOfType<Light>();
            var intensity = 0.0f;

            for (int i = 0; i < allLights.Length; i++)
            {
                if (allLights[i].type == LightType.Directional)
                {
                    if (allLights[i].intensity > intensity)
                    {
                        globalShading.mainLight = allLights[i];
                    }
                }
            }
        }

        void UpgradeTo150()
        {
            // Update elements to the new save system
            var elements = FindObjectsOfType<TVEElement>();

            for (int i = 0; i < elements.Length; i++)
            {
                var data = elements[i].data;

                if (data != null)
                {
                    if (data.elementShader != null)
                    {
                        var materialData = new TVEElementMaterialData();
                        materialData.props = new List<TVEElementPropertyData>();

                        materialData.shader = data.elementShader;

                        materialData.props.Add(new TVEElementPropertyData(PropertyType.Value, "_ElementIntensity", data.elementIntensity));
                        materialData.props.Add(new TVEElementPropertyData(PropertyType.Value, "_ElementMode", data.elementMode));

                        materialData.props.Add(new TVEElementPropertyData(PropertyType.Texture, "_MainTex", data.mainTex));
                        materialData.props.Add(new TVEElementPropertyData(PropertyType.Vector, "_MainUVs", data.mainUVs));

                        materialData.props.Add(new TVEElementPropertyData(PropertyType.Vector, "_MainColor", data.main));
                        materialData.props.Add(new TVEElementPropertyData(PropertyType.Vector, "_MainColorHDR", data.main));
                        materialData.props.Add(new TVEElementPropertyData(PropertyType.Vector, "_WinterColor", data.winter));
                        materialData.props.Add(new TVEElementPropertyData(PropertyType.Vector, "_SpringColor", data.spring));
                        materialData.props.Add(new TVEElementPropertyData(PropertyType.Vector, "_SummerColor", data.summer));
                        materialData.props.Add(new TVEElementPropertyData(PropertyType.Vector, "_AutumnColor", data.autumn));

                        materialData.props.Add(new TVEElementPropertyData(PropertyType.Value, "_MainValue", data.main.w));
                        materialData.props.Add(new TVEElementPropertyData(PropertyType.Value, "_WinterValue", data.winter.w));
                        materialData.props.Add(new TVEElementPropertyData(PropertyType.Value, "_SpringValue", data.spring.w));
                        materialData.props.Add(new TVEElementPropertyData(PropertyType.Value, "_SummerValue", data.summer.w));
                        materialData.props.Add(new TVEElementPropertyData(PropertyType.Value, "_AutumnValue", data.autumn.w));

                        elements[i].materialData = materialData;
                    }
                }
            }
        }

        void UpgradeTo200()
        {
            if (globalVolume.volumeBuffers == null || globalVolume.volumeBuffers.Count == 0)
            {
                SetGlobalVolumeDefaultBuffers();
            }

            if (globalShading.mainLight == null)
            {
                SetGlobalLightingMainLight();
            }

            var elements = FindObjectsOfType<TVEElement>();

            for (int i = 0; i < elements.Length; i++)
            {
                var data = elements[i].materialData;

                if (data != null)
                {
                    if (data.props != null)
                    {
                        for (int p = 0; p < data.props.Count; p++)
                        {
                            var prop = data.props[p];

                            if (prop.prop == "_WinterColor")
                            {
                                prop.prop = "_AdditionalColor1";
                            }

                            if (prop.prop == "_SpringColor")
                            {
                                prop.prop = "_AdditionalColor2";
                            }

                            if (prop.prop == "_SummerColor")
                            {
                                prop.prop = "_AdditionalColor3";
                            }

                            if (prop.prop == "_AutumnColor")
                            {
                                prop.prop = "_AdditionalColor4";
                            }

                            if (prop.prop == "_WinterValue")
                            {
                                prop.prop = "_AdditionalValue1";
                            }

                            if (prop.prop == "_SpringValue")
                            {
                                prop.prop = "_AdditionalValue2";
                            }

                            if (prop.prop == "_SummerValue")
                            {
                                prop.prop = "_AdditionalValue3";
                            }

                            if (prop.prop == "_AutumnValue")
                            {
                                prop.prop = "_AdditionalValue4";
                            }
                        }
                    }
                }
            }
        }
    }
}