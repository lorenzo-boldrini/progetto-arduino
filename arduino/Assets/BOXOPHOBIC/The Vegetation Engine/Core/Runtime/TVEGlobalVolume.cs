// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using Boxophobic.StyledGUI;
using UnityEngine.Rendering;
using System.Collections.Generic;
#if UNITY_EDITOR
using UnityEditor;
#endif

namespace TheVegetationEngine
{
    [ExecuteInEditMode]
    [AddComponentMenu("BOXOPHOBIC/The Vegetation Engine/TVE Global Volume")]
    public class TVEGlobalVolume : StyledMonoBehaviour
    {
        public enum ElementsVisibility
        {
            AlwaysHidden = 0,
            AlwaysVisible = 10,
            HiddenInGame = 20,
        }

        public enum ElementsSorting
        {
            Once = 0,
            Realtime = 10,
        }

        [StyledBanner(0.890f, 0.745f, 0.309f, "Global Volume", "", "https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.wx14v2fugsn4")]
        public bool styledBanner;

        [StyledMessage("Info", "The Volume Buffers allows for more customization for the global elements rendering. Read more about Volume Buffers and Element Layers in the documentation. Please note that this feature is in Experimental stage and it might not work as expected! Enter playmode if the buffer settings are not updated.", 0, 10)]
        public bool styledMessage = true;

        public Transform followTransform;
        public int followGridSize = 50;

        [Space(10)]
        public ElementsVisibility elementsVisibility = ElementsVisibility.HiddenInGame;
        [HideInInspector]
        public ElementsVisibility elementsVisibilityOld = ElementsVisibility.HiddenInGame;

        public ElementsSorting elementsSorting = ElementsSorting.Once;

        [Range(0.0f, 1.0f)]
        public float elementsEdgeFade = 0.75f;

        [Space(10)]
        public List<TVEVolumeData> volumeBuffers;
        public List<TVEElementDrawerData> volumeElements;

        [StyledSpace(10)]
        public bool styledSpace0;

        [HideInInspector]
        public GameObject globalMotion;
        Vector3 motionDirection = new Vector3(0, 0, 1);
        Color motionColor = new Color(0, 1, 0.5f, 0);

        Matrix4x4 modelViewMatrix;
        Matrix4x4 projectionMatrix;

        Camera mainCamera;

        void Awake()
        {
            volumeElements = new List<TVEElementDrawerData>();

            modelViewMatrix = new Matrix4x4
            (
                new Vector4(1f, 0f, 0f, 0f),
                new Vector4(0f, 0f, -1f, 0f),
                new Vector4(0f, -1f, 0f, 0f),
                new Vector4(0f, 0f, 0f, 1f)
            );
        }

        void Start()
        {
            gameObject.name = "Global Volume";

            if (TVEManager.Instance.globalMotion == null)
            {
                Debug.Log("[TVE] The Vegetation Engine is missing from your scene. Make sure setup TVE first!");
            }
            else
            {
                globalMotion = TVEManager.Instance.globalMotion.gameObject;
            }

            if (volumeBuffers == null || volumeBuffers.Count == 0)
            {
                volumeBuffers = new List<TVEVolumeData>();
            }

            SetDefaultGlobalTextures();

            ClearRenderBuffers();
            CreateRenderBuffers();

            SortElementObjects();
            SetElementsVisibility();

            GetMaincamera();

            if (mainCamera == null)
            {
                Debug.Log("[The Vegetation Engine] Main Camera not found! Make sure you have a main camera with Main Camera tag in your scene! Particle elements updating will be skipped without it.");
            }
        }

        void Update()
        {
            UpdateVolumeTransform();

            if (Application.isPlaying == false || elementsSorting == ElementsSorting.Realtime)
            {
                SortElementObjects();
            }

            if (mainCamera == null)
            {
                GetMaincamera();
            }

            if (mainCamera != null)
            {
                UpdateParticleRenderers();
            }

            if (elementsVisibilityOld != elementsVisibility)
            {
                SetElementsVisibility();

                elementsVisibilityOld = elementsVisibility;
            }

            UpdateDirectionColor();

#if UNITY_EDITOR
            CheckRenderBuffers();
#endif

            UpdateRenderBuffers();
            ExecuteRenderBuffers();

            SetGlobalShaderParameters();
        }

        void OnDrawGizmosSelected()
        {
            Gizmos.color = new Color(0.890f, 0.745f, 0.309f, 1.0f);
            Gizmos.DrawWireCube(new Vector3(gameObject.transform.position.x, gameObject.transform.position.y, gameObject.transform.position.z), new Vector3(gameObject.transform.lossyScale.x, gameObject.transform.lossyScale.y, gameObject.transform.lossyScale.z));
        }

        void GetMaincamera()
        {
            mainCamera = Camera.main;
        }

        void UpdateVolumeTransform()
        {
            gameObject.transform.eulerAngles = Vector3.zero;

            if (followTransform != null)
            {
                var x = Mathf.Round(followTransform.position.x / followGridSize) * followGridSize;
                var z = Mathf.Round(followTransform.position.z / followGridSize) * followGridSize;
                gameObject.transform.position = new Vector3(x, gameObject.transform.position.y, z);
            }
        }

        void UpdateDirectionColor()
        {
            motionDirection = globalMotion.transform.forward;

            motionColor = new Color(motionDirection.x * 0.5f + 0.5f, motionDirection.z * 0.5f + 0.5f, 0.5f, 0.0f);
            //Shader.SetGlobalColor("TVE_MotionDirectionColor", new Color(motionDirection.x * 0.5f + 0.5f, motionDirection.z * 0.5f + 0.5f, 0.0f, 0.0f));
        }

        void SetDefaultRenderBuffers()
        {
            volumeBuffers = new List<TVEVolumeData>();
            volumeBuffers.Add(Resources.Load<TVEVolumeData>("Default Colors Buffer"));
            volumeBuffers.Add(Resources.Load<TVEVolumeData>("Default Extras Buffer"));
            volumeBuffers.Add(Resources.Load<TVEVolumeData>("Default Motion Buffer"));
        }

        void SetDefaultGlobalTextures()
        {
            var internalColorsTex = Resources.Load<Texture2D>("Internal BufferColorTex");
            var internalExtrasTex = Resources.Load<Texture2D>("Internal BufferExtrasTex");
            var internalMotionTex = Resources.Load<Texture2D>("Internal BufferMotionTex");

            Shader.SetGlobalTexture("TVE_ColorsTex", internalColorsTex);
            Shader.SetGlobalTexture("TVE_ColorsTex_Vegetation", internalColorsTex);
            Shader.SetGlobalTexture("TVE_ColorsTex_Grass", internalColorsTex);
            Shader.SetGlobalTexture("TVE_ColorsTex_Objects", internalColorsTex);
            Shader.SetGlobalTexture("TVE_ColorsTex_Custom", internalColorsTex);

            Shader.SetGlobalTexture("TVE_ExtrasTex", internalExtrasTex);
            Shader.SetGlobalTexture("TVE_ExtrasTex_Vegetation", internalExtrasTex);
            Shader.SetGlobalTexture("TVE_ExtrasTex_Grass", internalExtrasTex);
            Shader.SetGlobalTexture("TVE_ExtrasTex_Objects", internalExtrasTex);
            Shader.SetGlobalTexture("TVE_ExtrasTex_Custom", internalExtrasTex);

            Shader.SetGlobalTexture("TVE_MotionTex", internalMotionTex);
            Shader.SetGlobalTexture("TVE_MotionTex_Vegetation", internalMotionTex);
            Shader.SetGlobalTexture("TVE_MotionTex_Grass", internalMotionTex);
            Shader.SetGlobalTexture("TVE_MotionTex_Objects", internalMotionTex);
            Shader.SetGlobalTexture("TVE_MotionTex_Custom", internalMotionTex);
        }

        void CreateRenderBuffers()
        {
            for (int i = 0; i < volumeBuffers.Count; i++)
            {
                var volumeData = volumeBuffers[i];

                if (volumeData == null)
                {
                    continue;
                }

                volumeData.internalTex = new RenderTexture(volumeData.internalResolution, volumeData.internalResolution, 0, volumeData.internalFormat);
                volumeData.internalTex.name = volumeData.bufferName;
                volumeData.internalTex.wrapMode = volumeData.textureWrapMode;

                volumeData.internalBuffer = new CommandBuffer();
                volumeData.internalBuffer.name = volumeData.bufferName;

                Shader.SetGlobalTexture(volumeData.internalTexLegacy, volumeData.internalTex);
                Shader.SetGlobalTexture(volumeData.internalTexVegetation, volumeData.internalTex);
                Shader.SetGlobalTexture(volumeData.internalTexGrass, volumeData.internalTex);
                Shader.SetGlobalTexture(volumeData.internalTexObjects, volumeData.internalTex);
                Shader.SetGlobalTexture(volumeData.internalTexCustom, volumeData.internalTex);
            }
        }

        void ClearRenderBuffers()
        {
            for (int i = 0; i < volumeBuffers.Count; i++)
            {
                var volumeData = volumeBuffers[i];

                if (volumeData == null)
                {
                    continue;
                }

                if (volumeData.internalTex != null)
                {
                    volumeData.internalTex.Release();
                }

                if (volumeData.internalBuffer != null)
                {
                    volumeData.internalBuffer.Clear();
                }
            }
        }

        void UpdateRenderBuffers()
        {
            for (int i = 0; i < volumeBuffers.Count; i++)
            {
                var volumeData = volumeBuffers[i];

                if (volumeData == null)
                {
                    continue;
                }

                if (volumeData.internalBuffer == null)
                {
                    continue;
                }

                volumeData.internalBuffer.Clear();

                if (volumeData.bufferType == TVEVolumeData.BufferType.Motion)
                {
                    volumeData.internalBuffer.ClearRenderTarget(true, true, motionColor);
                }
                else
                {
                    volumeData.internalBuffer.ClearRenderTarget(true, true, volumeData.internalColor);
                }

                if (volumeData.bufferMode == ToggleMode.Off)
                {
                    continue;
                }

                for (int e = 0; e < volumeElements.Count; e++)
                {
                    var elementData = volumeElements[e];

                    if ((int)elementData.elementType == (int)volumeData.bufferType)
                    {
                        if ((int)elementData.elementLayer == (int)volumeData.bufferLayer || elementData.elementLayer == ElementLayer.Any)
                        {
                            if (elementData.rendererType == RendererType.Mesh)
                            {
                                volumeData.internalBuffer.DrawMesh(elementData.mesh, elementData.renderer.localToWorldMatrix, elementData.renderer.sharedMaterial);
                            }
                            else
                            {
                                volumeData.internalBuffer.DrawMesh(elementData.mesh, Matrix4x4.identity, elementData.renderer.sharedMaterial);
                            }
                        }
                    }
                }
            }
        }

        void ExecuteRenderBuffers()
        {
            var position = gameObject.transform.position;
            var scale = gameObject.transform.lossyScale;

            projectionMatrix = Matrix4x4.Ortho(-scale.x / 2 + position.x,
                                                scale.x / 2 + position.x,
                                                scale.z / 2 + -position.z,
                                                -scale.z / 2 + -position.z,
                                                -scale.y / 2 + position.y,
                                                scale.y / 2 + position.y);

            GL.PushMatrix();
            RenderTexture currentRenderTexture = RenderTexture.active;

            for (int i = 0; i < volumeBuffers.Count; i++)
            {
                var volumeData = volumeBuffers[i];

                if (volumeData == null)
                {
                    continue;
                }

                if (volumeData.internalBuffer == null)
                {
                    continue;
                }

                Graphics.SetRenderTarget(volumeData.internalTex);
                GL.LoadProjectionMatrix(projectionMatrix);
                GL.modelview = modelViewMatrix;
                Graphics.ExecuteCommandBuffer(volumeData.internalBuffer);

                Shader.SetGlobalTexture(volumeData.internalTexLegacy, volumeData.internalTex);
                Shader.SetGlobalTexture(volumeData.internalTexVegetation, volumeData.internalTex);
                Shader.SetGlobalTexture(volumeData.internalTexGrass, volumeData.internalTex);
                Shader.SetGlobalTexture(volumeData.internalTexObjects, volumeData.internalTex);
                Shader.SetGlobalTexture(volumeData.internalTexCustom, volumeData.internalTex);
            }

            RenderTexture.active = currentRenderTexture;
            GL.PopMatrix();
        }

        void CheckRenderBuffers()
        {
            for (int i = 0; i < volumeBuffers.Count; i++)
            {
                var volumeData = volumeBuffers[i];

                if (volumeData == null)
                {
                    continue;
                }

                if (volumeData.isUpdated)
                {
                    ClearRenderBuffers();
                    CreateRenderBuffers();
                    volumeData.isUpdated = false;
                }
            }
        }

        void SetGlobalShaderParameters()
        {
            var x = 1 / gameObject.transform.lossyScale.x;
            var y = 1 / gameObject.transform.lossyScale.z;
            var z = 1 / gameObject.transform.lossyScale.x * transform.position.x - 0.5f;
            var w = 1 / gameObject.transform.lossyScale.z * transform.position.z - 0.5f;

            Shader.SetGlobalVector("TVE_VolumeCoord", new Vector4(x, y, -z, -w));
            Shader.SetGlobalFloat("TVE_ElementFadeContrast", elementsEdgeFade);
        }

        void UpdateParticleRenderers()
        {
            for (int i = 0; i < volumeElements.Count; i++)
            {
                if (volumeElements[i] != null)
                {
                    if (volumeElements[i].rendererType == RendererType.Particle)
                    {
                        var particleRenderer = (ParticleSystemRenderer)volumeElements[i].renderer;
                        particleRenderer.BakeMesh(volumeElements[i].mesh, true);
                    }
                }
            }
        }

        void SortElementObjects()
        {
            for (int i = 0; i < volumeElements.Count - 1; i++)
            {
                for (int j = 0; j < volumeElements.Count - 1; j++)
                {
                    if (volumeElements[j] != null && volumeElements[j].gameobject.transform.position.y > volumeElements[j + 1].gameobject.transform.position.y)
                    {
                        var temp = volumeElements[j + 1];
                        volumeElements[j + 1] = volumeElements[j];
                        volumeElements[j] = temp;
                    }
                }
            }
        }

        void SetElementsVisibility()
        {
            if (elementsVisibility == ElementsVisibility.AlwaysHidden)
            {
                DisableElementsVisibility();
            }
            else if (elementsVisibility == ElementsVisibility.AlwaysVisible)
            {
                EnableElementsVisibility();
            }
            else if (elementsVisibility == ElementsVisibility.HiddenInGame)
            {
                if (Application.isPlaying)
                {
                    DisableElementsVisibility();
                }
                else
                {
                    EnableElementsVisibility();
                }
            }
        }

        void EnableElementsVisibility()
        {
            for (int i = 0; i < volumeElements.Count; i++)
            {
                if (volumeElements[i] != null)
                {
                    volumeElements[i].renderer.enabled = true;
                }
            }
        }

        void DisableElementsVisibility()
        {
            for (int i = 0; i < volumeElements.Count; i++)
            {
                if (volumeElements[i] != null)
                {
                    volumeElements[i].renderer.enabled = false;
                }
            }
        }
    }
}
