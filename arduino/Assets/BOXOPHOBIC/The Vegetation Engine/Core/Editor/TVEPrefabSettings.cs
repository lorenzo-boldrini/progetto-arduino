// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using System.Collections.Generic;
using Boxophobic.StyledGUI;
using System.Globalization;
using System.IO;

namespace TheVegetationEngine
{
    public class TVEPrefabSettings : EditorWindow
    {
        const int SPACE_DEFAULT = 10;
        const int SPACE_SMALL = 3;
        const int GUI_WIDTH = 200;
        const int GUI_HEIGHT = 18;
        const int GUI_MESH = 24;

        float GUI_HALF_WIDTH = 200;

        string[] materialOptions = new string[]
        {
        "All", "Motion", "Shading", "Globals", "Subsurface", "Main", "Detail", "Gradient and Noise", "Billboard and Perspective",
        };

        string[] savingOptions = new string[]
        {
        "Save All Settings", "Save Current Settings",
        };

        List<TVEMaterialData> materialData = new List<TVEMaterialData>
        {

        };

        List<TVEMaterialData> saveData = new List<TVEMaterialData>
        {

        };

        List<TVEMaterialData> motionData = new List<TVEMaterialData>
        {
            new TVEMaterialData("_MotionHighlightColor", "Motion Highlight", new Color(-100, 0,0,0), true, true),

            new TVEMaterialData("_MotionAmplitude_10", "Bending Amplitude", -100, 0, 2, false, true),
            new TVEMaterialData("_MotionSpeed_10", "Bending Speed", -100, 0, 60, true, false),
            new TVEMaterialData("_MotionScale_10", "Bending Scale", -100, 0, 20, false, false),
            new TVEMaterialData("_MotionVariation_10", "Bending Variation", -100, 0, 20, false, false),

            new TVEMaterialData("_MotionAmplitude_20", "Rolling Amplitude", -100, 0, 2, false, true),
            new TVEMaterialData("_MotionSpeed_20", "Rolling Speed", -100, 0, 60, true, false),
            new TVEMaterialData("_MotionScale_20", "Rolling Scale", -100, 0, 20, false, false),
            new TVEMaterialData("_MotionVariation_20", "Rolling Variation", -100, 0, 20, false, false),

            new TVEMaterialData("_MotionAmplitude_30", "Leaves Amplitude", -100, 0, 2, false, true),
            new TVEMaterialData("_MotionSpeed_30", "Leaves Speed", -100, 0, 60, true, false),
            new TVEMaterialData("_MotionScale_30", "Leaves Scale", -100, 0, 20, false, false),
            new TVEMaterialData("_MotionVariation_30", "Leaves Variation", -100, 0, 20, false, false),

            new TVEMaterialData("_MotionAmplitude_32", "Flutter Amplitude", -100, 0, 2, false, true),
            new TVEMaterialData("_MotionSpeed_32", "Flutter Speed", -100, 0, 60, true, false),
            new TVEMaterialData("_MotionScale_32", "Flutter Scale", -100, 0, 20, false, false),
            new TVEMaterialData("_MotionVariation_32", "Flutter Variation", -100, 0, 20, false, false),

            new TVEMaterialData("_InteractionAmplitude", "Interaction Amplitude", -100, 0, 10, false, true),
            new TVEMaterialData("_InteractionVariation", "Interaction Variation", -100, 0, 1, false, false),
        };

        List<TVEMaterialData> globalData = new List<TVEMaterialData>
        {
            new TVEMaterialData("_GlobalColors", "Global Colors", -100, 0, 1, false, true),
            new TVEMaterialData("_GlobalOverlay", "Global Overlay", -100, 0, 1, false, false),
            new TVEMaterialData("_GlobalWetness", "Global Wetness", -100, 0, 1, false, false),
            new TVEMaterialData("_GlobalLeaves", "Global Leaves", -100, 0, 1, false, false),
            new TVEMaterialData("_GlobalHealthiness", "Global Healthiness", -100, 0, 1, false, false),
            new TVEMaterialData("_GlobalSize", "Global Size", -100, 0, 1, false, false),
            new TVEMaterialData("_GlobalSizeFade", "Global Size Fade", -100, 0, 1, false, false),

            new TVEMaterialData("_ColorsMaskValue", "Colors Use Mask", -100, 0, 1, false, true),
            new TVEMaterialData("_OverlayContrastValue", "Overlay Contrast", -100, 0, 10, false, false),
            new TVEMaterialData("_OverlayVariationValue", "Overlay Variation", -100, 0, 1, false, false),
            new TVEMaterialData("_LeavesVariationValue", "Leaves Variation", -100, 0, 1, false, false),
        };

        List<TVEMaterialData> subsurfaceData = new List<TVEMaterialData>
        {
            new TVEMaterialData("_SubsurfaceValue", "Subsurface Intensity", -100, 0, 1, false, true),

            new TVEMaterialData("_SubsurfaceColor", "Subsurface Color", new Color(-100, 0,0,0), true, true),
            new TVEMaterialData("_SubsurfaceViewValue", "Subsurface View", -100, 0, 8, false, false),
            new TVEMaterialData("_SubsurfaceAngleValue", "Subsurface Angle", -100, 0, 16, false, false),
            new TVEMaterialData("_SubsurfaceMaskValue", "Subsurface Use Mask", -100, 0, 1, false, false),
            new TVEMaterialData("_SubsurfaceLightValue", "Subsurface Use Light", -100, 0, 1, false, false),
        };

        List<TVEMaterialData> mainData = new List<TVEMaterialData>
        {
            new TVEMaterialData("_RenderCutoff", "Alpha Treshold", -100, 0, 1, false, true),

            new TVEMaterialData("_MainColor", "Main Color", new Color(-100, 0,0,0), true, true),
            new TVEMaterialData("_MainNormalValue", "Main Normal", -100, -8, 8, false, false),
            new TVEMaterialData("_MainMetallicValue", "Main Metallic", -100, 0, 1, false, false),
            new TVEMaterialData("_MainOcclusionValue", "Main Occlusion", -100, 0, 1, false, false),
            new TVEMaterialData("_MainSmoothnessValue", "Main Smoothness", -100, 0, 1, false, false),

            new TVEMaterialData("_MainMaskMinValue", "Main Mask Min", -100, 0, 1, false, true),
            new TVEMaterialData("_MainMaskMaxValue", "Main Mask Max", -100, 0, 1, false, false),

            new TVEMaterialData("_VertexOcclusionColor", "Vertex Occlusion Color", new Color(-100, 0,0,0), true, true),
            new TVEMaterialData("_VertexOcclusionValue", "Vertex Occlusion Power", -100, 0, 8, false, false),
        };

        List<TVEMaterialData> secondData = new List<TVEMaterialData>
        {
            new TVEMaterialData("_SecondColor", "Detail Color", new Color(-100, 0,0,0), true, true),
            new TVEMaterialData("_SecondNormalValue", "Detail Normal", -100, -8, 8, false, false),
            new TVEMaterialData("_SecondMetallicValue", "Detail Metallic", -100, 0, 1, false, false),
            new TVEMaterialData("_SecondOcclusionValue", "Detail Occlusion", -100, 0, 1, false, false),
            new TVEMaterialData("_SecondSmoothnessValue", "Detail Smoothness", -100, 0, 1, false, false),

            new TVEMaterialData("_DetailNormalValue", "Detail Use Main Normal", -100, 0, 1, false, true),

            new TVEMaterialData("_DetailMeshValue", "Detail Mask Offset", -100, -1, 1, false, true),
            new TVEMaterialData("_DetailMaskValue", "Detail Mask Power", -100, -1, 1, false, false),
            new TVEMaterialData("_DetailMaskContrast", "Detail Mask Contrast", -100, 0, 1, false, false),
        };

        List<TVEMaterialData> gradientAndNoiseData = new List<TVEMaterialData>
        {
            new TVEMaterialData("_GradientColorOne", "Gradient Color One", new Color(-100, 0,0,0), true, true),
            new TVEMaterialData("_GradientColorTwo", "Gradient Color Two", new Color(-100, 0,0,0), true, false),
            new TVEMaterialData("_GradientMinValue", "Gradient Mask Min", -100, 0, 1, false, false),
            new TVEMaterialData("_GradientMaxValue", "Gradient Mask Max", -100, 0, 1, false, false),

            new TVEMaterialData("_NoiseScaleValue", "Noise Scale", -100, 0, 10, false, true),
            new TVEMaterialData("_NoiseMinValue", "Noise Min", -100, 0, 1, false, false),
            new TVEMaterialData("_NoiseMaxValue", "Noise Max", -100, 0, 1, false, false),

            new TVEMaterialData("_NoiseTintOne", "Noise Tint One", new Color(-100, 0,0,0), true, true),
            new TVEMaterialData("_NoiseTintTwo", "Noise Tint Two", new Color(-100, 0,0,0), true, false),
        };

        List<TVEMaterialData> billboardAndGrassData = new List<TVEMaterialData>
        {
            new TVEMaterialData("_BillboardFadeHValue", "Billboard Fade Horizontal", -100, 0, 4, false, true),
            new TVEMaterialData("_BillboardFadeVValue", "Billboard Fade Vertical", -100, 0, 4, false, false),

            new TVEMaterialData("_PerspectivePushValue", "Perspective Push", -100, 0, 4, false, true),
            new TVEMaterialData("_PerspectiveNoiseValue", "Perspective Noise", -100, 0, 4, false, false),
            new TVEMaterialData("_PerspectiveAngleValue", "Perspective Angle", -100, 0, 8, false, false),
        };

        List<GameObject> prefabObjects = new List<GameObject>();
        List<Material> prefabMaterials = new List<Material>();

        string[] allPresetPaths;
        List<string> presetPaths;
        List<string> presetLines;
        string[] presetOptions;

        int presetIndex;
        int settingsIndex = 1;
        int settingsIndexOld = -1;
        int savingIndex = 1;
        string savePath = "";

        bool isValid = true;
        bool useProceduralVariation = false;
        bool showSelectedPrefabs = true;

        float windPower = 4.0f;
        TVEGlobalMotion globalMotion;

        GUIStyle stylePopup;
        GUIStyle styleCenteredHelpBox;
        GUIStyle styleCenteredMiniLabel;

        Color bannerColor;
        string bannerText;
        string helpURL;
        static TVEPrefabSettings window;
        Vector2 scrollPosition = Vector2.zero;

        [MenuItem("Window/BOXOPHOBIC/The Vegetation Engine/Prefab Settings", false, 1002)]
        public static void ShowWindow()
        {
            window = GetWindow<TVEPrefabSettings>(false, "Prefab Settings", true);
            window.minSize = new Vector2(389, 300);
        }

        void OnEnable()
        {
            bannerColor = new Color(0.890f, 0.745f, 0.309f);
            bannerText = "Prefab Settings";
            helpURL = "https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.161s3m1jg4ul";

            if (GameObject.Find("The Vegetation Engine") == null)
            {
                isValid = false;
                Debug.Log("[Warning][The Vegetation Engine] " + "The Vegetation Engine manager is missing from your scene. Make sure setup it up first and the reopen the Prefab Settings!");
            }

            OverrideWind();

            materialData = new List<TVEMaterialData>();
            materialData.AddRange(motionData);
            materialData.AddRange(globalData);
            materialData.AddRange(subsurfaceData);
            materialData.AddRange(mainData);
            materialData.AddRange(secondData);
            materialData.AddRange(gradientAndNoiseData);
            materialData.AddRange(billboardAndGrassData);


            GetPresets();
            GetPresetOptions();
        }

        void OnSelectionChange()
        {
            Initialize();
            Repaint();
        }

        void OnFocus()
        {
            Initialize();
            Repaint();
            OverrideWind();
        }

        void OnLostFocus()
        {
            ResetWind();
        }

        void OnDisable()
        {
            ResetWind();
        }

        void OnGUI()
        {
            SetGUIStyles();

            GUI_HALF_WIDTH = this.position.width / 2.0f - 24;

            StyledGUI.DrawWindowBanner(bannerColor, bannerText, helpURL);

            GUILayout.BeginHorizontal();
            GUILayout.Space(15);

            GUILayout.BeginVertical();

            GUILayout.Space(-2);

            if (isValid && prefabObjects.Count > 0)
            {
                EditorGUILayout.HelpBox("Move the slider to owerride the Mixed values for prefabs with different material settings. Please note that Undo is not supported for the Prefab Settings window!", MessageType.Info, true);

                if (useProceduralVariation)
                {
                    EditorGUILayout.HelpBox("Procedural variation detected! Use the Scale settings if the Variation is breaking the bending and rolling animation!", MessageType.Warning, true);
                }
            }
            else
            {
                if (isValid == false)
                {
                    EditorGUILayout.HelpBox("The Vegetation Engine manager is missing from your scene. Make sure setup it up first and the reopen the Prefab Converter!", MessageType.Warning, true);
                }
                else if (prefabObjects.Count == 0)
                {
                    EditorGUILayout.HelpBox("Select a prefab or multiple prefabs to get started!", MessageType.Info, true);
                }
            }

            scrollPosition = GUILayout.BeginScrollView(scrollPosition, false, false, GUILayout.Width(this.position.width - 28), GUILayout.Height(this.position.height - 200));

            if (isValid == false || prefabObjects.Count == 0)
            {
                GUI.enabled = false;
            }

            DrawWindPower();

            SetGlobalShaderProperties();

            if (TVEManager.Instance == null)
            {
                globalMotion = TVEManager.Instance.globalMotion;
            }

            if (prefabObjects.Count > 0)
            {
                GUILayout.Space(5);
            }

            DrawPrefabObjects();

            GUILayout.Space(15);

            presetIndex = StyledPopup("Material Preset", presetIndex, presetOptions);

            if (presetIndex > 0)
            {
                GetPresetLines();

                for (int i = 0; i < prefabMaterials.Count; i++)
                {
                    var material = prefabMaterials[i];

                    GetMaterialConversionFromPreset(material);
                    TVEShaderUtils.SetRenderSettings(material);
                }

                materialData = new List<TVEMaterialData>();
                materialData.AddRange(motionData);
                materialData.AddRange(globalData);
                materialData.AddRange(subsurfaceData);
                materialData.AddRange(mainData);
                materialData.AddRange(secondData);
                materialData.AddRange(gradientAndNoiseData);
                materialData.AddRange(billboardAndGrassData);

                GetInitMaterialProperties();
                GetMaterialProperties();

                presetIndex = 0;
                settingsIndexOld = -1;
            }

            settingsIndex = StyledPopup("Material Settings", settingsIndex, materialOptions);

            if (settingsIndexOld != settingsIndex)
            {
                materialData = new List<TVEMaterialData>();

                if (settingsIndex == 0)
                {
                    materialData.AddRange(motionData);
                    materialData.AddRange(globalData);
                    materialData.AddRange(subsurfaceData);
                    materialData.AddRange(mainData);
                    materialData.AddRange(secondData);
                    materialData.AddRange(gradientAndNoiseData);
                    materialData.AddRange(billboardAndGrassData);
                }
                else if (settingsIndex == 1)
                {
                    materialData = motionData;
                }
                else if (settingsIndex == 2)
                {
                    materialData.AddRange(globalData);
                    materialData.AddRange(subsurfaceData);
                    materialData.AddRange(mainData);
                    materialData.AddRange(secondData);
                    materialData.AddRange(gradientAndNoiseData);
                    materialData.AddRange(billboardAndGrassData);
                }
                else if (settingsIndex == 3)
                {
                    materialData = globalData;
                }
                else if (settingsIndex == 4)
                {
                    materialData = subsurfaceData;
                }
                else if (settingsIndex == 5)
                {
                    materialData = mainData;
                }
                else if (settingsIndex == 6)
                {
                    materialData = secondData;
                }
                else if (settingsIndex == 7)
                {
                    materialData = gradientAndNoiseData;
                }
                else if (settingsIndex == 8)
                {
                    materialData = billboardAndGrassData;
                }

                settingsIndexOld = settingsIndex;
            }

            for (int i = 0; i < materialData.Count; i++)
            {
                if (materialData[i].type == TVEMaterialData.PropertyType.Range)
                {
                    materialData[i].value = StyledSlider(materialData[i].name, materialData[i].value, materialData[i].min, materialData[i].max, materialData[i].snap, materialData[i].space);
                }
                else if (materialData[i].type == TVEMaterialData.PropertyType.Color)
                {
                    materialData[i].color = StyledColor(materialData[i].name, materialData[i].color, materialData[i].hdr, materialData[i].space);
                }
            }

            GUILayout.Space(10);

            SavePreset();

            SetMaterialProperties();

            GUILayout.EndScrollView();

            GUILayout.EndVertical();

            GUILayout.Space(13);
            GUILayout.EndHorizontal();
        }

        void SetGUIStyles()
        {
            stylePopup = new GUIStyle(EditorStyles.popup)
            {
                alignment = TextAnchor.MiddleCenter
            };

            styleCenteredHelpBox = new GUIStyle(GUI.skin.GetStyle("HelpBox"))
            {
                richText = true,
                alignment = TextAnchor.MiddleCenter,
            };

            styleCenteredMiniLabel = new GUIStyle(EditorStyles.label)
            {
                richText = true,
                alignment = TextAnchor.MiddleCenter,
                fontStyle = FontStyle.Bold
            };
        }

        void DrawWindPower()
        {
            GUIStyle styleMid = new GUIStyle();
            styleMid.alignment = TextAnchor.MiddleCenter;
            styleMid.normal.textColor = Color.gray;
            styleMid.fontSize = 7;

            GUILayout.Space(10);

            //GUILayout.Label("Wind Power (for testing only)");

            GUILayout.BeginHorizontal();
            GUILayout.Space(8);
            windPower = GUILayout.HorizontalSlider(windPower, 0, 1);

            GUILayout.Space(8);
            GUILayout.EndHorizontal();

            int maxWidth = 20;

#if UNITY_2019_3_OR_NEWER
            GUILayout.Space(15);
#endif

            GUILayout.BeginHorizontal();
            GUILayout.Space(2);
            GUILayout.Label("Calm", styleMid, GUILayout.Width(maxWidth));
            GUILayout.Label("", styleMid);
            GUILayout.Label("Windy", styleMid, GUILayout.Width(maxWidth));
            GUILayout.Label("", styleMid);
            GUILayout.Label("Strong", styleMid, GUILayout.Width(maxWidth));
            GUILayout.Space(7);
            GUILayout.EndHorizontal();
        }

        void DrawPrefabObjects()
        {
            if (prefabObjects.Count > 0)
            {
                GUILayout.Space(10);
            }

            if (showSelectedPrefabs)
            {
                if (StyledButton("▼ Hide Prefab Selection"))
                    showSelectedPrefabs = !showSelectedPrefabs;
            }
            else
            {
                if (StyledButton("► Show Prefab Selection"))
                    showSelectedPrefabs = !showSelectedPrefabs;
            }
            if (showSelectedPrefabs)
            {
                for (int i = 0; i < Selection.gameObjects.Length; i++)
                {
                    StyledGameObject(i, prefabObjects);
                }
            }
        }

        void StyledGameObject(int index, List<GameObject> gameObjects)
        {
            if (gameObjects.Count > index)
            {
                if (gameObjects[index].GetComponent<TVEPrefab>() == null)
                {
                    if (EditorGUIUtility.isProSkin)
                    {
                        if (GUILayout.Button("<b><color=#7dacf1>" + gameObjects[index].name + "</color></b>", styleCenteredHelpBox, GUILayout.Height(GUI_MESH)))
                        {
                            EditorGUIUtility.PingObject(gameObjects[index].gameObject);
                        }                        
                    }
                    else
                    {
                        if (GUILayout.Button("<b><color=#0b448b>" + gameObjects[index].name + "</color></b>", styleCenteredHelpBox, GUILayout.Height(GUI_MESH)))
                        {
                            EditorGUIUtility.PingObject(gameObjects[index].gameObject);
                        }                        
                    }
                }
                else
                {
                    if (EditorGUIUtility.isProSkin)
                    {
                        if (GUILayout.Button("<b><color=#e3be4f>" + gameObjects[index].name + "</color></b>", styleCenteredHelpBox, GUILayout.Height(GUI_MESH)))
                        {
                            EditorGUIUtility.PingObject(gameObjects[index].gameObject);
                        }
                    }
                    else
                    {
                        if (GUILayout.Button("<b><color=#e16f00>" + gameObjects[index].name + "</color></b>", styleCenteredHelpBox, GUILayout.Height(GUI_MESH)))
                        {
                            EditorGUIUtility.PingObject(gameObjects[index].gameObject);
                        }                        
                    }
                }
            }
        }

        int StyledPopup(string name, int index, string[] options)
        {
            if (index > options.Length)
            {
                index = 0;
            }

            GUILayout.BeginHorizontal();
            GUILayout.Label(name, GUILayout.MaxWidth(GUI_HALF_WIDTH));
            index = EditorGUILayout.Popup(index, options, stylePopup);
            GUILayout.EndHorizontal();

            return index;
        }

        float StyledSlider(string name, float val, float min, float max, bool snap, bool space)
        {
            if (space)
            {
                GUILayout.Space(10);
            }

            GUILayout.BeginHorizontal();

            GUILayout.Label(name, GUILayout.MaxWidth(GUI_HALF_WIDTH));

            float equalValue = val;
            float mixedValue = 0;

            if (val == -100)
            {
                mixedValue = GUILayout.HorizontalSlider(mixedValue, min, max);

                GUILayout.Label("<color=#7f7f7f><size=10>Mixed</size></color>", styleCenteredMiniLabel, GUILayout.MaxWidth(60), GUILayout.Height(GUI_HEIGHT));

                if (mixedValue != 0)
                {
                    val = mixedValue;
                }
            }
            else
            {
                equalValue = GUILayout.HorizontalSlider(equalValue, min, max);

                val = equalValue;

                float floatVal = EditorGUILayout.FloatField(val, GUILayout.MaxWidth(60));

                if (val != floatVal)
                {
                    val = Mathf.Clamp(floatVal, min, max);
                }
            }

            GUILayout.EndHorizontal();

            if (snap)
            {
                val = Mathf.Round(val);
            }
            else
            {
                val = Mathf.Round(val * 1000f) / 1000f;
            }

            return val;
        }

        bool StyledButton(string text)
        {
            bool value = GUILayout.Button("<b>" + text + "</b>", styleCenteredHelpBox, GUILayout.Height(GUI_MESH));

            return value;
        }

        Color StyledColor(string name, Color color, bool HDR, bool space)
        {
            if (space)
            {
                GUILayout.Space(10);
            }

            GUILayout.BeginHorizontal();

            GUILayout.Label(name, GUILayout.MaxWidth(GUI_HALF_WIDTH));

            GUILayout.Label("");

            if (HDR)
            {
                color = EditorGUILayout.ColorField(new GUIContent(""), color, true, true, true, GUILayout.MaxWidth(60));
            }
            else
            {
                color = EditorGUILayout.ColorField(color, GUILayout.MaxWidth(60));
            }

            GUILayout.EndHorizontal();

            return color;
        }

        void Initialize()
        {
            GetPrefabObjects();
            GetPrefabMaterials();
            GetInitMaterialProperties();
            GetMaterialProperties();
        }

        void GetPrefabObjects()
        {
            prefabObjects = new List<GameObject>();

            for (int i = 0; i < Selection.gameObjects.Length; i++)
            {
                var prefabRoot = GetPrefabObjectRoot(Selection.gameObjects[i]);

                if (prefabRoot != null && prefabObjects.Contains(prefabRoot) == false)
                {
                    //if (prefabRoot.GetComponent<TVEPrefab>() != null)
                    {
                        prefabObjects.Add(prefabRoot);
                    }
                }
            }
        }

        GameObject GetPrefabObjectRoot(GameObject selection)
        {
            GameObject prefabRoot = null;

            if (selection != null)
            {
                if (PrefabUtility.GetPrefabAssetPathOfNearestInstanceRoot(selection).Length > 0)
                {
                    var prefabPath = PrefabUtility.GetPrefabAssetPathOfNearestInstanceRoot(selection);
                    var prefabAsset = AssetDatabase.LoadAssetAtPath<GameObject>(prefabPath);

                    prefabRoot = prefabAsset;
                }
                else
                {
                    prefabRoot = null;
                }
            }

            return prefabRoot;
        }

        void GetPrefabMaterials()
        {
            // Get Materials on demand
            prefabMaterials = new List<Material>();

            var gameObjects = new List<GameObject>();
            var meshRenderers = new List<MeshRenderer>();

            for (int i = 0; i < prefabObjects.Count; i++)
            {
                gameObjects.Add(prefabObjects[i]);
                GetChildRecursive(prefabObjects[i], gameObjects);
            }

            for (int i = 0; i < gameObjects.Count; i++)
            {
                if (gameObjects[i].GetComponent<MeshRenderer>() != null)
                {
                    meshRenderers.Add(gameObjects[i].GetComponent<MeshRenderer>());
                }
            }

            for (int i = 0; i < meshRenderers.Count; i++)
            {
                if (meshRenderers[i].sharedMaterials != null)
                {
                    for (int j = 0; j < meshRenderers[i].sharedMaterials.Length; j++)
                    {
                        if (meshRenderers[i].sharedMaterials[j] != null)
                        {
                            if (meshRenderers[i].sharedMaterials[j].HasProperty("_IsTVEShader") || meshRenderers[i].sharedMaterials[j].HasProperty("_IsTVEEXTShader"))
                            {
                                prefabMaterials.Add(meshRenderers[i].sharedMaterials[j]);
                            }
                        }
                    }
                }
            }

            // Get Materials from Prefab
            //for (int i = 0; i < prefabObjects.Count; i++)
            //{
            //    prefabMaterials.AddRange(prefabObjects[i].GetComponent<TVEPrefab>().materials);
            //}
        }

        void GetChildRecursive(GameObject go, List<GameObject> gameObjects)
        {
            foreach (Transform child in go.transform)
            {
                if (child == null)
                    continue;

                gameObjects.Add(child.gameObject);
                GetChildRecursive(child.gameObject, gameObjects);
            }
        }

        void GetInitMaterialProperties()
        {
            if (prefabMaterials.Count > 0)
            {
                var material = prefabMaterials[0];

                for (int d = 0; d < materialData.Count; d++)
                {
                    if (materialData[d].type == TVEMaterialData.PropertyType.Range)
                    {
                        if (material.HasProperty(materialData[d].prop))
                        {
                            var value = material.GetFloat(materialData[d].prop);

                            materialData[d].value = value;
                        }
                    }
                    else if (materialData[d].type == TVEMaterialData.PropertyType.Color)
                    {
                        if (material.HasProperty(materialData[d].prop))
                        {
                            var color = material.GetColor(materialData[d].prop);

                            materialData[d].color = color;
                        }
                    }
                }

                if (material.HasProperty("_VertexVariationMode") && material.GetInt("_VertexVariationMode") == 1)
                {
                    useProceduralVariation = true;
                }
                else
                {
                    useProceduralVariation = false;
                }
            }
            else
            {
                for (int d = 0; d < materialData.Count; d++)
                {
                    if (materialData[d].type == TVEMaterialData.PropertyType.Range)
                    {
                        materialData[d].value = -100;
                    }
                    else if (materialData[d].type == TVEMaterialData.PropertyType.Color)
                    {
                        materialData[d].color = new Color(-100f, 0, 0, 0);
                    }
                }
            }
        }

        void GetMaterialProperties()
        {
            for (int i = 0; i < prefabMaterials.Count; i++)
            {
                var material = prefabMaterials[i];

                for (int d = 0; d < materialData.Count; d++)
                {
                    if (material.HasProperty(materialData[d].prop))
                    {
                        if (materialData[d].type == TVEMaterialData.PropertyType.Range)
                        {
                            var value = material.GetFloat(materialData[d].prop);

                            if (materialData[d].value != value)
                            {
                                materialData[d].value = -100;
                            }
                            else
                            {
                                materialData[d].value = value;
                            }
                        }

                        else if (materialData[d].type == TVEMaterialData.PropertyType.Color)
                        {
                            if (material.HasProperty(materialData[d].prop))
                            {
                                var color = material.GetColor(materialData[d].prop);

                                if (materialData[d].color != color)
                                {
                                    materialData[d].color = new Color(-100f, 0, 0, 0);
                                }
                                else
                                {
                                    materialData[d].color = color;
                                }
                            }
                        }
                    }
                }
            }
        }

        void SetMaterialProperties()
        {
            for (int i = 0; i < prefabMaterials.Count; i++)
            {
                var material = prefabMaterials[i];

                // Maybe a better check for unfocus on Converter Convert button pressed
                if (material != null)
                {
                    if (material.HasProperty("_IsTVEShader") || material.HasProperty("_IsTVEEXTShader"))
                    {
                        for (int d = 0; d < materialData.Count; d++)
                        {
                            if (materialData[d].type == TVEMaterialData.PropertyType.Range)
                            {
                                if (materialData[d].value > -99)
                                {
                                    material.SetFloat(materialData[d].prop, materialData[d].value);
                                }
                            }

                            else if (materialData[d].type == TVEMaterialData.PropertyType.Color)
                            {
                                if (materialData[d].color.r > -99)
                                {
                                    material.SetColor(materialData[d].prop, materialData[d].color);
                                }
                            }
                        }
                    }
                }
            }
        }

        void GetPresets()
        {
            presetPaths = new List<string>();
            presetPaths.Add(null);

            // FindObjectsOfTypeAll not working properly for unloaded assets
            allPresetPaths = Directory.GetFiles(Application.dataPath, "*.tvesettings", SearchOption.AllDirectories);

            for (int i = 0; i < allPresetPaths.Length; i++)
            {
                string assetPath = "Assets" + allPresetPaths[i].Replace(Application.dataPath, "").Replace('\\', '/');
                presetPaths.Add(assetPath);
            }

            //for (int i = 0; i < presetTreePaths.Count; i++)
            //{
            //    Debug.Log(presetTreePaths[i]);
            //}
        }

        void GetPresetOptions()
        {
            presetOptions = new string[presetPaths.Count];
            presetOptions[0] = "Choose a preset";

            for (int i = 1; i < presetPaths.Count; i++)
            {
                presetOptions[i] = AssetDatabase.LoadAssetAtPath<Object>(presetPaths[i]).name;
                presetOptions[i] = presetOptions[i].Replace(" - ", "/");
            }

            //for (int i = 0; i < presetOptions.Length; i++)
            //{
            //    Debug.Log(presetOptions[i]);
            //}
        }

        void GetPresetLines()
        {
            StreamReader reader = new StreamReader(presetPaths[presetIndex]);

            presetLines = new List<string>();

            while (!reader.EndOfStream)
            {
                var line = reader.ReadLine();

                presetLines.Add(line);
            }

            reader.Close();

            //for (int i = 0; i < presetLines.Count; i++)
            //{
            //    Debug.Log(presetLines[i]);
            //}
        }

        void GetMaterialConversionFromPreset(Material material)
        {
            for (int i = 0; i < presetLines.Count; i++)
            {
                if (presetLines[i].StartsWith("Material"))
                {
                    string[] splitLine = presetLines[i].Split(char.Parse(" "));

                    var type = "";
                    var src = "";
                    //var dst = "";
                    //var val = "";
                    var set = "";

                    var x = "0";
                    var y = "0";
                    var z = "0";
                    var w = "0";

                    if (splitLine.Length > 1)
                    {
                        type = splitLine[1];
                        //Debug.Log(type);
                    }

                    if (splitLine.Length > 2)
                    {
                        src = splitLine[2];
                        set = splitLine[2];
                        //Debug.Log(src);
                    }

                    if (splitLine.Length > 3)
                    {
                        //dst = splitLine[3];
                        x = splitLine[3];
                        //Debug.Log(dst);
                    }

                    if (splitLine.Length > 4)
                    {
                        //val = splitLine[4];
                        y = splitLine[4];
                    }

                    if (splitLine.Length > 5)
                    {
                        z = splitLine[5];
                    }

                    if (splitLine.Length > 6)
                    {
                        w = splitLine[6];
                    }

                    if (type == "SET_FLOAT")
                    {
                        material.SetFloat(set, float.Parse(x, CultureInfo.InvariantCulture));
                    }

                    else if (type == "SET_COLOR")
                    {
                        material.SetColor(set, new Color(float.Parse(x, CultureInfo.InvariantCulture), float.Parse(y, CultureInfo.InvariantCulture), float.Parse(z, CultureInfo.InvariantCulture), float.Parse(w, CultureInfo.InvariantCulture)));
                    }

                    else if (type == "SET_VECTOR")
                    {
                        material.SetVector(set, new Vector4(float.Parse(x, CultureInfo.InvariantCulture), float.Parse(y, CultureInfo.InvariantCulture), float.Parse(z, CultureInfo.InvariantCulture), float.Parse(w, CultureInfo.InvariantCulture)));
                    }

                    else if (type == "SHADER_NAME_TO_SHADER_FIND")
                    {
                        if (material.shader.name.Contains(src))
                        {
                            var shader = presetLines[i].Replace("Material SHADER_NAME_TO_SHADER_FIND " + src + " ", "");

                            if (Shader.Find(shader) != null)
                            {
                                material.shader = Shader.Find(shader);
                            }
                        }
                    }
                }
            }
        }

        void SavePreset()
        {
            GUILayout.BeginHorizontal();

            savingIndex = EditorGUILayout.Popup(savingIndex, savingOptions, stylePopup, GUILayout.Width(GUI_HALF_WIDTH - 5), GUILayout.Height(GUI_HEIGHT));

            GUILayout.Space(5);

            if (GUILayout.Button("Save Preset", GUILayout.Height(GUI_HEIGHT)))
            {
                savePath = EditorUtility.SaveFilePanelInProject("Save Preset", "Custom - My Preset", "tvesettings", "Use the ' - ' simbol to create categories!");

                if (savePath != "")
                {
                    StreamWriter writer = new StreamWriter(savePath);
                    saveData = new List<TVEMaterialData>();

                    if (savingIndex == 0)
                    {
                        saveData.AddRange(motionData);
                        saveData.AddRange(globalData);
                        saveData.AddRange(subsurfaceData);
                        saveData.AddRange(mainData);
                        saveData.AddRange(secondData);
                        saveData.AddRange(gradientAndNoiseData);
                        saveData.AddRange(billboardAndGrassData);
                    }
                    else if (savingIndex == 1)
                    {
                        saveData = materialData;
                    }

                    for (int i = 0; i < saveData.Count; i++)
                    {
                        if (saveData[i].type == TVEMaterialData.PropertyType.Range)
                        {
                            if (saveData[i].value > -99)
                            {
                                writer.WriteLine("Material SET_FLOAT " + saveData[i].prop + " " + saveData[i].value);
                            }
                        }

                        if (saveData[i].type == TVEMaterialData.PropertyType.Color)
                        {
                            if (saveData[i].color.r > -99)
                            {
                                writer.WriteLine("Material SET_COLOR " + saveData[i].prop + " " + saveData[i].color.r + " " + saveData[i].color.g + " " + saveData[i].color.b + " " + saveData[i].color.a);
                            }
                        }
                    }

                    writer.Close();

                    AssetDatabase.Refresh();

                    GetPresets();
                    GetPresetOptions();

                    // Reset materialData
                    settingsIndexOld = -1;

                    GUIUtility.ExitGUI();
                }
            }

            GUILayout.EndHorizontal();
        }

        void OverrideWind()
        {
            if (TVEManager.Instance != null)
            {
                globalMotion = TVEManager.Instance.globalMotion;
            }

            if (globalMotion != null)
            {
                windPower = globalMotion.windPower;
                globalMotion.enabled = false;
            }
        }

        void ResetWind()
        {
            if (globalMotion != null)
            {
                windPower = globalMotion.windPower;
                globalMotion.enabled = true;
            }
        }

        void SetGlobalShaderProperties()
        {
            Shader.SetGlobalFloat("TVE_WindPower", windPower);
        }
    }
}
