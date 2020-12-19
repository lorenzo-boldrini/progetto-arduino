//using UnityEditor;
//using Boxophobic.Utils;

//namespace TheVegetationEngine
//{
//    [InitializeOnLoad]
//    class TVEListener : AssetPostprocessor
//    {
//        static string folderUser = "Assets/BOXOPHOBIC/User";

//        static void OnPostprocessAllAssets(string[] importedAssets, string[] deletedAssets, string[] movedAssets, string[] movedFromAssetPaths)
//        {
//            string[] searchFolders = AssetDatabase.FindAssets("User");

//            for (int i = 0; i < searchFolders.Length; i++)
//            {
//                if (AssetDatabase.GUIDToAssetPath(searchFolders[i]).EndsWith("User.pdf"))
//                {
//                    //Safer search, there might be many user folders
//                    folderUser = AssetDatabase.GUIDToAssetPath(searchFolders[i]);
//                    folderUser = folderUser.Replace("/User.pdf", "");
//                }
//            }

//            SwitchDefineSymbols();
//        }

//        static void SwitchDefineSymbols()
//        {
//            var defineSymbols = PlayerSettings.GetScriptingDefineSymbolsForGroup(EditorUserBuildSettings.selectedBuildTargetGroup);

//            // Cleanup
//            defineSymbols = defineSymbols.Replace("THE_VEGETATION_ENGINE", "");
//            defineSymbols = defineSymbols.Replace("IS_STANDARD_PIPELINE", "");
//            defineSymbols = defineSymbols.Replace("THE_VEGETATION_ENGINE_UNIVERSAL", "");
//            defineSymbols = defineSymbols.Replace("THE_VEGETATION_ENGINE_HD", "");

//            defineSymbols = defineSymbols + ";THE_VEGETATION_ENGINE;";

//            var define = "";
//            var pipeline = SettingsUtils.LoadSettingsData(folderUser + "/The Vegetation Engine/Asset Pipeline.asset", "");

//            if (pipeline.Contains("Standard"))
//            {
//                define = "IS_STANDARD_PIPELINE";
//            }
//            else if (pipeline.Contains("Universal"))
//            {
//                define = "THE_VEGETATION_ENGINE_UNIVERSAL";
//            }

//            else if (pipeline.Contains("High"))
//            {
//                define = "THE_VEGETATION_ENGINE_HD";
//            }
//            else if (pipeline == "")
//            {
//                define = "IS_STANDARD_PIPELINE";
//            }

//            defineSymbols = defineSymbols + ";" + define + ";";

//            PlayerSettings.SetScriptingDefineSymbolsForGroup(EditorUserBuildSettings.selectedBuildTargetGroup, defineSymbols);
//        }
//    }
//}