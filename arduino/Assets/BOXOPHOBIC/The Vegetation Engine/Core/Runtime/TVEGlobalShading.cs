// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using Boxophobic.StyledGUI;

namespace TheVegetationEngine
{
    [ExecuteInEditMode]
    [AddComponentMenu("BOXOPHOBIC/The Vegetation Engine/TVE Global Shading")]
    public class TVEGlobalShading : StyledMonoBehaviour
    {
        [StyledBanner(0.890f, 0.745f, 0.309f, "Global Shading", "", "https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.31aoa8vyouy4")]
        public bool styledBanner;

        [StyledMessage("Info", "Use the Min Max values to remap the light intensity used for Subsurface. This is useful in HDRP where the light intensity can reach high values.", 0, 10)]
        public bool styledMessage = true;
        
        public Light mainLight;

        public float mainLightMin = 0;
        public float mainLightMax = 1;

        [StyledSpace(10)]
        public bool styledSpace0;

        void Start()
        {
            gameObject.name = "Global Shading";
        }

        void Update()
        {
            SetGlobalShaderProperties();
        }

        void SetGlobalShaderProperties()
        {
            if (mainLight != null)
            {
                var intensity = Mathf.Clamp01(mainLight.intensity - mainLightMin) / (mainLightMax - mainLightMin);

                Shader.SetGlobalVector("TVE_MainLightParams", new Vector4(mainLight.color.r * intensity, mainLight.color.g * intensity, mainLight.color.b * intensity, intensity));
                Shader.SetGlobalVector("TVE_MainLightDirection", -mainLight.transform.forward);
            }
            else
            {
                Shader.SetGlobalVector("TVE_MainLightParams", Vector4.one);
                Shader.SetGlobalVector("TVE_MainLightDirection", new Vector4(0, 1, 0, 0));
            }
        }
    }
}
