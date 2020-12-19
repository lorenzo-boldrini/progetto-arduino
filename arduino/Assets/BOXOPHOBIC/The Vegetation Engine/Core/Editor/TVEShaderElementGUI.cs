//Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using System.Collections.Generic;

public class TVEShaderElementGUI : ShaderGUI
{
    Material material;

    public override void AssignNewShaderToMaterial(Material material, Shader oldShader, Shader newShader)
    {
        base.AssignNewShaderToMaterial(material, oldShader, newShader);

        AssignDefaultTexture(material, newShader);
    }

    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] props)
    {
        material = materialEditor.target as Material;

        DrawDynamicInspector(materialEditor, props);
    }

    void DrawDynamicInspector(MaterialEditor materialEditor, MaterialProperty[] props)
    {
        var customPropsList = new List<MaterialProperty>();

        for (int i = 0; i < props.Length; i++)
        {
            var prop = props[i];

            if (prop.flags == MaterialProperty.PropFlags.HideInInspector)
            {
                continue;
            }

            if (material.HasProperty("_ElementMode"))
            {
                if (material.GetInt("_ElementMode") == 1 && prop.name == "_MainColor")
                    continue;

                if (material.GetInt("_ElementMode") == 0 && prop.name == "_AdditionalColor1")
                    continue;

                if (material.GetInt("_ElementMode") == 0 && prop.name == "_AdditionalColor2")
                    continue;

                if (material.GetInt("_ElementMode") == 0 && prop.name == "_AdditionalColor3")
                    continue;

                if (material.GetInt("_ElementMode") == 0 && prop.name == "_AdditionalColor4")
                    continue;

                if (material.GetInt("_ElementMode") == 1 && prop.name == "_MainValue")
                    continue;

                if (material.GetInt("_ElementMode") == 0 && prop.name == "_AdditionalValue1")
                    continue;

                if (material.GetInt("_ElementMode") == 0 && prop.name == "_AdditionalValue2")
                    continue;

                if (material.GetInt("_ElementMode") == 0 && prop.name == "_AdditionalValue3")
                    continue;

                if (material.GetInt("_ElementMode") == 0 && prop.name == "_AdditionalValue4")
                    continue;
            }

            customPropsList.Add(prop);
        }

        //Draw Default GUI
        //var customPropsArr = new MaterialProperty[customPropsList.Count];

        //for (int i = 0; i < customPropsList.Count; i++)
        //{
        //    customPropsArr[i] = customPropsList[i];
        //}

        //materialEditor.PropertiesDefaultGUI(customPropsArr);

        //return;

        //Draw Custom GUI
        for (int i = 0; i < customPropsList.Count; i++)
        {
            var prop = customPropsList[i];

            if (prop.type == MaterialProperty.PropType.Texture)
            {
                var tex = (Texture2D)EditorGUILayout.ObjectField(prop.displayName, prop.textureValue, typeof(Texture2D), true, GUILayout.Height(50));
                prop.textureValue = tex;
            }
            else
            {
                materialEditor.ShaderProperty(customPropsList[i], customPropsList[i].displayName);
            }
        }

        GUILayout.Space(10);
    }

    void AssignDefaultTexture(Material material, Shader shader)
    {
        if (shader.name.Contains("Interaction"))
        {
            material.SetTexture("_MainTex", Resources.Load<Material>("Internal Interaction").GetTexture("_MainTex"));
        }
        else if (shader.name.Contains("Flow"))
        {
            material.SetTexture("_MainTex", Resources.Load<Material>("Internal Flow").GetTexture("_MainTex"));
        }
        else
        {
            material.SetTexture("_MainTex", Resources.Load<Material>("Internal Colors").GetTexture("_MainTex"));
        }
    }
}

