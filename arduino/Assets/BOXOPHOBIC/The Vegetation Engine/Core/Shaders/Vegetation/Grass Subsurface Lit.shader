// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Vegetation Engine/Vegetation/Grass Subsurface Lit"
{
	Properties
	{
		[StyledBanner(Grass Subsurface Lit)]_Banner("Banner", Float) = 0
		[StyledCategory(Render Settings)]_RenderingCat("[ Rendering Cat ]", Float) = 0
		[Enum(Opaque,0,Transparent,1)]_RenderMode("Render Mode", Float) = 0
		[Enum(Both,0,Back,1,Front,2)]_RenderCull("Render Faces", Float) = 0
		[Enum(Flip,0,Mirror,1,None,2)]_RenderNormals("Render Normals", Float) = 0
		[Enum(Alpha,0,Premultiply,1)]_RenderBlend("Render Blend", Float) = 0
		[Enum(Off,0,On,1)]_RenderZWrite("Render ZWrite", Float) = 1
		[IntRange]_RenderPriority("Render Priority", Range( -100 , 100)) = 0
		[Enum(Off,0,On,1)][Space(10)]_RenderClip("Alpha Clipping", Float) = 1
		_Cutoff("Alpha Treshold", Range( 0 , 1)) = 0.5
		[StyledCategory(Global Settings)]_GlobalCat("[ Global Cat ]", Float) = 0
		_GlobalColors("Global Colors", Range( 0 , 1)) = 1
		_GlobalOverlay("Global Overlay", Range( 0 , 1)) = 1
		_GlobalWetness("Global Wetness", Range( 0 , 1)) = 1
		_GlobalLeaves("Global Leaves", Range( 0 , 1)) = 1
		_GlobalHealthiness("Global Healthiness", Range( 0 , 1)) = 1
		_GlobalSize("Global Size", Range( 0 , 1)) = 1
		_GlobalSizeFade("Global Size Fade", Range( 0 , 1)) = 0
		[StyledSpace(10)]_GlobalSpace("# Global Space", Float) = 0
		[HideInInspector][HDR]_LocalColors("Local Colors", Color) = (1,1,1,1)
		[HideInInspector]_LocalLeaves("Local Leaves", Range( 0 , 1)) = 1
		[HideInInspector]_LocalSize("Local Size", Range( 0 , 1)) = 1
		_ColorsMaskValue("Colors Use Mask (bottom mask)", Range( 0 , 1)) = 0
		_OverlayContrastValue("Overlay Contrast", Range( 0 , 10)) = 4
		_OverlayVariationValue("Overlay Variation", Range( 0 , 1)) = 0
		_LeavesVariationValue("Leaves Variation", Range( 0 , 1)) = 0
		[StyledCategory(Main Settings)]_MainCat("[ Main Cat ]", Float) = 0
		[NoScaleOffset]_MainAlbedoTex("Main Albedo", 2D) = "white" {}
		[NoScaleOffset]_MainNormalTex("Main Normal", 2D) = "gray" {}
		[NoScaleOffset]_MainMaskTex("Main Mask", 2D) = "white" {}
		[Space(10)]_MainUVs("Main UVs", Vector) = (1,1,0,0)
		[HDR]_MainColor("Main Color", Color) = (1,1,1,1)
		_MainNormalValue("Main Normal", Range( -8 , 8)) = 1
		_MainOcclusionValue("Main Occlusion", Range( 0 , 1)) = 1
		_MainSmoothnessValue("Main Smoothness", Range( 0 , 1)) = 1
		[StyledCategory(Detail Settings)]_DetailCat("[ Detail Cat ]", Float) = 0
		[Enum(Off,0,Overlay,1,Replace,2)]_DetailMode("Detail Mode", Float) = 0
		[Enum(Vertex Paint,0,Projection,1)]_DetailTypeMode("Detail Type", Float) = 0
		[Enum(Standard,0,Packed,1)]_DetailMapsMode("Detail Maps", Float) = 0
		[StyledSpace(10)]_DetailSpace("# Detail Space", Float) = 0
		[StyledCategory(Occlusion Settings)]_OcclusionCat("[ Occlusion Cat ]", Float) = 0
		[HDR]_VertexOcclusionColor("Vertex Occlusion Color", Color) = (0,0,0,0)
		_VertexOcclusionValue("Vertex Occlusion Power", Range( 0 , 8)) = 0
		[StyledCategory(Subsurface Settings)]_SubsurfaceCat("[ Subsurface Cat ]", Float) = 0
		[HideInInspector][ASEDiffusionProfile(_SubsurfaceDiffusion)]_SubsurfaceDiffusion_asset("Subsurface Diffusion", Vector) = (0,0,0,0)
		[HDR]_SubsurfaceColor("Subsurface Color", Color) = (0.3315085,0.490566,0,1)
		_SubsurfaceValue("Subsurface Intensity", Range( 0 , 1)) = 1
		_SubsurfaceViewValue("Subsurface View", Range( 0 , 8)) = 1
		_SubsurfaceAngleValue("Subsurface Angle", Range( 0 , 16)) = 8
		_SubsurfaceLightValue("Subsurface Use Light", Range( 0 , 1)) = 1
		_SubsurfaceMaskValue("Subsurface Use Mask (top mask)", Range( 0 , 1)) = 1
		[StyledCategory(Gradient Settings)]_GradientCat("[ Gradient Cat ]", Float) = 0
		[HDR]_GradientColorOne("Gradient Color One", Color) = (1,1,1,1)
		[HDR]_GradientColorTwo("Gradient Color Two", Color) = (1,1,1,1)
		_GradientMinValue("Gradient Mask Min", Range( 0 , 1)) = 0
		_GradientMaxValue("Gradient Mask Max ", Range( 0 , 1)) = 1
		[StyledCategory(Noise Settings)]_MoiseCat("[ Noise Cat ]", Float) = 0
		[NoScaleOffset]_NoiseTex("Noise Mask", 2D) = "white" {}
		_NoiseScaleValue("Noise Mask Scale", Range( 0 , 1)) = 0.01
		_NoiseMinValue("Noise Mask Min", Range( 0 , 1)) = 0
		_NoiseMaxValue("Noise Mask Max ", Range( 0 , 1)) = 1
		[HDR][Space(10)]_NoiseTintOne("Noise Tint One", Color) = (1,1,1,1)
		[HDR]_NoiseTintTwo("Noise Tint Two", Color) = (1,1,1,1)
		[StyledCategory(Perspective Settings)]_PerspectiveCat("[ Perspective Cat ]", Float) = 0
		_PerspectivePushValue("Perspective Push", Range( 0 , 4)) = 0
		_PerspectiveNoiseValue("Perspective Noise", Range( 0 , 4)) = 0
		_PerspectiveAngleValue("Perspective Angle", Range( 0 , 8)) = 1
		[StyledCategory(Vertex Settings)]_VertexCat("[ Vertex Cat ]", Float) = 0
		[StyledMessage(Info, The Object motion feature allows for high quality bending motion and interaction. The motion and global elements are calculated per instance., _VertexMotionMode, 0 , 2, 0)]_ObjectDataMessage("# Object Data Message", Float) = 0
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[StyledMessage(Info, The World motion feature allows for simpler and cheaper translation motion and interaction. The motion is calculated in world space but the global elements are calculated per instance., _VertexMotionMode, 1 , 2, 0)]_WorldDataMessage("# World Data Message", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[StyledMessage(Info, The Baked pivots feature allows for using per mesh element interaction and elements influence. This feature requires pre baked pivots on prefab conversion. Useful for latge grass meshes., _VertexPivotMode, 1 , 0, 0)]_PivotsMessage("# Pivots Message", Float) = 0
		[Enum(Object,0,World,1)][Space(10)]_VertexMotionMode("Vertex Motion", Float) = 0
		[Enum(Object,0,Baked,1)]_VertexPivotMode("Vertex Pivot", Float) = 0
		[StyledSpace(10)]_VertexMotionSpace("# Vertex Motion Space", Float) = 0
		[HDR]_MotionHighlightColor("Motion Highlight", Color) = (2,2,2,1)
		_Motion_10("Motion Bending", Range( 0 , 1)) = 1
		_Motion_32("Motion Flutter", Range( 0 , 1)) = 1
		_Motion_Interaction("Motion Interaction", Range( 0 , 1)) = 1
		[HideInInspector]_MotionAmplitude_10("Primary Bending", Float) = 2
		[HideInInspector]_MotionSpeed_10("Primary Speed", Float) = 6
		[HideInInspector]_MotionScale_10("Primary Elasticity", Float) = 1
		[HideInInspector]_MotionVariation_10("Primary Variation", Float) = 3
		[HideInInspector]_MotionAmplitude_20("Secundary Rolling", Float) = 0
		[HideInInspector]_MotionSpeed_20("Secundary Speed", Float) = 5
		[HideInInspector]_MotionScale_20("Secundary Elasticity", Float) = 0
		[HideInInspector]_MotionVariation_20("Secundary Variation", Range( 0 , 5)) = 0
		[HideInInspector]_MotionAmplitude_30("Leaves Amplitude", Float) = 0
		[HideInInspector]_MotionSpeed_30("Leaves Speed", Float) = 15
		[HideInInspector]_MotionScale_30("Leaves Scale", Float) = 30
		[HideInInspector]_MotionVariation_30("Leaves Variation", Float) = 30
		[HideInInspector]_MotionAmplitude_32("Flutter Amplitude", Float) = 1
		[HideInInspector]_MotionSpeed_32("Flutter Speed", Float) = 30
		[HideInInspector]_MotionScale_32("Flutter Elasticity", Float) = 30
		[HideInInspector]_MotionVariation_32("Flutter Variation", Float) = 30
		[HideInInspector]_InteractionAmplitude("Interaction Bending", Float) = 0
		[HideInInspector]_InteractionVariation("Interaction Variation", Float) = 0
		[StyledCategory(Advanced)]_AdvancedCat("[ Advanced Cat]", Float) = 0
		[StyledMessage(Info, Use the Batching Support option when the object is statically batched. All vertex calculations are done in world space and features like Baked Pivots and Size options are not supported because the object pivot data is missing with static batching., _VertexDataMode, 1 , 2,10)]_BatchingMessage("# Batching Message", Float) = 0
		[Toggle]_VertexDataMode("Enable Batching Support", Float) = 0
		[HideInInspector]_IsTVEShader("_IsTVEShader", Float) = 1
		[HideInInspector]_IsVersion("_IsVersion", Float) = 200
		[HideInInspector]_Color("_Color", Color) = (0,0,0,0)
		[HideInInspector]_MainTex("_MainTex", 2D) = "white" {}
		[HideInInspector]_MaxBoundsInfo("_MaxBoundsInfo", Vector) = (1,1,1,1)
		[HideInInspector]_VertexVariationMode("_VertexVariationMode", Float) = 0
		[HideInInspector]_vertex_pivot_mode("_vertex_pivot_mode", Float) = 0
		[HideInInspector]_render_normals_options("_render_normals_options", Vector) = (1,1,1,0)
		[HideInInspector]_material_batching("_material_batching", Float) = 0
		[HideInInspector][Enum(Main Mask,0,Detail Mask,1)]_MaskMode("_MaskMode", Float) = 0
		[HideInInspector]_OverlayContrast("_OverlayContrast", Float) = 0
		[HideInInspector]_ObjectOcclusionValue("_ObjectOcclusionValue", Float) = 0
		[HideInInspector]_ObjectSmoothnessValue("_ObjectSmoothnessValue", Float) = 0
		[HideInInspector]_ObjectMetallicValue("_ObjectMetallicValue", Float) = 0
		[HideInInspector]_OverlayVariation("_OverlayVariation", Float) = 0
		[HideInInspector]_GrassPerspectiveAngleValue("_GrassPerspectiveAngleValue", Float) = 0
		[HideInInspector]_GrassPerspectiveNoiseValue("_GrassPerspectiveNoiseValue", Float) = 0
		[HideInInspector]_GrassPerspectivePushValue("_GrassPerspectivePushValue", Float) = 0
		[HideInInspector]_SubsurfaceMinValue("_SubsurfaceMinValue", Float) = 0
		[HideInInspector]_SubsurfaceMaxValue("_SubsurfaceMaxValue", Float) = 0
		[HideInInspector]_render_mode("_render_mode", Float) = 0
		[HideInInspector]_render_normals("_render_normals", Float) = 0
		[HideInInspector]_render_blend("_render_blend", Float) = 0
		[HideInInspector]_render_priority("_render_priority", Float) = 0
		[HideInInspector]_render_premul("_render_premul", Float) = 0
		[HideInInspector]_IsGrassShader("_IsGrassShader", Float) = 1
		[HideInInspector]_IsStandardShader("_IsStandardShader", Float) = 1
		[HideInInspector]_IsForwardPathShader("_IsForwardPathShader", Float) = 1
		[HideInInspector]_IsLitShader("_IsLitShader", Float) = 1
		[HideInInspector]_render_cutoff("_render_cutoff", Float) = 0.5
		[HideInInspector]_render_src("_render_src", Float) = 1
		[HideInInspector]_render_cull("_render_cull", Float) = 0
		[HideInInspector]_render_dst("_render_dst", Float) = 0
		[HideInInspector]_render_zw("_render_zw", Float) = 1
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" "DisableBatching" = "True" }
		Cull [_render_cull]
		ZWrite [_render_zw]
		Blend [_render_src] [_render_dst]
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#pragma target 3.0
		#pragma multi_compile_instancing
		#pragma shader_feature_local _ALPHATEST_ON
		#pragma shader_feature_local TVE_VERTEX_DATA_OBJECT TVE_VERTEX_DATA_WORLD TVE_VERTEX_DATA_BATCHED
		#define TVE_PIVOT_DATA_BAKED
		#define TVE_IS_GRASS_SHADER
		  
		//SHADER INJECTION POINT BEGIN
		//SHADER INJECTION POINT END
		    
		#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
		#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
		#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex.SampleBias(samplerTex,coord,bias)
		#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex.SampleGrad(samplerTex,coord,ddx,ddy)
		#else//ASE Sampling Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
		#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
		#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
		#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
		#endif//ASE Sampling Macros

		#pragma exclude_renderers d3d9 d3d11_9x gles 
		#pragma surface surf StandardCustom keepalpha addshadow fullforwardshadows exclude_path:deferred nodynlightmap dithercrossfade vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			half ASEVFace : VFACE;
			float4 vertexColor : COLOR;
			float3 vertexToFrag3225_g42392;
			float3 vertexToFrag3252_g42392;
			float4 uv_tex4coord;
		};

		struct SurfaceOutputStandardCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			half3 Transmission;
		};

		uniform half _render_cutoff;
		uniform half _render_dst;
		uniform half _render_cull;
		uniform half _render_src;
		uniform half _render_zw;
		uniform half _Banner;
		uniform half _IsStandardShader;
		uniform half _IsLitShader;
		uniform half _IsForwardPathShader;
		uniform half _IsGrassShader;
		uniform half _MainNormalValue;
		uniform float4 _SubsurfaceDiffusion_asset;
		uniform half _RenderNormals;
		uniform half _IsVersion;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MainTex);
		SamplerState sampler_MainTex;
		uniform half _InteractionAmplitude;
		uniform float _MotionScale_30;
		uniform float _MotionSpeed_32;
		uniform half _IsTVEShader;
		uniform half _Cutoff;
		uniform half _InteractionVariation;
		uniform float _MotionScale_32;
		uniform float4 _MaxBoundsInfo;
		uniform half _RenderingCat;
		uniform half _VertexVariationMode;
		uniform half _MotionVariation_20;
		uniform half _RenderPriority;
		uniform half _PivotsMessage;
		uniform float _MotionSpeed_30;
		uniform half _RenderCull;
		uniform half _MotionAmplitude_32;
		uniform half _RenderZWrite;
		uniform half _RenderBlend;
		uniform half _RenderMode;
		uniform half _DetailMode;
		uniform half _DetailCat;
		uniform half _AdvancedCat;
		uniform half _ObjectDataMessage;
		uniform half _GlobalCat;
		uniform half _DetailTypeMode;
		uniform float _MotionVariation_32;
		uniform half _BatchingMessage;
		uniform half _DetailMapsMode;
		uniform float _MotionScale_20;
		uniform float _MotionSpeed_10;
		uniform half _WorldDataMessage;
		uniform half _MotionVariation_10;
		uniform half _MainCat;
		uniform half _MotionAmplitude_20;
		uniform float _MotionVariation_30;
		uniform half3 _render_normals_options;
		uniform float4 _Color;
		uniform float _MotionSpeed_20;
		uniform half _RenderClip;
		uniform half _MotionAmplitude_10;
		uniform float _MotionScale_10;
		uniform half _MotionAmplitude_30;
		uniform half _DetailSpace;
		uniform half _GlobalSpace;
		uniform float _SubsurfaceMaxValue;
		uniform float _GrassPerspectiveAngleValue;
		uniform float _SubsurfaceMinValue;
		uniform float _ObjectOcclusionValue;
		uniform float _GrassPerspectivePushValue;
		uniform float _OverlayContrast;
		uniform float _OverlayVariation;
		uniform float _material_batching;
		uniform float _render_priority;
		uniform float _render_mode;
		uniform float _render_blend;
		uniform float _ObjectSmoothnessValue;
		uniform float _GrassPerspectiveNoiseValue;
		uniform float _render_normals;
		uniform float _ObjectMetallicValue;
		uniform half _MaskMode;
		uniform half _VertexPivotMode;
		UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_MotionTex);
		uniform half4 TVE_VolumeCoord;
		uniform half _vertex_pivot_mode;
		SamplerState samplerTVE_MotionTex;
		UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_MotionTex_Vegetation);
		SamplerState samplerTVE_MotionTex_Vegetation;
		UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_MotionTex_Grass);
		SamplerState samplerTVE_MotionTex_Grass;
		UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_MotionTex_Objects);
		SamplerState samplerTVE_MotionTex_Objects;
		UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_MotionTex_User);
		SamplerState samplerTVE_MotionTex_User;
		uniform half TVE_WindPower;
		uniform half _Motion_10;
		UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_NoiseTex);
		uniform float2 TVE_NoiseSpeed_Vegetation;
		uniform float2 TVE_NoiseSpeed_Grass;
		uniform half TVE_NoiseSize_Vegetation;
		uniform half TVE_NoiseSize_Grass;
		SamplerState samplerTVE_NoiseTex;
		uniform half TVE_NoiseContrast;
		uniform half _Motion_Interaction;
		uniform half _Motion_32;
		uniform half TVE_WindMode;
		uniform half _VertexCat;
		uniform half _VertexMotionSpace;
		uniform half _VertexMotionMode;
		uniform half _VertexDataMode;
		uniform half _GlobalSizeFade;
		uniform half TVE_SizeFadeEnd;
		uniform half TVE_SizeFadeStart;
		UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_ExtrasTex);
		SamplerState samplerTVE_ExtrasTex;
		UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_ExtrasTex_Vegetation);
		SamplerState samplerTVE_ExtrasTex_Vegetation;
		UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_ExtrasTex_Grass);
		SamplerState samplerTVE_ExtrasTex_Grass;
		UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_ExtrasTex_Objects);
		SamplerState samplerTVE_ExtrasTex_Objects;
		UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_ExtrasTex_User);
		SamplerState samplerTVE_ExtrasTex_User;
		uniform half _GlobalSize;
		uniform half _LocalSize;
		uniform half _PerspectivePushValue;
		uniform half _PerspectiveCat;
		uniform half _PerspectiveNoiseValue;
		uniform half _PerspectiveAngleValue;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MainNormalTex);
		SamplerState sampler_MainNormalTex;
		uniform half4 _MainUVs;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MainAlbedoTex);
		SamplerState sampler_MainAlbedoTex;
		uniform half4 _GradientColorTwo;
		uniform half4 _GradientColorOne;
		uniform half _GradientMinValue;
		uniform half _GradientMaxValue;
		uniform half _GradientCat;
		uniform half4 _NoiseTintTwo;
		uniform half4 _NoiseTintOne;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_NoiseTex);
		SamplerState sampler_NoiseTex;
		uniform half _NoiseScaleValue;
		uniform half _MoiseCat;
		uniform half _NoiseMinValue;
		uniform half _NoiseMaxValue;
		uniform half4 _MainColor;
		uniform half4 _MotionHighlightColor;
		uniform half TVE_NoiseHighlight;
		uniform float4 _LocalColors;
		UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_ColorsTex);
		SamplerState samplerTVE_ColorsTex;
		UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_ColorsTex_Vegetation);
		SamplerState samplerTVE_ColorsTex_Vegetation;
		UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_ColorsTex_Grass);
		SamplerState samplerTVE_ColorsTex_Grass;
		UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_ColorsTex_Objects);
		SamplerState samplerTVE_ColorsTex_Objects;
		UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_ColorsTex_User);
		SamplerState samplerTVE_ColorsTex_User;
		uniform half _GlobalColors;
		uniform half _ColorsMaskValue;
		uniform half4 _SubsurfaceColor;
		uniform float4 TVE_MainLightParams;
		uniform half _SubsurfaceLightValue;
		uniform half _SubsurfaceValue;
		uniform half _GlobalHealthiness;
		uniform half _SubsurfaceCat;
		uniform half _SubsurfaceMaskValue;
		uniform half3 TVE_MainLightDirection;
		uniform half _SubsurfaceAngleValue;
		uniform half _SubsurfaceViewValue;
		uniform half4 TVE_OverlayColor;
		uniform half _OverlayContrastValue;
		uniform half TVE_OverlayIntensity;
		uniform half _GlobalOverlay;
		uniform half _OverlayVariationValue;
		uniform half _render_premul;
		uniform half4 _VertexOcclusionColor;
		uniform half _VertexOcclusionValue;
		uniform half _OcclusionCat;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MainMaskTex);
		SamplerState sampler_MainMaskTex;
		uniform half _MainSmoothnessValue;
		uniform half TVE_OverlaySmoothness;
		uniform float TVE_Wetness;
		uniform half _GlobalWetness;
		uniform half _MainOcclusionValue;
		uniform half _LeavesVariationValue;
		uniform half _GlobalLeaves;
		uniform half _LocalLeaves;


		half4 USE_BUFFERS( half4 Legacy, half4 Vegetation, half4 Grass, half4 Objects, half4 Custom )
		{
			#if defined (TVE_IS_VEGETATION_SHADER)
			return Vegetation;
			#elif defined (TVE_IS_GRASS_SHADER)
			return Grass;
			#elif defined (TVE_IS_OBJECT_SHADER)
			return Objects;
			#elif defined (TVE_IS_CUSTOM_SHADER)
			return Custom;
			#else
			return Legacy;
			#endif
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			half3 _Vector1 = half3(0,0,0);
			half3 Off19_g42468 = _Vector1;
			float3 appendResult2827_g42392 = (float3(v.texcoord.z , v.texcoord3.w , v.texcoord.w));
			half3 Mesh_PivotsData2831_g42392 = ( appendResult2827_g42392 * _VertexPivotMode );
			half3 On20_g42468 = Mesh_PivotsData2831_g42392;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g42468 = On20_g42468;
			#else
				float3 staticSwitch14_g42468 = Off19_g42468;
			#endif
			half3 ObjectData20_g42469 = staticSwitch14_g42468;
			half3 WorldData19_g42469 = Off19_g42468;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g42469 = WorldData19_g42469;
			#else
				float3 staticSwitch14_g42469 = ObjectData20_g42469;
			#endif
			#ifdef TVE_VERTEX_DATA_WORLD
				float3 staticSwitch14_g42430 = _Vector1;
			#else
				float3 staticSwitch14_g42430 = staticSwitch14_g42469;
			#endif
			half3 Mesh_PivotsOS2291_g42392 = staticSwitch14_g42430;
			float3 temp_output_2283_0_g42392 = ( ase_vertex3Pos - Mesh_PivotsOS2291_g42392 );
			half3 VertexPos40_g42409 = temp_output_2283_0_g42392;
			float3 appendResult74_g42409 = (float3(VertexPos40_g42409.x , 0.0 , 0.0));
			half3 VertexPosRotationAxis50_g42409 = appendResult74_g42409;
			float3 break84_g42409 = VertexPos40_g42409;
			float3 appendResult81_g42409 = (float3(0.0 , break84_g42409.y , break84_g42409.z));
			half3 VertexPosOtherAxis82_g42409 = appendResult81_g42409;
			float ObjectData20_g42486 = 3.14;
			float Bounds_Height374_g42392 = _MaxBoundsInfo.y;
			float WorldData19_g42486 = ( Bounds_Height374_g42392 * 3.14 );
			#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g42486 = WorldData19_g42486;
			#else
				float staticSwitch14_g42486 = ObjectData20_g42486;
			#endif
			float Motion_Max_Bending1133_g42392 = staticSwitch14_g42486;
			float4x4 break19_g42433 = unity_ObjectToWorld;
			float3 appendResult20_g42433 = (float3(break19_g42433[ 0 ][ 3 ] , break19_g42433[ 1 ][ 3 ] , break19_g42433[ 2 ][ 3 ]));
			half3 Off19_g42434 = appendResult20_g42433;
			float4 ase_vertex4Pos = v.vertex;
			float4 transform68_g42433 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 appendResult93_g42433 = (float3(v.texcoord.z , v.texcoord3.w , v.texcoord.w));
			float4 transform62_g42433 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult93_g42433 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g42433 = ( (transform68_g42433).xyz - (transform62_g42433).xyz );
			half3 On20_g42434 = ObjectPositionWithPivots28_g42433;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g42434 = On20_g42434;
			#else
				float3 staticSwitch14_g42434 = Off19_g42434;
			#endif
			half3 ObjectData20_g42435 = staticSwitch14_g42434;
			half3 WorldData19_g42435 = Off19_g42434;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g42435 = WorldData19_g42435;
			#else
				float3 staticSwitch14_g42435 = ObjectData20_g42435;
			#endif
			float3 temp_output_42_0_g42433 = staticSwitch14_g42435;
			half3 ObjectData20_g42438 = temp_output_42_0_g42433;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			half3 WorldData19_g42438 = ase_worldPos;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g42438 = WorldData19_g42438;
			#else
				float3 staticSwitch14_g42438 = ObjectData20_g42438;
			#endif
			float2 temp_output_39_38_g42431 = ( (TVE_VolumeCoord).zw + ( (TVE_VolumeCoord).xy * (staticSwitch14_g42438).xz ) );
			half4 Legacy33_g42439 = SAMPLE_TEXTURE2D_LOD( TVE_MotionTex, samplerTVE_MotionTex, temp_output_39_38_g42431, 0.0 );
			half4 Vegetation33_g42439 = SAMPLE_TEXTURE2D_LOD( TVE_MotionTex_Vegetation, samplerTVE_MotionTex_Vegetation, temp_output_39_38_g42431, 0.0 );
			half4 Grass33_g42439 = SAMPLE_TEXTURE2D_LOD( TVE_MotionTex_Grass, samplerTVE_MotionTex_Grass, temp_output_39_38_g42431, 0.0 );
			half4 Objects33_g42439 = SAMPLE_TEXTURE2D_LOD( TVE_MotionTex_Objects, samplerTVE_MotionTex_Objects, temp_output_39_38_g42431, 0.0 );
			half4 Custom33_g42439 = SAMPLE_TEXTURE2D_LOD( TVE_MotionTex_User, samplerTVE_MotionTex_User, temp_output_39_38_g42431, 0.0 );
			half4 localUSE_BUFFERS33_g42439 = USE_BUFFERS( Legacy33_g42439 , Vegetation33_g42439 , Grass33_g42439 , Objects33_g42439 , Custom33_g42439 );
			float4 break322_g42457 = localUSE_BUFFERS33_g42439;
			half Wind_Power369_g42457 = saturate( ( (break322_g42457.z*2.0 + -1.0) + TVE_WindPower ) );
			half Wind_Power_103106_g42392 = Wind_Power369_g42457;
			float3 appendResult323_g42457 = (float3(break322_g42457.x , 0.0 , break322_g42457.y));
			float3 temp_output_324_0_g42457 = (appendResult323_g42457*2.0 + -1.0);
			float3 ase_parentObjectScale = (1.0/float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ));
			float3 temp_output_339_0_g42457 = ( mul( unity_WorldToObject, float4( temp_output_324_0_g42457 , 0.0 ) ).xyz * ase_parentObjectScale );
			half2 Wind_DirectionOS39_g42392 = (temp_output_339_0_g42457).xz;
			half Motion_Use1056_g42392 = _Motion_10;
			#ifdef TVE_IS_GRASS_SHADER
				float2 staticSwitch160_g42477 = TVE_NoiseSpeed_Grass;
			#else
				float2 staticSwitch160_g42477 = TVE_NoiseSpeed_Vegetation;
			#endif
			float4x4 break19_g42479 = unity_ObjectToWorld;
			float3 appendResult20_g42479 = (float3(break19_g42479[ 0 ][ 3 ] , break19_g42479[ 1 ][ 3 ] , break19_g42479[ 2 ][ 3 ]));
			half3 Off19_g42480 = appendResult20_g42479;
			float4 transform68_g42479 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 appendResult95_g42479 = (float3(v.texcoord.z , 0.0 , v.texcoord.w));
			float4 transform62_g42479 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult95_g42479 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g42479 = ( (transform68_g42479).xyz - (transform62_g42479).xyz );
			half3 On20_g42480 = ObjectPositionWithPivots28_g42479;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g42480 = On20_g42480;
			#else
				float3 staticSwitch14_g42480 = Off19_g42480;
			#endif
			half3 ObjectData20_g42481 = staticSwitch14_g42480;
			half3 WorldData19_g42481 = Off19_g42480;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g42481 = WorldData19_g42481;
			#else
				float3 staticSwitch14_g42481 = ObjectData20_g42481;
			#endif
			float3 temp_output_42_0_g42479 = staticSwitch14_g42481;
			half3 ObjectData20_g42478 = temp_output_42_0_g42479;
			half3 WorldData19_g42478 = ase_worldPos;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g42478 = WorldData19_g42478;
			#else
				float3 staticSwitch14_g42478 = ObjectData20_g42478;
			#endif
			#ifdef TVE_IS_GRASS_SHADER
				float2 staticSwitch164_g42477 = (ase_worldPos).xz;
			#else
				float2 staticSwitch164_g42477 = (staticSwitch14_g42478).xz;
			#endif
			#ifdef TVE_IS_GRASS_SHADER
				float staticSwitch161_g42477 = TVE_NoiseSize_Grass;
			#else
				float staticSwitch161_g42477 = TVE_NoiseSize_Vegetation;
			#endif
			float2 panner73_g42477 = ( _Time.y * staticSwitch160_g42477 + ( staticSwitch164_g42477 * staticSwitch161_g42477 ));
			float4 tex2DNode75_g42477 = SAMPLE_TEXTURE2D_LOD( TVE_NoiseTex, samplerTVE_NoiseTex, panner73_g42477, 0.0 );
			float4 saferPower77_g42477 = max( abs( tex2DNode75_g42477 ) , 0.0001 );
			float4 temp_cast_9 = (TVE_NoiseContrast).xxxx;
			float4 break142_g42477 = pow( saferPower77_g42477 , temp_cast_9 );
			half Global_NoiseTex_R34_g42392 = break142_g42477.r;
			half Input_Speed62_g42408 = _MotionSpeed_10;
			float mulTime373_g42408 = _Time.y * Input_Speed62_g42408;
			float4x4 break19_g42425 = unity_ObjectToWorld;
			float3 appendResult20_g42425 = (float3(break19_g42425[ 0 ][ 3 ] , break19_g42425[ 1 ][ 3 ] , break19_g42425[ 2 ][ 3 ]));
			half3 Off19_g42426 = appendResult20_g42425;
			float4 transform68_g42425 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 appendResult95_g42425 = (float3(v.texcoord.z , 0.0 , v.texcoord.w));
			float4 transform62_g42425 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult95_g42425 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g42425 = ( (transform68_g42425).xyz - (transform62_g42425).xyz );
			half3 On20_g42426 = ObjectPositionWithPivots28_g42425;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g42426 = On20_g42426;
			#else
				float3 staticSwitch14_g42426 = Off19_g42426;
			#endif
			half3 ObjectData20_g42427 = staticSwitch14_g42426;
			half3 WorldData19_g42427 = Off19_g42426;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g42427 = WorldData19_g42427;
			#else
				float3 staticSwitch14_g42427 = ObjectData20_g42427;
			#endif
			float3 temp_output_42_0_g42425 = staticSwitch14_g42427;
			float3 break9_g42425 = temp_output_42_0_g42425;
			half Variation_Complex102_g42422 = frac( ( v.color.r + ( break9_g42425.x + break9_g42425.z ) ) );
			float ObjectData20_g42424 = Variation_Complex102_g42422;
			half Variation_Simple105_g42422 = v.color.r;
			float WorldData19_g42424 = Variation_Simple105_g42422;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g42424 = WorldData19_g42424;
			#else
				float staticSwitch14_g42424 = ObjectData20_g42424;
			#endif
			half Variation3073_g42392 = staticSwitch14_g42424;
			half Motion_Variation284_g42408 = ( _MotionVariation_10 * Variation3073_g42392 );
			float2 appendResult344_g42408 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 Motion_Scale287_g42408 = ( _MotionScale_10 * appendResult344_g42408 );
			half2 Sine_MinusOneToOne281_g42408 = sin( ( mulTime373_g42408 + Motion_Variation284_g42408 + Motion_Scale287_g42408 ) );
			float2 temp_cast_11 = (1.0).xx;
			half Input_Turbulence327_g42408 = Global_NoiseTex_R34_g42392;
			float2 lerpResult321_g42408 = lerp( Sine_MinusOneToOne281_g42408 , temp_cast_11 , Input_Turbulence327_g42408);
			half2 Motion_Bending2258_g42392 = ( ( _MotionAmplitude_10 * Motion_Max_Bending1133_g42392 ) * Wind_Power_103106_g42392 * Wind_DirectionOS39_g42392 * Motion_Use1056_g42392 * Global_NoiseTex_R34_g42392 * lerpResult321_g42408 );
			half Motion_UseInteraction2097_g42392 = _Motion_Interaction;
			half Motion_InteractionMask66_g42392 = break322_g42457.w;
			float lerpResult3307_g42392 = lerp( 1.0 , Variation3073_g42392 , _InteractionVariation);
			half2 Motion_Interaction53_g42392 = ( _InteractionAmplitude * Motion_Max_Bending1133_g42392 * Motion_UseInteraction2097_g42392 * Motion_InteractionMask66_g42392 * Motion_InteractionMask66_g42392 * Wind_DirectionOS39_g42392 * lerpResult3307_g42392 );
			float2 lerpResult109_g42392 = lerp( Motion_Bending2258_g42392 , Motion_Interaction53_g42392 , Motion_InteractionMask66_g42392);
			half Mesh_Motion_182_g42392 = v.texcoord3.x;
			float2 break143_g42392 = ( lerpResult109_g42392 * Mesh_Motion_182_g42392 );
			half Motion_Z190_g42392 = break143_g42392.y;
			half Angle44_g42409 = Motion_Z190_g42392;
			half3 VertexPos40_g42394 = ( VertexPosRotationAxis50_g42409 + ( VertexPosOtherAxis82_g42409 * cos( Angle44_g42409 ) ) + ( cross( float3(1,0,0) , VertexPosOtherAxis82_g42409 ) * sin( Angle44_g42409 ) ) );
			float3 appendResult74_g42394 = (float3(0.0 , 0.0 , VertexPos40_g42394.z));
			half3 VertexPosRotationAxis50_g42394 = appendResult74_g42394;
			float3 break84_g42394 = VertexPos40_g42394;
			float3 appendResult81_g42394 = (float3(break84_g42394.x , break84_g42394.y , 0.0));
			half3 VertexPosOtherAxis82_g42394 = appendResult81_g42394;
			half Motion_X216_g42392 = break143_g42392.x;
			half Angle44_g42394 = -Motion_X216_g42392;
			half Motion_Scale321_g42399 = ( _MotionScale_32 * 10.0 );
			half Input_Speed62_g42399 = _MotionSpeed_32;
			float mulTime349_g42399 = _Time.y * Input_Speed62_g42399;
			float Motion_Variation330_g42399 = ( _MotionVariation_32 * v.color.r );
			float Bounds_Radius121_g42392 = _MaxBoundsInfo.x;
			half Input_Amplitude58_g42399 = ( _MotionAmplitude_32 * Bounds_Radius121_g42392 * 0.1 );
			float3 appendResult345_g42399 = (float3(v.color.r , ( 1.0 - v.color.r ) , v.color.r));
			half Global_NoiseTex_B132_g42392 = break142_g42477.b;
			half Mesh_Motion_3144_g42392 = v.texcoord3.z;
			half Motion_Use322013_g42392 = _Motion_32;
			float lerpResult376_g42457 = lerp( 0.1 , 1.0 , Wind_Power369_g42457);
			half Wind_Power_323115_g42392 = lerpResult376_g42457;
			half3 Motion_Flutter263_g42392 = ( ( sin( ( ( ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z ) * Motion_Scale321_g42399 ) + mulTime349_g42399 + Motion_Variation330_g42399 ) ) * Input_Amplitude58_g42399 * appendResult345_g42399 ) * ( ( Global_NoiseTex_R34_g42392 + Global_NoiseTex_B132_g42392 ) * Mesh_Motion_3144_g42392 * Motion_Use322013_g42392 * Wind_Power_323115_g42392 ) );
			half Wind_Mode3167_g42392 = TVE_WindMode;
			float3 lerpResult3168_g42392 = lerp( ase_vertex3Pos , ( ( VertexPosRotationAxis50_g42394 + ( VertexPosOtherAxis82_g42394 * cos( Angle44_g42394 ) ) + ( cross( float3(0,0,1) , VertexPosOtherAxis82_g42394 ) * sin( Angle44_g42394 ) ) ) + Motion_Flutter263_g42392 ) , Wind_Mode3167_g42392);
			float3 Vertex_Motion_Object833_g42392 = lerpResult3168_g42392;
			float3 appendResult2043_g42392 = (float3(Motion_X216_g42392 , 0.0 , Motion_Z190_g42392));
			float3 lerpResult3173_g42392 = lerp( ase_vertex3Pos , ( ( ase_vertex3Pos + appendResult2043_g42392 ) + Motion_Flutter263_g42392 ) , Wind_Mode3167_g42392);
			float3 Vertex_Motion_World1118_g42392 = lerpResult3173_g42392;
			float3 temp_output_3331_0_g42392 = ( ( _VertexCat * _VertexMotionSpace * _VertexMotionMode * _VertexDataMode ) + Vertex_Motion_World1118_g42392 );
			#if defined(TVE_VERTEX_DATA_OBJECT)
				float3 staticSwitch3312_g42392 = Vertex_Motion_Object833_g42392;
			#elif defined(TVE_VERTEX_DATA_WORLD)
				float3 staticSwitch3312_g42392 = temp_output_3331_0_g42392;
			#elif defined(TVE_VERTEX_DATA_BATCHED)
				float3 staticSwitch3312_g42392 = temp_output_3331_0_g42392;
			#else
				float3 staticSwitch3312_g42392 = Vertex_Motion_Object833_g42392;
			#endif
			half3 ObjectData20_g42456 = staticSwitch3312_g42392;
			half3 WorldData19_g42456 = Vertex_Motion_World1118_g42392;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g42456 = WorldData19_g42456;
			#else
				float3 staticSwitch14_g42456 = ObjectData20_g42456;
			#endif
			float4x4 break19_g42472 = unity_ObjectToWorld;
			float3 appendResult20_g42472 = (float3(break19_g42472[ 0 ][ 3 ] , break19_g42472[ 1 ][ 3 ] , break19_g42472[ 2 ][ 3 ]));
			half3 Off19_g42473 = appendResult20_g42472;
			float4 transform68_g42472 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 appendResult93_g42472 = (float3(v.texcoord.z , v.texcoord3.w , v.texcoord.w));
			float4 transform62_g42472 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult93_g42472 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g42472 = ( (transform68_g42472).xyz - (transform62_g42472).xyz );
			half3 On20_g42473 = ObjectPositionWithPivots28_g42472;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g42473 = On20_g42473;
			#else
				float3 staticSwitch14_g42473 = Off19_g42473;
			#endif
			half3 ObjectData20_g42474 = staticSwitch14_g42473;
			half3 WorldData19_g42474 = Off19_g42473;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g42474 = WorldData19_g42474;
			#else
				float3 staticSwitch14_g42474 = ObjectData20_g42474;
			#endif
			float3 temp_output_42_0_g42472 = staticSwitch14_g42474;
			float temp_output_7_0_g42396 = TVE_SizeFadeEnd;
			float ObjectData20_g42471 = saturate( ( ( ( distance( _WorldSpaceCameraPos , temp_output_42_0_g42472 ) * _GlobalSizeFade ) - temp_output_7_0_g42396 ) / ( TVE_SizeFadeStart - temp_output_7_0_g42396 ) ) );
			float WorldData19_g42471 = 1.0;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g42471 = WorldData19_g42471;
			#else
				float staticSwitch14_g42471 = ObjectData20_g42471;
			#endif
			float Vertex_SizeFade1740_g42392 = staticSwitch14_g42471;
			float4x4 break19_g42462 = unity_ObjectToWorld;
			float3 appendResult20_g42462 = (float3(break19_g42462[ 0 ][ 3 ] , break19_g42462[ 1 ][ 3 ] , break19_g42462[ 2 ][ 3 ]));
			half3 Off19_g42463 = appendResult20_g42462;
			float4 transform68_g42462 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 appendResult95_g42462 = (float3(v.texcoord.z , 0.0 , v.texcoord.w));
			float4 transform62_g42462 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult95_g42462 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g42462 = ( (transform68_g42462).xyz - (transform62_g42462).xyz );
			half3 On20_g42463 = ObjectPositionWithPivots28_g42462;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g42463 = On20_g42463;
			#else
				float3 staticSwitch14_g42463 = Off19_g42463;
			#endif
			half3 ObjectData20_g42464 = staticSwitch14_g42463;
			half3 WorldData19_g42464 = Off19_g42463;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g42464 = WorldData19_g42464;
			#else
				float3 staticSwitch14_g42464 = ObjectData20_g42464;
			#endif
			float3 temp_output_42_0_g42462 = staticSwitch14_g42464;
			half3 ObjectData20_g42461 = temp_output_42_0_g42462;
			half3 WorldData19_g42461 = ase_worldPos;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g42461 = WorldData19_g42461;
			#else
				float3 staticSwitch14_g42461 = ObjectData20_g42461;
			#endif
			float2 temp_output_43_38_g42459 = ( (TVE_VolumeCoord).zw + ( (TVE_VolumeCoord).xy * (staticSwitch14_g42461).xz ) );
			half4 Legacy33_g42460 = SAMPLE_TEXTURE2D_LOD( TVE_ExtrasTex, samplerTVE_ExtrasTex, temp_output_43_38_g42459, 0.0 );
			half4 Vegetation33_g42460 = SAMPLE_TEXTURE2D_LOD( TVE_ExtrasTex_Vegetation, samplerTVE_ExtrasTex_Vegetation, temp_output_43_38_g42459, 0.0 );
			half4 Grass33_g42460 = SAMPLE_TEXTURE2D_LOD( TVE_ExtrasTex_Grass, samplerTVE_ExtrasTex_Grass, temp_output_43_38_g42459, 0.0 );
			half4 Objects33_g42460 = SAMPLE_TEXTURE2D_LOD( TVE_ExtrasTex_Objects, samplerTVE_ExtrasTex_Objects, temp_output_43_38_g42459, 0.0 );
			half4 Custom33_g42460 = SAMPLE_TEXTURE2D_LOD( TVE_ExtrasTex_User, samplerTVE_ExtrasTex_User, temp_output_43_38_g42459, 0.0 );
			half4 localUSE_BUFFERS33_g42460 = USE_BUFFERS( Legacy33_g42460 , Vegetation33_g42460 , Grass33_g42460 , Objects33_g42460 , Custom33_g42460 );
			float4 break49_g42459 = localUSE_BUFFERS33_g42460;
			half Global_ExtrasTex_G305_g42392 = break49_g42459.y;
			float lerpResult346_g42392 = lerp( 1.0 , Global_ExtrasTex_G305_g42392 , _GlobalSize);
			float ObjectData20_g42470 = ( lerpResult346_g42392 * _LocalSize );
			float WorldData19_g42470 = 1.0;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g42470 = WorldData19_g42470;
			#else
				float staticSwitch14_g42470 = ObjectData20_g42470;
			#endif
			half Vertex_Size1741_g42392 = staticSwitch14_g42470;
			float3 normalizeResult2696_g42392 = normalize( ( _WorldSpaceCameraPos - ase_worldPos ) );
			float3 break2709_g42392 = cross( normalizeResult2696_g42392 , half3(0,1,0) );
			float3 appendResult2710_g42392 = (float3(-break2709_g42392.z , 0.0 , break2709_g42392.x));
			float3 appendResult2667_g42392 = (float3(v.color.r , 0.5 , v.color.r));
			float3 normalizeResult2210_g42392 = normalize( ( _WorldSpaceCameraPos - ase_worldPos ) );
			float dotResult2212_g42392 = dot( normalizeResult2210_g42392 , float3(0,1,0) );
			half Mask_HView2656_g42392 = abs( dotResult2212_g42392 );
			float saferPower2652_g42392 = max( Mask_HView2656_g42392 , 0.0001 );
			half3 Grass_Coverage2661_g42392 = ( ( ( mul( unity_WorldToObject, float4( appendResult2710_g42392 , 0.0 ) ).xyz * ( _PerspectivePushValue + _PerspectiveCat ) ) + ( (appendResult2667_g42392*2.0 + -1.0) * _PerspectiveNoiseValue ) ) * v.color.a * pow( saferPower2652_g42392 , _PerspectiveAngleValue ) );
			float3 Final_VertexPosition890_g42392 = ( ( staticSwitch14_g42456 * Vertex_SizeFade1740_g42392 * Vertex_Size1741_g42392 ) + Mesh_PivotsOS2291_g42392 + Grass_Coverage2661_g42392 );
			v.vertex.xyz = Final_VertexPosition890_g42392;
			v.vertex.w = 1;
			half2 Noise_UVs3274_g42392 = ( (ase_worldPos).xz * ( ( _NoiseScaleValue * 0.1 ) + _MoiseCat ) );
			float temp_output_7_0_g42418 = _NoiseMinValue;
			half Noise_Mask3162_g42392 = saturate( ( ( SAMPLE_TEXTURE2D_LOD( _NoiseTex, sampler_NoiseTex, Noise_UVs3274_g42392, 0.0 ).r - temp_output_7_0_g42418 ) / ( _NoiseMaxValue - temp_output_7_0_g42418 ) ) );
			float4 lerpResult2800_g42392 = lerp( _NoiseTintTwo , _NoiseTintOne , Noise_Mask3162_g42392);
			half3 Noise_Tint2802_g42392 = (lerpResult2800_g42392).rgb;
			o.vertexToFrag3225_g42392 = Noise_Tint2802_g42392;
			half Global_NoiseTex_H2869_g42392 = pow( abs( tex2DNode75_g42477.r ) , TVE_NoiseHighlight );
			half3 Highlight_Tint3231_g42392 = ( ( (_MotionHighlightColor).rgb * Global_NoiseTex_H2869_g42392 * Wind_Power_103106_g42392 * Wind_Mode3167_g42392 * v.color.r ) + float3( 1,1,1 ) );
			o.vertexToFrag3252_g42392 = Highlight_Tint3231_g42392;
		}

		inline half4 LightingStandardCustom(SurfaceOutputStandardCustom s, half3 viewDir, UnityGI gi )
		{
			half3 transmission = max(0 , -dot(s.Normal, gi.light.dir)) * gi.light.color * s.Transmission;
			half4 d = half4(s.Albedo * transmission , 0);

			SurfaceOutputStandard r;
			r.Albedo = s.Albedo;
			r.Normal = s.Normal;
			r.Emission = s.Emission;
			r.Metallic = s.Metallic;
			r.Smoothness = s.Smoothness;
			r.Occlusion = s.Occlusion;
			r.Alpha = s.Alpha;
			return LightingStandard (r, viewDir, gi) + d;
		}

		inline void LightingStandardCustom_GI(SurfaceOutputStandardCustom s, UnityGIInput data, inout UnityGI gi )
		{
			#if defined(UNITY_PASS_DEFERRED) && UNITY_ENABLE_REFLECTION_BUFFERS
				gi = UnityGlobalIllumination(data, s.Occlusion, s.Normal);
			#else
				UNITY_GLOSSY_ENV_FROM_SURFACE( g, s, data );
				gi = UnityGlobalIllumination( data, s.Occlusion, s.Normal, g );
			#endif
		}

		void surf( Input i , inout SurfaceOutputStandardCustom o )
		{
			half2 Main_UVs15_g42392 = ( ( i.uv_texcoord * (_MainUVs).xy ) + (_MainUVs).zw );
			float4 tex2DNode117_g42392 = SAMPLE_TEXTURE2D( _MainNormalTex, sampler_MainAlbedoTex, Main_UVs15_g42392 );
			float2 appendResult88_g42398 = (float2(tex2DNode117_g42392.a , tex2DNode117_g42392.g));
			float2 temp_output_90_0_g42398 = ( (appendResult88_g42398*2.0 + -1.0) * _MainNormalValue );
			float3 appendResult91_g42398 = (float3(temp_output_90_0_g42398 , 1.0));
			half3 Main_Normal137_g42392 = appendResult91_g42398;
			float3 temp_output_13_0_g42416 = Main_Normal137_g42392;
			float3 switchResult12_g42416 = (((i.ASEVFace>0)?(temp_output_13_0_g42416):(( temp_output_13_0_g42416 * _render_normals_options ))));
			half3 Blend_Normal312_g42392 = switchResult12_g42416;
			half3 Final_Normal366_g42392 = Blend_Normal312_g42392;
			o.Normal = Final_Normal366_g42392;
			float temp_output_7_0_g42414 = _GradientMinValue;
			float4 lerpResult2779_g42392 = lerp( _GradientColorTwo , _GradientColorOne , saturate( ( ( i.vertexColor.a - temp_output_7_0_g42414 ) / ( ( _GradientMaxValue + _GradientCat ) - temp_output_7_0_g42414 ) ) ));
			half3 Gradient_Tint2784_g42392 = (lerpResult2779_g42392).rgb;
			float4 tex2DNode29_g42392 = SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, Main_UVs15_g42392 );
			float4 temp_output_51_0_g42392 = ( _MainColor * tex2DNode29_g42392 );
			half3 Main_AlbedoRaw99_g42392 = (temp_output_51_0_g42392).rgb;
			half3 Main_AlbedoTinted2808_g42392 = ( Gradient_Tint2784_g42392 * i.vertexToFrag3225_g42392 * Main_AlbedoRaw99_g42392 * i.vertexToFrag3252_g42392 );
			float4x4 break19_g42441 = unity_ObjectToWorld;
			float3 appendResult20_g42441 = (float3(break19_g42441[ 0 ][ 3 ] , break19_g42441[ 1 ][ 3 ] , break19_g42441[ 2 ][ 3 ]));
			half3 Off19_g42442 = appendResult20_g42441;
			float4 ase_vertex4Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float4 transform68_g42441 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float3 appendResult95_g42441 = (float3(i.uv_tex4coord.z , 0.0 , i.uv_tex4coord.w));
			float4 transform62_g42441 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult95_g42441 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g42441 = ( (transform68_g42441).xyz - (transform62_g42441).xyz );
			half3 On20_g42442 = ObjectPositionWithPivots28_g42441;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g42442 = On20_g42442;
			#else
				float3 staticSwitch14_g42442 = Off19_g42442;
			#endif
			half3 ObjectData20_g42443 = staticSwitch14_g42442;
			half3 WorldData19_g42443 = Off19_g42442;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g42443 = WorldData19_g42443;
			#else
				float3 staticSwitch14_g42443 = ObjectData20_g42443;
			#endif
			float3 temp_output_42_0_g42441 = staticSwitch14_g42443;
			half3 ObjectData20_g42447 = temp_output_42_0_g42441;
			float3 ase_worldPos = i.worldPos;
			half3 WorldData19_g42447 = ase_worldPos;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g42447 = WorldData19_g42447;
			#else
				float3 staticSwitch14_g42447 = ObjectData20_g42447;
			#endif
			float2 temp_output_35_38_g42440 = ( (TVE_VolumeCoord).zw + ( (TVE_VolumeCoord).xy * (staticSwitch14_g42447).xz ) );
			half4 Legacy33_g42446 = SAMPLE_TEXTURE2D( TVE_ColorsTex, samplerTVE_ColorsTex, temp_output_35_38_g42440 );
			half4 Vegetation33_g42446 = SAMPLE_TEXTURE2D( TVE_ColorsTex_Vegetation, samplerTVE_ColorsTex_Vegetation, temp_output_35_38_g42440 );
			half4 Grass33_g42446 = SAMPLE_TEXTURE2D( TVE_ColorsTex_Grass, samplerTVE_ColorsTex_Grass, temp_output_35_38_g42440 );
			half4 Objects33_g42446 = SAMPLE_TEXTURE2D( TVE_ColorsTex_Objects, samplerTVE_ColorsTex_Objects, temp_output_35_38_g42440 );
			half4 Custom33_g42446 = SAMPLE_TEXTURE2D( TVE_ColorsTex_User, samplerTVE_ColorsTex_User, temp_output_35_38_g42440 );
			half4 localUSE_BUFFERS33_g42446 = USE_BUFFERS( Legacy33_g42446 , Vegetation33_g42446 , Grass33_g42446 , Objects33_g42446 , Custom33_g42446 );
			float4 temp_output_45_0_g42440 = localUSE_BUFFERS33_g42446;
			half3 Global_ColorsTex_RGB1700_g42392 = (temp_output_45_0_g42440).xyz;
			#ifdef UNITY_COLORSPACE_GAMMA
				float staticSwitch1_g42411 = 2.0;
			#else
				float staticSwitch1_g42411 = 4.594794;
			#endif
			float lerpResult2103_g42392 = lerp( 1.0 , ( 1.0 - i.vertexColor.a ) , _ColorsMaskValue);
			float3 lerpResult108_g42392 = lerp( float3( 1,1,1 ) , ( (_LocalColors).rgb * ( Global_ColorsTex_RGB1700_g42392 * staticSwitch1_g42411 ) ) , ( _GlobalColors * lerpResult2103_g42392 ));
			half3 Global_Colors1954_g42392 = lerpResult108_g42392;
			float3 temp_output_123_0_g42392 = ( Main_AlbedoTinted2808_g42392 * Global_Colors1954_g42392 );
			half3 Main_AlbedoColored863_g42392 = temp_output_123_0_g42392;
			half3 Blend_Albedo265_g42392 = Main_AlbedoColored863_g42392;
			float3 lerpResult2929_g42392 = lerp( float3( 1,1,1 ) , (TVE_MainLightParams).rgb , _SubsurfaceLightValue);
			half3 Subsurface_Color1722_g42392 = ( (_SubsurfaceColor).rgb * lerpResult2929_g42392 );
			half Global_ColorsTex_A1701_g42392 = (temp_output_45_0_g42440).w;
			float lerpResult1720_g42392 = lerp( 1.0 , Global_ColorsTex_A1701_g42392 , _GlobalHealthiness);
			half Subsurface_Intensity1752_g42392 = ( ( _SubsurfaceValue * lerpResult1720_g42392 ) + _SubsurfaceCat );
			float lerpResult3219_g42392 = lerp( 1.0 , i.vertexColor.a , _SubsurfaceMaskValue);
			half Subsurface_Mask1557_g42392 = lerpResult3219_g42392;
			half3 Subsurface_Transmission884_g42392 = ( Subsurface_Color1722_g42392 * Subsurface_Intensity1752_g42392 * Subsurface_Mask1557_g42392 );
			float3 normalizeResult1983_g42392 = normalize( ( _WorldSpaceCameraPos - ase_worldPos ) );
			float dotResult785_g42392 = dot( -TVE_MainLightDirection , normalizeResult1983_g42392 );
			float saferPower1624_g42392 = max( (dotResult785_g42392*0.5 + 0.5) , 0.0001 );
			#ifdef UNITY_PASS_FORWARDADD
				float staticSwitch1602_g42392 = 0.0;
			#else
				float staticSwitch1602_g42392 = ( pow( saferPower1624_g42392 , _SubsurfaceAngleValue ) * _SubsurfaceViewValue );
			#endif
			half Mask_Subsurface_View782_g42392 = staticSwitch1602_g42392;
			half3 Subsurface_Forward1691_g42392 = ( Subsurface_Transmission884_g42392 * Mask_Subsurface_View782_g42392 );
			half3 Blend_AlbedoAndSubsurface149_g42392 = ( Blend_Albedo265_g42392 + Subsurface_Forward1691_g42392 );
			half3 Global_OverlayColor1758_g42392 = (TVE_OverlayColor).rgb;
			float2 break93_g42398 = temp_output_90_0_g42398;
			half Main_NormalY2095_g42392 = break93_g42398.y;
			half Overlay_Contrast1405_g42392 = _OverlayContrastValue;
			half Global_OverlayIntensity154_g42392 = TVE_OverlayIntensity;
			float4x4 break19_g42462 = unity_ObjectToWorld;
			float3 appendResult20_g42462 = (float3(break19_g42462[ 0 ][ 3 ] , break19_g42462[ 1 ][ 3 ] , break19_g42462[ 2 ][ 3 ]));
			half3 Off19_g42463 = appendResult20_g42462;
			float4 transform68_g42462 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 appendResult95_g42462 = (float3(i.uv_tex4coord.z , 0.0 , i.uv_tex4coord.w));
			float4 transform62_g42462 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult95_g42462 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g42462 = ( (transform68_g42462).xyz - (transform62_g42462).xyz );
			half3 On20_g42463 = ObjectPositionWithPivots28_g42462;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g42463 = On20_g42463;
			#else
				float3 staticSwitch14_g42463 = Off19_g42463;
			#endif
			half3 ObjectData20_g42464 = staticSwitch14_g42463;
			half3 WorldData19_g42464 = Off19_g42463;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g42464 = WorldData19_g42464;
			#else
				float3 staticSwitch14_g42464 = ObjectData20_g42464;
			#endif
			float3 temp_output_42_0_g42462 = staticSwitch14_g42464;
			half3 ObjectData20_g42461 = temp_output_42_0_g42462;
			half3 WorldData19_g42461 = ase_worldPos;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g42461 = WorldData19_g42461;
			#else
				float3 staticSwitch14_g42461 = ObjectData20_g42461;
			#endif
			float2 temp_output_43_38_g42459 = ( (TVE_VolumeCoord).zw + ( (TVE_VolumeCoord).xy * (staticSwitch14_g42461).xz ) );
			half4 Legacy33_g42460 = SAMPLE_TEXTURE2D( TVE_ExtrasTex, samplerTVE_ExtrasTex, temp_output_43_38_g42459 );
			half4 Vegetation33_g42460 = SAMPLE_TEXTURE2D( TVE_ExtrasTex_Vegetation, samplerTVE_ExtrasTex_Vegetation, temp_output_43_38_g42459 );
			half4 Grass33_g42460 = SAMPLE_TEXTURE2D( TVE_ExtrasTex_Grass, samplerTVE_ExtrasTex_Grass, temp_output_43_38_g42459 );
			half4 Objects33_g42460 = SAMPLE_TEXTURE2D( TVE_ExtrasTex_Objects, samplerTVE_ExtrasTex_Objects, temp_output_43_38_g42459 );
			half4 Custom33_g42460 = SAMPLE_TEXTURE2D( TVE_ExtrasTex_User, samplerTVE_ExtrasTex_User, temp_output_43_38_g42459 );
			half4 localUSE_BUFFERS33_g42460 = USE_BUFFERS( Legacy33_g42460 , Vegetation33_g42460 , Grass33_g42460 , Objects33_g42460 , Custom33_g42460 );
			float4 break49_g42459 = localUSE_BUFFERS33_g42460;
			half Global_ExtrasTex_B156_g42392 = break49_g42459.z;
			float temp_output_1025_0_g42392 = ( Global_OverlayIntensity154_g42392 * _GlobalOverlay * Global_ExtrasTex_B156_g42392 );
			float lerpResult1065_g42392 = lerp( 1.0 , i.vertexColor.r , _OverlayVariationValue);
			half Overlay_Commons1365_g42392 = ( temp_output_1025_0_g42392 * lerpResult1065_g42392 );
			half Overlay_Mask269_g42392 = saturate( ( saturate( ( i.vertexColor.a + ( Main_NormalY2095_g42392 * Overlay_Contrast1405_g42392 ) ) ) - ( 1.0 - Overlay_Commons1365_g42392 ) ) );
			float3 lerpResult336_g42392 = lerp( Blend_AlbedoAndSubsurface149_g42392 , Global_OverlayColor1758_g42392 , Overlay_Mask269_g42392);
			half3 Final_Albedo359_g42392 = lerpResult336_g42392;
			half Main_Alpha316_g42392 = (temp_output_51_0_g42392).a;
			float lerpResult354_g42392 = lerp( 1.0 , Main_Alpha316_g42392 , _render_premul);
			half Final_Premultiply355_g42392 = lerpResult354_g42392;
			float3 temp_output_410_0_g42392 = ( Final_Albedo359_g42392 * Final_Premultiply355_g42392 );
			float3 temp_cast_12 = (1.0).xxx;
			half Mesh_Occlusion318_g42392 = i.vertexColor.g;
			float saferPower1201_g42392 = max( Mesh_Occlusion318_g42392 , 0.0001 );
			float3 lerpResult2945_g42392 = lerp( (_VertexOcclusionColor).rgb , temp_cast_12 , saturate( pow( saferPower1201_g42392 , ( _VertexOcclusionValue + _OcclusionCat ) ) ));
			half3 Vertex_Occlusion648_g42392 = lerpResult2945_g42392;
			o.Albedo = ( temp_output_410_0_g42392 * Vertex_Occlusion648_g42392 );
			float4 tex2DNode35_g42392 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainAlbedoTex, Main_UVs15_g42392 );
			half Main_Smoothness227_g42392 = ( tex2DNode35_g42392.a * _MainSmoothnessValue );
			half Blend_Smoothness314_g42392 = Main_Smoothness227_g42392;
			half Global_OverlaySmoothness311_g42392 = TVE_OverlaySmoothness;
			float lerpResult343_g42392 = lerp( Blend_Smoothness314_g42392 , Global_OverlaySmoothness311_g42392 , Overlay_Mask269_g42392);
			half Final_Smoothness371_g42392 = lerpResult343_g42392;
			half Global_Wetness1016_g42392 = ( TVE_Wetness * _GlobalWetness );
			half Global_ExtrasTex_A1033_g42392 = break49_g42459.w;
			float lerpResult1037_g42392 = lerp( Final_Smoothness371_g42392 , saturate( ( Final_Smoothness371_g42392 + Global_Wetness1016_g42392 ) ) , Global_ExtrasTex_A1033_g42392);
			o.Smoothness = lerpResult1037_g42392;
			float lerpResult240_g42392 = lerp( 1.0 , tex2DNode35_g42392.g , _MainOcclusionValue);
			half Main_Occlusion247_g42392 = lerpResult240_g42392;
			half Blend_Occlusion323_g42392 = Main_Occlusion247_g42392;
			o.Occlusion = Blend_Occlusion323_g42392;
			o.Transmission = Subsurface_Transmission884_g42392;
			o.Alpha = Main_Alpha316_g42392;
			half Main_AlphaRaw1203_g42392 = tex2DNode29_g42392.a;
			float Mesh_Variation16_g42392 = i.vertexColor.r;
			float lerpResult2262_g42392 = lerp( 0.9 , Mesh_Variation16_g42392 , _LeavesVariationValue);
			half Global_ExtrasTex_R174_g42392 = break49_g42459.x;
			float lerpResult2624_g42392 = lerp( 1.0 , Global_ExtrasTex_R174_g42392 , _GlobalLeaves);
			half AlphaTreshold2132_g42392 = _Cutoff;
			half Mask_Leaves315_g42392 = ( ( (lerpResult2262_g42392*0.5 + 0.5) - ( 1.0 - ( lerpResult2624_g42392 * _LocalLeaves ) ) ) + AlphaTreshold2132_g42392 );
			half Alpha5_g42421 = ( Main_AlphaRaw1203_g42392 * Mask_Leaves315_g42392 );
			#ifdef _ALPHATEST_ON
				float staticSwitch2_g42421 = Alpha5_g42421;
			#else
				float staticSwitch2_g42421 = 1.0;
			#endif
			half Final_Clip914_g42392 = staticSwitch2_g42421;
			clip( Final_Clip914_g42392 - _render_cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "TVEShaderCoreGUI"
}
/*ASEBEGIN
Version=18600
1927;1;1906;1020;2730.327;890.7327;1;True;False
Node;AmplifyShaderEditor.FunctionNode;713;-2176,256;Inherit;False;Use TVE_IS_GRASS_SHADER;-1;;42391;921559c53826c0142ba6e27dd03eaef2;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;271;-1552,-896;Half;False;Property;_IsLitShader;_IsLitShader;207;1;[HideInInspector];Create;True;0;0;True;0;False;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;81;-1792,-896;Half;False;Property;_IsStandardShader;_IsStandardShader;205;1;[HideInInspector];Create;True;0;0;True;0;False;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;982;-2176,-384;Inherit;False;Base Shader;1;;42392;856f7164d1c579d43a5cf4968a75ca43;50,1300,1,1298,1,1271,1,1962,1,1708,1,1712,1,1964,1,1969,1,1719,1,893,1,1745,1,1742,1,1718,1,1714,1,1715,1,1717,1,916,0,1949,1,1763,0,1762,0,1776,1,1646,1,1690,0,1757,0,3221,2,1981,0,2807,1,2953,1,3243,1,2172,0,2658,1,1734,0,1733,0,1735,0,1736,0,1966,0,1968,0,1737,0,878,0,1550,0,860,1,2750,1,2261,1,2260,1,2054,0,2032,0,2060,0,2036,0,2062,1,2039,1;0;15;FLOAT3;0;FLOAT3;528;FLOAT3;2489;FLOAT;529;FLOAT;530;FLOAT;531;FLOAT;1235;FLOAT3;1230;FLOAT;1461;FLOAT;1290;FLOAT;721;FLOAT;532;FLOAT;653;FLOAT;629;FLOAT3;534
Node;AmplifyShaderEditor.RangedFloatNode;168;-1984,-896;Half;False;Property;_IsGrassShader;_IsGrassShader;204;1;[HideInInspector];Create;True;0;0;True;0;False;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;530;-1376,-896;Half;False;Property;_IsForwardPathShader;_IsForwardPathShader;206;1;[HideInInspector];Create;True;0;0;True;0;False;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-2176,-896;Half;False;Property;_Banner;Banner;0;0;Create;True;0;0;True;1;StyledBanner(Grass Subsurface Lit);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1536,-768;Half;False;Property;_render_dst;_render_dst;211;1;[HideInInspector];Create;True;2;Opaque;0;Transparent;1;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;735;-2176,320;Inherit;False;Use TVE_PIVOT_DATA_BAKED;-1;;42390;8da5867b3f9f1834693af40d3eff73f4;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-2176,-768;Half;False;Property;_render_cutoff;_render_cutoff;208;1;[HideInInspector];Create;True;4;Alpha;0;Premultiply;1;Additive;2;Multiply;3;0;True;0;False;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1342.73,-768;Half;False;Property;_render_zw;_render_zw;212;1;[HideInInspector];Create;True;2;Opaque;0;Transparent;1;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1728,-768;Half;False;Property;_render_src;_render_src;209;1;[HideInInspector];Create;True;0;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1920,-768;Half;False;Property;_render_cull;_render_cull;210;1;[HideInInspector];Create;True;3;Both;0;Back;1;Front;2;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-1376,-384;Float;False;True;-1;2;TVEShaderCoreGUI;0;0;Standard;BOXOPHOBIC/The Vegetation Engine/Vegetation/Grass Subsurface Lit;False;False;False;False;False;False;False;True;False;False;False;False;True;True;True;False;True;False;False;False;True;Back;0;True;17;0;False;-1;False;0;False;-1;-1;False;-1;False;0;Custom;0.5;True;True;0;True;Opaque;;Geometry;ForwardOnly;11;d3d11;glcore;gles3;metal;vulkan;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;1;0;True;20;0;True;7;0;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Absolute;0;;-1;-1;-1;-1;0;False;0;0;True;10;-1;0;True;21;0;0;0;False;0.1;False;-1;0;False;-1;True;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;33;-2176,-512;Inherit;False;1024.392;100;Final;0;;0,1,0.5,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;408;-2176,128;Inherit;False;1026.438;100;Features;0;;0,1,0.5,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;37;-2176,-1024;Inherit;False;1023.392;100;Internal;0;;1,0.252,0,1;0;0
WireConnection;0;0;982;0
WireConnection;0;1;982;528
WireConnection;0;4;982;530
WireConnection;0;5;982;531
WireConnection;0;6;982;1230
WireConnection;0;9;982;532
WireConnection;0;10;982;653
WireConnection;0;11;982;534
ASEEND*/
//CHKSM=D55398FAB499B2E0C33E50CA649DD0E75D51BAE0
