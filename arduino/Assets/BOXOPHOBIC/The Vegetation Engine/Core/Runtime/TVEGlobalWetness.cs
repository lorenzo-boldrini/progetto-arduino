// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using Boxophobic.StyledGUI;

namespace TheVegetationEngine
{
    [ExecuteInEditMode]
    [AddComponentMenu("BOXOPHOBIC/The Vegetation Engine/TVE Global Seasons")]
    public class TVEGlobalWetness : StyledMonoBehaviour
    {
        [StyledBanner(0.890f, 0.745f, 0.309f, "Global Wetness", "", "https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.oaihoayshutd")]
        public bool styledBanner;

        [StyledMessage("Info", "Use the Wetness slider to control the smoothness on vegetation and props for a wet look. The wetness can be controlled locally with Wetness elements.", 0, 10)]
        public bool styledMessage = true;

        [StyledRangeOptions(-1f, 1f, "Wetness", new string[] { "Dry", "Default", "Wet"})]
        public float wetness = 0f;

        [StyledSpace(10)]
        public bool styledSpace0;

        void Start()
        {
            gameObject.name = "Global Wetness";

            SetGlobalShaderProperties();
        }

        void Update()
        {
            SetGlobalShaderProperties();
        }
        void SetGlobalShaderProperties()
        {
            Shader.SetGlobalFloat("TVE_Wetness", wetness);
        }
    }
}
