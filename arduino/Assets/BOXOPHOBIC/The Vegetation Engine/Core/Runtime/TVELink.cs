using UnityEngine;
using System.Reflection;
using System;
using Boxophobic;
using Boxophobic.StyledGUI;
#if UNITY_EDITOR
using UnityEditor;
#endif

namespace TheVegetationEngine
{
#if UNITY_EDITOR
    [ExecuteInEditMode]
    [AddComponentMenu("BOXOPHOBIC/The Vegetation Engine/TVE Link")]
#endif
    public class TVELink : StyledMonoBehaviour
    {
#if UNITY_EDITOR
        [HideInInspector]
        public bool mainGameobjectIsValid;
        [HideInInspector]
        public bool mainComponentIsValid;
        [HideInInspector]
        public bool mainPropertyIsValid;
        [HideInInspector]
        public string mainPropertyType = "";

        [HideInInspector]
        public bool childGameobjectIsValid;
        [HideInInspector]
        public bool childComponentIsValid;
        [HideInInspector]
        public bool childPropertyIsValid;
        [HideInInspector]
        public string childPropertyType = "";

        [HideInInspector]
        public bool linkIsValid;
        [HideInInspector]
        public bool typeIsValid;
        [HideInInspector]
        public bool typeIsFloat;
#endif

        [Space(10)]
        public string linkName;

        [StyledInteractive("OFF")]
        public int interactiveOff;

        [Space(10)]
        public GameObject mainGameobject;
        public UnityEngine.Object mainComponent;
        public GameObject childGameobject;
        public UnityEngine.Object childComponent;

        [StyledInteractive("ON")]
        public int interactiveOn;

        [Space(10)]
        public string mainGameobjectName;
        public string mainComponentName;
        public string mainPropertyName;

        [Space(10)]
        public string childGameobjectName;
        public string childComponentName;
        public string childPropertyName;

        FieldInfo mainFieldInfo;
        PropertyInfo mainPropertyInfo;
        FieldInfo childFieldInfo;
        PropertyInfo childPropertyInfo;
        public object initValue = null;

        [StyledInteractive(1)]
        public int typeIsFloatInteractive;

        [Space(10)]
        public bool mainValueRemap = false;
        [Space(10)]
        public float valueFromMin = 0;
        public float valueFromMax = 1;
        public float valueToMin = 0;
        public float valueToMax = 1;

        [Space(10)]
        public float valueClampMin = 0;
        public float valueClampMax = 1;

        [StyledInteractive("ON")]
        public int typeIsFloatInteractiveOn;

        void OnEnable()
        {
#if UNITY_EDITOR
            // Update Link in editor on enable
            UpdatePropsOnSceneChanged();
#endif
            // Optimize Link in build
            if (mainComponent != null && childComponent != null)
            {
                // Set Props if the objects exist in the scene
                SetProps(mainPropertyName, mainComponent, out mainFieldInfo, out mainPropertyInfo);
                SetProps(childPropertyName, childComponent, out childFieldInfo, out childPropertyInfo);
            }
            else
            {
                // Search Props if the objects is added to a prefab or added at runtime
                SearchProps(mainGameobjectName, mainComponentName, mainPropertyName, out mainGameobject, out mainComponent, out mainFieldInfo, out mainPropertyInfo);
                SearchProps(childGameobjectName, childComponentName, childPropertyName, out childGameobject, out childComponent, out childFieldInfo, out childPropertyInfo);
            }

            //SaveInitialValue();
        }

        //void OnDisable()
        //{
        //    UnlinkProps();
        //}

        void Update()
        {
#if UNITY_EDITOR
            if (UnityEditor.SceneManagement.EditorSceneManager.GetActiveScene().isDirty)
            {
                UpdatePropsOnSceneChanged();
            }

            if (Selection.Contains(gameObject))
            {
                UpdatePropsOnSceneChanged();
            }
#endif
            LinkProps();
        }

        void SearchProps(string gameobjectName, string componentName, string propertyName, out GameObject gameobject, out UnityEngine.Object component, out FieldInfo fieldInfo, out PropertyInfo propertyInfo)
        {
            component = null;
            fieldInfo = null;
            propertyInfo = null;

            gameobject = GameObject.Find(gameobjectName);

            if (gameobject != null)
            {
                component = gameobject.GetComponent(componentName);
            }

            if (component != null)
            {
                Type t = component.GetType();

                FieldInfo[] fieldInfos = t.GetFields();
                foreach (FieldInfo info in fieldInfos)
                {
                    if (info.Name == propertyName)
                    {
                        fieldInfo = info;
                    }
                }

                PropertyInfo[] propertyInfos = t.GetProperties();
                foreach (System.Reflection.PropertyInfo info in propertyInfos)
                {
                    if (info.Name == propertyName)
                    {
                        propertyInfo = info;
                    }
                }
            }
        }

        void SetProps(string propertyName, UnityEngine.Object component, out FieldInfo fieldInfo, out PropertyInfo propertyInfo)
        {
            fieldInfo = null;
            propertyInfo = null;

            if (component != null)
            {
                Type t = component.GetType();

                FieldInfo[] fieldInfos = t.GetFields();

                foreach (FieldInfo info in fieldInfos)
                {
                    if (info.Name == propertyName)
                    {
                        fieldInfo = info;
                    }
                }

                PropertyInfo[] propertyInfos = t.GetProperties();

                foreach (System.Reflection.PropertyInfo info in propertyInfos)
                {
                    if (info.Name == propertyName)
                    {
                        propertyInfo = info;
                    }
                }
            }
        }

        //void SaveInitialValue()
        //{
        //    if (childFieldInfo != null)
        //    {
        //        initValue = childFieldInfo.GetValue(childComponent);
        //    }
        //    else if (childPropertyInfo != null)
        //    {
        //        initValue = childPropertyInfo.GetValue(childComponent, null);
        //    }
        //}

        void LinkProps()
        {
            if (mainComponent == null || childComponent == null)
            {
                return;
            }

            if (mainFieldInfo != null && childFieldInfo != null)
            {
                if (mainFieldInfo.FieldType.Name == childFieldInfo.FieldType.Name)
                {
                    var value = mainFieldInfo.GetValue(mainComponent);

                    if (mainValueRemap && mainFieldInfo.FieldType.Name == "Single")
                    {
                        value = FloatRemapAndClamp(mainFieldInfo.FieldType.Name, (float)value, valueFromMin, valueFromMax, valueToMin, valueToMax);
                    }

                    childFieldInfo.SetValue(childComponent, value);
                }
            }
            else if (mainPropertyInfo != null && childPropertyInfo != null)
            {
                if (mainPropertyInfo.PropertyType.Name == childPropertyInfo.PropertyType.Name)
                {
                    var value = mainPropertyInfo.GetValue(mainComponent, null);

                    if (mainValueRemap && mainPropertyInfo.PropertyType.Name == "Single")
                    {
                        value = FloatRemapAndClamp(mainFieldInfo.FieldType.Name, (float)value, valueFromMin, valueFromMax, valueToMin, valueToMax);
                    }

                    childPropertyInfo.SetValue(childComponent, value, null);
                }
            }
            else if (mainFieldInfo != null && childPropertyInfo != null)
            {
                if (mainFieldInfo.FieldType.Name == childPropertyInfo.PropertyType.Name)
                {
                    var value = mainFieldInfo.GetValue(mainComponent);

                    if (mainValueRemap && mainFieldInfo.FieldType.Name == "Single")
                    {
                        value = FloatRemapAndClamp(mainFieldInfo.FieldType.Name, (float)value, valueFromMin, valueFromMax, valueToMin, valueToMax);
                    }

                    childPropertyInfo.SetValue(childComponent, value, null);
                }
            }
            else if (mainPropertyInfo != null && childFieldInfo != null)
            {
                if (mainPropertyInfo.PropertyType.Name == childFieldInfo.FieldType.Name)
                {
                    var value = mainPropertyInfo.GetValue(mainComponent, null);

                    if (mainValueRemap && mainPropertyInfo.PropertyType.Name == "Single")
                    {
                        value = FloatRemapAndClamp(mainFieldInfo.FieldType.Name, (float)value, valueFromMin, valueFromMax, valueToMin, valueToMax);
                    }

                    childFieldInfo.SetValue(childComponent, value);
                }
            }
        }

        //void UnlinkProps()
        //{
        //    if (childFieldInfo != null)
        //    {
        //        childFieldInfo.SetValue(childComponent, initValue);
        //    }
        //    else if (childPropertyInfo != null)
        //    {
        //        childPropertyInfo.SetValue(childComponent, initValue, null);
        //    }
        //}

        float FloatRemapAndClamp(string type, float value, float low1, float high1, float low2, float high2)
        {
            return value = Mathf.Clamp(low2 + (value - low1) * (high2 - low2) / (high1 - low1), valueClampMin, valueClampMax);
        }

#if UNITY_EDITOR
        void UpdatePropsOnSceneChanged()
        {
            SearchProps(mainGameobjectName, mainComponentName, mainPropertyName, out mainGameobject, out mainComponent, out mainFieldInfo, out mainPropertyInfo);
            SearchProps(childGameobjectName, childComponentName, childPropertyName, out childGameobject, out childComponent, out childFieldInfo, out childPropertyInfo);
            SetBools();
        }

        void SetBools()
        {
            // Check for Gamobjects
            if (mainGameobject == null)
            {
                mainGameobjectIsValid = false;
            }
            else
            {
                mainGameobjectIsValid = true;
            }

            if (childGameobject == null)
            {
                childGameobjectIsValid = false;
            }
            else
            {
                childGameobjectIsValid = true;
            }

            // Check for Components
            if (mainComponent == null)
            {
                mainComponentIsValid = false;
            }
            else
            {
                mainComponentIsValid = true;
            }

            if (childComponent == null)
            {
                childComponentIsValid = false;
            }
            else
            {
                childComponentIsValid = true;
            }

            // Check for properties
            if (mainFieldInfo == null && mainPropertyInfo == null)
            {
                mainPropertyIsValid = false;
            }
            else
            {
                mainPropertyIsValid = true;
            }

            if (childFieldInfo == null && childPropertyInfo == null)
            {
                childPropertyIsValid = false;
            }
            else
            {
                childPropertyIsValid = true;
            }

            if (mainPropertyIsValid)
            {
                if (mainFieldInfo != null)
                {
                    mainPropertyType = mainFieldInfo.FieldType.Name;
                }
                else if (mainPropertyInfo != null)
                {
                    mainPropertyType = mainPropertyInfo.PropertyType.Name;
                }
            }

            if (childPropertyIsValid)
            {
                if (childFieldInfo != null)
                {
                    childPropertyType = childFieldInfo.FieldType.Name;
                }
                else if (childPropertyInfo != null)
                {
                    childPropertyType = childPropertyInfo.PropertyType.Name;
                }
            }

            if (mainPropertyIsValid && childPropertyIsValid)
            {
                if (mainPropertyType == childPropertyType)
                {
                    linkIsValid = true;
                    typeIsValid = true;

                    if (linkName == "")
                    {
                        gameObject.name = "Link (" + mainGameobjectName + " to " + childGameobjectName + ")";
                    }
                    else
                    {
                        gameObject.name = "Link (" + linkName + ")";
                    }
                }
                else
                {
                    linkIsValid = false;
                    typeIsValid = false;

                    gameObject.name = "Link (Invalid Type)";
                }
            }
            else
            {
                linkIsValid = false;
                typeIsValid = false;

                gameObject.name = "Link (Invalid Link)";
            }

            if (mainPropertyType == "Single" && childPropertyType == "Single")
            {
                typeIsFloat = true;
                typeIsFloatInteractive = 1;
            }
            else
            {
                typeIsFloat = false;
                typeIsFloatInteractive = 0;
            }
        }

        public void DebugProps()
        {
            if (GameObject.Find(mainGameobjectName) != null)
            {
                GetGameobjectProps(GameObject.Find(mainGameobjectName));
            }
            else
            {
                Debug.Log("[Warning][The Vegetation Engine] " + "The First GameObject is not set!");
            }

            if (GameObject.Find(childGameobjectName) != null)
            {
                GetGameobjectProps(GameObject.Find(childGameobjectName));
            }
            else
            {
                Debug.Log("[Warning][The Vegetation Engine] " + "The Second GameObject is not set!");
            }
        }

        void GetGameobjectProps(GameObject go)
        {
            var components = go.GetComponents(typeof(UnityEngine.Component));

            foreach (UnityEngine.Component comp in components)
            {
                if (EditorGUIUtility.isProSkin)
                {
                    Debug.Log("<color=#a5eb52>● " + go.name + ": " + comp.GetType().Name + " Component</color>");
                }
                else
                {
                    Debug.Log("<color=#4d8c03>● " + go.name + ": " + comp.GetType().Name + " Component</color>");
                }

                GetCopmpnentProps(comp);
            }
        }

        void GetCopmpnentProps(UnityEngine.Object component)
        {
            Type t = component.GetType();

            FieldInfo[] fieldInfo = t.GetFields();
            foreach (FieldInfo info in fieldInfo)
            {
                Debug.Log("○ FieldInfo:  " + info.Name + "  " +
                                  info.FieldType.Name/* + "  " +
                                  info.GetValue(component)*/);
            }

            PropertyInfo[] propertyInfo = t.GetProperties();
            foreach (PropertyInfo info in propertyInfo)
            {
                if (!info.IsDefined(typeof(ObsoleteAttribute), true))
                {
                    //if (info.GetIndexParameters().Length == 0)
                    //    Debug.Log("○ PropertyInfo:  " + info.Name + "  " +
                    //                      info.PropertyType.Name + "  " +
                    //                      info.GetValue(component, null));
                    //else
                    Debug.Log("○ Property Info:  " + info.Name + "  " +
                                      info.PropertyType.Name);
                }
            }
        }
#endif
    }
}