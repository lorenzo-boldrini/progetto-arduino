// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using Boxophobic.StyledGUI;
#if UNITY_EDITOR
using System.IO;
using UnityEditor;
#endif

namespace TheVegetationEngine
{
    [ExecuteInEditMode]
    [AddComponentMenu("BOXOPHOBIC/The Vegetation Engine/TVE Global Overlay")]
    public class TVEGlobalOverlay : StyledMonoBehaviour
    {
        [StyledBanner(0.890f, 0.745f, 0.309f, "Global Overlay", "", "https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.g40aci2udwrg")]
        public bool styledBanner;

        [StyledMessage("Info", "The overlay texures are currently disabled for the built-in shaders. They will only be used for shaders compiled with the Overlay Quality option set to Standard on the Amplify Base function!", 0, 10)]
        public bool styledMessage = true;

        public ToggleMode overlayMode = ToggleMode.Off;

        [Space(10)]
        [Range(0.0f, 1.0f)]
        public float overlayIntensity = 1.0f;

        [Space(10)]
        [ColorUsage(false, true)]
        public Color overlayColor = Color.white;
        [Range(0.0f, 1.0f)]
        public float overlaySmoothness = 0.5f;

        [Space(10)]
        public Texture2D overlayAlbedo;
        public Texture2D overlayNormal;
        [Range(0.0f, 10.0f)]
        public float overlayTilling = 1.0f;
        [Range(-8.0f, 8.0f)]
        public float overlayNormalScale = 1.0f;


        [StyledSpace(10)]
        public bool styledSpace0;

        Texture2D dummyNormalTex;

        void Start()
        {
            gameObject.name = "Global Overlay";

            dummyNormalTex = Resources.Load<Texture2D>("Internal NormalTex");

            SetGlobalShaderProperties();
        }

        void Update()
        {
            SetGlobalShaderProperties();
        }

        void SetGlobalShaderProperties()
        {
            var direction = -gameObject.transform.forward;

            Shader.SetGlobalVector("TVE_OverlayDirection", direction);

            Shader.SetGlobalFloat("TVE_OverlayIntensity", overlayIntensity * (float)overlayMode);
            Shader.SetGlobalColor("TVE_OverlayColor", overlayColor);

            if (overlayAlbedo != null)
            {
                Shader.SetGlobalTexture("TVE_OverlayAlbedoTex", overlayAlbedo);
            }
            else
            {
                Shader.SetGlobalTexture("TVE_OverlayAlbedoTex", Texture2D.whiteTexture);
            }

            if (overlayNormal != null)
            {
                Shader.SetGlobalTexture("TVE_OverlayNormalTex", overlayNormal);
            }
            else
            {
                Shader.SetGlobalTexture("TVE_OverlayNormalTex", dummyNormalTex);
            }

            Shader.SetGlobalFloat("TVE_OverlayUVTilling", overlayTilling);
            Shader.SetGlobalFloat("TVE_OverlayNormalValue", overlayNormalScale);
            Shader.SetGlobalFloat("TVE_OverlaySmoothness", overlaySmoothness);
        }
    }
}
