// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using Boxophobic.StyledGUI;

namespace TheVegetationEngine
{
    [ExecuteInEditMode]
    [AddComponentMenu("BOXOPHOBIC/The Vegetation Engine/TVE Global Motion")]
    public class TVEGlobalMotion : StyledMonoBehaviour
    {
        [StyledBanner(0.890f, 0.745f, 0.309f, "Global Motion", "", "https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.czf8ud5bmaq2")]
        public bool styledBanner;

        [StyledMessage("Info", "When the Noise is linked with the Motion Direction, smooth direction animation is not supported!", 0, 10)]
        public bool styledLinkMessage = false;

        public ToggleMode windMode = ToggleMode.On;

        [Space(10)]
        [StyledRangeOptions(0,1, "Wind Power", new string[] { "Calm", "Windy", "Strong" })]
        public float windPower = 0.5f;

        [Space(10)]
        public Texture2D noiseTexture;
        public float noiseSize = 50;
        public float noiseSpeed = 1;

        [Space(10)]
        public bool linkNoiseWithMotionDirection = true;

        [StyledSpace(10)]
        public bool styledSpace0;

        float noiseDirectionX;
        float noiseDirectionZ;

        void Start()
        {

#if UNITY_EDITOR
            gameObject.GetComponent<MeshRenderer>().hideFlags = HideFlags.HideInInspector;
            gameObject.GetComponent<MeshFilter>().hideFlags = HideFlags.HideInInspector;
#endif

            // Disable Arrow in play mode
            if (Application.isPlaying == true)
            {
                gameObject.GetComponent<MeshRenderer>().enabled = false;
            }
            else
            {
                gameObject.GetComponent<MeshRenderer>().enabled = true;
            }

            gameObject.name = "Global Motion";

            if (noiseTexture == null)
            {
                noiseTexture = Resources.Load<Texture2D>("Internal NoiseTex");
            }

            SetGlobalShaderProperties();
        }

        void Update()
        {
            gameObject.transform.eulerAngles = new Vector3(0, gameObject.transform.eulerAngles.y, 0);

            SetGlobalShaderProperties();
        }

        void SetGlobalShaderProperties()
        {
            Shader.SetGlobalFloat("TVE_WindPower", windPower);
            Shader.SetGlobalFloat("TVE_WindMode", (int)windMode);

            var mode = (int)windMode;

            Shader.SetGlobalFloat("TVE_NoiseContrast", Mathf.Lerp(2.5f, 0.5f, windPower));
            Shader.SetGlobalFloat("TVE_NoiseHighlight", Mathf.Lerp(4f, 2f, windPower));

            if (linkNoiseWithMotionDirection)
            {
                noiseDirectionX = -gameObject.transform.forward.x;
                noiseDirectionZ = -gameObject.transform.forward.z;

                styledLinkMessage = true;
            }
            else
            {
                noiseDirectionX = -1;
                noiseDirectionZ = -1;

                styledLinkMessage = false;
            }

            Shader.SetGlobalTexture("TVE_NoiseTex", noiseTexture);
            Shader.SetGlobalVector("TVE_NoiseSpeed_Vegetation", new Vector2 (noiseSpeed * noiseDirectionX * 0.1f, noiseSpeed * noiseDirectionZ * 0.1f));
            Shader.SetGlobalVector("TVE_NoiseSpeed_Grass", new Vector2(noiseSpeed * 2 * noiseDirectionX * 0.1f, noiseSpeed * 2 * noiseDirectionZ * 0.1f));
            Shader.SetGlobalFloat("TVE_NoiseSize_Vegetation", 1.0f / noiseSize);
            Shader.SetGlobalFloat("TVE_NoiseSize_Grass", 1.0f / (noiseSize / 2));
        }
    }
}
