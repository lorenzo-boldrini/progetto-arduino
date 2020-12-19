// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using Boxophobic.StyledGUI;
using Boxophobic.Utils;
using System.IO;
using System.Collections.Generic;
using UnityEngine.SceneManagement;
using UnityEditor.SceneManagement;
using System;

namespace TheVegetationEngine
{
    public class TVEHub : EditorWindow
    {
#if UNITY_2019_3_OR_NEWER
        const int GUI_HEIGHT = 18;
#else
        const int GUI_HEIGHT = 14;
#endif

        string[] engineVegetationStudio = new string[]
        {
        "           //Vegetation Studio (Instanced Indirect)",
        "           #include \"XXX/Core/Library/VS_Indirect.cginc\"",
        "           #pragma instancing_options procedural:setup forwardadd",
        "           #pragma multi_compile GPU_FRUSTUM_ON __",
        };

        string[] engineVegetationStudioHD = new string[]
        {
        "           //Vegetation Studio (Instanced Indirect)",
        "           #include \"XXX/Core/Library/VS_IndirectHD.cginc\"",
        "           #pragma instancing_options procedural:setupVSPro forwardadd",
        "           #pragma multi_compile GPU_FRUSTUM_ON __",
        };

        string[] engineGPUInstancer = new string[]
        {
        "           //GPU Instancer (Instanced Indirect)",
        "           #include \"XXX\"",
        "           #pragma instancing_options procedural:setupGPUI",
        "           #pragma multi_compile_instancing",
        };

        string[] engineNatureRenderer = new string[]
        {
        "           //Nature Renderer (Procedural Instancing)",
        "           #include \"XXX\"",
        "           #pragma instancing_options procedural:SetupNatureRenderer",
        };

        readonly string[] engineOptions =
        {
        "Unity Default Renderer",
        "Nature Renderer (Procedural Instancing)",
        "Vegetation Studio (Instanced Indirect)",
        "GPU Instancer (Instanced Indirect)",
        };

        string coreFolder = "Assets/BOXOPHOBIC/The Vegetation Engine";
        string userFolder = "Assets/BOXOPHOBIC/User";

        string[] corePackagePaths;
        string[] corePackageOptions;

        string[] allMaterialPaths;
        List<string> coreShaderPaths;
        //List<string> coreMaterialPaths;
        //List<string> elementMaterialPaths;
        List<int> engineOverridesIndices;

        string aciveScene = "";
        string corePackagesPath;

        int corePackageIndex = 0;
        int coreEngineIndex = 0;

        int coreVersion;
        int userVersion;
        int unityMajorVersion;

        bool upgradeIsNeeded = false;
        bool installIsNeeded = false;
        bool rendererOverrides = false;
        bool rendererOverridesOld = false;

        GUIStyle stylePopup;
        GUIStyle styleLabel;
        //GUIStyle styleButton;

        Color bannerColor;
        string bannerText;
        string bannerVersion;
        string helpURL;
        static TVEHub window;
        Vector2 scrollPosition = Vector2.zero;

        [MenuItem("Window/BOXOPHOBIC/The Vegetation Engine/Hub", false, 1000)]
        public static void ShowWindow()
        {
            window = GetWindow<TVEHub>(false, "The Vegetation Engine Hub", true);
            window.minSize = new Vector2(389, 220);
        }

        void OnEnable()
        {
            //Safer search, there might be many user folders
            string[] searchFolders;

            searchFolders = AssetDatabase.FindAssets("The Vegetation Engine");

            for (int i = 0; i < searchFolders.Length; i++)
            {
                if (AssetDatabase.GUIDToAssetPath(searchFolders[i]).EndsWith("The Vegetation Engine.pdf"))
                {
                    coreFolder = AssetDatabase.GUIDToAssetPath(searchFolders[i]);
                    coreFolder = coreFolder.Replace("/The Vegetation Engine.pdf", "");
                }
            }

            searchFolders = AssetDatabase.FindAssets("User");

            for (int i = 0; i < searchFolders.Length; i++)
            {
                if (AssetDatabase.GUIDToAssetPath(searchFolders[i]).EndsWith("User.pdf"))
                {
                    userFolder = AssetDatabase.GUIDToAssetPath(searchFolders[i]);
                    userFolder = userFolder.Replace("/User.pdf", "");
                    userFolder = userFolder + "/The Vegetation Engine/";
                }
            }

            var cgincGPUI = "Assets/GPUInstancer/Shaders/Include/GPUInstancerInclude.cginc";

            searchFolders = AssetDatabase.FindAssets("GPUInstancerInclude");

            for (int i = 0; i < searchFolders.Length; i++)
            {
                if (AssetDatabase.GUIDToAssetPath(searchFolders[i]).EndsWith("GPUInstancerInclude.cginc"))
                {
                    cgincGPUI = AssetDatabase.GUIDToAssetPath(searchFolders[i]);
                }
            }

            var cgincNR = "Assets/Visual Design Cafe/Nature Shaders/Common/Nodes/Integrations/Nature Renderer.cginc";

            searchFolders = AssetDatabase.FindAssets("Nature Renderer");

            for (int i = 0; i < searchFolders.Length; i++)
            {
                if (AssetDatabase.GUIDToAssetPath(searchFolders[i]).EndsWith("Nature Renderer.cginc"))
                {
                    cgincNR = AssetDatabase.GUIDToAssetPath(searchFolders[i]);
                }
            }

            // Add corect paths for VSP and GPUI
            engineVegetationStudio[1] = engineVegetationStudio[1].Replace("XXX", coreFolder);
            engineVegetationStudioHD[1] = engineVegetationStudioHD[1].Replace("XXX", coreFolder);
            engineGPUInstancer[1] = engineGPUInstancer[1].Replace("XXX", cgincGPUI);
            engineNatureRenderer[1] = engineNatureRenderer[1].Replace("XXX", cgincNR);

            corePackagesPath = coreFolder + "/Core/Packages";

            GetPackages();
            GetCoreShaders();

            GetAllMaterialPaths();

            // GetUser Settings
            if (File.Exists(userFolder + "Asset Version.asset"))
            {
                SettingsUtils.SaveSettingsData(userFolder + "Version.asset", SettingsUtils.LoadSettingsData(userFolder + "Asset Version.asset", -99));
                FileUtil.DeleteFileOrDirectory(userFolder + "Asset Version.asset");
                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }

            if (File.Exists(userFolder + "Asset Settings.asset"))
            {
                FileUtil.DeleteFileOrDirectory(userFolder + "Asset Settings.asset");
                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }

            if (File.Exists(userFolder + "Asset Pipeline.asset"))
            {
                FileUtil.DeleteFileOrDirectory(userFolder + "Asset Pipeline.asset");
                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }

            if (File.Exists(userFolder + "Shader Compatibility.asset"))
            {
                FileUtil.DeleteFileOrDirectory(userFolder + "Shader Compatibility.asset");
                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }

            coreVersion = SettingsUtils.LoadSettingsData(coreFolder + "/Core/Editor/TVEVersion.asset", -99);
            userVersion = SettingsUtils.LoadSettingsData(userFolder + "Version.asset", -99);
            unityMajorVersion = int.Parse(Application.unityVersion.Substring(0, 4));

            if (userVersion == -99)
            {
                // Looks like new install, but User folder might be deleted so check for TVE materials
                for (int i = 0; i < allMaterialPaths.Length; i++)
                {
                    var material = AssetDatabase.LoadAssetAtPath<Material>(allMaterialPaths[i]);

                    // Exclude TVE folder when checking
                    if (material.HasProperty("_IsTVEShader") && allMaterialPaths[i].Contains("The Vegetation Engine") == false)
                    {
                        upgradeIsNeeded = true;
                        break;
                    }
                }
            }

            // User Version exist and need upgrade
            if (userVersion != -99 && userVersion < coreVersion)
            {
                upgradeIsNeeded = true;
            }

            // Curent version was installed but deleted and reimported
            if (userVersion == coreVersion)
            {
                upgradeIsNeeded = false;
            }

            for (int i = 0; i < corePackageOptions.Length; i++)
            {
                if (corePackageOptions[i] == SettingsUtils.LoadSettingsData(userFolder + "Pipeline.asset", ""))
                {
                    corePackageIndex = i;
                }
            }

            for (int i = 0; i < engineOptions.Length; i++)
            {
                if (engineOptions[i] == SettingsUtils.LoadSettingsData(userFolder + "Engine.asset", ""))
                {
                    coreEngineIndex = i;
                }
            }

            bannerVersion = coreVersion.ToString();
            bannerVersion = bannerVersion.Insert(1, ".");
            bannerVersion = bannerVersion.Insert(3, ".");

            bannerColor = new Color(0.890f, 0.745f, 0.309f);
            bannerText = "The Vegetation Engine " + bannerVersion;
            helpURL = "https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.pr0qp2u684tr";

            // Check for latest version
            //StartBackgroundTask(StartRequest("https://boxophobic.com/s/thevegetationengine", () =>
            //{
            //    int.TryParse(www.downloadHandler.text, out latestVersion);
            //    Debug.Log("hubhub" + latestVersion);
            //}));
        }

        void OnGUI()
        {
            SetGUIStyles();

            StyledGUI.DrawWindowBanner(bannerColor, bannerText, helpURL);

            GUILayout.BeginHorizontal();
            GUILayout.Space(15);

            GUILayout.BeginVertical();

            scrollPosition = GUILayout.BeginScrollView(scrollPosition, false, false, GUILayout.Width(this.position.width - 28), GUILayout.Height(this.position.height - 80));

            if (File.Exists(coreFolder + "/Core/Editor/TVEHubAutoRun.cs"))
            {
                if (upgradeIsNeeded)
                {
                    DrawUpgradeSetup();
                }
                else
                {
                    DrawInstallSetup();
                }
            }
            // TVE is installed
            else
            {
                if (installIsNeeded)
                {
                    EditorGUILayout.HelpBox("The Render Pipeline is not yet installed! Choose and Install the desired Render Engine to finish the setup!", MessageType.Warning, true);
                }
                else
                {
                    EditorGUILayout.HelpBox("Click the Render Pipeline Import button then click the Render Engine Install button to use The Vegetation Engine with another render pipeline. Click the Render Engine Install button to update the shader render engine only. The selected features are shared across all TVE shaders. Enable Render Engine Overrides to select per shader Render Engine.", MessageType.Info, true);
                }

                if (coreEngineIndex > 0)
                {
                    EditorGUILayout.HelpBox("Please note that GPU Instancer, Vegetation Studio and Nature Renderer Instanced Indirect feature might not work with all render pipelines or all platforms! Check the product documentation for more details.", MessageType.Warning, true);
                }

                DrawInteraface();

                GUILayout.FlexibleSpace();
                GUI.enabled = false;

                GUILayout.Space(20);

                if (!installIsNeeded)
                {
                    GUILayout.Label("<color=#7f7f7f><size=10><b>Imported Render Pipeline: " + SettingsUtils.LoadSettingsData(userFolder + "Pipeline.asset", "Standard") + "</b></size></color>", styleLabel);
                    GUILayout.Label("<color=#7f7f7f><size=10><b>Installed Render Engine: " + SettingsUtils.LoadSettingsData(userFolder + "Engine.asset", "Unity Default Renderer") + "</b></size></color>", styleLabel);
                }

                GUILayout.Space(20);
            }

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

            styleLabel = new GUIStyle(EditorStyles.label)
            {
                richText = true,
                alignment = TextAnchor.MiddleCenter,
            };

            //styleButton = new GUIStyle(GUI.skin.GetStyle("Button"))
            //{
            //    richText = true,
            //    alignment = TextAnchor.MiddleCenter,
            //};
        }

        void DrawInteraface()
        {
            GUILayout.Space(15);

            GUILayout.BeginHorizontal();

            GUILayout.Label("Render Pipeline", GUILayout.Width(220));
            corePackageIndex = EditorGUILayout.Popup(corePackageIndex, corePackageOptions, stylePopup);

            if (GUILayout.Button("Import", GUILayout.Width(80), GUILayout.Height(GUI_HEIGHT)))
            {
                SettingsUtils.SaveSettingsData(userFolder + "Pipeline.asset", corePackageOptions[corePackageIndex]);

                SetDefineSymbols(corePackageOptions[corePackageIndex]);
                ImportPackage();

                installIsNeeded = true;

                GUIUtility.ExitGUI();
            }

            GUILayout.EndHorizontal();

            GUILayout.BeginHorizontal();
            GUILayout.Label("Render Engine", GUILayout.Width(220));
            coreEngineIndex = EditorGUILayout.Popup(coreEngineIndex, engineOptions, stylePopup);

            if (GUILayout.Button("Install", GUILayout.Width(80), GUILayout.Height(GUI_HEIGHT)))
            {
                SettingsUtils.SaveSettingsData(userFolder + "Engine.asset", engineOptions[coreEngineIndex]);

                UpdateShaders();
                SetMaterialsRenderSettings();

                // Refresh overrides if opened
                rendererOverridesOld = false;
                installIsNeeded = false;

                GUIUtility.ExitGUI();
            }

            GUILayout.EndHorizontal();

            GUILayout.Space(10);

            GUILayout.BeginHorizontal();

            GUILayout.Label("Render Engine Overrides", GUILayout.Width(220));
            rendererOverrides = EditorGUILayout.Toggle(rendererOverrides);

            GUILayout.EndHorizontal();

            if (rendererOverrides == true)
            {
                GUILayout.Space(10);

                if (rendererOverridesOld != rendererOverrides)
                {
                    for (int i = 0; i < coreShaderPaths.Count; i++)
                    {
                        GetRenderEngineFromShader(coreShaderPaths[i], i);
                    }

                    rendererOverridesOld = rendererOverrides;
                }

                for (int i = 0; i < coreShaderPaths.Count; i++)
                {
                    GUILayout.BeginHorizontal();

                    GUILayout.Label(Path.GetFileNameWithoutExtension(coreShaderPaths[i]), GUILayout.Width(220));
                    engineOverridesIndices[i] = EditorGUILayout.Popup(engineOverridesIndices[i], engineOptions, stylePopup);

                    //if (engineOverridesIndices[i] == 0)
                    //{
                    //    GUI.enabled = false;
                    //}

                    if (GUILayout.Button("Install", GUILayout.Width(80), GUILayout.Height(GUI_HEIGHT)))
                    {
                        InjectShaderFeature(coreShaderPaths[i], engineOptions[engineOverridesIndices[i]]);
                        AssetDatabase.SaveAssets();
                        AssetDatabase.Refresh();

                        SettingsUtils.SaveSettingsData(userFolder + "Engine.asset", "Mixed Render Engines");
                        GUIUtility.ExitGUI();
                    }

                    //GUI.enabled = true;

                    GUILayout.EndHorizontal();
                }
            }
        }

        void DrawInstallSetup()
        {
            EditorGUILayout.HelpBox("The Vegetation Engine needs to be installed for the current Unity version! Make sure you check the Get Started tutorials to start using the asset!", MessageType.Info, true);

            GUILayout.Space(15);

            if (GUILayout.Button("Documentation"))
            {
                Application.OpenURL("https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.u2ox035i3s3h");
            }
            if (GUILayout.Button("Get Started"))
            {
                Application.OpenURL("https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.d2fkuuhecva5");
            }

            GUILayout.Space(10);

            if (GUILayout.Button("Install", GUILayout.Height(24)))
            {
                RestartActiveScene();

                UpdateShaders();

                SettingsUtils.SaveSettingsData(userFolder + "Version.asset", coreVersion);
                SettingsUtils.SaveSettingsData(userFolder + "Pipeline.asset", "Standard");
                SettingsUtils.SaveSettingsData(userFolder + "Engine.asset", engineOptions[coreEngineIndex]);

                FileUtil.DeleteFileOrDirectory(coreFolder + "/Core/Editor/TVEHubAutorun.cs");
                AssetDatabase.Refresh();

                SetDefineSymbols("Standard");
                SetScriptExecutionOrder();

                Debug.Log("[The Vegetation Engine] " + "The Vegetation Engine " + bannerVersion + " is installed!");

                GUIUtility.ExitGUI();
            }
        }

        void DrawUpgradeSetup()
        {
            EditorGUILayout.HelpBox("Previous version detected! The Vegetation Engine will check and upgrade the assets if needed. Make sure you read the Upgrading Steps to upgrade to a new version. Do not close Unity during the upgrade!", MessageType.Info, true);

            GUILayout.Space(15);

            if (GUILayout.Button("What's New"))
            {
                Application.OpenURL("https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.1rbujejuzjce");
            }

            if (GUILayout.Button("Upgrading Steps"))
            {
                Application.OpenURL("https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.a9dctyujbl0");
            }

            GUILayout.Space(10);

            if (GUILayout.Button("Upgrade", GUILayout.Height(24)))
            {
                RestartActiveScene();

                EditorUtility.DisplayProgressBar("The Vegetation Engine", "", 0f);

                if (userVersion < 100)
                {
                    UpdateTo100();
                }

                if (userVersion < 110)
                {
                    UpdateTo110();
                }

                if (userVersion < 120)
                {
                    UpdateTo120();
                }

                if (userVersion < 130)
                {
                    UpdateTo130();
                }

                if (userVersion < 140)
                {
                    UpdateTo140();
                }

                if (userVersion < 200)
                {
                    UpdateTo200();
                }

                EditorUtility.ClearProgressBar();

                UpdateShaders();
                SetMaterialsRenderSettings();

                SettingsUtils.SaveSettingsData(userFolder + "Version.asset", coreVersion);
                SettingsUtils.SaveSettingsData(userFolder + "Pipeline.asset", "Standard");
                SettingsUtils.SaveSettingsData(userFolder + "Engine.asset", engineOptions[coreEngineIndex]);

                FileUtil.DeleteFileOrDirectory(coreFolder + "/Core/Editor/TVEHubAutorun.cs");

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();

                Debug.Log("[The Vegetation Engine] " + "The Vegetation Engine has been upgraded to version " + bannerVersion);
                GUIUtility.ExitGUI();
            }
        }

        int StyledBool(string name, int value)
        {
            bool boolValue = false;

            if (value == 1)
            {
                boolValue = true;
            }

            GUILayout.BeginHorizontal();
            EditorGUILayout.LabelField(new GUIContent(name, ""));
            boolValue = EditorGUILayout.Toggle(boolValue, GUILayout.Width(14));
            GUILayout.EndHorizontal();

            if (boolValue == false)
            {
                return 0;
            }
            else
            {
                return 1;
            }
        }

        void GetPackages()
        {
            corePackagePaths = Directory.GetFiles(corePackagesPath, "*.unitypackage", SearchOption.TopDirectoryOnly);

            corePackageOptions = new string[corePackagePaths.Length];

            for (int i = 0; i < corePackageOptions.Length; i++)
            {
                corePackageOptions[i] = Path.GetFileNameWithoutExtension(corePackagePaths[i].Replace("Built-in Pipeline", "Standard"));
            }
        }

        void GetCoreShaders()
        {
            coreShaderPaths = new List<string>();
            engineOverridesIndices = new List<int>();

            var allShaderPaths = Directory.GetFiles("Assets/", "*.shader", SearchOption.AllDirectories);

            for (int i = 0; i < allShaderPaths.Length; i++)
            {
                // No direct path usage to awoid Windows/Mac slash convention issues
                if (allShaderPaths[i].Contains("The Vegetation Engine") || allShaderPaths[i].Contains("TVE Shader"))
                {
                    if (allShaderPaths[i].Contains("Elements") == false &&
                        allShaderPaths[i].Contains("Helpers") == false &&
                        allShaderPaths[i].Contains("Legacy") == false &&
                        allShaderPaths[i].Contains("Tools") == false &&
                        allShaderPaths[i].Contains("The Vegetation Engine Details") == false)
                    {
                        // Auto generated GPUI Shaders need to be removed to avoid issues
                        if (allShaderPaths[i].Contains("GPUI"))
                        {
                            FileUtil.DeleteFileOrDirectory(allShaderPaths[i]);
                            AssetDatabase.Refresh();
                        }
                        else
                        {
                            coreShaderPaths.Add(allShaderPaths[i]);
                            engineOverridesIndices.Add(0);
                        }
                    }
                }
            }
        }

        void GetAllMaterialPaths()
        {
            allMaterialPaths = Directory.GetFiles("Assets/", "*.mat", SearchOption.AllDirectories);
        }

        //void GetCoreMaterialPaths()
        //{
        //    coreMaterialPaths = new List<string>();

        //    for (int i = 0; i < allMaterialPaths.Length; i++)
        //    {
        //        var material = AssetDatabase.LoadAssetAtPath<Material>(allMaterialPaths[i]);

        //        if (material.HasProperty("_IsTVEShader"))
        //        {
        //            coreMaterialPaths.Add(material);
        //        }
        //    }
        //}

        //void GetElementMaterials()
        //{
        //    elementMaterialPaths = new List<Material>();

        //    for (int i = 0; i < allMaterialPaths.Count; i++)
        //    {
        //        var material = AssetDatabase.LoadAssetAtPath<Material>(allMaterialPaths[i]);

        //        if (material.HasProperty("_IsElementShader") || material.HasProperty("_IsTerrainElementShader"))
        //        {
        //            elementMaterialPaths.Add(material);
        //        }
        //    }
        //}

        void RestartActiveScene()
        {
            if (SceneManager.GetActiveScene().name != "")
            {
                //if (SceneManager.GetActiveScene().isDirty)
                //{
                //    EditorSceneManager.SaveScene(SceneManager.GetActiveScene());
                //    AssetDatabase.SaveAssets();
                //    AssetDatabase.Refresh();
                //}

                aciveScene = SceneManager.GetActiveScene().path;
                EditorSceneManager.NewScene(NewSceneSetup.EmptyScene);
                EditorSceneManager.OpenScene(aciveScene);
            }
        }

        void ImportPackage()
        {
            AssetDatabase.ImportPackage(corePackagePaths[corePackageIndex], false);
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            Debug.Log("[The Vegetation Engine] " + corePackageOptions[corePackageIndex] + " package imported!");
        }

        void UpdateShaders()
        {
            for (int i = 0; i < coreShaderPaths.Count; i++)
            {
                InjectShaderFeature(coreShaderPaths[i], engineOptions[coreEngineIndex]);
            }

            Debug.Log("[The Vegetation Engine] " + "Shader features updated!");

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
        }

        void GetRenderEngineFromShader(string shaderAssetPath, int index)
        {
            StreamReader reader = new StreamReader(shaderAssetPath);

            string lines = reader.ReadToEnd();

            for (int i = 0; i < engineOptions.Length; i++)
            {
                if (lines.Contains(engineOptions[i]))
                {
                    engineOverridesIndices[index] = i;
                }
            }

            reader.Close();
        }

        void InjectShaderFeature(string shaderAssetPath, string renderEngine)
        {
            StreamReader reader = new StreamReader(shaderAssetPath);

            List<string> lines = new List<string>();

            while (!reader.EndOfStream)
            {
                lines.Add(reader.ReadLine());
            }

            reader.Close();

            // Delete Features before adding new ones
            int count = lines.Count;

            for (int i = 0; i < count; i++)
            {
                if (lines[i].Contains("SHADER INJECTION POINT BEGIN"))
                {
                    int c = 0;
                    int j = i + 1;

                    while (lines[j].Contains("SHADER INJECTION POINT END") == false)
                    {
                        j++;
                        c++;
                    }

                    lines.RemoveRange(i + 1, c);
                    count = count - c;
                }
            }

            var pipeline = SettingsUtils.LoadSettingsData(userFolder + "Pipeline.asset", "Standard");

            // Delete GPUI added lines    
            count = lines.Count;

            if (pipeline.Contains("Standard"))
            {
                for (int i = 0; i < count; i++)
                {
                    if (lines[i].StartsWith("#"))
                    {
                        lines.RemoveRange(i + 1, 4);
                        count = count - 4;

                        i--;
                    }

                    if (lines[i].Contains("#pragma target 3.0"))
                    {
                        if (lines[i + 1].Contains("multi_compile_instancing") == false)
                        {
                            lines.Insert(i + 1, "		#pragma multi_compile_instancing");
                        }
                    }
                }
            }
            else if (pipeline.Contains("Universal"))
            {
                for (int i = 0; i < count; i++)
                {
                    if (lines[i].StartsWith("#"))
                    {
                        lines.RemoveRange(i, 3);
                        count = count - 3;

                        i--;
                    }

                    if (lines[i].Contains("HLSLPROGRAM"))
                    {
                        if (lines[i + 1].Contains("multi_compile_instancing") == false)
                        {
                            lines.Insert(i + 1, "		    #pragma multi_compile_instancing");
                        }
                    }
                }
            }
            else if (pipeline.Contains("High"))
            {
                for (int i = 0; i < count; i++)
                {
                    if (lines[i].StartsWith("#"))
                    {
                        lines.RemoveRange(i, 3);
                        count = count - 3;

                        i--;
                    }

                    if (lines[i].Contains("HLSLINCLUDE"))
                    {
                        if (lines[i + 3].Contains("multi_compile_instancing") == false)
                        {
                            lines.Insert(i + 3, "		    #pragma multi_compile_instancing");
                        }
                    }
                }
            }

            for (int i = 0; i < count; i++)
            {
                if (lines[i].Contains("GPUInstancerInclude.cginc"))
                {
                    if (pipeline.Contains("Standard"))
                    {
                        lines.RemoveAt(i - 1);
                        lines.RemoveAt(i);
                        lines.RemoveAt(i + 1);
                    }

                    count = count - 3;
                }
            }

            //Inject 3rd Party Support
            if (renderEngine.Contains("GPU Instancer"))
            {
                for (int i = 0; i < lines.Count; i++)
                {
                    if (lines[i].Contains("SHADER INJECTION POINT BEGIN"))
                    {
                        lines.InsertRange(i + 1, engineGPUInstancer);
                    }
                }
            }

            else if (renderEngine.Contains("Vegetation Studio"))
            {
                for (int i = 0; i < lines.Count; i++)
                {
                    if (lines[i].Contains("SHADER INJECTION POINT BEGIN"))
                    {
                        if (pipeline.Contains("High"))
                        {
                            lines.InsertRange(i + 1, engineVegetationStudioHD);
                        }
                        else
                        {
                            lines.InsertRange(i + 1, engineVegetationStudio);
                        }
                    }
                }
            }

            else if (renderEngine.Contains("Nature Renderer"))
            {
                for (int i = 0; i < lines.Count; i++)
                {
                    if (lines[i].Contains("SHADER INJECTION POINT BEGIN"))
                    {
                        lines.InsertRange(i + 1, engineNatureRenderer);
                    }
                }
            }

            // Set Keywords to local
            if (unityMajorVersion >= 2019)
            {
                for (int i = 0; i < lines.Count; i++)
                {
                    // Disable Universal define set by ASE
                    if (lines[i].Contains("_ALPHATEST_ON 1"))
                    {
                        lines[i] = lines[i].Replace("_ALPHATEST_ON 1", "TVE_DISABLE_ALPHATEST_ON 1");
                    }

                    // Set keyword to local
                    if (lines[i].Contains("shader_feature _ALPHATEST_ON"))
                    {
                        lines[i] = lines[i].Replace("shader_feature _ALPHATEST_ON", "shader_feature_local _ALPHATEST_ON");
                    }

                    if (lines[i].Contains("shader_feature TVE_DETAIL_MODE_OFF"))
                    {
                        lines[i] = lines[i].Replace("shader_feature TVE_DETAIL_MODE_OFF", "shader_feature_local TVE_DETAIL_MODE_OFF");
                    }

                    if (lines[i].Contains("shader_feature TVE_DETAIL_MAPS_STANDARD"))
                    {
                        lines[i] = lines[i].Replace("shader_feature TVE_DETAIL_MAPS_STANDARD", "shader_feature_local TVE_DETAIL_MAPS_STANDARD");
                    }

                    if (lines[i].Contains("shader_feature TVE_DETAIL_TYPE_VERTEX_BLUE"))
                    {
                        lines[i] = lines[i].Replace("shader_feature TVE_DETAIL_TYPE_VERTEX_BLUE", "shader_feature_local TVE_DETAIL_TYPE_VERTEX_BLUE");
                    }

                    if (lines[i].Contains("shader_feature TVE_VERTEX_DATA_OBJECT"))
                    {
                        lines[i] = lines[i].Replace("shader_feature TVE_VERTEX_DATA_OBJECT", "shader_feature_local TVE_VERTEX_DATA_OBJECT");
                    }

                    // Disable ASE Drawers
                    if (lines[i].Contains("[ASEBegin]"))
                    {
                        lines[i] = lines[i].Replace("[ASEBegin]", "");
                    }

                    if (lines[i].Contains("[ASEnd]"))
                    {
                        lines[i] = lines[i].Replace("[ASEnd]", "");
                    }

                    // Change Property Names
                    if (shaderAssetPath.Contains("Grass Standard Lit") || shaderAssetPath.Contains("Grass Subsurface Lit"))
                    {
                        if (lines[i].Contains("Colors Use Mask") && !lines[i].Contains("mask"))
                        {
                            lines[i] = lines[i].Replace("Colors Use Mask", "Colors Use Mask (bottom mask)");
                        }

                        if (lines[i].Contains("Subsurface Use Mask") && !lines[i].Contains("mask"))
                        {
                            lines[i] = lines[i].Replace("Subsurface Use Mask", "Subsurface Use Mask (top mask)");
                        }
                    }

                    if (shaderAssetPath.Contains("Leaf Standard Lit") || shaderAssetPath.Contains("Leaf Subsurface Lit") || shaderAssetPath.Contains("Cross Standard Lit") || shaderAssetPath.Contains("Cross Subsurface Lit"))
                    {
                        if (lines[i].Contains("Colors Use Mask") && !lines[i].Contains("mask"))
                        {
                            lines[i] = lines[i].Replace("Colors Use Mask", "Colors Use Mask (main mask)");
                        }

                        if (lines[i].Contains("Subsurface Use Mask") && !lines[i].Contains("mask"))
                        {
                            lines[i] = lines[i].Replace("Subsurface Use Mask", "Subsurface Use Mask (main mask)");
                        }
                    }
                }
            }

#if AMPLIFY_SHADER_EDITOR

            // Add diffusion profile support
            if (pipeline.Contains("High"))
            {
                if (shaderAssetPath.Contains("Subsurface Lit"))
                {
                    for (int i = 0; i < lines.Count; i++)
                    {
                        if (lines[i].Contains("ASEDiffusionProfile"))
                        {
                            lines[i] = lines[i].Replace("[HideInInspector][ASEDiffusionProfile(_SubsurfaceDiffusion)]", "[ASEDiffusionProfile(_SubsurfaceDiffusion)]");
                        }

                        if (lines[i].Contains("StyledDiffusionMaterial"))
                        {
                            lines[i] = lines[i].Replace("[StyledDiffusionMaterial(_SubsurfaceDiffusion)]", "[HideInInspector][StyledDiffusionMaterial(_SubsurfaceDiffusion)]");
                        }
                    }
                }
            }
#endif
            // Check if the Hub should enable/disable shader features
            //bool useHubOverrides = false;

            //for (int i = 0; i < lines.Count; i++)
            //{
            //    if (lines[i].Contains("SHADER_USE_GLOBAL_OVERRIDES"))
            //    {
            //        useHubOverrides = true;
            //        break;
            //    }
            //}

            //if (useHubOverrides)
            //{
            //    for (int i = 0; i < lines.Count; i++)
            //    {
            //        if (lines[i].Contains("#define SHADER_USE_GLOBAL_COLORS"))
            //        {
            //            if (shaderGlobalColors == 1)
            //            {
            //                lines[i] = lines[i].Replace("0", "1");
            //            }
            //            else
            //            {
            //                lines[i] = lines[i].Replace("1", "0");
            //            }
            //        }

            //        if (lines[i].Contains("#define SHADER_USE_GLOBAL_OVERLAY"))
            //        {
            //            if (shaderGlobalOverlay == 1)
            //            {
            //                lines[i] = lines[i].Replace("0", "1");
            //            }
            //            else
            //            {
            //                lines[i] = lines[i].Replace("1", "0");
            //            }
            //        }

            //        if (lines[i].Contains("#define SHADER_USE_GLOBAL_LEAVES"))
            //        {
            //            if (shaderGlobalLeaves == 1)
            //            {
            //                lines[i] = lines[i].Replace("0", "1");
            //            }
            //            else
            //            {
            //                lines[i] = lines[i].Replace("1", "0");
            //            }
            //        }
            //    }
            //}

            StreamWriter writer = new StreamWriter(shaderAssetPath);

            for (int i = 0; i < lines.Count; i++)
            {
                writer.WriteLine(lines[i]);
            }

            writer.Close();

            lines = new List<string>();

            //AssetDatabase.ImportAsset(shaderAssetPath);
        }

        void SetMaterialsRenderSettings()
        {
            for (int i = 0; i < allMaterialPaths.Length; i++)
            {
                var material = AssetDatabase.LoadAssetAtPath<Material>(allMaterialPaths[i]);

                if (material.HasProperty("_IsTVEShader"))
                {
                    TVEShaderUtils.SetRenderSettings(material);
                }
            }

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
        }

        void SetDefineSymbols(string pipeline)
        {
            var defineSymbols = PlayerSettings.GetScriptingDefineSymbolsForGroup(EditorUserBuildSettings.selectedBuildTargetGroup);

            // Cleanup
            defineSymbols = defineSymbols.Replace("THE_VEGETATION_ENGINE_STANDARD", "");
            defineSymbols = defineSymbols.Replace("THE_VEGETATION_ENGINE_UNIVERSAL", "");
            defineSymbols = defineSymbols.Replace("THE_VEGETATION_ENGINE_HD", "");
            defineSymbols = defineSymbols.Replace("THE_VEGETATION_ENGINE", "");

            defineSymbols = defineSymbols + ";THE_VEGETATION_ENGINE;";

            var define = "";

            if (pipeline.Contains("Standard"))
            {
                define = "THE_VEGETATION_ENGINE_STANDARD";
            }
            else if (pipeline.Contains("Universal"))
            {
                define = "THE_VEGETATION_ENGINE_UNIVERSAL";
            }

            else if (pipeline.Contains("High"))
            {
                define = "THE_VEGETATION_ENGINE_HD";
            }
            else if (pipeline == "")
            {
                define = "THE_VEGETATION_ENGINE_STANDARD";
            }

            defineSymbols = defineSymbols + ";" + define + ";";

            PlayerSettings.SetScriptingDefineSymbolsForGroup(EditorUserBuildSettings.selectedBuildTargetGroup, defineSymbols);
        }

        void SetScriptExecutionOrder()
        {
            MonoScript[] scripts = (MonoScript[])Resources.FindObjectsOfTypeAll(typeof(MonoScript));
            foreach (MonoScript script in scripts)
            {
                if (script.GetClass() == typeof(TVEElement))
                {
                    MonoImporter.SetExecutionOrder(script, 122);
                }
            }
        }

        void UpdateTo100()
        {
            for (int i = 0; i < allMaterialPaths.Length; i++)
            {
                var material = AssetDatabase.LoadAssetAtPath<Material>(allMaterialPaths[i]);

                if (material.HasProperty("_IsTVEShader") && material.HasProperty("_IsVersion"))
                {
                    if (material.GetInt("_IsVersion") < 100)
                    {
                        material.SetInt("_IsTVEShader", 1);
                        material.SetInt("_IsTVEElement", 1);

                        material.SetInt("_IsStandardPipeline", 1);
                        material.SetInt("_IsUniversalPipeline", 1);
                        material.SetInt("_IsHDPipeline", 1);

                        material.SetInt("_IsLitShader", 1);

                        material.SetInt("_IsStandardShader", 1);
                        material.SetInt("_IsSubsurfaceShader", 1);
                        material.SetInt("_IsDisplacementShader", 1);
                        material.SetInt("_IsTessellationShader", 1);

                        material.SetInt("_IsBillboardShader", 1);
                        material.SetInt("_IsVegetationShader", 1);

                        material.SetInt("_IsVersion", 100);
                    }
                }
            }
        }

        void UpdateTo110()
        {
            for (int i = 0; i < allMaterialPaths.Length; i++)
            {
                var material = AssetDatabase.LoadAssetAtPath<Material>(allMaterialPaths[i]);

                if (material.HasProperty("_IsTVEShader") && material.HasProperty("_IsVersion"))
                {
                    if (material.GetInt("_IsVersion") < 110)
                    {
                        if (material.HasProperty("_DetailMaskValue"))
                        {
                            material.SetFloat("_DetailMeshValue", material.GetFloat("_DetailMaskValue"));
                            material.SetFloat("_DetailMaskValue", material.GetFloat("_MainMaskValue"));
                        }

                        if (material.HasProperty("_VertexOcclusion"))
                        {
                            material.SetFloat("_ObjectOcclusionValue", material.GetFloat("_VertexOcclusion"));
                        }

                        if (material.HasProperty("_SubsurfaceMode"))
                        {
                            if (material.GetInt("_SubsurfaceMode") == 0)
                            {
                                material.SetFloat("_SubsurfaceMinValue", 0);
                                material.SetFloat("_SubsurfaceMaxValue", 1);
                            }
                            else
                            {
                                material.SetFloat("_SubsurfaceMinValue", 1);
                                material.SetFloat("_SubsurfaceMaxValue", 0);
                            }
                        }

                        if (material.HasProperty("_ObjectThicknessValue"))
                        {
                            material.SetFloat("_SubsurfaceValue", 1 - material.GetFloat("_ObjectThicknessValue"));
                        }

                        material.SetInt("_IsVersion", 110);
                    }
                }
            }
        }

        void UpdateTo120()
        {
            for (int i = 0; i < allMaterialPaths.Length; i++)
            {
                var material = AssetDatabase.LoadAssetAtPath<Material>(allMaterialPaths[i]);

                if (material.shader.name.Contains("Bark Advanced Lit"))
                {
                    material.shader = Shader.Find("BOXOPHOBIC/The Vegetation Engine/Vegetation/Bark Standard Lit");
                }
            }
        }

        void UpdateTo130()
        {
            for (int i = 0; i < allMaterialPaths.Length; i++)
            {
                var material = AssetDatabase.LoadAssetAtPath<Material>(allMaterialPaths[i]);

                if (material.HasProperty("_IsTVEShader") && material.HasProperty("_IsVersion"))
                {
                    if (material.GetInt("_IsVersion") < 130)
                    {
                        if (material.HasProperty("__surface"))
                        {
                            material.SetFloat("_render_mode", material.GetFloat("__surface"));
                        }

                        if (material.HasProperty("__cull"))
                        {
                            material.SetFloat("_render_cull", material.GetFloat("__cull"));
                        }

                        if (material.HasProperty("__normals"))
                        {
                            material.SetFloat("_render_normals", material.GetFloat("__normals"));
                        }

                        if (material.HasProperty("__normalsoptions"))
                        {
                            material.SetFloat("_render_normals_options", material.GetFloat("__normalsoptions"));
                        }

                        if (material.HasProperty("__blend"))
                        {
                            material.SetFloat("_render_blend", material.GetFloat("__blend"));
                        }

                        if (material.HasProperty("__clip"))
                        {
                            material.SetFloat("_render_clip", material.GetFloat("__clip"));
                        }

                        if (material.HasProperty("__priority"))
                        {
                            material.SetFloat("_render_priority", material.GetFloat("__priority"));
                        }

                        if (material.HasProperty("__premul"))
                        {
                            material.SetFloat("_render_premul", material.GetFloat("__premul"));
                        }

                        if (material.HasProperty("__src"))
                        {
                            material.SetFloat("_render_src", material.GetFloat("__src"));
                        }

                        if (material.HasProperty("__dst"))
                        {
                            material.SetFloat("_render_dst", material.GetFloat("__dst"));
                        }

                        if (material.HasProperty("__zw"))
                        {
                            material.SetFloat("_render_zw", material.GetFloat("__zw"));
                        }

                        material.SetInt("_IsVersion", 130);
                    }
                }
            }

            // Get all TVE Meshes
            var allMeshesPaths = Directory.GetFiles("Assets/", "*.asset", SearchOption.AllDirectories);
            allMeshesPaths = Array.FindAll(allMeshesPaths, (s) => { return s.Contains("TVE Mesh") && s.EndsWith(".asset"); });

            for (int i = 0; i < allMeshesPaths.Length; i++)
            {
                EditorUtility.DisplayProgressBar("The Vegetation Engine", "Converting " + Path.GetFileName(allMeshesPaths[i]), i * 1f / allMeshesPaths.Length);

                var oldMesh = AssetDatabase.LoadAssetAtPath<Mesh>(allMeshesPaths[i]);

                // Enable IsReadable manually in text mode
                string filePath = Path.Combine(Directory.GetCurrentDirectory(), allMeshesPaths[i]);
#if UNITY_EDITOR_WIN
                filePath = filePath.Replace("/", "\\");
#endif
                string fileText = File.ReadAllText(filePath);
                fileText = fileText.Replace("m_IsReadable: 0", "m_IsReadable: 1");
                File.WriteAllText(filePath, fileText);
                AssetDatabase.Refresh();

                var newMesh = Instantiate(oldMesh);
                var newPath = allMeshesPaths[i].Replace(".asset", ".mesh");

                if (newMesh.isReadable)
                {
                    var UV4 = new List<Vector4>();
                    oldMesh.GetUVs(3, UV4);

                    // Create new Data
                    var newColors = new List<Color>(oldMesh.vertexCount);
                    var newUV4 = new List<Vector4>(oldMesh.vertexCount);

                    //Calculate new Data
                    for (int j = 0; j < oldMesh.vertexCount; j++)
                    {
                        float x = ((Mathf.RoundToInt(UV4[j].x) >> 0) & 0xFF) / 255.0f;
                        float y = ((Mathf.RoundToInt(UV4[j].x) >> 8) & 0xFF) / 255.0f;
                        float z = ((Mathf.RoundToInt(UV4[j].x) >> 16) & 0xFF) / 255.0f;

                        newColors.Add(new Color(oldMesh.colors[j].a, oldMesh.colors[j].g, oldMesh.colors[j].r, x));
                        newUV4.Add(new Vector4(x, y, z, 0));
                    }

                    // Assign new Data
                    newMesh.SetColors(newColors);
                    newMesh.SetUVs(3, newUV4);

                    AssetDatabase.MoveAsset(allMeshesPaths[i], newPath);
                    oldMesh.Clear();
                    EditorUtility.CopySerialized(newMesh, oldMesh);
                }
                else
                {
                    Debug.Log("The following mesh cannot be converted " + Path.GetFileName(allMeshesPaths[i]) + ". Manual prefab rencoversion is needed!");
                }
            }
        }

        void UpdateTo140()
        {
            for (int i = 0; i < allMaterialPaths.Length; i++)
            {
                var material = AssetDatabase.LoadAssetAtPath<Material>(allMaterialPaths[i]);

                if (material.HasProperty("_IsTVEShader") && material.HasProperty("_IsVersion"))
                {
                    if (material.GetInt("_IsVersion") < 140)
                    {
                        if (material.HasProperty("_UseMotion_Main"))
                        {
                            material.SetFloat("_Motion_10", material.GetFloat("_UseMotion_Main"));
                        }

                        if (material.HasProperty("_Motion_Main"))
                        {
                            material.SetFloat("_Motion_20", material.GetFloat("_UseMotion_Main"));
                        }

                        if (material.HasProperty("_UseMotion_Leaves"))
                        {
                            material.SetFloat("_Motion_30", material.GetFloat("_UseMotion_Leaves"));
                        }

                        if (material.HasProperty("_UseMotion_Leaves"))
                        {
                            material.SetFloat("_Motion_32", material.GetFloat("_UseMotion_Leaves"));
                        }

                        material.SetInt("_IsVersion", 140);
                    }
                }
            }
        }

        void UpdateTo200()
        {
            for (int i = 0; i < allMaterialPaths.Length; i++)
            {       
                var material = AssetDatabase.LoadAssetAtPath<Material>(allMaterialPaths[i]);

                EditorUtility.DisplayProgressBar("The Vegetation Engine", "Updating Materials", i * 1f / allMaterialPaths.Length);

                if (material.shader.name.Contains("Bark Simple Lit"))
                {
                    material.shader = Shader.Find("BOXOPHOBIC/The Vegetation Engine/Vegetation/Bark Standard Lit");
                }

                if (material.shader.name.Contains("Cross Simple Lit"))
                {
                    material.shader = Shader.Find("BOXOPHOBIC/The Vegetation Engine/Vegetation/Cross Standard Lit");
                }

                if (material.shader.name.Contains("Grass Simple Lit"))
                {
                    material.shader = Shader.Find("BOXOPHOBIC/The Vegetation Engine/Vegetation/Grass Standard Lit");
                }

                if (material.shader.name.Contains("Leaf Simple Lit"))
                {
                    material.shader = Shader.Find("BOXOPHOBIC/The Vegetation Engine/Vegetation/Leaf Standard Lit");
                }

                if (material.shader.name.Contains("Prop Simple Lit") && material.shader.name.Contains("projection") == false)
                {
                    material.shader = Shader.Find("BOXOPHOBIC/The Vegetation Engine/Objects/Prop Standard Lit");
                }

                if (material.shader.name.Contains("Prop Simple Lit") && material.shader.name.Contains("projection") == true)
                {
                    material.shader = Shader.Find("BOXOPHOBIC/The Vegetation Engine/Objects/Prop Standard Lit");
                    material.SetInt("_DetailTypeMode", 1);
                }

                if (material.shader.name.Contains("Prop Standard Lit") && material.shader.name.Contains("projection") == true)
                {
                    material.shader = Shader.Find("BOXOPHOBIC/The Vegetation Engine/Objects/Prop Standard Lit");
                    material.SetInt("_DetailTypeMode", 1);
                }

                if (material.HasProperty("_IsTVEShader") && material.HasProperty("_IsVersion"))
                {
                    if (material.GetInt("_IsVersion") < 200)
                    {
                        if (material.HasProperty("_render_mode"))
                        {
                            material.SetInt("_RenderMode", material.GetInt("_render_mode"));
                        }

                        if (material.HasProperty("_render_cull"))
                        {
                            material.SetInt("_RenderCull", material.GetInt("_render_cull"));
                        }

                        if (material.HasProperty("_render_normals"))
                        {
                            material.SetInt("_RenderNormals", material.GetInt("_render_normals"));
                        }

                        if (material.HasProperty("_render_blend"))
                        {
                            material.SetInt("_RenderBlend", material.GetInt("_render_blend"));
                        }

                        if (material.HasProperty("_render_zw"))
                        {
                            material.SetInt("_RenderZWrite", material.GetInt("_render_zw"));
                        }

                        if (material.HasProperty("_render_clip"))
                        {
                            material.SetInt("_RenderClip", material.GetInt("_render_clip"));
                        }

                        if (material.HasProperty("_render_priority"))
                        {
                            material.SetInt("_RenderPriority", material.GetInt("_render_priority"));
                        }

                        if (material.HasProperty("_material_batching"))
                        {
                            material.SetInt("_VertexDataMode", material.GetInt("_material_batching"));
                        }

                        if (material.HasProperty("_ObjectMetallicValue"))
                        {
                            material.SetFloat("_MainMetallicValue", material.GetFloat("_ObjectMetallicValue"));
                        }

                        if (material.HasProperty("_ObjectSmoothnessValue"))
                        {
                            material.SetFloat("_MainSmoothnessValue", material.GetFloat("_ObjectSmoothnessValue"));
                        }

                        if (material.HasProperty("_ObjectOcclusionValue"))
                        {
                            material.SetFloat("_VertexOcclusionValue", material.GetFloat("_ObjectOcclusionValue") * 0.5f);
                        }

                        if (material.HasProperty("_OverlayContrast"))
                        {
                            material.SetFloat("_OverlayContrastValue", material.GetFloat("_OverlayContrast"));
                        }

                        if (material.HasProperty("_OverlayVariation"))
                        {
                            material.SetFloat("_OverlayVariationValue", material.GetFloat("_OverlayVariation"));
                        }

                        if (material.HasProperty("_MaskMode"))
                        {
                            material.SetFloat("_DetailMaskMode", material.GetFloat("_MaskMode"));
                        }

                        if (material.HasProperty("_MotionAmplitude_30"))
                        {
                            material.SetFloat("_MotionAmplitude_30", material.GetFloat("_MotionAmplitude_30") * 2.0f);
                        }

                        if (material.HasProperty("_MotionAmplitude_32"))
                        {
                            material.SetFloat("_MotionAmplitude_32", material.GetFloat("_MotionAmplitude_32") * 2.0f);
                        }

                        if (material.HasProperty("_SubsurfaceMinValue"))
                        {
                            material.SetFloat("_MainMaskMinValue", material.GetFloat("_SubsurfaceMinValue"));
                        }

                        if (material.HasProperty("_SubsurfaceMaxValue"))
                        {
                            material.SetFloat("_MainMaskMaxValue", material.GetFloat("_SubsurfaceMaxValue"));
                        }

                        if (material.HasProperty("_GrassPerspectivePushValue"))
                        {
                            material.SetFloat("_PerspectivePushValue", material.GetFloat("_GrassPerspectivePushValue"));
                        }

                        if (material.HasProperty("_GrassPerspectiveNoiseValue"))
                        {
                            material.SetFloat("_PerspectiveNoiseValue", material.GetFloat("_GrassPerspectiveNoiseValue"));
                        }

                        if (material.HasProperty("_GrassPerspectiveAngleValue"))
                        {
                            material.SetFloat("_PerspectiveAngleValue", material.GetFloat("_GrassPerspectiveAngleValue"));
                        }

                        material.SetInt("_IsVersion", 200);
                    }
                }
            }

            for (int i = 0; i < allMaterialPaths.Length; i++)
            {
                var material = AssetDatabase.LoadAssetAtPath<Material>(allMaterialPaths[i]);

                EditorUtility.DisplayProgressBar("The Vegetation Engine", "Updating Elements", i * 1f / allMaterialPaths.Length);

                if ((material.HasProperty("_IsElementShader") || material.HasProperty("_IsTerrainElementShader")) && material.HasProperty("_IsVersion"))
                {
                    if (material.GetInt("_IsVersion") < 200)
                    {
                        if (material.HasProperty("_WinterColor"))
                        {
                            material.SetColor("_AdditionalColor1", material.GetColor("_WinterColor"));
                        }

                        if (material.HasProperty("_SpringColor"))
                        {
                            material.SetColor("_AdditionalColor2", material.GetColor("_SpringColor"));
                        }

                        if (material.HasProperty("_SummerColor"))
                        {
                            material.SetColor("_AdditionalColor3", material.GetColor("_SummerColor"));
                        }

                        if (material.HasProperty("_AutumnColor"))
                        {
                            material.SetColor("_AdditionalColor4", material.GetColor("_AutumnColor"));
                        }

                        if (material.HasProperty("_WinterValue"))
                        {
                            material.SetFloat("_AdditionalValue1", material.GetFloat("_WinterValue"));
                        }

                        if (material.HasProperty("_SpringValue"))
                        {
                            material.SetFloat("_AdditionalValue2", material.GetFloat("_SpringValue"));
                        }

                        if (material.HasProperty("_SummerValue"))
                        {
                            material.SetFloat("_AdditionalValue3", material.GetFloat("_SummerValue"));
                        }

                        if (material.HasProperty("_AutumnColor"))
                        {
                            material.SetFloat("_AdditionalValue4", material.GetFloat("_AutumnValue"));
                        }

                        material.SetInt("_IsVersion", 200);
                    }
                }
            }
        }

        // Check for latest version
        //UnityWebRequest www;

        //IEnumerator StartRequest(string url, Action success = null)
        //{
        //    using (www = UnityWebRequest.Get(url))
        //    {
        //        yield return www.Send();

        //        while (www.isDone == false)
        //            yield return null;

        //        if (success != null)
        //            success();
        //    }
        //}

        //public static void StartBackgroundTask(IEnumerator update, Action end = null)
        //{
        //    EditorApplication.CallbackFunction closureCallback = null;

        //    closureCallback = () =>
        //    {
        //        try
        //        {
        //            if (update.MoveNext() == false)
        //            {
        //                if (end != null)
        //                    end();
        //                EditorApplication.update -= closureCallback;
        //            }
        //        }
        //        catch (Exception ex)
        //        {
        //            if (end != null)
        //                end();
        //            Debug.LogException(ex);
        //            EditorApplication.update -= closureCallback;
        //        }
        //    };

        //    EditorApplication.update += closureCallback;
        //}
    }
}
