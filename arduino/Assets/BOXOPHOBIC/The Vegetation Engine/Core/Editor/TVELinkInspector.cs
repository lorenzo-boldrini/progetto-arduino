//Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using Boxophobic.StyledGUI;

namespace TheVegetationEngine
{
    [CanEditMultipleObjects]
    [CustomEditor(typeof(TVELink))]
    public class TVELinkInspector : Editor
    {
        private static readonly string excludeProps = "m_Script";
        private TVELink targetScript;

        GUIStyle styleCenteredBoldLabel;
        Color bannerColor;
        string bannerText;
        string helpURL;

        void OnEnable()
        {
            targetScript = (TVELink)target;

            bannerColor = new Color(0.890f, 0.745f, 0.309f);
            bannerText = "Link";
            helpURL = "https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.b62bh9fbu9j4";
        }

        public override void OnInspectorGUI()
        {
            SetGUIStyles();

            StyledGUI.DrawInspectorBanner(bannerColor, bannerText, helpURL);

            EditorGUILayout.HelpBox("Please note that the Link component is in experimental stage!", MessageType.Info, true);

            GUILayout.Space(10);

            DrawStatus();
            DrawInspector();

            GUILayout.Space(10);

            DrawDebugButton();

            GUILayout.Space(10);
        }

        void SetGUIStyles()
        {
            styleCenteredBoldLabel = new GUIStyle(GUI.skin.GetStyle("HelpBox"))
            {
                richText = true,
                alignment = TextAnchor.MiddleCenter,
                fontStyle = FontStyle.Bold
            };
        }

        void DrawStatus()
        {
            string mainStatus = "<color=#fd4a30>";
            string mainGameobjectName = "Missing Gameobject";
            string mainComponentName = "Missing Component";
            string mainPropertyName = "Missing Property";

            if (targetScript.mainGameobjectIsValid)
            {
                mainGameobjectName = targetScript.mainGameobjectName;
            }

            if (targetScript.mainComponentIsValid)
            {
                mainComponentName = targetScript.mainComponentName;
            }

            if (targetScript.mainPropertyIsValid)
            {
                mainPropertyName = targetScript.mainPropertyName + " (" + targetScript.mainPropertyType + ")";
            }

            if (targetScript.mainGameobjectIsValid && targetScript.mainComponentIsValid && targetScript.mainPropertyIsValid)
            {
                if (targetScript.typeIsValid)
                {
                    if (EditorGUIUtility.isProSkin)
                    {
                        mainStatus = "<color=#a5eb52>";
                    }
                    else
                    {
                        mainStatus = "<color=#247c03>";
                    }
                }
                else
                {
                    mainStatus = "<color=#808080>";
                }
            }

            string childStatus = "<color=#fd4a30>";
            string childGameobjectName = "Missing Gameobject";
            string childComponentName = "Missing Component";
            string childPropertyName = "Missing Property";

            if (targetScript.childGameobjectIsValid)
            {
                childGameobjectName = targetScript.childGameobjectName;
            }

            if (targetScript.childComponentIsValid)
            {
                childComponentName = targetScript.childComponentName;
            }

            if (targetScript.childPropertyIsValid)
            {
                childPropertyName = targetScript.childPropertyName + " (" + targetScript.childPropertyType + ")";
            }

            if (targetScript.childGameobjectIsValid && targetScript.childComponentIsValid && targetScript.childPropertyIsValid)
            {
                if (targetScript.typeIsValid)
                {
                    if (EditorGUIUtility.isProSkin)
                    {
                        childStatus = "<color=#a5eb52>";
                    }
                    else
                    {
                        childStatus = "<color=#247c03>";
                    }
                }
                else
                {
                    childStatus = "<color=#808080>";
                }
            }

            GUILayout.Label(mainStatus + mainGameobjectName + "  •  " + mainComponentName + "  •  " + mainPropertyName + "</color>", styleCenteredBoldLabel);
            GUILayout.Label(childStatus + childGameobjectName + "  •  " + childComponentName + "  •  " + childPropertyName + "</color>", styleCenteredBoldLabel);
        }

        void DrawInspector()
        {
            serializedObject.Update();

            DrawPropertiesExcluding(serializedObject, excludeProps);

            serializedObject.ApplyModifiedProperties();
        }

        void DrawDebugButton()
        {
            if (GUILayout.Button("Debug Components and Properties"/*, GUILayout.Width(160)*/))
            {
                targetScript.DebugProps();
            }
        }
    }
}


