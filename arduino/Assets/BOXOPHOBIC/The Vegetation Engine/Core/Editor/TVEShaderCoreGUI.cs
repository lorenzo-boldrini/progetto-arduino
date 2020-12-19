//Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using System.Collections.Generic;

public class TVEShaderCoreGUI : ShaderGUI
{
    Material material;

    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] props)
    {
        material = materialEditor.target as Material;

        DrawDynamicInspector(materialEditor, props);
        TheVegetationEngine.TVEShaderUtils.SetRenderSettings(material);
        SetLegacyProps();
    }

    void SetLegacyProps()
    {
        if (material.HasProperty("_MainAlbedoTex"))
        {
            material.SetColor("_Color", material.GetColor("_MainColor"));
            material.SetTexture("_MainTex", material.GetTexture("_MainAlbedoTex"));
            material.SetTextureScale("_MainTex", new Vector2(material.GetVector("_MainUVs").x, material.GetVector("_MainUVs").y));
            material.SetTextureOffset("_MainTex", new Vector2(material.GetVector("_MainUVs").z, material.GetVector("_MainUVs").w));
        }
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

            if (material.HasProperty("_RenderMode"))
            {
                if (material.GetInt("_RenderMode") == 0 && prop.name == "_RenderBlend")
                    continue;

                if (material.GetInt("_RenderMode") == 0 && prop.name == "_RenderZWrite")
                    continue;

                if (material.GetInt("_RenderMode") == 0 && prop.name == "_RenderPriority")
                    continue;
            }

            if (material.HasProperty("_LocalColors"))
            {
                if (prop.name == "_LocalColors")
                    continue;
            }

            if (!material.HasProperty("_SecondColor"))
            {
                if (prop.name == "_DetailCat")
                    continue;

                if (prop.name == "_DetailMode")
                    continue;

                if (prop.name == "_DetailTypeMode")
                    continue;

                if (prop.name == "_DetailMapsMode")
                    continue;

                if (prop.name == "_DetailSpace")
                    continue;
            }

            if (!material.HasProperty("_IsPropShader"))
            {
                if (prop.name == "_DetailTypeMode")
                    continue;
            }

            if (material.HasProperty("_DetailTypeMode"))
            {
                if (material.GetInt("_DetailTypeMode") == 0 && prop.name == "_DetailProjectionMode")
                    continue;

                if (material.GetInt("_DetailTypeMode") == 1 && prop.name == "_DetailCoordMode")
                    continue;
            }

            if (material.HasProperty("_DetailMapsMode"))
            {
                if (material.GetInt("_DetailMapsMode") == 0 && prop.name == "_SecondPackedTex")
                    continue;

                if (material.GetInt("_DetailMapsMode") == 1 && prop.name == "_SecondAlbedoTex")
                    continue;

                if (material.GetInt("_DetailMapsMode") == 1 && prop.name == "_SecondNormalTex")
                    continue;

                if (material.GetInt("_DetailMapsMode") == 1 && prop.name == "_SecondMetallicValue")
                    continue;

                if (material.GetInt("_DetailMapsMode") == 1 && prop.name == "_SecondOcclusionValue")
                    continue;
            }

            if (material.HasProperty("_VertexDataMode"))
            {
                if (material.GetInt("_VertexDataMode") == 1 && prop.name == "_VertexMotionMode")
                    continue;

                if (material.GetInt("_VertexDataMode") == 1 && prop.name == "_VertexPivotMode")
                    continue;

                if (material.GetInt("_VertexDataMode") == 1 && prop.name == "_VertexMotionSpace")
                    continue;

                if (material.GetInt("_VertexDataMode") == 1 && prop.name == "_ObjectDataMessage")
                    continue;

                if (material.GetInt("_VertexDataMode") == 1 && prop.name == "_WorldDataMessage")
                    continue;

                if (material.GetInt("_VertexDataMode") == 1 && prop.name == "_PivotsMessage")
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

        materialEditor.EnableInstancingField();

        GUILayout.Space(10);

        materialEditor.DoubleSidedGIField();
        materialEditor.LightmapEmissionProperty(0);

        GUILayout.Space(10);

        materialEditor.RenderQueueField();
    }
}

