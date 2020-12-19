// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using Boxophobic.StyledGUI;

namespace TheVegetationEngine
{
    [ExecuteInEditMode]
    [AddComponentMenu("BOXOPHOBIC/The Vegetation Engine/TVE Global Size Fade")]
    public class TVEGlobalSizeFade : StyledMonoBehaviour
    {
        [StyledBanner(0.890f, 0.745f, 0.309f, "Global Size Fade", "", "https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.q3sme6mi00gy")]
        public bool styledBanner;

        [StyledMessage("Info", "Use the Global Size Fade slider on the materials to control the distance fade bias. This features is currently enabled for the grass shaders only!", 0, 10)]
        public bool styledMessage = true;

        public ToggleMode sizeFadeMode = ToggleMode.On;

        [Space(10)]
        public float sizeFadeStart = 75.0f;
        public float sizeFadeEnd = 100.0f;

        [StyledSpace(10)]
        public bool styledSpace0;

        void Start()
        {
            gameObject.name = "Global Size Fade";

            SetGlobalShaderProperties();
        }

        void Update()
        {
            SetGlobalShaderProperties();
        }

        void SetGlobalShaderProperties()
        {
            if (sizeFadeMode == ToggleMode.On)
            {
                Shader.SetGlobalFloat("TVE_SizeFadeStart", sizeFadeStart);
                Shader.SetGlobalFloat("TVE_SizeFadeEnd", sizeFadeEnd);
            }
            else
            {
                Shader.SetGlobalFloat("TVE_SizeFadeStart", 0);
                Shader.SetGlobalFloat("TVE_SizeFadeEnd", 0);
            }
        }
    }
}
