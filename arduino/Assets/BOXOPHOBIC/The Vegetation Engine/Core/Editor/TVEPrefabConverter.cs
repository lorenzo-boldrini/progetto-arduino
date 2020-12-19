// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using Boxophobic.StyledGUI;
using System.IO;
using System.Collections.Generic;
using System.Globalization;

namespace TheVegetationEngine
{
    //[System.Serializable]
    //public class TVEConversionData
    //{
    //    public string propName;
    //    public string checkName;
    //    public Texture texRed;
    //    public Texture texGreen;
    //    public Texture texBlue;
    //    public Texture texAlpha;

    //    public TVEConversionData(string propName, string checkName, Texture texRed, Texture texGreen, Texture texBlue, Texture texAlpha)
    //    {

    //    }
    //}

    public class TVEPrefabConverter : EditorWindow
    {
        const int SPACE_DEFAULT = 10;
        const int SPACE_SMALL = 3;
        const int GUI_WIDTH = 200;
        const int GUI_MESH = 24;

        const int NONE = 0;
        const bool SRGB = true;
        const bool LINEAR = false;
        const bool ALPHA_NONE = false;
        const bool ALPHA_DEFAULT = true;

        const int MAIN_MASK = 0;
        const int SECOND_MASK = 1;

        System.Diagnostics.Stopwatch stopwatch;

        readonly int[] MaxTextureSizes = new int[]
        {
        0,
        32,
        64,
        128,
        256,
        512,
        1024,
        2048,
        4096,
        8192,
        };

        enum ConversionOutput
        {
            Vegetation = 0,
            StaticObject = 1,
            TerrainDetail = 2,
            PolyverseProp = 3,
        }

        string[] ConversionTypeEnum = new string[]
        {
        "Vegetation", "Static Object", "Terrain Detail", "Polyverse Prop",
        };

        string[] ConversionSettingsEnum = new string[]
        {
        "Preset Settings", "Custom Settings",
        };

        string[] SourceMaskEnum = new string[]
        {
        "None", "Channel", "Procedural", "3rd Party" /* "Texture", "Extra Mesh" */
        };

        string[] SourceMaskMeshEnum = new string[]
        {
        "Vertex R", "Vertex G", "Vertex B", "Vertex A",
        "UV 0 X", "UV 0 Y", "UV 0 Z", "UV 0 W",
        "UV 2 X", "UV 2 Y", "UV 2 Z", "UV 2 W",
        "UV 3 X", "UV 3 Y", "UV 3 Z", "UV 3 W",
        "UV 4 X", "UV 4 Y", "UV 4 Z", "UV 4 W",
        };

        string[] SourceMaskProceduralEnum = new string[]
        {
        "Constant Black", "Constant White", "Random Element Variation", "Predictive Element Variation", "Height", "Sphere", "Cylinder", "Capsule",
        "Bottom To Top", "Top To Bottom", "Bottom Projection", "Top Projection", "Height Exp", "Hemi Sphere", "Hemi Cylinder", "Hemi Capsule"
        };

        string[] SourceMask3rdPartyEnum = new string[]
        {
        "CTI Leaves Mask", "CTI Leaves Variation", "ST8 Leaves Mask", "NM Leaves Mask"
        };

        string[] SourceCoordEnum = new string[]
        {
        "None", "Channel", "Procedural", "3rd Party",
        };

        string[] SourceCoordMeshEnum = new string[]
        {
        "UV 0", "UV 2", "UV 3", "UV 4",
        };

        string[] SourceCoordProceduralEnum = new string[]
        {
        "Planar XZ", "Planar XY", "Planar ZY", "Procedural Pivots",
        };

        string[] SourceCoord3rdPartyEnum = new string[]
        {
        "NM Trunk Blend"
        };

        string[] SourceNormalsEnum = new string[]
        {
        "From Mesh", "Procedural",
        };

        string[] SourceNormalsProceduralEnum = new string[]
        {
        "Recalculate Normals", "Flat Shading (Low)", "Flat Shading (Medium)", "Flat Shading (Full)", "Spherical Shading",
        };

        int conversionSettingsIndex = 0;

        int conversionTypeIndex = (int)ConversionOutput.Vegetation;

        int sourceVariation = 0;
        int optionVariation = 0;
        int actionVariation = 0;

        int sourceOcclusion = 0;
        int optionOcclusion = 0;
        int actionOcclusion = 0;

        int sourceDetail = 0;
        int optionDetail = 0;
        int actionDetail = 0;

        int sourceMulti = 0;
        int optionMulti = 0;
        int actionMulti = 0;

        int sourceDetailCoord = 0;
        int optionDetailCoord = 0;

        int sourceMotion1 = 0;
        int optionMotion1 = 0;
        int actionMotion1 = 0;

        int sourceMotion2 = 0;
        int optionMotion2 = 0;
        int actionMotion2 = 0;

        int sourceMotion3 = 0;
        int optionMotion3 = 0;
        int actionMotion3 = 0;

        int sourceNormals = 0;
        int optionNormals = 0;

        List<GameObject> prefabObjects;
        int prefabObjectsConvertedCount;

        GameObject prefabObject;
        GameObject prefabInstance;
        GameObject prefabBackup;

        string prefabDataFolder;

        List<GameObject> gameObjectsInPrefab;
        List<Vector3> transformPositions;
        List<Vector3> transformRotations;
        List<Vector3> transformScales;
        List<MeshRenderer> meshRenderersInPrefab;
        List<Material[]> materialArraysInPrefab;
        List<Material[]> materialArraysInstances;
        List<Material> materialsInPrefab;
        List<MeshFilter> meshFiltersInPrefab;
        List<Mesh> meshesInPrefab;
        List<Mesh> meshInstances;
        Vector4 maxBoundsInfo;

        Material blitMaterial;
        Texture blitTexture;
        TextureImporter[] sourceTexImporters;
        TextureImporterSettings[] sourceTexSettings;
        TextureImporterCompression[] sourceTexCompressions;
        int[] sourceimportSizes;

        int[] maskChannels;
        Texture[] maskTextures;
        List<string> packedTextureNames;
        List<Texture> packedTextureObjcts;

        Mesh convertedMesh;
        Material convertedMaterial;

        int conversionPresetIndex;
        int presetIndexOld = -1;
        string[] allPresetPaths;
        List<string> presetPaths;
        List<string> presetLines;
        string[] PresetsEnum;

        string infoTitle = "";
        string infoPreset = "";
        string infoStatus = "";
        string infoOnline = "";

        //int presetShaderIndex;
        //int presetShaderIndexOld = -1;
        //string[] allPresetShaderPaths;
        //List<string> presetShaderPaths;
        //List<string> presetShaderLines;
        //string[] presetShaderOptions;

        Shader shaderCross;
        Shader shaderLeaf;
        Shader shaderBark;
        Shader shaderGrass;
        Shader shaderProp;

        bool isValid = true;
        bool showSelectedPrefabs = true;
        float seed = 1;

        GUIStyle stylePopup;
        GUIStyle styleHelpBox;
        GUIStyle styleCenteredHelpBox;
        Color bannerColor;
        string bannerText;
        string helpURL;
        static TVEPrefabConverter window;
        Vector2 scrollPosition = Vector2.zero;

        [MenuItem("Window/BOXOPHOBIC/The Vegetation Engine/Prefab Converter", false, 1001)]
        public static void ShowWindow()
        {
            window = GetWindow<TVEPrefabConverter>(false, "Prefab Converter", true);
            window.minSize = new Vector2(389, 280);
        }

        void OnEnable()
        {
            bannerColor = new Color(0.890f, 0.745f, 0.309f);
            bannerText = "Prefab Converter";
            helpURL = "https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.46l51yqt2zky";

            if (GameObject.Find("The Vegetation Engine") == null)
            {
                isValid = false;
                Debug.Log("[Warning][The Vegetation Engine] " + "The Vegetation Engine manager is missing from your scene. Make sure setup it up first and the reopen the Prefab Converter!");
            }

            int intSeed = Random.Range(1, 99);
            float floatSeed = Random.Range(0.1f, 0.9f);
            seed = intSeed + floatSeed;

            InitTexturePacker();

            GetDefaultShaders();

            GetPresets();
            GetPresetOptions();

            //GetShaderPresets();
            //GetShaderPresetOptions();

            GetPrefabObjects();
            GetPrefabPreset();
        }

        void OnSelectionChange()
        {
            GetPrefabObjects();
            GetPrefabPreset();
            Repaint();
        }

        void OnFocus()
        {
            GetPrefabObjects();
            GetPrefabPreset();
            Repaint();
        }

        void OnGUI()
        {
            SetGUIStyles();

            StyledGUI.DrawWindowBanner(bannerColor, bannerText, helpURL);

            GUILayout.BeginHorizontal();
            GUILayout.Space(15);

            GUILayout.BeginVertical();

            DrawMessage();

            scrollPosition = GUILayout.BeginScrollView(scrollPosition, false, false, GUILayout.Width(this.position.width - 28), GUILayout.Height(this.position.height - 240));

            if (isValid == false || prefabObjects.Count == 0)
            {
                GUI.enabled = false;
            }

            DrawPrefabObjects();
            DrawPacking();
            DrawConvert();

            GUILayout.EndScrollView();

            GUILayout.EndVertical();

            GUILayout.Space(13);
            GUILayout.EndHorizontal();

            //DrawProgress();

            //GUILayout.BeginVertical();
            //GUILayout.FlexibleSpace();

            //BEditorGUI.DrawLogo();

            //GUILayout.FlexibleSpace();
            //GUILayout.Space(20);
            //GUILayout.EndVertical();
        }

        void SetGUIStyles()
        {
            stylePopup = new GUIStyle(EditorStyles.popup)
            {
                alignment = TextAnchor.MiddleCenter
            };

            styleHelpBox = new GUIStyle(GUI.skin.GetStyle("HelpBox"))
            {
                richText = true,
            };

            styleCenteredHelpBox = new GUIStyle(GUI.skin.GetStyle("HelpBox"))
            {
                richText = true,
                alignment = TextAnchor.MiddleCenter,
            };
        }

        void DrawMessage()
        {
            GUILayout.Space(-2);

            if (isValid && prefabObjects.Count > 0)
            {
                var status = infoStatus;

                if (conversionTypeIndex == (int)ConversionOutput.StaticObject)
                {
                    status = "Mesh conversion is skipped for Object conversion!";
                }
                else if (conversionTypeIndex == (int)ConversionOutput.TerrainDetail)
                {
                    status = "Use the Detail conversion for TVE Detail Add-on compatibility!";
                }
                else if (conversionTypeIndex == (int)ConversionOutput.PolyverseProp)
                {
                    status = "Use Polyverse conversion for Polyverse Wind compatibility!";
                }

                if (conversionPresetIndex != 0)
                {
                    if (GUILayout.Button("\n<size=16>" + infoTitle + "</size>"
                                        + "\n\n" + infoPreset + " Click here for more details!"
                                        + "\n\n" + status + "\n"
                                        , styleCenteredHelpBox))
                    {
                        Application.OpenURL(infoOnline);
                    }
                }
                else
                {
                    EditorGUILayout.HelpBox("Choose a preset to convert the selected prefabs! Please note that not all material properties will be copied after conversion and the new materials will have different shading!", MessageType.Info, true);
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
        }

        void DrawPrefabObjects()
        {
            if (prefabObjects.Count > 0)
            {
                GUILayout.Space(10);

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
        }

        void DrawPacking()
        {
            GetPresetInfo();

            GUILayout.Space(10);

            conversionPresetIndex = StyledPopup("Conversion Preset", conversionPresetIndex, PresetsEnum);

            if (conversionPresetIndex != 0)
            {
                conversionTypeIndex = StyledPopup("Conversion Output", conversionTypeIndex, ConversionTypeEnum);

                if (conversionTypeIndex == (int)ConversionOutput.Vegetation)
                {
                    conversionSettingsIndex = StyledPopup("Conversion Settings", conversionSettingsIndex, ConversionSettingsEnum);

                    if (conversionSettingsIndex == 1)
                    {
                        GUILayout.Space(10);

                        sourceNormals = StyledSourcePopup("Normals", sourceNormals, SourceNormalsEnum);
                        optionNormals = StyledNormalsOptionEnum("Normals", sourceNormals, optionNormals, true);

                        GUILayout.Space(10);

                        sourceVariation = StyledSourcePopup("Variation", sourceVariation, SourceMaskEnum);
                        optionVariation = StyledMaskOptionEnum("Variation", sourceVariation, optionVariation, true);

                        sourceOcclusion = StyledSourcePopup("Occlusion", sourceOcclusion, SourceMaskEnum);
                        optionOcclusion = StyledMaskOptionEnum("Occlusion", sourceOcclusion, optionOcclusion, true);

                        sourceDetail = StyledSourcePopup("Detail Mask", sourceDetail, SourceMaskEnum);
                        optionDetail = StyledMaskOptionEnum("Detail Mask", sourceDetail, optionDetail, true);

                        sourceMulti = StyledSourcePopup("Multi Mask", sourceMulti, SourceMaskEnum);
                        optionMulti = StyledMaskOptionEnum("Multi Mask", sourceMulti, optionMulti, true);

                        GUILayout.Space(10);

                        sourceDetailCoord = StyledSourcePopup("Detail Coord or Pivots", sourceDetailCoord, SourceCoordEnum);
                        optionDetailCoord = StyledCoordOptionEnum("Detail Coord or Pivots", sourceDetailCoord, optionDetailCoord, true);

                        GUILayout.Space(10);

                        sourceMotion1 = StyledSourcePopup("Motion Primary", sourceMotion1, SourceMaskEnum);
                        optionMotion1 = StyledMaskOptionEnum("Motion Primary", sourceMotion1, optionMotion1, true);

                        sourceMotion2 = StyledSourcePopup("Motion Secondary", sourceMotion2, SourceMaskEnum);
                        optionMotion2 = StyledMaskOptionEnum("Motion Secondary", sourceMotion2, optionMotion2, true);

                        sourceMotion3 = StyledSourcePopup("Motion Leaves", sourceMotion3, SourceMaskEnum);
                        optionMotion3 = StyledMaskOptionEnum("Motion Leaves", sourceMotion3, optionMotion3, true);
                    }
                }
            }
        }

        void DrawConvert()
        {
            GUILayout.Space(10);
            GUILayout.BeginHorizontal();

            if (prefabObjects.Count == 0)
            {
                GUI.enabled = false;
            }
            else
            {
                GUI.enabled = true;
            }

            if (prefabObjectsConvertedCount == 0)
            {
                GUI.enabled = false;
            }
            else
            {
                GUI.enabled = true;
            }

            if (GUILayout.Button("Revert"))
            {
                bool keepData = false;
                keepData = EditorUtility.DisplayDialog("Delete Converted Data?", "Choose Keep if you want to keep all the converted files. Any custom added file will remain in the folder!", "Keep", "Delete Converted Data");

                for (int i = 0; i < prefabObjects.Count; i++)
                {
                    prefabObject = prefabObjects[i];

                    if (prefabObject.GetComponent<TVEPrefab>() != null && prefabObject.GetComponent<TVEPrefab>().storedPrefabBackup != null)
                    {
                        RevertPrefab(keepData);
                    }
                }

                GetPrefabObjects();
            }

            GUILayout.Space(6);

            if (prefabObjects.Count == 0)
            {
                GUI.enabled = false;
            }
            else
            {
                if (conversionPresetIndex == 0)
                {
                    GUI.enabled = false;
                }
                else
                {
                    GUI.enabled = true;
                }
            }

            if (GUILayout.Button("Convert"))
            {
                for (int i = 0; i < prefabObjects.Count; i++)
                {
                    prefabObject = prefabObjects[i];

                    EditorUtility.DisplayProgressBar("The Vegetation Engine", "Converting " + prefabObjects[i].name + " (" + (i + 1).ToString() + "/" + prefabObjects.Count.ToString() + ")", i * 1f / prefabObjects.Count);

                    if (prefabObject.GetComponent<TVEPrefab>() != null)
                    {
                        RevertPrefab(true);
                    }

                    ConvertPrefab();
                }

                GetPrefabObjects();

                EditorUtility.ClearProgressBar();
            }

            GUILayout.EndHorizontal();
            GUI.enabled = true;
        }

        void DrawProgress()
        {
            Rect progress = new Rect(1, this.position.height - 9, this.position.width - 1, 8);
            //EditorGUI.DrawRect(progress, new Color(0.1f, 0.1f, 0.1f));
            EditorGUI.DrawRect(progress, new Color(0.890f, 0.745f, 0.309f));
            //EditorGUI.ProgressBar(progress, .5f, "prog");
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
            if (index >= options.Length)
            {
                index = 0;
            }

            GUILayout.BeginHorizontal();
            EditorGUILayout.LabelField(new GUIContent(name, ""));
            index = EditorGUILayout.Popup(index, options, stylePopup/*, GUILayout.Width(GUI_WIDTH)*/);
            GUILayout.EndHorizontal();

            return index;
        }

        int StyledSourcePopup(string name, int index, string[] options)
        {
            index = StyledPopup(name + " Source", index, options);

            return index;
        }

        int StyledMaskOptionEnum(string name, int source, int option, bool space)
        {
            if (source == 1)
            {
                option = StyledPopup(name + " Channel", option, SourceMaskMeshEnum);
            }
            if (source == 2)
            {
                option = StyledPopup(name + " Procedural", option, SourceMaskProceduralEnum);
            }
            if (source == 3)
            {
                option = StyledPopup(name + " 3rd Party", option, SourceMask3rdPartyEnum);
            }

            GUILayout.Space(SPACE_SMALL);

            return option;
        }

        int StyledCoordOptionEnum(string name, int source, int option, bool space)
        {
            if (source == 1)
            {
                option = StyledPopup(name + " Channel", option, SourceCoordMeshEnum);
            }
            if (source == 2)
            {
                option = StyledPopup(name + " Procedural", option, SourceCoordProceduralEnum);
            }
            if (source == 3)
            {
                option = StyledPopup(name + " 3rd Party", option, SourceCoord3rdPartyEnum);
            }

            GUILayout.Space(SPACE_SMALL);

            return option;
        }

        int StyledNormalsOptionEnum(string name, int source, int option, bool space)
        {
            if (source == 1)
            {
                option = StyledPopup(name + " Procedural", option, SourceNormalsProceduralEnum);
            }

            GUILayout.Space(SPACE_SMALL);

            return option;
        }

        bool StyledButton(string text)
        {
            bool value = GUILayout.Button("<b>" + text + "</b>", styleCenteredHelpBox, GUILayout.Height(GUI_MESH));

            return value;
        }

        /// <summary>
        /// Convert and Revert Macros
        /// </summary>

        void ConvertPrefab()
        {
            //if (prefabInstance != null)
            //{
            //    DestroyImmediate(prefabInstance);
            //}

            prefabInstance = Instantiate(prefabObject);

            prefabInstance.AddComponent<TVEPrefab>();
            prefabInstance.GetComponent<TVEPrefab>().storedPreset = PresetsEnum[conversionPresetIndex];

            CreatePrefabDataFolder();
            CreatePrefabBackupFile();

            prefabInstance.GetComponent<TVEPrefab>().storedPrefabBackup = prefabBackup;

            GetGameObjectsInPrefab();
            DisableInvalidGameObjectsInPrefab();

            if (conversionTypeIndex != (int)ConversionOutput.StaticObject)
            {
                GetTransformsInPrefab();
                GetMeshFiltersInPrefab();
                GetMeshesInPrefab();
                CreateMeshInstances();
                TransformMeshesToWorldSpace();
                GetMaxBoundsInPrefab();
                // Save max bounds if need in the future 
                prefabInstance.GetComponent<TVEPrefab>().storedMaxBoundsInfo = maxBoundsInfo;
                ApplyOriginalTransforms();
                ConvertMeshes();
            }

            GetMeshRenderersInPrefab();
            GetMaterialArraysInPrefab();
            CreateMaterialArraysInstances();

            ConvertMaterials();

            AssignConvertedMaterials();

            PackTextures();

            EnableInvalidGameObjectsInPrefab();

            PrefabUtility.ReplacePrefab(prefabInstance, prefabObject, ReplacePrefabOptions.ReplaceNameBased);

            //PrefabUtility.SaveAsPrefabAssetAndConnect(prefabInstance, AssetDatabase.GetAssetPath(prefabObject), InteractionMode.AutomatedAction);

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            DestroyImmediate(prefabInstance);
        }

        void RevertPrefab(bool keepData)
        {
            //if (prefabInstance != null)
            //{
            //    DestroyImmediate(prefabInstance);
            //}

            prefabInstance = Instantiate(prefabObject);

            var prefabBackup = prefabInstance.GetComponent<TVEPrefab>().storedPrefabBackup;

            PrefabUtility.ReplacePrefab(prefabBackup, prefabObject, ReplacePrefabOptions.ReplaceNameBased);

            //PrefabUtility.SaveAsPrefabAssetAndConnect(prefabInstance, AssetDatabase.GetAssetPath(prefabObject), InteractionMode.AutomatedAction);

            if (keepData == false)
            {
                DeletePrefabDataFolder();
            }

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            DestroyImmediate(prefabInstance);
        }

        /// <summary>
        /// Interanal Stopwatch
        /// </summary>

        void StartStopwatch()
        {
            stopwatch = new System.Diagnostics.Stopwatch();
            stopwatch.Start();
        }

        void StopStopwatch(string message)
        {
            stopwatch.Stop();
            Debug.Log(message + " " + stopwatch.ElapsedMilliseconds.ToString("F0"));
        }

        /// <summary>
        /// Get GameObjects, Materials and MeshFilters in Prefab
        /// </summary>

        GameObject GetPrefabObjectRoot(GameObject selection)
        {
            GameObject prefabRoot = null;

            if (selection != null)
            {
                if (PrefabUtility.GetPrefabAssetPathOfNearestInstanceRoot(selection).Length > 0)
                {
                    var prefabPath = PrefabUtility.GetPrefabAssetPathOfNearestInstanceRoot(selection);
                    var prefabAsset = AssetDatabase.LoadAssetAtPath<GameObject>(prefabPath);
                    var prefabAssets = AssetDatabase.LoadAllAssetRepresentationsAtPath(prefabPath);
                    var prefabType = PrefabUtility.GetPrefabAssetType(prefabAsset);

                    if (prefabAssets.Length == 0)
                    {
                        if (prefabType == PrefabAssetType.Regular || prefabType == PrefabAssetType.Variant)
                        {
                            prefabRoot = prefabAsset;
                        }
                        else if (prefabType == PrefabAssetType.MissingAsset || prefabType == PrefabAssetType.Model || prefabType == PrefabAssetType.NotAPrefab)
                        {
                            prefabRoot = null;
                        }
                    }
                    else
                    {
                        Debug.Log("[Warning][The Vegetation Engine] " + "Prefabs with sub-asset such as Tree Creator of SpeedTree cannot be converted directly. Please create a new prefab from it first!");
                        prefabRoot = null;
                    }
                }
                else
                {
                    prefabRoot = null;
                }
            }

            return prefabRoot;
        }

        void GetPrefabObjects()
        {
            prefabObjects = new List<GameObject>();
            prefabObjectsConvertedCount = 0;

            for (int i = 0; i < Selection.gameObjects.Length; i++)
            {
                var prefabRoot = GetPrefabObjectRoot(Selection.gameObjects[i]);

                if (prefabRoot != null && prefabObjects.Contains(prefabRoot) == false)
                {
                    prefabObjects.Add(prefabRoot);
                }

                if (prefabRoot != null && prefabRoot.GetComponent<TVEPrefab>() != null && prefabRoot.GetComponent<TVEPrefab>().storedPrefabBackup != null)
                {
                    prefabObjectsConvertedCount = 1;
                }
            }
        }

        void GetPrefabPreset()
        {
            if (prefabObjects.Count > 0)
            {
                var TVEPrefab = prefabObjects[0].GetComponent<TVEPrefab>();

                if (TVEPrefab != null)
                {
                    for (int i = 0; i < PresetsEnum.Length; i++)
                    {
                        if (TVEPrefab.storedPreset != null && PresetsEnum[i].Contains(TVEPrefab.storedPreset))
                        {
                            conversionPresetIndex = i;
                        }
                    }
                }
            }
        }

        void CreatePrefabDataFolder()
        {
            var prefabPath = AssetDatabase.GetAssetPath(prefabObject);

            var folderPath = prefabPath.Replace(Path.GetFileName(prefabPath), "");
            folderPath = folderPath + prefabObject.name;

            if (Directory.Exists(folderPath) == false)
            {
                Directory.CreateDirectory(folderPath);
                AssetDatabase.Refresh();
            }

            prefabDataFolder = folderPath;
        }

        void DeletePrefabDataFolder()
        {
            var prefabPath = AssetDatabase.GetAssetPath(prefabObject);

            var folderPath = prefabPath.Replace(Path.GetFileName(prefabPath), "");
            folderPath = folderPath + prefabObject.name;

            if (Directory.Exists(folderPath))
            {
                var allFolderFiles = Directory.GetFiles(folderPath);

                for (int i = 0; i < allFolderFiles.Length; i++)
                {
                    if (allFolderFiles[i].Contains("TVE"))
                    {
                        FileUtil.DeleteFileOrDirectory(allFolderFiles[i]);
                    }
                }

                allFolderFiles = Directory.GetFiles(folderPath);

                if (allFolderFiles == null || allFolderFiles.Length == 0)
                {
                    FileUtil.DeleteFileOrDirectory(folderPath);
                }

                AssetDatabase.Refresh();
            }
        }

        void CreatePrefabBackupFile()
        {
            var prefabPath = AssetDatabase.GetAssetPath(prefabObject);
            var backupPath = prefabDataFolder + "/" + Path.GetFileNameWithoutExtension(prefabPath) + " (TVE Backup).prefab";

            AssetDatabase.CopyAsset(prefabPath, backupPath);
            AssetDatabase.Refresh();

            prefabBackup = AssetDatabase.LoadAssetAtPath<GameObject>(backupPath);
        }

        void GetGameObjectsInPrefab()
        {
            gameObjectsInPrefab = new List<GameObject>();
            gameObjectsInPrefab.Add(prefabInstance);

            GetChildRecursive(prefabInstance);

            //for (int i = 0; i < gameObjectsInPrefab.Count; i++)
            //{
            //    Debug.Log(gameObjectsInPrefab[i]);
            //}
        }

        void GetChildRecursive(GameObject go)
        {
            foreach (Transform child in go.transform)
            {
                if (child == null)
                    continue;

                gameObjectsInPrefab.Add(child.gameObject);
                GetChildRecursive(child.gameObject);
            }
        }

        void DisableInvalidGameObjectsInPrefab()
        {
            for (int i = 0; i < gameObjectsInPrefab.Count; i++)
            {
                if (gameObjectsInPrefab[i].name.Contains("Impostor") == true)
                {
                    gameObjectsInPrefab[i].SetActive(false);
                    Debug.Log("[Warning][The Vegetation Engine] " + "Impostor Mesh are not yet supported! The " + gameObjectsInPrefab[i].name + " gameobject remains unchanged!");
                }
                else if (gameObjectsInPrefab[i].GetComponent<BillboardRenderer>() != null)
                {
                    gameObjectsInPrefab[i].SetActive(false);
                    Debug.Log("[Warning][The Vegetation Engine] " + "Billboard Renderers are not supported! The " + gameObjectsInPrefab[i].name + " gameobject has been disabled. You can manually enable them after the conversion is done!");
                }
                else if (gameObjectsInPrefab[i].GetComponent<Tree>() != null)
                {
                    DestroyImmediate(gameObjectsInPrefab[i].GetComponent<Tree>());
                }
            }
        }

        void EnableInvalidGameObjectsInPrefab()
        {
            for (int i = 0; i < gameObjectsInPrefab.Count; i++)
            {
                if (gameObjectsInPrefab[i].name.Contains("Impostor") == true)
                {
                    gameObjectsInPrefab[i].SetActive(true);
                }
            }
        }

        void GetTransformsInPrefab()
        {
            transformPositions = new List<Vector3>();
            transformRotations = new List<Vector3>();
            transformScales = new List<Vector3>();

            for (int i = 0; i < gameObjectsInPrefab.Count; i++)
            {
                transformPositions.Add(gameObjectsInPrefab[i].transform.localPosition);
                transformRotations.Add(gameObjectsInPrefab[i].transform.localEulerAngles);
                transformScales.Add(gameObjectsInPrefab[i].transform.localScale);
            }
        }

        void GetMeshRenderersInPrefab()
        {
            meshRenderersInPrefab = new List<MeshRenderer>();

            for (int i = 0; i < gameObjectsInPrefab.Count; i++)
            {
                if (IsValidGameObject(gameObjectsInPrefab[i]) && gameObjectsInPrefab[i].GetComponent<MeshRenderer>() != null)
                {
                    meshRenderersInPrefab.Add(gameObjectsInPrefab[i].GetComponent<MeshRenderer>());
                }
                else
                {
                    meshRenderersInPrefab.Add(null);
                }
            }

            //for (int i = 0; i < meshRenderersInPrefab.Count; i++)
            //{
            //    Debug.Log(meshRenderersInPrefab[i]);
            //}
        }

        void GetMaterialArraysInPrefab()
        {
            materialArraysInPrefab = new List<Material[]>();

            for (int i = 0; i < meshRenderersInPrefab.Count; i++)
            {
                if (meshRenderersInPrefab[i] != null)
                {
                    materialArraysInPrefab.Add(meshRenderersInPrefab[i].sharedMaterials);
                }
                else
                {
                    materialArraysInPrefab.Add(null);
                }
            }
        }

        void CreateMaterialArraysInstances()
        {
            materialArraysInstances = new List<Material[]>();

            for (int i = 0; i < materialArraysInPrefab.Count; i++)
            {
                if (materialArraysInPrefab[i] != null)
                {
                    var materials = materialArraysInPrefab[i];
                    var materialsInstances = new Material[materials.Length];

                    for (int j = 0; j < materials.Length; j++)
                    {
                        if (materials[j] != null)
                        {
                            if (materials[j].name.Contains("Impostor") == true)
                            {
                                materialsInstances[j] = materials[j];
                            }
                            else
                            {
                                materialsInstances[j] = new Material(materials[j]);
                                materialsInstances[j].name = materials[j].name;
                            }
                        }
                        else
                        {
                            materialsInstances[j] = null;
                        }
                    }

                    materialArraysInstances.Add(materialsInstances);
                }
                else
                {
                    materialArraysInstances.Add(null);
                }
            }
        }

        void GetMeshFiltersInPrefab()
        {
            meshFiltersInPrefab = new List<MeshFilter>();

            for (int i = 0; i < gameObjectsInPrefab.Count; i++)
            {
                if (IsValidGameObject(gameObjectsInPrefab[i]) && gameObjectsInPrefab[i].GetComponent<MeshFilter>() != null)
                {
                    meshFiltersInPrefab.Add(gameObjectsInPrefab[i].GetComponent<MeshFilter>());
                }
                else
                {
                    meshFiltersInPrefab.Add(null);
                }
            }

            //for (int i = 0; i < meshFiltersInPrefab.Count; i++)
            //{
            //    Debug.Log(meshFiltersInPrefab[i].sharedMesh);
            //}
        }

        void GetMeshesInPrefab()
        {
            meshesInPrefab = new List<Mesh>();

            for (int i = 0; i < gameObjectsInPrefab.Count; i++)
            {
                if (meshFiltersInPrefab[i] != null)
                {
                    meshesInPrefab.Add(meshFiltersInPrefab[i].sharedMesh);
                }
                else
                {
                    meshesInPrefab.Add(null);
                }
            }

            //for (int i = 0; i < meshFiltersInPrefab.Count; i++)
            //{
            //    Debug.Log(meshFiltersInPrefab[i].sharedMesh);
            //}
        }

        void CreateMeshInstances()
        {
            meshInstances = new List<Mesh>();

            for (int i = 0; i < gameObjectsInPrefab.Count; i++)
            {
                if (meshesInPrefab[i] != null)
                {
                    var meshPath = AssetDatabase.GetAssetPath(meshesInPrefab[i]);

                    if (meshesInPrefab[i].isReadable == true)
                    {
                        var meshInstance = Instantiate(meshesInPrefab[i]);
                        meshInstance.name = meshesInPrefab[i].name;
                        meshInstances.Add(meshInstance);
                    }
                    else
                    {
                        //Workaround when the mesh is not readable (Unity Bug)
                        ModelImporter modelImporter = AssetImporter.GetAtPath(meshPath) as ModelImporter;

                        if (modelImporter != null)
                        {
                            modelImporter.isReadable = true;
                            modelImporter.SaveAndReimport();
                        }

                        if (meshPath.EndsWith(".asset"))
                        {
                            string filePath = Path.Combine(Directory.GetCurrentDirectory(), meshPath);
                            filePath = filePath.Replace("/", "\\");
                            string fileText = File.ReadAllText(filePath);
                            fileText = fileText.Replace("m_IsReadable: 0", "m_IsReadable: 1");
                            File.WriteAllText(filePath, fileText);
                            AssetDatabase.Refresh();
                        }

                        var meshInstance = Instantiate(meshesInPrefab[i]);
                        meshInstance.name = meshesInPrefab[i].name;
                        meshInstances.Add(meshInstance);
                    }
                }
                else
                {
                    meshInstances.Add(null);
                }
            }

            //for (int i = 0; i < meshFiltersInPrefab.Count; i++)
            //{
            //    Debug.Log(meshFiltersInPrefab[i].sharedMesh);
            //}
        }

        void TransformMeshesToWorldSpace()
        {
            for (int i = 0; i < gameObjectsInPrefab.Count; i++)
            {
                // Reset only the pos/scale for meshes to capture the WS rotation
                // Reset all transform for gos without mesh for proper children baking
                if (meshInstances[i] != null)
                {
                    gameObjectsInPrefab[i].transform.localPosition = Vector3.zero;
                    gameObjectsInPrefab[i].transform.localScale = Vector3.one;
                }
                else
                {
                    gameObjectsInPrefab[i].transform.localPosition = Vector3.zero;
                    gameObjectsInPrefab[i].transform.localEulerAngles = Vector3.zero;
                    gameObjectsInPrefab[i].transform.localScale = Vector3.one;
                }
            }

            for (int i = 0; i < gameObjectsInPrefab.Count; i++)
            {
                if (meshInstances[i] != null)
                {
                    var meshInstance = meshInstances[i];
                    var transforms = gameObjectsInPrefab[i].transform;

                    Vector3[] verticesOS = meshInstance.vertices;
                    Vector3[] verticesWS = new Vector3[meshInstance.vertices.Length];

                    // Transform vertioces OS pos to WS pos
                    for (int j = 0; j < verticesOS.Length; j++)
                    {
                        verticesWS[j] = transforms.TransformPoint(verticesOS[j]);
                    }

                    meshInstances[i].vertices = verticesWS;

                    // Some meshes don't have normals, check is needed
                    if (meshInstance.normals != null && meshInstance.normals.Length > 0)
                    {
                        Vector3[] normalsOS = meshInstance.normals;
                        Vector3[] normalsWS = new Vector3[meshInstance.vertices.Length];

                        for (int j = 0; j < normalsOS.Length; j++)
                        {
                            normalsWS[j] = transforms.TransformPoint(normalsOS[j]);
                        }

                        meshInstances[i].normals = normalsWS;
                    }

                    //// Some meshes don't have tangenst, check is needed
                    //if (meshInstance.tangents != null && meshInstance.tangents.Length > 0)
                    //{
                    //    Vector4[] tangentsOS = meshInstance.tangents;
                    //    Vector4[] tangentsWS = new Vector4[meshInstance.vertices.Length];

                    //    for (int j = 0; j < tangentsOS.Length; j++)
                    //    {
                    //        var tan = transforms.TransformPoint(tangentsOS[j]);
                    //        tangentsWS[j] = new Vector4(tan.x, tan.y, tan.z, tangentsOS[j].w);
                    //    }

                    //    meshInstances[i].tangents = tangentsWS;
                    //}

                    meshInstances[i].RecalculateTangents();
                    meshInstances[i].RecalculateBounds();
                }
            }

            for (int i = 0; i < gameObjectsInPrefab.Count; i++)
            {
                gameObjectsInPrefab[i].transform.localEulerAngles = Vector3.zero;
            }
        }

        void ApplyOriginalTransforms()
        {
            for (int i = 0; i < gameObjectsInPrefab.Count; i++)
            {
                // Apply original pos/scale only for meshes
                // Apply all original transforms for nonmeshes
                if (meshInstances[i] != null)
                {
                    gameObjectsInPrefab[i].transform.localPosition = transformPositions[i];
                    gameObjectsInPrefab[i].transform.localScale = transformScales[i];
                }
                else
                {
                    gameObjectsInPrefab[i].transform.localPosition = transformPositions[i];
                    gameObjectsInPrefab[i].transform.localEulerAngles = transformRotations[i];
                    gameObjectsInPrefab[i].transform.localScale = transformScales[i];
                }
            }
        }

        void GetMaxBoundsInPrefab()
        {
            maxBoundsInfo = Vector4.zero;

            var bounds = new Bounds(Vector3.zero, Vector3.zero);

            for (int i = 0; i < meshInstances.Count; i++)
            {
                if (meshInstances[i] != null)
                {
                    bounds.Encapsulate(meshInstances[i].bounds);
                }
            }

            var maxX = Mathf.Max(Mathf.Abs(bounds.min.x), Mathf.Abs(bounds.max.x));
            var maxZ = Mathf.Max(Mathf.Abs(bounds.min.z), Mathf.Abs(bounds.max.z));

            var maxR = Mathf.Max(maxX, maxZ);
            var maxH = Mathf.Max(Mathf.Abs(bounds.min.y), Mathf.Abs(bounds.max.y));
            var maxS = Mathf.Max(maxR, maxH);

            maxBoundsInfo = new Vector4(maxR, maxH, maxS, 0.0f);

            //Debug.Log(maxBoundsInfo);
        }

        bool IsValidGameObject(GameObject gameObject)
        {
            bool valid = true;

            if (gameObject.activeInHierarchy == false)
            {
                valid = false;
            }

            return valid;
        }

        /// <summary>
        /// Mesh Packing Macros
        /// </summary>

        void GetPrefabConversionFromPreset()
        {
            if (conversionPresetIndex == 0)
            {
                return;
            }

            for (int i = 0; i < 20; i++)
            {
                if (presetLines[i].StartsWith("Conversion"))
                {
                    string source = presetLines[i].Replace("Conversion ", "");

                    if (source == "VEGETATION")
                    {
                        conversionTypeIndex = (int)ConversionOutput.Vegetation;
                    }
                    else if (source == "OBJECT")
                    {
                        conversionTypeIndex = (int)ConversionOutput.StaticObject;
                    }
                    else if (source == "DETAIL")
                    {
                        conversionTypeIndex = (int)ConversionOutput.TerrainDetail;
                    }
                    else if (source == "POLYVERSE")
                    {
                        conversionTypeIndex = (int)ConversionOutput.PolyverseProp;
                    }
                }
            }
        }

        void GetMeshConversionFromPreset()
        {
            for (int i = 0; i < presetLines.Count; i++)
            {
                if (presetLines[i].StartsWith("Mesh"))
                {
                    string[] splitLine = presetLines[i].Split(char.Parse(" "));
                    string name = "";
                    string source = "";
                    int sourceIndex = 0;
                    string option = "";
                    int optionIndex = 0;
                    string action = "";
                    int actionIndex = 0;

                    if (splitLine.Length > 1)
                    {
                        name = splitLine[1];
                    }

                    if (splitLine.Length > 2)
                    {
                        source = splitLine[2];

                        if (source == "NONE")
                        {
                            sourceIndex = 0;
                        }

                        if (source == "AUTO")
                        {
                            sourceIndex = 0;
                        }

                        // Available options for Float masks
                        if (source == "GET_MASK_FROM_CHANNEL")
                        {
                            sourceIndex = 1;
                        }

                        if (source == "GET_MASK_PROCEDURAL")
                        {
                            sourceIndex = 2;
                        }

                        if (source == "GET_MASK_3RD_PARTY")
                        {
                            sourceIndex = 3;
                        }

                        // Available options for Coord masks
                        if (source == "GET_COORD_FROM_CHANNEL")
                        {
                            sourceIndex = 1;
                        }

                        if (source == "GET_COORD_PROCEDURAL")
                        {
                            sourceIndex = 2;
                        }

                        if (source == "GET_COORD_3RD_PARTY")
                        {
                            sourceIndex = 3;
                        }

                        // Available options for Coord masks
                        if (source == "GET_NORMALS_PROCEDURAL")
                        {
                            sourceIndex = 1;
                        }
                    }

                    if (splitLine.Length > 3)
                    {
                        option = splitLine[3];

                        optionIndex = int.Parse(option);
                    }

                    if (splitLine.Length > 4)
                    {
                        action = splitLine[4];

                        if (action == "ACTION_INVERT")
                        {
                            actionIndex = 1;
                        }

                        if (action == "ACTION_REMAP01")
                        {
                            actionIndex = 2;
                        }
                    }

                    if (name == "Variation")
                    {
                        sourceVariation = sourceIndex;
                        optionVariation = optionIndex;
                        actionVariation = actionIndex;
                    }

                    if (name == "Occlusion")
                    {
                        sourceOcclusion = sourceIndex;
                        optionOcclusion = optionIndex;
                        actionOcclusion = actionIndex;
                    }

                    if (name == "DetailMask")
                    {
                        sourceDetail = sourceIndex;
                        optionDetail = optionIndex;
                        actionDetail = actionIndex;
                    }

                    if (name == "MultiMask")
                    {
                        sourceMulti = sourceIndex;
                        optionMulti = optionIndex;
                        actionMulti = actionIndex;
                    }

                    if (name == "DetailCoord")
                    {
                        sourceDetailCoord = sourceIndex;
                        optionDetailCoord = optionIndex;
                    }

                    if (name == "Motion1")
                    {
                        sourceMotion1 = sourceIndex;
                        optionMotion1 = optionIndex;
                        actionMotion1 = actionIndex;
                    }

                    if (name == "Motion2")
                    {
                        sourceMotion2 = sourceIndex;
                        optionMotion2 = optionIndex;
                        actionMotion2 = actionIndex;
                    }

                    if (name == "Motion3")
                    {
                        sourceMotion3 = sourceIndex;
                        optionMotion3 = optionIndex;
                        actionMotion3 = actionIndex;
                    }

                    if (name == "Normals")
                    {
                        sourceNormals = sourceIndex;
                        optionNormals = optionIndex;
                    }
                }
            }
        }

        void ConvertMeshes()
        {
            if (conversionTypeIndex == (int)ConversionOutput.Vegetation)
            {
                for (int i = 0; i < meshInstances.Count; i++)
                {
                    if (meshInstances[i] != null)
                    {
                        ConvertMeshVegetation(meshInstances[i]);
                        meshFiltersInPrefab[i].sharedMesh = convertedMesh;
                    }
                }
            }
            else if (conversionTypeIndex == (int)ConversionOutput.TerrainDetail)
            {
                for (int i = 0; i < meshInstances.Count; i++)
                {
                    if (meshInstances[i] != null)
                    {
                        ConvertMeshDetail(meshInstances[i]);
                        meshFiltersInPrefab[i].sharedMesh = convertedMesh;
                    }
                }
            }
            else if (conversionTypeIndex == (int)ConversionOutput.PolyverseProp)
            {
                for (int i = 0; i < meshInstances.Count; i++)
                {
                    if (meshInstances[i] != null)
                    {
                        ConvertMeshPolyverse(meshInstances[i]);
                        meshFiltersInPrefab[i].sharedMesh = convertedMesh;
                    }
                }
            }
        }

        void ConvertMeshVegetation(Mesh mesh)
        {
            Color[] colors = new Color[mesh.vertexCount];

            var UV0 = GetCoordData(mesh, 0, 0);
            var UV4 = GetCoordData(mesh, 0, 0);

            var multiMask = new List<float>();

            if (sourceMulti == 0)
            {
                multiMask = GetMaskData(mesh, 2, 4, 0, 1.0f);
            }
            else
            {
                multiMask = GetMaskData(mesh, sourceMulti, optionMulti, actionMulti, 1.0f);
            }

            var occlusion = GetMaskData(mesh, sourceOcclusion, optionOcclusion, actionOcclusion, 1.0f);
            var detailMask = GetMaskData(mesh, sourceDetail, optionDetail, actionDetail, 1.0f);
            var variation = GetMaskData(mesh, sourceVariation, optionVariation, actionVariation, 1.0f);

            var detailCoordOrPivots = GetCoordData(mesh, sourceDetailCoord, optionDetailCoord);

            var motion1 = GetMaskData(mesh, sourceMotion1, optionMotion1, actionMotion1, 1.0f);
            var motion2 = GetMaskData(mesh, sourceMotion2, optionMotion2, actionMotion2, 1.0f);
            var motion3 = GetMaskData(mesh, sourceMotion3, optionMotion3, actionMotion3, 1.0f);

            for (int i = 0; i < mesh.vertexCount; i++)
            {
                colors[i] = new Color(variation[i], occlusion[i], detailMask[i], multiMask[i]);
                UV0[i] = new Vector4(UV0[i].x, UV0[i].y, detailCoordOrPivots[i].x, detailCoordOrPivots[i].y);
                UV4[i] = new Vector4(motion1[i], motion2[i], motion3[i], 0);
            }

            mesh.colors = colors;
            mesh.SetUVs(0, UV0);
            mesh.SetUVs(3, UV4);

            GetNormalsData(mesh, sourceNormals, optionNormals);

            SaveMesh(mesh);
        }

        void ConvertMeshDetail(Mesh mesh)
        {
            Color[] colors = new Color[mesh.vertexCount];

            var UV0 = GetCoordData(mesh, 0, 0);

            var height = GetMaskData(mesh, 2, 4, 0, 1.0f);

            for (int i = 0; i < mesh.vertexCount; i++)
            {
                colors[i] = new Color(1, 1, 1, height[i]);
                UV0[i] = new Vector4(UV0[i].x, UV0[i].y, 0, 0);
            }

            mesh.colors = colors;
            mesh.SetUVs(0, UV0);

            SaveMesh(mesh);
        }

        void ConvertMeshPolyverse(Mesh mesh)
        {
            var UV0 = GetCoordData(mesh, 0, 0);
            var UV4 = GetCoordData(mesh, 0, 0);

            var height = GetMaskData(mesh, 2, 4, 0, 1.0f);

            for (int i = 0; i < mesh.vertexCount; i++)
            {
                UV0[i] = new Vector4(UV0[i].x, UV0[i].y, height[i], height[i]);
                UV4[i] = new Vector4(mesh.vertices[i].x, mesh.vertices[i].y, mesh.vertices[i].z, height[i]);
            }

            mesh.SetUVs(0, UV0);
            mesh.SetUVs(3, UV4);

            SaveMesh(mesh);
        }

        void SaveMesh(Mesh mesh)
        {
            var saveFullPath = prefabDataFolder + "/" + mesh.name + " (TVE Mesh).mesh";

            if (File.Exists(saveFullPath))
            {
                var adsMeshFile = AssetDatabase.LoadAssetAtPath<Mesh>(saveFullPath);
                adsMeshFile.Clear();
                EditorUtility.CopySerialized(mesh, adsMeshFile);
            }
            else
            {
                AssetDatabase.CreateAsset(mesh, saveFullPath);
            }

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            convertedMesh = AssetDatabase.LoadAssetAtPath<Mesh>(saveFullPath);
        }

        // Get Float data
        List<float> GetMaskData(Mesh mesh, int source, int option, int action, float defaulValue)
        {
            var meshChannel = new List<float>();

            if (source == 0)
            {
                meshChannel = GetMaskDefaultValue(mesh, defaulValue);
            }
            else if (source == 1)
            {
                meshChannel = GetMaskMeshData(mesh, option, defaulValue);
            }
            else if (source == 2)
            {
                meshChannel = GetMaskProceduralData(mesh, option);
            }
            else if (source == 3)
            {
                meshChannel = GetMask3rdPartyData(mesh, option);
            }

            if (action > 0)
            {
                meshChannel = MathAction(meshChannel, action);
            }

            return meshChannel;
        }

        List<float> GetMaskDefaultValue(Mesh mesh, float defaulValue)
        {
            var meshChannel = new List<float>();

            for (int i = 0; i < mesh.vertexCount; i++)
            {
                meshChannel.Add(defaulValue);
            }

            return meshChannel;
        }

        List<float> GetMaskMeshData(Mesh mesh, int option, float defaulValue)
        {
            var meshChannel = new List<float>();

            var tempColors = new List<Color>();
            var tempChannel = new List<Vector4>();

            // Vertex Color Data
            if (option == 0)
            {
                mesh.GetColors(tempColors);

                for (int i = 0; i < tempColors.Count; i++)
                {
                    meshChannel.Add(tempColors[i].r);
                }
            }

            else if (option == 1)
            {
                mesh.GetColors(tempColors);

                for (int i = 0; i < tempColors.Count; i++)
                {
                    meshChannel.Add(tempColors[i].g);
                }
            }

            else if (option == 2)
            {
                mesh.GetColors(tempColors);

                for (int i = 0; i < tempColors.Count; i++)
                {
                    meshChannel.Add(tempColors[i].b);
                }
            }

            else if (option == 3)
            {
                mesh.GetColors(tempColors);

                for (int i = 0; i < tempColors.Count; i++)
                {
                    meshChannel.Add(tempColors[i].a);
                }
            }

            // UV 0 Data
            else if (option == 4)
            {
                mesh.GetUVs(0, tempChannel);

                for (int i = 0; i < tempChannel.Count; i++)
                {
                    meshChannel.Add(tempChannel[i].x);
                }
            }

            else if (option == 5)
            {
                mesh.GetUVs(0, tempChannel);

                for (int i = 0; i < tempChannel.Count; i++)
                {
                    meshChannel.Add(tempChannel[i].y);
                }
            }

            else if (option == 6)
            {
                mesh.GetUVs(0, tempChannel);

                for (int i = 0; i < tempChannel.Count; i++)
                {
                    meshChannel.Add(tempChannel[i].z);
                }
            }

            else if (option == 7)
            {
                mesh.GetUVs(0, tempChannel);

                for (int i = 0; i < tempChannel.Count; i++)
                {
                    meshChannel.Add(tempChannel[i].w);
                }
            }

            // UV 2 Data
            else if (option == 8)
            {
                mesh.GetUVs(1, tempChannel);

                for (int i = 0; i < tempChannel.Count; i++)
                {
                    meshChannel.Add(tempChannel[i].x);
                }
            }

            else if (option == 9)
            {
                mesh.GetUVs(1, tempChannel);

                for (int i = 0; i < tempChannel.Count; i++)
                {
                    meshChannel.Add(tempChannel[i].y);
                }
            }

            else if (option == 10)
            {
                mesh.GetUVs(1, tempChannel);

                for (int i = 0; i < tempChannel.Count; i++)
                {
                    meshChannel.Add(tempChannel[i].z);
                }
            }

            else if (option == 11)
            {
                mesh.GetUVs(1, tempChannel);

                for (int i = 0; i < tempChannel.Count; i++)
                {
                    meshChannel.Add(tempChannel[i].w);
                }
            }

            // UV 3 Data
            else if (option == 12)
            {
                mesh.GetUVs(2, tempChannel);

                for (int i = 0; i < tempChannel.Count; i++)
                {
                    meshChannel.Add(tempChannel[i].x);
                }
            }

            else if (option == 13)
            {
                mesh.GetUVs(2, tempChannel);

                for (int i = 0; i < tempChannel.Count; i++)
                {
                    meshChannel.Add(tempChannel[i].y);
                }
            }

            else if (option == 14)
            {
                mesh.GetUVs(2, tempChannel);

                for (int i = 0; i < tempChannel.Count; i++)
                {
                    meshChannel.Add(tempChannel[i].z);
                }
            }

            else if (option == 15)
            {
                mesh.GetUVs(2, tempChannel);

                for (int i = 0; i < tempChannel.Count; i++)
                {
                    meshChannel.Add(tempChannel[i].w);
                }
            }

            // UV 4 Data
            else if (option == 16)
            {
                mesh.GetUVs(3, tempChannel);

                for (int i = 0; i < tempChannel.Count; i++)
                {
                    meshChannel.Add(tempChannel[i].x);
                }
            }

            else if (option == 17)
            {
                mesh.GetUVs(3, tempChannel);

                for (int i = 0; i < tempChannel.Count; i++)
                {
                    meshChannel.Add(tempChannel[i].y);
                }
            }

            else if (option == 18)
            {
                mesh.GetUVs(3, tempChannel);

                for (int i = 0; i < tempChannel.Count; i++)
                {
                    meshChannel.Add(tempChannel[i].z);
                }
            }

            else if (option == 19)
            {
                mesh.GetUVs(3, tempChannel);

                for (int i = 0; i < tempChannel.Count; i++)
                {
                    meshChannel.Add(tempChannel[i].w);
                }
            }

            if (meshChannel.Count == 0)
            {
                meshChannel = GetMaskDefaultValue(mesh, defaulValue);

                //Debug.Log("[The Vegetation Engine] " + mesh.name + " does not have " + SourceMaskMeshEnum[option] + ". A default value has been assigned instead!");
            }

            //meshChannel = HandleMeshAction(meshChannel);

            return meshChannel;
        }

        List<float> GetMaskProceduralData(Mesh mesh, int option)
        {
            var meshChannel = new List<float>();

            if (option == 0)
            {
                for (int i = 0; i < mesh.vertexCount; i++)
                {
                    meshChannel.Add(0.0f);
                }
            }
            else if (option == 1)
            {
                for (int i = 0; i < mesh.vertexCount; i++)
                {
                    meshChannel.Add(1.0f);
                }
            }
            // Random Object Variation
            else if (option == 2)
            {
                meshChannel = GenerateRandomVariation(mesh);
            }
            // Random Element Variation
            else if (option == 3)
            {
                meshChannel = GeneratePredictiveVariation(mesh);
            }
            // Normalized in bounds height
            else if (option == 4)
            {
                for (int i = 0; i < mesh.vertexCount; i++)
                {
                    var mask = Mathf.Clamp01(mesh.vertices[i].y / maxBoundsInfo.y);

                    meshChannel.Add(mask);
                }
            }
            // Procedural Sphere
            else if (option == 5)
            {
                for (int i = 0; i < mesh.vertexCount; i++)
                {
                    var mask = Mathf.Clamp01(Vector3.Distance(mesh.vertices[i], Vector3.zero) / maxBoundsInfo.x);

                    meshChannel.Add(mask);
                }
            }
            // Procedural Cylinder no Cap
            else if (option == 6)
            {
                for (int i = 0; i < mesh.vertexCount; i++)
                {
                    var mask = Mathf.Clamp01(MathRemap(Vector3.Distance(mesh.vertices[i], new Vector3(0, mesh.vertices[i].y, 0)), maxBoundsInfo.x * 0.1f, maxBoundsInfo.x, 0f, 1f));

                    meshChannel.Add(mask);
                }
            }
            // Procedural Capsule
            else if (option == 7)
            {
                for (int i = 0; i < mesh.vertexCount; i++)
                {
                    var maskCyl = Mathf.Clamp01(MathRemap(Vector3.Distance(mesh.vertices[i], new Vector3(0, mesh.vertices[i].y, 0)), maxBoundsInfo.x * 0.1f, maxBoundsInfo.x, 0f, 1f));
                    var maskCap = Vector3.Magnitude(new Vector3(0, Mathf.Clamp01(MathRemap(mesh.vertices[i].y / maxBoundsInfo.y, 0.8f, 1f, 0f, 1f)), 0));
                    var maskBase = Mathf.Clamp01(MathRemap(mesh.vertices[i].y / maxBoundsInfo.y, 0f, 0.1f, 0f, 1f));
                    var mask = Mathf.Clamp01(maskCyl + maskCap) * maskBase;

                    meshChannel.Add(mask);
                }
            }
            // Bottom To Top
            else if (option == 8)
            {
                for (int i = 0; i < mesh.vertexCount; i++)
                {
                    var mask = 1.0f - Mathf.Clamp01(mesh.vertices[i].y / maxBoundsInfo.y);

                    meshChannel.Add(mask);
                }
            }
            // Top To Bottom
            else if (option == 9)
            {
                for (int i = 0; i < mesh.vertexCount; i++)
                {
                    var mask = Mathf.Clamp01(mesh.vertices[i].y / maxBoundsInfo.y);

                    meshChannel.Add(mask);
                }
            }
            // Bottom Projection
            else if (option == 10)
            {
                for (int i = 0; i < mesh.vertexCount; i++)
                {
                    var mask = Mathf.Clamp01(Vector3.Dot(new Vector3(0, -1, 0), mesh.normals[i]) * 0.5f + 0.5f);

                    meshChannel.Add(mask);
                }
            }
            // Top Projection
            else if (option == 11)
            {
                for (int i = 0; i < mesh.vertexCount; i++)
                {
                    var mask = Mathf.Clamp01(Vector3.Dot(new Vector3(0, 1, 0), mesh.normals[i]) * 0.5f + 0.5f);

                    meshChannel.Add(mask);
                }
            }
            // Height Exp
            else if (option == 12)
            {
                for (int i = 0; i < mesh.vertexCount; i++)
                {
                    var oneMinusMask = 1 - Mathf.Clamp01(mesh.vertices[i].y / maxBoundsInfo.y);
                    var powerMask = oneMinusMask * oneMinusMask * oneMinusMask * oneMinusMask;
                    var mask = 1 - powerMask;

                    meshChannel.Add(mask);
                }
            }
            //Hemi Sphere
            else if (option == 13)
            {
                for (int i = 0; i < mesh.vertexCount; i++)
                {
                    var height = Mathf.Clamp01(mesh.vertices[i].y / maxBoundsInfo.y);
                    var sphere = Mathf.Clamp01(Vector3.Distance(mesh.vertices[i], Vector3.zero) / maxBoundsInfo.x);
                    var mask = height * sphere;

                    meshChannel.Add(mask);
                }
            }
            //Hemi Cylinder
            else if (option == 14)
            {
                for (int i = 0; i < mesh.vertexCount; i++)
                {
                    var height = Mathf.Clamp01(mesh.vertices[i].y / maxBoundsInfo.y);
                    var cyl = Mathf.Clamp01(MathRemap(Vector3.Distance(mesh.vertices[i], new Vector3(0, mesh.vertices[i].y, 0)), maxBoundsInfo.x * 0.1f, maxBoundsInfo.x, 0f, 1f));
                    var mask = height * cyl;

                    meshChannel.Add(mask);
                }
            }
            //Hemi Capsule
            else if (option == 15)
            {
                for (int i = 0; i < mesh.vertexCount; i++)
                {
                    var height = Mathf.Clamp01(mesh.vertices[i].y / maxBoundsInfo.y);
                    var maskCyl = Mathf.Clamp01(MathRemap(Vector3.Distance(mesh.vertices[i], new Vector3(0, mesh.vertices[i].y, 0)), maxBoundsInfo.x * 0.1f, maxBoundsInfo.x, 0f, 1f));
                    var maskCap = Vector3.Magnitude(new Vector3(0, Mathf.Clamp01(MathRemap(mesh.vertices[i].y / maxBoundsInfo.y, 0.8f, 1f, 0f, 1f)), 0));
                    var maskBase = Mathf.Clamp01(MathRemap(mesh.vertices[i].y / maxBoundsInfo.y, 0f, 0.1f, 0f, 1f));
                    var mask = Mathf.Clamp01(maskCyl + maskCap) * maskBase * height;

                    meshChannel.Add(mask);
                }
            }

            return meshChannel;
        }

        List<float> GetMask3rdPartyData(Mesh mesh, int option)
        {
            var meshChannel = new List<float>();

            // CTI Leaves Mask
            if (option == 0)
            {
                for (int i = 0; i < mesh.vertexCount; i++)
                {
                    var pivotX = (Mathf.Repeat(mesh.uv3[i].x, 1.0f) * 2.0f) - 1.0f;
                    var pivotZ = (Mathf.Repeat(32768.0f * mesh.uv3[i].x, 1.0f) * 2.0f) - 1.0f;
                    var pivotY = Mathf.Sqrt(1.0f - Mathf.Clamp01(Vector2.Dot(new Vector2(pivotX, pivotZ), new Vector2(pivotX, pivotZ))));

                    var pivot = new Vector3(pivotX * mesh.uv3[i].y, pivotY * mesh.uv3[i].y, pivotZ * mesh.uv3[i].y);
                    var pos = mesh.vertices[i];

                    var mask = Vector3.Magnitude(pos - pivot) / (maxBoundsInfo.x * 1f);

                    meshChannel.Add(mask);
                }
            }
            // CTI Leaves Variation
            else if (option == 1)
            {
                for (int i = 0; i < mesh.vertexCount; i++)
                {
                    var pivotX = (Mathf.Repeat(mesh.uv3[i].x, 1.0f) * 2.0f) - 1.0f;
                    var pivotZ = (Mathf.Repeat(32768.0f * mesh.uv3[i].x, 1.0f) * 2.0f) - 1.0f;
                    var pivotY = Mathf.Sqrt(1.0f - Mathf.Clamp01(Vector2.Dot(new Vector2(pivotX, pivotZ), new Vector2(pivotX, pivotZ))));

                    var pivot = new Vector3(pivotX * mesh.uv3[i].y, pivotY * mesh.uv3[i].y, pivotZ * mesh.uv3[i].y);

                    var variX = Mathf.Repeat(pivot.x * 33.3f, 1.0f);
                    var variY = Mathf.Repeat(pivot.y * 33.3f, 1.0f);
                    var variZ = Mathf.Repeat(pivot.z * 33.3f, 1.0f);

                    var mask = variX + variY + variZ;

                    if (mesh.uv3[i].x < 0.01f)
                    {
                        mask = 0.0f;
                    }

                    meshChannel.Add(mask);
                }
            }
            // ST8 Leaves Mask
            else if (option == 2)
            {
                var UV2 = new List<Vector4>();
                var UV3 = new List<Vector4>();
                var UV4 = new List<Vector4>();

                mesh.GetUVs(1, UV2);
                mesh.GetUVs(2, UV3);
                mesh.GetUVs(3, UV4);

                if (UV4.Count != 0)
                {
                    for (int i = 0; i < mesh.vertexCount; i++)
                    {
                        var anchor = new Vector3(UV2[i].z - mesh.vertices[i].x, UV2[i].w - mesh.vertices[i].y, UV3[i].w - mesh.vertices[i].z);
                        var length = Vector3.Magnitude(anchor);
                        var leaves = UV2[i].w * UV4[i].w;

                        var mask = (length * leaves) / maxBoundsInfo.x;

                        meshChannel.Add(mask);
                    }
                }
                else
                {
                    for (int i = 0; i < mesh.vertexCount; i++)
                    {
                        var mask = Mathf.Clamp01(mesh.vertices[i].y / maxBoundsInfo.y);

                        meshChannel.Add(mask);
                    }
                }
            }
            // NM Leaves Mask
            else if (option == 3)
            {
                var tempColors = new List<Color>();
                mesh.GetColors(tempColors);

                //Debug.Log(mesh.vertexCount);
                //Debug.Log(tempColors.Count);

                if (tempColors.Count != 0)
                {
                    for (int i = 0; i < mesh.vertexCount; i++)
                    {
                        if (tempColors[i].a > 0.99f)
                        {
                            meshChannel.Add(0.0f);
                        }
                        else
                        {
                            meshChannel.Add(tempColors[i].a);
                        }
                    }
                }
                else
                {
                    for (int i = 0; i < mesh.vertexCount; i++)
                    {
                        var mask = Mathf.Clamp01(mesh.vertices[i].y / maxBoundsInfo.y);

                        meshChannel.Add(mask);
                    }
                }
            }

            return meshChannel;
        }

        List<float> GenerateRandomVariation(Mesh mesh)
        {
            // Good Enough approach
            var meshVariation = new List<float>();

            for (int i = 0; i < mesh.vertexCount; i++)
            {
                meshVariation.Add(-99);
            }

            for (int i = 0; i < mesh.triangles.Length; i += 3)
            {
                var index1 = mesh.triangles[i + 0];
                var index2 = mesh.triangles[i + 1];
                var index3 = mesh.triangles[i + 2];

                float variation = 0;

                if (meshVariation[index1] != -99)
                {
                    variation = meshVariation[index1];
                }
                else if (meshVariation[index2] != -99)
                {
                    variation = meshVariation[index2];
                }
                else if (meshVariation[index3] != -99)
                {
                    variation = meshVariation[index3];
                }
                else
                {
                    variation = Random.Range(0.0f, 1.0f);
                }

                meshVariation[index1] = variation;
                meshVariation[index2] = variation;
                meshVariation[index3] = variation;
            }

            return meshVariation;
        }

        List<float> GeneratePredictiveVariation(Mesh mesh)
        {
            var elementIndices = new List<int>();
            var elementVariation = new List<float>();
            int elementCount = 0;

            for (int i = 0; i < mesh.vertexCount; i++)
            {
                elementIndices.Add(-99);
            }

            //for (int i = 0; i < mesh.vertexCount; i++)
            //{
            //    elementVariation.Add(0.0f);
            //}

            for (int i = 0; i < mesh.triangles.Length; i += 3)
            {
                var index1 = mesh.triangles[i + 0];
                var index2 = mesh.triangles[i + 1];
                var index3 = mesh.triangles[i + 2];

                int element = 0;

                if (elementIndices[index1] != -99)
                {
                    element = elementIndices[index1];
                }
                else if (elementIndices[index2] != -99)
                {
                    element = elementIndices[index2];
                }
                else if (elementIndices[index3] != -99)
                {
                    element = elementIndices[index3];
                }
                else
                {
                    element = elementCount;
                    elementCount++;
                }

                elementIndices[index1] = element;
                elementIndices[index2] = element;
                elementIndices[index3] = element;
            }

            for (int i = 0; i < elementIndices.Count; i++)
            {
                var variation = (float)elementIndices[i] / elementCount;
                variation = Mathf.Repeat(variation * seed, 1.0f);
                elementVariation.Add(variation);
            }

            return elementVariation;
        }

        // Get Vector2 data
        List<Vector4> GetCoordData(Mesh mesh, int source, int option)
        {
            var meshCoord = new List<Vector4>();

            if (source == 0)
            {
                mesh.GetUVs(0, meshCoord);
            }
            else if (source == 1)
            {
                meshCoord = GetCoordMeshData(mesh, option);
            }
            else if (source == 2)
            {
                meshCoord = GetCoordProceduralData(mesh, option);
            }
            else if (source == 3)
            {
                meshCoord = GetCoord3rdPartyData(mesh, option);
            }

            if (meshCoord.Count == 0)
            {
                for (int i = 0; i < mesh.vertexCount; i++)
                {
                    meshCoord.Add(Vector4.zero);
                }

                //Debug.Log("[The Vegetation Engine] " + mesh.name + " does not have " + SourceCoordMeshEnum[option] + ". UV Coord 0 has been assigned instead!");
            }

            return meshCoord;
        }

        List<Vector4> GetCoordMeshData(Mesh mesh, int option)
        {
            var meshCoord = new List<Vector4>();

            if (option == 0)
            {
                mesh.GetUVs(0, meshCoord);
            }

            else if (option == 1)
            {
                mesh.GetUVs(1, meshCoord);
            }

            else if (option == 2)
            {
                mesh.GetUVs(2, meshCoord);
            }

            else if (option == 3)
            {
                mesh.GetUVs(3, meshCoord);
            }

            return meshCoord;
        }

        List<Vector4> GetCoordProceduralData(Mesh mesh, int option)
        {
            var meshCoord = new List<Vector4>();

            // Planar XZ
            if (option == 0)
            {
                for (int i = 0; i < mesh.vertexCount; i++)
                {
                    meshCoord.Add(new Vector4(mesh.vertices[i].x, mesh.vertices[i].z, 0, 0));
                }
            }
            // Planar XY
            else if (option == 1)
            {
                for (int i = 0; i < mesh.vertexCount; i++)
                {
                    meshCoord.Add(new Vector4(mesh.vertices[i].x, mesh.vertices[i].y, 0, 0));
                }
            }
            // Planar ZY
            else if (option == 2)
            {
                for (int i = 0; i < mesh.vertexCount; i++)
                {
                    meshCoord.Add(new Vector4(mesh.vertices[i].z, mesh.vertices[i].y, 0, 0));
                }
            }
            // Procedural Pivots XZ
            else if (option == 3)
            {
                meshCoord = GenerateElementPivot(mesh);
            }

            return meshCoord;
        }

        List<Vector4> GetCoord3rdPartyData(Mesh mesh, int option)
        {
            var meshCoord = new List<Vector4>();

            // NM Trunk Blend
            if (option == 0)
            {
                mesh.GetUVs(2, meshCoord);

                if (meshCoord.Count == 0)
                {
                    mesh.GetUVs(1, meshCoord);
                }
            }

            return meshCoord;
        }


        List<Vector4> GenerateElementPivot(Mesh mesh)
        {
            var elementIndices = new List<int>();
            var meshPivots = new List<Vector4>();
            int elementCount = 0;

            for (int i = 0; i < mesh.vertexCount; i++)
            {
                elementIndices.Add(-99);
            }

            for (int i = 0; i < mesh.vertexCount; i++)
            {
                meshPivots.Add(Vector3.zero);
            }

            for (int i = 0; i < mesh.triangles.Length; i += 3)
            {
                var index1 = mesh.triangles[i + 0];
                var index2 = mesh.triangles[i + 1];
                var index3 = mesh.triangles[i + 2];

                int element = 0;

                if (elementIndices[index1] != -99)
                {
                    element = elementIndices[index1];
                }
                else if (elementIndices[index2] != -99)
                {
                    element = elementIndices[index2];
                }
                else if (elementIndices[index3] != -99)
                {
                    element = elementIndices[index3];
                }
                else
                {
                    element = elementCount;
                    elementCount++;
                }

                elementIndices[index1] = element;
                elementIndices[index2] = element;
                elementIndices[index3] = element;
            }

            for (int e = 0; e < elementCount; e++)
            {
                var positions = new List<Vector3>();

                for (int i = 0; i < elementIndices.Count; i++)
                {
                    if (elementIndices[i] == e)
                    {
                        positions.Add(mesh.vertices[i]);
                    }
                }

                float x = 0;
                float z = 0;

                for (int p = 0; p < positions.Count; p++)
                {
                    x = x + positions[p].x;
                    z = z + positions[p].z;
                }

                for (int i = 0; i < elementIndices.Count; i++)
                {
                    if (elementIndices[i] == e)
                    {
                        meshPivots[i] = new Vector3(x / positions.Count, z / positions.Count);
                    }
                }
            }

            return meshPivots;
        }

        void GetNormalsData(Mesh mesh, int source, int option)
        {
            if (source == 1)
            {
                if (option == 0)
                {
                    mesh.RecalculateNormals();
                    mesh.RecalculateTangents();
                }

                // Flat Shading Low
                else if (option == 1)
                {
                    Vector3[] normals = new Vector3[mesh.vertices.Length];

                    for (int i = 0; i < mesh.vertexCount; i++)
                    {
                        var height = Mathf.Clamp01(mesh.vertices[i].y / maxBoundsInfo.y);

                        if (mesh.normals != null)
                        {
                            normals[i] = Vector3.Lerp(mesh.normals[i], new Vector3(0, 1, 0), height);
                        }
                        else
                        {
                            normals[i] = new Vector3(0, 1, 0);
                        }
                    }

                    mesh.normals = normals;
                    mesh.RecalculateTangents();
                }

                // Flat Shading Medium
                else if (option == 2)
                {
                    Vector3[] normals = new Vector3[mesh.vertices.Length];

                    for (int i = 0; i < mesh.vertexCount; i++)
                    {
                        var height = Mathf.Clamp01(Mathf.Clamp01(mesh.vertices[i].y / maxBoundsInfo.y) + 0.5f);

                        if (mesh.normals != null)
                        {
                            normals[i] = Vector3.Lerp(mesh.normals[i], new Vector3(0, 1, 0), height);
                        }
                        else
                        {
                            normals[i] = new Vector3(0, 1, 0);
                        }
                    }

                    mesh.normals = normals;
                    mesh.RecalculateTangents();
                }

                // Flat Shading Full
                else if (option == 3)
                {
                    Vector3[] normals = new Vector3[mesh.vertices.Length];

                    for (int i = 0; i < mesh.vertexCount; i++)
                    {
                        normals[i] = new Vector3(0, 1, 0);
                    }

                    mesh.normals = normals;
                    mesh.RecalculateTangents();
                }

                // Spherical Shading
                else if (option == 4)
                {
                    Vector3[] normals = new Vector3[mesh.vertices.Length];

                    for (int i = 0; i < mesh.vertexCount; i++)
                    {
                        normals[i] = Vector3.Normalize(mesh.vertices[i]);
                    }

                    mesh.normals = normals;
                    mesh.RecalculateTangents();
                }
            }
        }

        //Encode Vector3 to 8bit per channel Float based on: https://developer.download.nvidia.com/cg/pack.html
        List<float> EncodeVector3ToFloat(int vertexCount, List<float> source1, List<float> source2, List<float> source3)
        {
            var encoded = new List<float>();

            for (int i = 0; i < vertexCount; i++)
            {
                var x = Mathf.RoundToInt(255.0f * Mathf.Clamp01(source1[i]));
                var y = Mathf.RoundToInt(255.0f * Mathf.Clamp01(source2[i]));
                var z = Mathf.RoundToInt(255.0f * Mathf.Clamp01(source3[i]));
                //int w = 0;

                int result = /*(w << 24) |*/ (z << 16) | (y << 8) | x;

                encoded.Add(result);
            }

            return encoded;
        }

        List<float> EncodeVector3ToFloat(int vertexCount, List<Vector3> source)
        {
            var encoded = new List<float>();

            for (int i = 0; i < vertexCount; i++)
            {
                var x = Mathf.RoundToInt(255.0f * Mathf.Clamp01(source[i].x));
                var y = Mathf.RoundToInt(255.0f * Mathf.Clamp01(source[i].y));
                var z = Mathf.RoundToInt(255.0f * Mathf.Clamp01(source[i].z));
                //int w = 0;

                int result = /*(w << 24) |*/ (z << 16) | (y << 8) | x;

                encoded.Add(result);
            }

            return encoded;
        }

        float GetMeshArea(Mesh mesh)
        {
            float result = 0;

            for (int p = mesh.vertices.Length - 1, q = 0; q < mesh.vertices.Length; p = q++)
            {
                result += Vector3.Cross(mesh.vertices[q], mesh.vertices[p]).magnitude;
            }
            return result * 0.5f;
        }

        /// <summary>
        /// Mesh Actions
        /// </summary>

        List<float> MathAction(List<float> source, int action)
        {
            if (action == 1)
            {
                source = MathInvert(source);
            }
            else if (action == 2)
            {
                source = MathRemap01(source);
            }

            return source;
        }

        List<float> MathInvert(List<float> source)
        {
            for (int i = 0; i < source.Count; i++)
            {
                source[i] = 1.0f - source[i];
            }

            return source;
        }

        List<float> MathRemap01(List<float> source)
        {
            float min = source[0];
            float max = source[0];

            for (int i = 0; i < source.Count; i++)
            {
                if (source[i] < min)
                    min = source[i];

                if (source[i] > max)
                    max = source[i];
            }

            // Avoid divide by 0
            if (min != max)
            {
                for (int i = 0; i < source.Count; i++)
                {
                    source[i] = (source[i] - min) / (max - min);
                }
            }
            else
            {
                for (int i = 0; i < source.Count; i++)
                {
                    source[i] = 0.0f;
                }
            }

            return source;
        }

        List<float> MathRemap01InBounds(List<float> source, int channel)
        {
            float max = 0;


            if (channel == 1)
            {
                max = maxBoundsInfo.y;
            }


            for (int i = 0; i < source.Count; i++)
            {
                source[i] = source[i] / max;
            }

            return source;
        }

        float MathRemap(float value, float low1, float high1, float low2, float high2)
        {
            return low2 + (value - low1) * (high2 - low2) / (high1 - low1);
        }

        /// <summary>
        /// Convert Macros
        /// </summary>

        void GetMaterialConversionFromPreset(Material material, Material materialInstance)
        {
            var allMaterialKeyords = material.shaderKeywords;
            var materialKeywords = new List<string>();

            for (int i = 0; i < allMaterialKeyords.Length; i++)
            {
                materialKeywords.Add(allMaterialKeyords[i]);
            }

            var presetLinesCount = GetBreakConditionFromPreset(material);

            for (int i = 0; i < presetLinesCount; i++)
            {
                if (presetLines[i].StartsWith("Material"))
                {
                    string[] splitLine = presetLines[i].Split(char.Parse(" "));

                    var type = "";
                    var src = "";
                    var dst = "";
                    var val = "";
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
                        dst = splitLine[3];
                        x = splitLine[3];
                        //Debug.Log(dst);
                    }

                    if (splitLine.Length > 4)
                    {
                        val = splitLine[4];
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

                    // Set the shader first
                    if (type == "SHADER_NAME_TO_SHADER")
                    {
                        if (material.shader.name.Contains(src))
                        {
                            materialInstance.shader = GetShaderFromPreset(dst);
                        }
                    }

                    else if (type == "KEYWORD_ON_TO_SHADER")
                    {
                        if (materialKeywords.Contains(src) && material.IsKeywordEnabled(src) == true)
                        {
                            materialInstance.shader = GetShaderFromPreset(dst);
                        }
                    }

                    else if (type == "RENDERTYPE_TAG_TO_SHADER")
                    {
                        if (material.GetTag("RenderType", false) == src)
                        {
                            materialInstance.shader = GetShaderFromPreset(dst);
                        }
                    }

                    else if (type == "RENDERTYPE_TAG_TO_FLOAT")
                    {
                        if (material.GetTag("RenderType", false) == src)
                        {
                            materialInstance.SetFloat(dst, float.Parse(val, CultureInfo.InvariantCulture));
                        }
                    }

                    else if (type == "KEYWORD_OFF_TO_SHADER")
                    {
                        if (materialKeywords.Contains(src) && material.IsKeywordEnabled(src) == false)
                        {
                            materialInstance.shader = GetShaderFromPreset(dst);
                        }
                    }

                    else if (type == "FLOAT_TO_SHADER")
                    {
                        var min = float.Parse(x, CultureInfo.InvariantCulture) - 0.1f;
                        var max = float.Parse(x, CultureInfo.InvariantCulture) + 0.1f;

                        if (material.HasProperty(src) && material.GetFloat(src) > min && material.GetFloat(src) < max)
                        {
                            materialInstance.shader = GetShaderFromPreset(val);
                        }
                    }

                    // Set props by shader
                    else if (type == "SHADER_NAME_TO_FLOAT")
                    {
                        if (material.shader.name.Contains(src))
                        {
                            materialInstance.SetFloat(dst, float.Parse(val, CultureInfo.InvariantCulture));
                        }
                    }

                    else if (type == "SHADER_NAME_TO_KEYWORD_ON")
                    {
                        if (material.shader.name.Contains(src))
                        {
                            materialInstance.EnableKeyword(dst);
                        }
                    }

                    else if (type == "SHADER_NAME_TO_KEYWORD_OFF")
                    {
                        if (material.shader.name.Contains(src))
                        {
                            materialInstance.DisableKeyword(dst);
                        }
                    }

                    // Copy material properties
                    else if (type == "COPY_TEX")
                    {
                        if (material.HasProperty(src))
                        {
                            materialInstance.SetTexture(dst, material.GetTexture(src));
                        }
                    }

                    else if (type == "COPY_COLOR")
                    {
                        if (material.HasProperty(src))
                        {
                            materialInstance.SetColor(dst, material.GetColor(src).linear);
                        }
                    }

                    else if (type == "COPY_VECTOR")
                    {
                        if (material.HasProperty(src))
                        {
                            materialInstance.SetVector(dst, material.GetVector(src));
                        }
                    }

                    else if (type == "COPY_ST_AS_VECTOR")
                    {
                        if (material.HasProperty(src))
                        {
                            Vector4 uvs = new Vector4(material.GetTextureScale(src).x, material.GetTextureScale(src).y,
                                                      material.GetTextureOffset(src).x, material.GetTextureOffset(src).y);

                            materialInstance.SetVector(dst, uvs);
                        }
                    }

                    else if (type == "COPY_FLOAT")
                    {
                        if (material.HasProperty(src))
                        {
                            materialInstance.SetFloat(dst, material.GetFloat(src));
                        }
                    }

                    else if (type == "KEYWORD_ON_TO_KEYWORD_ON")
                    {
                        if (materialKeywords.Contains(src) && material.IsKeywordEnabled(src) == true)
                        {
                            materialInstance.EnableKeyword(dst);
                        }
                    }

                    else if (type == "KEYWORD_ON_TO_KEYWORD_OFF")
                    {
                        if (materialKeywords.Contains(src) && material.IsKeywordEnabled(src) == true)
                        {
                            materialInstance.DisableKeyword(dst);
                        }
                    }

                    else if (type == "KEYWORD_OFF_TO_KEYWORD_ON")
                    {
                        if (materialKeywords.Contains(src) && material.IsKeywordEnabled(src) == false)
                        {
                            materialInstance.EnableKeyword(dst);
                        }
                    }

                    else if (type == "KEYWORD_OFF_TO_KEYWORD_OFF")
                    {
                        if (materialKeywords.Contains(src) && material.IsKeywordEnabled(src) == false)
                        {
                            materialInstance.DisableKeyword(dst);
                        }
                    }

                    else if (type == "KEYWORD_ON_TO_FLOAT")
                    {
                        if (materialKeywords.Contains(src) && material.IsKeywordEnabled(src) == true)
                        {
                            materialInstance.SetFloat(dst, float.Parse(val, CultureInfo.InvariantCulture));
                        }
                    }

                    else if (type == "KEYWORD_OFF_TO_FLOAT")
                    {
                        if (materialKeywords.Contains(src) && material.IsKeywordEnabled(src) == false)
                        {
                            materialInstance.SetFloat(dst, float.Parse(val, CultureInfo.InvariantCulture));
                        }
                    }

                    else if (type == "FLOAT_TO_KEYWORD_ON")
                    {
                        var min = float.Parse(x) - 0.1f;
                        var max = float.Parse(x) + 0.1f;

                        if (material.HasProperty(src) && material.GetFloat(src) > min && material.GetFloat(src) < max)
                        {
                            materialInstance.EnableKeyword(val);
                        }
                    }

                    else if (type == "FLOAT_TO_KEYWORD_OFF")
                    {
                        var min = float.Parse(x, CultureInfo.InvariantCulture) - 0.1f;
                        var max = float.Parse(x, CultureInfo.InvariantCulture) + 0.1f;

                        if (material.HasProperty(src) && material.GetFloat(src) > min && material.GetFloat(src) < max)
                        {
                            materialInstance.DisableKeyword(val);
                        }
                    }

                    else if (type == "HAS_PROP_TO_FLOAT")
                    {
                        if (material.HasProperty(src))
                        {
                            materialInstance.SetFloat(dst, float.Parse(val, CultureInfo.InvariantCulture));
                        }
                    }

                    else if (type == "HAS_PROP_TO_KEYWORD_ON")
                    {
                        if (material.HasProperty(src))
                        {
                            materialInstance.EnableKeyword(dst);
                        }
                    }

                    else if (type == "HAS_PROP_TO_KEYWORD_OFF")
                    {
                        if (material.HasProperty(src))
                        {
                            materialInstance.DisableKeyword(dst);
                        }
                    }

                    else if (type == "FLOAT_TO_FLOAT")
                    {
                        var min = float.Parse(x, CultureInfo.InvariantCulture) - 0.1f;
                        var max = float.Parse(x, CultureInfo.InvariantCulture) + 0.1f;

                        if (material.HasProperty(src) && material.GetFloat(src) > min && material.GetFloat(src) < max)
                        {
                            materialInstance.SetFloat(val, float.Parse(z, CultureInfo.InvariantCulture));
                        }
                    }

                    else if (type == "ENABLE_KEYWORD")
                    {
                        materialInstance.EnableKeyword(set);
                    }

                    else if (type == "DISABLE_KEYWORD")
                    {
                        materialInstance.DisableKeyword(set);
                    }

                    else if (type == "SET_SHADER")
                    {
                        materialInstance.shader = GetShaderFromPreset(set);
                    }

                    else if (type == "SET_SHADER_BY_NAME")
                    {
                        if (material.shader.name.Contains(src))
                        {
                            var shader = presetLines[i].Replace("Material SET_SHADER_BY_NAME ", "");

                            if (Shader.Find(shader) != null)
                            {
                                materialInstance.shader = Shader.Find(shader);
                            }
                        }
                    }

                    else if (type == "SET_FLOAT")
                    {
                        materialInstance.SetFloat(set, float.Parse(x, CultureInfo.InvariantCulture));
                    }

                    else if (type == "SET_COLOR")
                    {
                        materialInstance.SetColor(set, new Color(float.Parse(x, CultureInfo.InvariantCulture), float.Parse(y, CultureInfo.InvariantCulture), float.Parse(z, CultureInfo.InvariantCulture), float.Parse(w, CultureInfo.InvariantCulture)));
                    }

                    else if (type == "SET_VECTOR")
                    {
                        materialInstance.SetVector(set, new Vector4(float.Parse(x, CultureInfo.InvariantCulture), float.Parse(y, CultureInfo.InvariantCulture), float.Parse(z, CultureInfo.InvariantCulture), float.Parse(w, CultureInfo.InvariantCulture)));
                    }
                }
            }
        }

        Shader GetShaderFromPreset(string check)
        {
            var shader = shaderLeaf;

            if (check == "SHADER_DEFAULT_CROSS")
            {
                shader = shaderCross;
            }
            else if (check == "SHADER_DEFAULT_LEAF")
            {
                shader = shaderLeaf;
            }
            else if (check == "SHADER_DEFAULT_BARK")
            {
                shader = shaderBark;
            }
            else if (check == "SHADER_DEFAULT_GRASS")
            {
                shader = shaderGrass;
            }
            else if (check == "SHADER_DEFAULT_PROP")
            {
                shader = shaderProp;
            }

            return shader;
        }

        void ConvertMaterials()
        {
            for (int i = 0; i < materialArraysInPrefab.Count; i++)
            {
                if (materialArraysInPrefab[i] != null)
                {
                    for (int j = 0; j < materialArraysInPrefab[i].Length; j++)
                    {
                        var material = materialArraysInPrefab[i][j];
                        var materialInstance = materialArraysInstances[i][j];

                        if (IsValidMaterial(material))
                        {
                            ConvertMaterial(material, materialInstance);
                            materialArraysInstances[i][j] = convertedMaterial;
                        }
                        else
                        {
                            materialArraysInstances[i][j] = material;
                        }
                    }
                }
            }
        }

        void ConvertMaterial(Material material, Material materialInstance)
        {
            if (conversionTypeIndex == (int)ConversionOutput.Vegetation)
            {
                materialInstance.shader = shaderLeaf;
                materialInstance.SetFloat("_RenderClip", 1f);
            }

            if (conversionTypeIndex == (int)ConversionOutput.StaticObject)
            {
                materialInstance.shader = shaderProp;
                materialInstance.SetFloat("_RenderClip", 0f);
            }

            if (conversionTypeIndex == (int)ConversionOutput.TerrainDetail)
            {
                materialInstance.shader = shaderGrass;
                materialInstance.SetFloat("_RenderClip", 1f);
            }

            SetMaterialInitSettings(materialInstance);
            GetMaterialConversionFromPreset(material, materialInstance);
            SetMaterialPostSettings(materialInstance);

            TVEShaderUtils.SetRenderSettings(materialInstance);

            SaveMaterial(materialInstance);
        }

        void SaveMaterial(Material materialInstance)
        {
            var saveFullPath = prefabDataFolder + "/" + materialInstance.name + " (TVE Material).mat";

            if (File.Exists(saveFullPath))
            {
                var materialFile = AssetDatabase.LoadAssetAtPath<Material>(saveFullPath);
                EditorUtility.CopySerialized(materialInstance, materialFile);
            }
            else
            {
                AssetDatabase.CreateAsset(materialInstance, saveFullPath);
            }

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            convertedMaterial = AssetDatabase.LoadAssetAtPath<Material>(saveFullPath);
        }

        void AssignConvertedMaterials()
        {
            for (int i = 0; i < meshRenderersInPrefab.Count; i++)
            {
                if (meshRenderersInPrefab[i] != null)
                {
                    meshRenderersInPrefab[i].sharedMaterials = materialArraysInstances[i];
                }
            }
        }

        void SetMaterialInitSettings(Material material)
        {
            // Set bounds info
            material.SetVector("_MaxBoundsInfo", maxBoundsInfo);

            // Set some initial motion settings
            material.SetFloat("_MotionAmplitude_10", 0.05f);
            material.SetFloat("_MotionSpeed_10", 2);
            material.SetFloat("_MotionScale_10", 0);
            material.SetFloat("_MotionVariation_10", 0);

            material.SetFloat("_MotionAmplitude_20", 0.1f);
            material.SetFloat("_MotionSpeed_20", 6);
            material.SetFloat("_MotionScale_20", 0);
            material.SetFloat("_MotionVariation_20", 5);

            material.SetFloat("_MotionAmplitude_30", 0.5f);
            material.SetFloat("_MotionSpeed_30", 8);
            material.SetFloat("_MotionScale_30", 10);
            material.SetFloat("_MotionVariation_30", 10);

            material.SetFloat("_MotionAmplitude_32", 0.2f);
            material.SetFloat("_MotionSpeed_32", 30);
            material.SetFloat("_MotionScale_32", 10);
            material.SetFloat("_MotionVariation_32", 15);

            material.SetFloat("_InteractionAmplitude", 1f);
        }

        void SetMaterialPostSettings(Material material)
        {
            if (sourceDetailCoord > 0 && optionDetailCoord == 3)
            {
                material.SetInt("_VertexPivotMode", 1);
            }

            if (sourceVariation > 0 && (optionVariation == 2 || optionVariation == 3))
            {
                material.SetInt("_VertexVariationMode", 1);
            }
        }

        bool IsValidMaterial(Material material)
        {
            bool valid = true;
            int i = 0;

            if (material == null)
            {
                i++;
            }

            if (material != null && material.HasProperty("_IsTVEShader") == true)
            {
                i++;
            }

            if (i > 0)
            {
                valid = false;
            }

            return valid;
        }

        /// <summary>
        /// Packed Texture Utils
        /// </summary>

        //void GetTextureConversionFromPreset2(Material material)
        //{
        //    var presetLinesCount = GetBreakConditionFromPreset(material);

        //    for (int i = 0; i < presetLinesCount; i++)
        //    {
        //        if (presetLines[i].StartsWith("Texture"))
        //        {
        //            string[] splitLine = presetLines[i].Split(char.Parse(" "));
        //            string pack = "";
        //            string getR = "";
        //            string texR = "";
        //            string getG = "";
        //            string texG = "";
        //            string getB = "";
        //            string texB = "";
        //            string texA = "";
        //            string getA = "";

        //            if (splitLine.Length > 1)
        //            {
        //                pack = splitLine[1];


        //            }

        //            if (splitLine.Length > 2)
        //            {
        //                pack = splitLine[2];

        //                if (pack == "NONE")
        //                {
        //                    packChannel = 0;
        //                }

        //                if (pack == "GET_RED")
        //                {
        //                    packChannel = 1;
        //                }

        //                if (pack == "GET_GREEN")
        //                {
        //                    packChannel = 2;
        //                }

        //                if (pack == "GET_BLUE")
        //                {
        //                    packChannel = 3;
        //                }

        //                if (pack == "GET_ALPHA")
        //                {
        //                    packChannel = 4;
        //                }

        //                if (pack == "GET_GRAY")
        //                {
        //                    packChannel = 555;
        //                }

        //                if (pack == "GET_GREY")
        //                {
        //                    packChannel = 555;
        //                }
        //            }

        //            if (splitLine.Length > 3)
        //            {
        //                tex = splitLine[3];
        //            }

        //            maskChannels[maskIndex] = packChannel;

        //            if (material.HasProperty(tex) && material.GetTexture(tex) != null)
        //            {
        //                maskTextures[maskIndex] = material.GetTexture(tex);
        //            }
        //        }
        //    }
        //}

        void GetTextureConversionFromPreset(Material material)
        {
            maskChannels = new int[8];
            maskTextures = new Texture[8];

            for (int i = 0; i < 8; i++)
            {
                maskChannels[i] = 0;
                maskTextures[i] = null;
            }

            var presetLinesCount = GetBreakConditionFromPreset(material);

            for (int i = 0; i < presetLinesCount; i++)
            {
                if (presetLines[i].StartsWith("Texture"))
                {
                    string[] splitLine = presetLines[i].Split(char.Parse(" "));
                    string mask = "";
                    string pack = "";
                    string tex = "";

                    int maskIndex = 0;
                    int packChannel = 0;

                    if (splitLine.Length > 1)
                    {
                        mask = splitLine[1];

                        if (mask == "MainMetallic")
                        {
                            maskIndex = 0;
                        }

                        if (mask == "MainOcclusion")
                        {
                            maskIndex = 1;
                        }

                        if (mask == "MainMask")
                        {
                            maskIndex = 2;
                        }

                        if (mask == "MainSmoothness")
                        {
                            maskIndex = 3;
                        }

                        if (mask == "SecondMetallic")
                        {
                            maskIndex = 4;
                        }

                        if (mask == "SecondOcclusion")
                        {
                            maskIndex = 5;
                        }

                        if (mask == "SecondMask")
                        {
                            maskIndex = 6;
                        }

                        if (mask == "SecondSmoothness")
                        {
                            maskIndex = 7;
                        }
                    }

                    if (splitLine.Length > 2)
                    {
                        pack = splitLine[2];

                        if (pack == "NONE")
                        {
                            packChannel = 0;
                        }

                        if (pack == "GET_RED")
                        {
                            packChannel = 1;
                        }

                        if (pack == "GET_GREEN")
                        {
                            packChannel = 2;
                        }

                        if (pack == "GET_BLUE")
                        {
                            packChannel = 3;
                        }

                        if (pack == "GET_ALPHA")
                        {
                            packChannel = 4;
                        }

                        if (pack == "GET_GRAY")
                        {
                            packChannel = 555;
                        }

                        if (pack == "GET_GREY")
                        {
                            packChannel = 555;
                        }
                    }

                    if (splitLine.Length > 3)
                    {
                        tex = splitLine[3];
                    }

                    maskChannels[maskIndex] = packChannel;

                    if (material.HasProperty(tex) && material.GetTexture(tex) != null)
                    {
                        maskTextures[maskIndex] = material.GetTexture(tex);
                    }
                }
            }
        }

        void PackTextures()
        {
            packedTextureNames = new List<string>();
            packedTextureObjcts = new List<Texture>();

            int id = 0;

            for (int i = 0; i < materialArraysInPrefab.Count; i++)
            {
                if (materialArraysInPrefab[i] != null)
                {
                    for (int j = 0; j < materialArraysInPrefab[i].Length; j++)
                    {
                        var material = materialArraysInPrefab[i][j];
                        var materialInstance = materialArraysInstances[i][j];

                        if (material != null)
                        {
                            GetTextureConversionFromPreset(material);

                            if (maskTextures[0] != null || maskTextures[1] != null || maskTextures[2] != null || maskTextures[3] != null)
                            {
                                var name = GetPackedTextureName(maskTextures[0], maskTextures[1], maskTextures[2], maskTextures[3]);
                                bool exist = false;

                                for (int n = 0; n < packedTextureNames.Count; n++)
                                {
                                    if (packedTextureNames[n] == name)
                                    {
                                        materialInstance.SetTexture("_MainMaskTex", packedTextureObjcts[n]);
                                        exist = true;
                                    }
                                }

                                if (exist == false)
                                {
                                    id++;
                                    PackTexture(material, materialInstance, MAIN_MASK, name, id);
                                }
                            }

                            if (maskTextures[4] != null || maskTextures[5] != null || maskTextures[6] != null || maskTextures[7] != null)
                            {
                                var name = GetPackedTextureName(maskTextures[4], maskTextures[5], maskTextures[6], maskTextures[7]);
                                bool exist = false;

                                for (int n = 0; n < packedTextureNames.Count; n++)
                                {
                                    if (packedTextureNames[n] == name)
                                    {
                                        materialInstance.SetTexture("_SecondMaskTex", packedTextureObjcts[n]);
                                        exist = true;
                                    }
                                }

                                if (exist == false)
                                {
                                    id++;
                                    PackTexture(material, materialInstance, SECOND_MASK, name, id);
                                }
                            }

                            //if (maskTextures[4] != null || maskTextures[5] != null || maskTextures[6] != null || maskTextures[7] != null)
                            //{
                            //    var path = GetPackedTexturePath(maskTextures[4], maskTextures[5], maskTextures[6], maskTextures[7]);

                            //    if (File.Exists(path))
                            //    {
                            //        GetExistingPackedTexture(path, materialInstance, SECOND_MASK);
                            //    }
                            //    else
                            //    {
                            //        PackTexture(path, material, materialInstance, SECOND_MASK);
                            //    }
                            //}
                        }
                    }
                }
            }
        }

        void PackTexture(Material material, Material materialInstance, int maskType, string name, int id)
        {
            var i = 0;

            if (maskType == 1)
            {
                i = 4;
            }

            string texPath = prefabDataFolder + "/" + "Mask " + id.ToString() + " (TVE Texture)" + ".png";

            int initSize = GetPackedInitSize(maskTextures[i + 0], maskTextures[i + 1], maskTextures[i + 2], maskTextures[i + 3]);

            ResetBlitMaterial();

            //Set Packer R channel
            if (maskTextures[i] != null)
            {
                PrepareSourceTexture(maskTextures[i + 0], i + 0);
                ResetSourceTexture(i + 0);

                blitMaterial.SetTexture("_Packer_TexR", maskTextures[i + 0]);
                blitMaterial.SetInt("_Packer_ChannelR", maskChannels[i + 0]);
            }
            else
            {
                blitMaterial.SetInt("_Packer_ChannelR", NONE);
                blitMaterial.SetFloat("_Packer_FloatR", 1.0f);
            }

            //Set Packer G channel
            if (maskTextures[i + 1] != null)
            {
                PrepareSourceTexture(maskTextures[i + 1], i + 1);
                ResetSourceTexture(i + 1);

                blitMaterial.SetTexture("_Packer_TexG", maskTextures[i + 1]);
                blitMaterial.SetInt("_Packer_ChannelG", maskChannels[i + 1]);
            }
            else
            {
                blitMaterial.SetInt("_Packer_ChannelG", NONE);
                blitMaterial.SetFloat("_Packer_FloatG", 1.0f);
            }

            //Set Packer B channel
            if (maskTextures[i + 2] != null)
            {
                PrepareSourceTexture(maskTextures[i + 2], i + 2);
                ResetSourceTexture(i + 2);

                blitMaterial.SetTexture("_Packer_TexB", maskTextures[i + 2]);
                blitMaterial.SetInt("_Packer_ChannelB", maskChannels[i + 2]);
            }
            else
            {
                blitMaterial.SetInt("_Packer_ChannelB", NONE);
                blitMaterial.SetFloat("_Packer_FloatB", 1.0f);
            }

            //Set Packer A channel
            if (maskTextures[i + 3] != null)
            {
                PrepareSourceTexture(maskTextures[i + 3], i + 3);
                ResetSourceTexture(i + 3);

                blitMaterial.SetTexture("_Packer_TexA", maskTextures[i + 3]);
                blitMaterial.SetInt("_Packer_ChannelA", maskChannels[i + 3]);
            }
            else
            {
                blitMaterial.SetInt("_Packer_ChannelA", NONE);
                blitMaterial.SetFloat("_Packer_FloatA", 1.0f);
            }

            Vector2 pixelSize = GetPackedPixelSize(maskTextures[i + 0], maskTextures[i + 1], maskTextures[i + 2], maskTextures[i + 3]);
            int importSize = GetPackedImportSize(initSize, pixelSize);

            Texture savedPacked = SavePackedTexture(texPath, pixelSize);

            packedTextureNames.Add(name);
            packedTextureObjcts.Add(savedPacked);

            SetTextureImporterSettings(savedPacked, importSize, SRGB, ALPHA_DEFAULT);

            //Apply texture to material
            if (maskType == 0)
            {
                materialInstance.SetTexture("_MainMaskTex", savedPacked);
            }
            else
            {
                materialInstance.SetTexture("_SecondMaskTex", savedPacked);
            }
        }

        void InitTexturePacker()
        {
            blitTexture = Texture2D.whiteTexture;
            blitMaterial = new Material(Shader.Find("Hidden/BOXOPHOBIC/Texture Packer Blit"));

            sourceTexCompressions = new TextureImporterCompression[8];
            sourceimportSizes = new int[8];
            sourceTexImporters = new TextureImporter[8];
            sourceTexSettings = new TextureImporterSettings[8];

            for (int i = 0; i < 8; i++)
            {
                sourceTexCompressions[i] = new TextureImporterCompression();
                sourceTexImporters[i] = new TextureImporter();
                sourceTexSettings[i] = new TextureImporterSettings();
            }
        }

        string GetPackedTextureName(Texture tex1, Texture tex2, Texture tex3, Texture tex4)
        {
            var texName1 = "NULL";
            var texName2 = "NULL";
            var texName3 = "NULL";
            var texName4 = "NULL";

            if (tex1 != null)
            {
                texName1 = tex1.name;
            }

            if (tex2 != null)
            {
                texName2 = tex2.name;
            }

            if (tex3 != null)
            {
                texName3 = tex3.name;
            }

            if (tex4 != null)
            {
                texName4 = tex4.name;
            }

            var name = texName1 + texName2 + texName3 + texName4;

            return name;
        }

        Vector2 GetPackedPixelSize(Texture tex1, Texture tex2, Texture tex3, Texture tex4)
        {
            int x = 32;
            int y = 32;

            if (tex1 != null)
            {
                x = Mathf.Max(x, tex1.width);
                y = Mathf.Max(y, tex1.height);
            }

            if (tex2 != null)
            {
                x = Mathf.Max(x, tex2.width);
                y = Mathf.Max(y, tex2.height);
            }

            if (tex3 != null)
            {
                x = Mathf.Max(x, tex3.width);
                y = Mathf.Max(y, tex3.height);
            }

            if (tex4 != null)
            {
                x = Mathf.Max(x, tex4.width);
                y = Mathf.Max(y, tex4.height);
            }

            //if (maxPackedBakingSize > 0)
            //{
            //    x = Mathf.Max(x, MaxTextureSizes[maxPackedBakingSize]);
            //    y = Mathf.Max(y, MaxTextureSizes[maxPackedBakingSize]);
            //}

            return new Vector2(x, y);
        }

        int GetPackedInitSize(Texture tex1, Texture tex2, Texture tex3, Texture tex4)
        {
            int initSize = 32;

            if (tex1 != null)
            {
                string texPath = AssetDatabase.GetAssetPath(tex1);
                TextureImporter texImporter = AssetImporter.GetAtPath(texPath) as TextureImporter;

                initSize = Mathf.Max(initSize, texImporter.maxTextureSize);
            }

            if (tex2 != null)
            {
                string texPath = AssetDatabase.GetAssetPath(tex2);
                TextureImporter texImporter = AssetImporter.GetAtPath(texPath) as TextureImporter;

                initSize = Mathf.Max(initSize, texImporter.maxTextureSize);
            }

            if (tex3 != null)
            {
                string texPath = AssetDatabase.GetAssetPath(tex3);
                TextureImporter texImporter = AssetImporter.GetAtPath(texPath) as TextureImporter;

                initSize = Mathf.Max(initSize, texImporter.maxTextureSize);
            }

            if (tex4 != null)
            {
                string texPath = AssetDatabase.GetAssetPath(tex4);
                TextureImporter texImporter = AssetImporter.GetAtPath(texPath) as TextureImporter;

                initSize = Mathf.Max(initSize, texImporter.maxTextureSize);
            }

            return initSize;
        }

        int GetPackedImportSize(int initTexImportSize, Vector2 pixelTexSize)
        {
            int pixelSize = (int)Mathf.Max(pixelTexSize.x, pixelTexSize.y);
            int importSize = initTexImportSize;

            if (pixelSize < importSize)
            {
                importSize = pixelSize;
            }

            for (int i = 1; i < MaxTextureSizes.Length - 1; i++)
            {
                int a;
                int b;

                if ((importSize > MaxTextureSizes[i]) && (importSize < MaxTextureSizes[i + 1]))
                {
                    a = Mathf.Abs(MaxTextureSizes[i] - importSize);
                    b = Mathf.Abs(MaxTextureSizes[i + 1] - importSize);

                    if (a < b)
                    {
                        importSize = MaxTextureSizes[i];
                    }
                    else
                    {
                        importSize = MaxTextureSizes[i + 1];
                    }

                    break;
                }
            }

            //if (maxPackedImportSize > 0)
            //{
            //    if (importSize > maxPackedImportSize)
            //    {
            //        importSize = MaxTextureSizes[maxPackedImportSize];
            //    }
            //}

            return importSize;
        }

        Texture SavePackedTexture(string path, Vector2 size)
        {
            if (File.Exists(path))
            {
                FileUtil.DeleteFileOrDirectory(path);
                FileUtil.DeleteFileOrDirectory(path + ".meta");
            }

            RenderTexture renderTexure = new RenderTexture((int)size.x, (int)size.y, 0, RenderTextureFormat.DefaultHDR);

            Graphics.Blit(blitTexture, renderTexure, blitMaterial, 0);

            RenderTexture.active = renderTexure;
            Texture2D packedTexure = new Texture2D(renderTexure.width, renderTexure.height, TextureFormat.ARGB32, false);
            packedTexure.ReadPixels(new Rect(0, 0, renderTexure.width, renderTexure.height), 0, 0);
            packedTexure.Apply();
            RenderTexture.active = null;

            renderTexure.Release();

            byte[] bytes;
            bytes = packedTexure.EncodeToPNG();

            File.WriteAllBytes(path, bytes);

            AssetDatabase.ImportAsset(path);
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            return AssetDatabase.LoadAssetAtPath<Texture>(path);
        }

        void SetTextureImporterSettings(Texture texture, int importSize, bool colorSpace, bool alphaSourceIsOn)
        {
            string texPath = AssetDatabase.GetAssetPath(texture);
            TextureImporter texImporter = AssetImporter.GetAtPath(texPath) as TextureImporter;

            texImporter.maxTextureSize = importSize;
            texImporter.sRGBTexture = colorSpace;
            if (alphaSourceIsOn)
            {
                texImporter.alphaSource = TextureImporterAlphaSource.FromInput;
            }
            else
            {
                texImporter.alphaSource = TextureImporterAlphaSource.None;
            }

            texImporter.SaveAndReimport();
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
        }

        void ResetBlitMaterial()
        {
            blitMaterial = new Material(Shader.Find("Hidden/BOXOPHOBIC/Texture Packer Blit"));
        }

        void PrepareSourceTexture(Texture texture, int channel)
        {
            string texPath = AssetDatabase.GetAssetPath(texture);
            TextureImporter texImporter = AssetImporter.GetAtPath(texPath) as TextureImporter;

            sourceTexCompressions[channel] = texImporter.textureCompression;
            sourceimportSizes[channel] = texImporter.maxTextureSize;

            texImporter.ReadTextureSettings(sourceTexSettings[channel]);

            texImporter.sRGBTexture = false;
            texImporter.mipmapEnabled = false;
            texImporter.maxTextureSize = 8192;
            texImporter.textureCompression = TextureImporterCompression.Uncompressed;

            sourceTexImporters[channel] = texImporter;

            texImporter.SaveAndReimport();
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
        }

        //void ResetSourceTextures()
        //{
        //    for (int i = 0; i < 8; i++)
        //    {
        //        if (sourceTexImporters[i] != null)
        //        {
        //            sourceTexImporters[i].textureCompression = sourceTexCompressions[i];
        //            sourceTexImporters[i].maxTextureSize = sourceimportSizes[i];
        //            sourceTexImporters[i].SetTextureSettings(sourceTexSettings[i]);
        //            sourceTexImporters[i].SaveAndReimport();
        //            AssetDatabase.SaveAssets();
        //            AssetDatabase.Refresh();
        //        }
        //    }
        //}

        void ResetSourceTexture(int index)
        {
            sourceTexImporters[index].textureCompression = sourceTexCompressions[index];
            sourceTexImporters[index].maxTextureSize = sourceimportSizes[index];
            sourceTexImporters[index].SetTextureSettings(sourceTexSettings[index]);
            sourceTexImporters[index].SaveAndReimport();
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
        }

        /// <summary>
        /// Get Project Presets
        /// </summary>

        void GetDefaultShaders()
        {
            shaderCross = Shader.Find("BOXOPHOBIC/The Vegetation Engine/Vegetation/Cross Subsurface Lit");
            shaderLeaf = Shader.Find("BOXOPHOBIC/The Vegetation Engine/Vegetation/Leaf Subsurface Lit");
            shaderBark = Shader.Find("BOXOPHOBIC/The Vegetation Engine/Vegetation/Bark Standard Lit");
            shaderGrass = Shader.Find("BOXOPHOBIC/The Vegetation Engine/Vegetation/Grass Subsurface Lit");
            shaderProp = Shader.Find("BOXOPHOBIC/The Vegetation Engine/Objects/Prop Standard Lit");
        }

        void GetPresets()
        {
            presetPaths = new List<string>();


            // FindObjectsOfTypeAll not working properly for unloaded assets
            allPresetPaths = Directory.GetFiles(Application.dataPath, "*.tveconverter", SearchOption.AllDirectories);

            for (int i = 0; i < allPresetPaths.Length; i++)
            {
                string assetPath = "Assets" + allPresetPaths[i].Replace(Application.dataPath, "").Replace('\\', '/');

                //if (assetPath.Contains("Internal Converter"))
                //{
                //    presetPaths[0] = assetPath;
                //}
                //else
                //{
                if (assetPath.Contains("[INCLUDE]") == false && assetPath.Contains("[HIDDEN]") == false)
                {
                    presetPaths.Add(assetPath);
                }
                //}
            }

            presetPaths.Sort();
            presetPaths.Insert(0, "");

            //for (int i = 0; i < presetTreePaths.Count; i++)
            //{
            //    Debug.Log(presetTreePaths[i]);
            //}
        }

        void GetPresetLines()
        {
            StreamReader reader = new StreamReader(presetPaths[conversionPresetIndex]);

            presetLines = new List<string>();

            while (!reader.EndOfStream)
            {
                var line = reader.ReadLine();

                presetLines.Add(line);

                if (line.StartsWith("Include"))
                {
                    GetIncludePresetLines(line);
                }
            }

            reader.Close();

            //for (int i = 0; i < presetLines.Count; i++)
            //{
            //    Debug.Log(presetLines[i]);
            //}
        }

        void GetIncludePresetLines(string line)
        {
            var import = line.Replace("Include ", "");

            for (int i = 0; i < allPresetPaths.Length; i++)
            {
                if (allPresetPaths[i].Contains(import))
                {
                    StreamReader reader = new StreamReader(allPresetPaths[i]);

                    while (!reader.EndOfStream)
                    {
                        presetLines.Add(reader.ReadLine());
                    }

                    reader.Close();
                }
            }
        }

        void GetPresetOptions()
        {
            PresetsEnum = new string[presetPaths.Count];
            PresetsEnum[0] = "Choose a preset";

            for (int i = 1; i < presetPaths.Count; i++)
            {
                PresetsEnum[i] = AssetDatabase.LoadAssetAtPath<Object>(presetPaths[i]).name;
                PresetsEnum[i] = PresetsEnum[i].Replace(" - ", "/");
            }

            //for (int i = 0; i < presetOptions.Length; i++)
            //{
            //    Debug.Log(presetOptions[i]);
            //}
        }

        void GetInfosFromPreset()
        {
            infoTitle = "Preset";
            infoPreset = "No preset info found in preset!";
            infoStatus = "○ ○ ○ ○ ○";
            infoOnline = "";

            for (int i = 0; i < 10; i++)
            {
                if (presetLines[i].StartsWith("InfoTitle"))
                {
                    infoTitle = presetLines[i].Replace("InfoTitle ", "");
                }

                if (presetLines[i].StartsWith("InfoPreset"))
                {
                    infoPreset = presetLines[i].Replace("InfoPreset ", "");
                }

                if (presetLines[i].StartsWith("InfoStatus"))
                {
                    infoStatus = presetLines[i].Replace("InfoStatus ", "");
                }

                if (presetLines[i].StartsWith("InfoOnline"))
                {
                    infoOnline = presetLines[i].Replace("InfoOnline ", "");
                }
            }
        }

        void GetPresetInfo()
        {
            if (presetIndexOld != conversionPresetIndex && conversionPresetIndex != 0)
            {
                GetPresetLines();
                GetPrefabConversionFromPreset();
                GetInfosFromPreset();
                GetMeshConversionFromPreset();

                presetIndexOld = conversionPresetIndex;
            }
        }

        int GetBreakConditionFromPreset(Material material)
        {
            int lines = presetLines.Count;

            for (int i = 0; i < presetLines.Count; i++)
            {
                if (presetLines[i].StartsWith("Condition"))
                {
                    string[] splitLine = presetLines[i].Split(char.Parse(" "));
                    string option = splitLine[1];
                    string value = splitLine[2];

                    if (option == "SHADER_NAME_TO_BREAK")
                    {
                        if (material.shader.name.Contains(value))
                        {
                            lines = i - 1;
                        }
                    }
                }
            }

            return lines;
        }

        //void GetShaderPresets()
        //{
        //    presetShaderPaths = new List<string>();
        //    //presetPaths.Add(null);

        //    // FindObjectsOfTypeAll not working properly for unloaded assets
        //    var files = Directory.GetFiles(Application.dataPath, "*.tveshaders", SearchOption.AllDirectories);

        //    for (int i = 0; i < files.Length; i++)
        //    {
        //        string assetPath = "Assets" + allPresetPaths[i].Replace(Application.dataPath, "").Replace('\\', '/');
        //        presetShaderPaths.Add(assetPath);
        //    }

        //    //for (int i = 0; i < presetTreePaths.Count; i++)
        //    //{
        //    //    Debug.Log(presetTreePaths[i]);
        //    //}
        //}

        //void GetShaderPresetOptions()
        //{
        //    presetShaderOptions = new string[presetShaderPaths.Count];
        //    //presetOptions[0] = "Choose a preset";

        //    for (int i = 1; i < presetShaderPaths.Count; i++)
        //    {
        //        presetShaderOptions[i] = AssetDatabase.LoadAssetAtPath<Object>(presetPaths[i]).name;
        //        presetShaderOptions[i] = presetShaderOptions[i].Replace(" - ", "/");
        //    }

        //    //for (int i = 0; i < presetOptions.Length; i++)
        //    //{
        //    //    Debug.Log(presetOptions[i]);
        //    //}
        //}
    }
}
