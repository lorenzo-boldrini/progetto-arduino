// Cristian Pop - https://boxophobic.com/

using Boxophobic.StyledGUI;
using UnityEngine;
using UnityEngine.Rendering;

namespace TheVegetationEngine
{
    [CreateAssetMenu(fileName = "New Volume Buffer", menuName = "BOXOPHOBIC/The Vegetation Engine/Volume Buffer")]
    public class TVEVolumeData : StyledScriptableObject
    {
        public enum BufferType
        {
            Colors = 10,
            Extras = 20,
            Motion = 30,
        }

        public enum BufferLayer
        {
            Default = 0,
            Vegetation = 10,
            Grass = 20,
            Objects = 30,
            Custom = 100,
        }

        public enum TextureFormat
        {
            Default = 10,
            DefaultHDR = 20,
        }

        public enum TextureSizes
        {
            _32 = 32,
            _64 = 64,
            _128 = 128,
            _256 = 256,
            _512 = 512,
            _1024 = 1024,
            _2048 = 2048,
            _4096 = 4096,
        }

        [StyledBanner(0.890f, 0.745f, 0.309f, "Volume Buffer", "", "https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.hbq3w8ae720x")]
        public bool styledBanner;

        [StyledMessage("Warning", "This is an internal buffer! Internal buffers will reset to default on upgrading the asset to a new version! Make sure to create your own buffers to change the setting by right clicking in the project window > BOXOPHOBIC > The Vegetation Engine > New Volume Buffer.", 0, 10)]
        public bool internalBufferMessage = false;

        public ToggleMode bufferMode = ToggleMode.On;

        [Space(10)]
        public string bufferName = "TVE New Colors Buffer";
        public BufferType bufferType = BufferType.Colors;
        public BufferLayer bufferLayer = BufferLayer.Default;

        [Space(10)]
        public TextureFormat textureFormat = TextureFormat.DefaultHDR;
        public TextureSizes textureResolution = TextureSizes._1024;
        public TextureWrapMode textureWrapMode = TextureWrapMode.Repeat;

        [Space(10)]
        [StyledTexturePreview]
        public RenderTexture internalTex;

        [HideInInspector]
        public bool isUpdated = false;
        [HideInInspector]
        public int internalResolution;
        [HideInInspector]
        public RenderTextureFormat internalFormat;
        [HideInInspector]
        public CommandBuffer internalBuffer;
        [HideInInspector]
        public Color internalColor;
        [HideInInspector]
        public string internalTexLegacy;
        [HideInInspector]
        public string internalTexVegetation;
        [HideInInspector]
        public string internalTexGrass;
        [HideInInspector]
        public string internalTexObjects;
        [HideInInspector]
        public string internalTexCustom;

        void OnValidate()
        {
            UpdateVolumeBufferData();
        }

        public void UpdateVolumeBufferData()
        {
            if (bufferMode == ToggleMode.Off)
            {
                internalResolution = 32;
            }
            else
            {
                internalResolution = (int)textureResolution;
            }

            if (bufferType != BufferType.Colors)
            {
                textureFormat = TextureFormat.Default;
            }

            if (textureFormat == TextureFormat.Default)
            {
                internalFormat = RenderTextureFormat.Default;
            }
            else
            {
                internalFormat = RenderTextureFormat.DefaultHDR;
            }

            if (bufferType == BufferType.Colors)
            {
                if (QualitySettings.activeColorSpace == ColorSpace.Linear)
                {
                    internalColor = new Color(0.5f, 0.5f, 0.5f, 1.0f).linear;
                }
                else
                {
                    internalColor = new Color(0.5f, 0.5f, 0.5f, 1.0f);
                }
            }

            if (bufferType == BufferType.Extras)
            {
                internalColor = new Color(1f, 1f, 1f, 1);
            }

            var outputTex = "TVE_ColorsTex";

            if (bufferType == BufferType.Motion)
            {
                outputTex = "TVE_MotionTex";
            }

            if (bufferType == BufferType.Extras)
            {
                outputTex = "TVE_ExtrasTex";
            }

            internalTexLegacy = outputTex;

            if (bufferLayer == BufferLayer.Default)
            {
                internalTexVegetation = outputTex + "_Vegetation";
                internalTexGrass = outputTex + "_Grass";
                internalTexObjects = outputTex + "_Objects";
            }

            if (bufferLayer == BufferLayer.Vegetation)
            {
                internalTexVegetation = outputTex + "_Vegetation";
                internalTexGrass = outputTex + "_Vegetation";
                internalTexObjects = outputTex + "_Vegetation";
            }

            if (bufferLayer == BufferLayer.Grass)
            {
                internalTexVegetation = outputTex + "_Grass";
                internalTexGrass = outputTex + "_Grass";
                internalTexObjects = outputTex + "_Grass";
            }

            if (bufferLayer == BufferLayer.Objects)
            {
                internalTexVegetation = outputTex + "_Objects";
                internalTexGrass = outputTex + "_Objects";
                internalTexObjects = outputTex + "_Objects";
            }

            if (bufferLayer == BufferLayer.Custom)
            {
                internalTexVegetation = outputTex + "_Custom";
                internalTexGrass = outputTex + "_Custom";
                internalTexObjects = outputTex + "_Custom";
            }

#if UNITY_EDITOR
            if (name == "Default Colors Buffer" || name == "Default Extras Buffer" || name == "Default Motion Buffer")
            {
                internalBufferMessage = true;
            }
            else if (name != "Default Colors Buffer" || name != "Default Extras Buffer" || name != "Default Motion Buffer")
            {
                internalBufferMessage = false;
            }
#endif

            isUpdated = true;
        }
    }
}