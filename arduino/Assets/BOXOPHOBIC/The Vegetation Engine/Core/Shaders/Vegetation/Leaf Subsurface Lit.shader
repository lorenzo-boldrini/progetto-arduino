// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Vegetation Engine/Vegetation/Leaf Subsurface Lit"
{
	Properties
	{
		[StyledBanner(Leaf Subsurface Lit)]_Banner("Banner", Float) = 0
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
		_ColorsMaskValue("Colors Use Mask (main mask)", Range( 0 , 1)) = 0
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
		[Space(10)]_MainMaskMinValue("Main Mask Min", Range( 0 , 1)) = 0
		_MainMaskMaxValue("Main Mask Max", Range( 0 , 1)) = 1
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
		_SubsurfaceMaskValue("Subsurface Use Mask (main mask)", Range( 0 , 1)) = 1
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
		[StyledCategory(Vertex Settings)]_VertexCat("[ Vertex Cat ]", Float) = 0
		[StyledMessage(Info, The Object motion feature allows for high quality bending motion and interaction. The motion and global elements are calculated per instance., _VertexMotionMode, 0 , 2, 0)]_ObjectDataMessage("# Object Data Message", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[StyledMessage(Info, The World motion feature allows for simpler and cheaper translation motion and interaction. The motion is calculated in world space but the global elements are calculated per instance., _VertexMotionMode, 1 , 2, 0)]_WorldDataMessage("# World Data Message", Float) = 0
		[StyledMessage(Info, The Baked pivots feature allows for using per mesh element interaction and elements influence. This feature requires pre baked pivots on prefab conversion. Useful for latge grass meshes., _VertexPivotMode, 1 , 0, 0)]_PivotsMessage("# Pivots Message", Float) = 0
		[Enum(Object,0,World,1)][Space(10)]_VertexMotionMode("Vertex Motion", Float) = 0
		[StyledSpace(10)]_VertexMotionSpace("# Vertex Motion Space", Float) = 0
		_Motion_10("Motion Bending", Range( 0 , 1)) = 1
		_Motion_20("Motion Rolling", Range( 0 , 1)) = 1
		_Motion_30("Motion Leaves", Range( 0 , 1)) = 1
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
		[HideInInspector]_IsLeafShader("_IsLeafShader", Float) = 1
		[HideInInspector]_IsStandardShader("_IsStandardShader", Float) = 1
		[HideInInspector]_IsLitShader("_IsLitShader", Float) = 1
		[HideInInspector]_IsForwardPathShader("_IsForwardPathShader", Float) = 1
		[HideInInspector]_render_cutoff("_render_cutoff", Float) = 0.5
		[HideInInspector]_render_cull("_render_cull", Float) = 0
		[HideInInspector]_render_src("_render_src", Float) = 1
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
		#define TVE_IS_VEGETATION_SHADER
		  
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
			float3 vertexToFrag3225_g33115;
			float4 uv_tex4coord;
			float3 worldNormal;
			INTERNAL_DATA
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

		uniform half _render_src;
		uniform half _render_zw;
		uniform half _Banner;
		uniform half _IsForwardPathShader;
		uniform half _IsLitShader;
		uniform half _IsStandardShader;
		uniform half _IsLeafShader;
		uniform half _render_dst;
		uniform half _render_cull;
		uniform half _render_cutoff;
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
		UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_NoiseTex);
		uniform float2 TVE_NoiseSpeed_Vegetation;
		uniform float2 TVE_NoiseSpeed_Grass;
		uniform half TVE_NoiseSize_Vegetation;
		uniform half TVE_NoiseSize_Grass;
		SamplerState samplerTVE_NoiseTex;
		uniform half TVE_NoiseContrast;
		uniform half _Motion_20;
		uniform half _Motion_10;
		uniform half _Motion_Interaction;
		uniform half _Motion_30;
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
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MainMaskTex);
		SamplerState sampler_MainMaskTex;
		uniform half _MainMaskMinValue;
		uniform half _MainMaskMaxValue;
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
			half3 Mesh_PivotsOS2291_g33115 = _Vector1;
			float3 temp_output_2283_0_g33115 = ( ase_vertex3Pos - Mesh_PivotsOS2291_g33115 );
			half3 VertexPos40_g33118 = temp_output_2283_0_g33115;
			float3 appendResult74_g33118 = (float3(0.0 , VertexPos40_g33118.y , 0.0));
			float3 VertexPosRotationAxis50_g33118 = appendResult74_g33118;
			float3 break84_g33118 = VertexPos40_g33118;
			float3 appendResult81_g33118 = (float3(break84_g33118.x , 0.0 , break84_g33118.z));
			float3 VertexPosOtherAxis82_g33118 = appendResult81_g33118;
			half MotionAmplitude203095_g33115 = _MotionAmplitude_20;
			float ObjectData20_g33207 = 3.14;
			float Bounds_Radius121_g33115 = _MaxBoundsInfo.x;
			float WorldData19_g33207 = Bounds_Radius121_g33115;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g33207 = WorldData19_g33207;
			#else
				float staticSwitch14_g33207 = ObjectData20_g33207;
			#endif
			float Motion_Max_Rolling1137_g33115 = staticSwitch14_g33207;
			float4x4 break19_g33156 = unity_ObjectToWorld;
			float3 appendResult20_g33156 = (float3(break19_g33156[ 0 ][ 3 ] , break19_g33156[ 1 ][ 3 ] , break19_g33156[ 2 ][ 3 ]));
			half3 Off19_g33157 = appendResult20_g33156;
			float4 ase_vertex4Pos = v.vertex;
			float4 transform68_g33156 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 appendResult93_g33156 = (float3(v.texcoord.z , v.texcoord3.w , v.texcoord.w));
			float4 transform62_g33156 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult93_g33156 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g33156 = ( (transform68_g33156).xyz - (transform62_g33156).xyz );
			half3 On20_g33157 = ObjectPositionWithPivots28_g33156;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g33157 = On20_g33157;
			#else
				float3 staticSwitch14_g33157 = Off19_g33157;
			#endif
			half3 ObjectData20_g33158 = staticSwitch14_g33157;
			half3 WorldData19_g33158 = Off19_g33157;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g33158 = WorldData19_g33158;
			#else
				float3 staticSwitch14_g33158 = ObjectData20_g33158;
			#endif
			float3 temp_output_42_0_g33156 = staticSwitch14_g33158;
			half3 ObjectData20_g33161 = temp_output_42_0_g33156;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			half3 WorldData19_g33161 = ase_worldPos;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g33161 = WorldData19_g33161;
			#else
				float3 staticSwitch14_g33161 = ObjectData20_g33161;
			#endif
			float2 temp_output_39_38_g33154 = ( (TVE_VolumeCoord).zw + ( (TVE_VolumeCoord).xy * (staticSwitch14_g33161).xz ) );
			half4 Legacy33_g33162 = SAMPLE_TEXTURE2D_LOD( TVE_MotionTex, samplerTVE_MotionTex, temp_output_39_38_g33154, 0.0 );
			half4 Vegetation33_g33162 = SAMPLE_TEXTURE2D_LOD( TVE_MotionTex_Vegetation, samplerTVE_MotionTex_Vegetation, temp_output_39_38_g33154, 0.0 );
			half4 Grass33_g33162 = SAMPLE_TEXTURE2D_LOD( TVE_MotionTex_Grass, samplerTVE_MotionTex_Grass, temp_output_39_38_g33154, 0.0 );
			half4 Objects33_g33162 = SAMPLE_TEXTURE2D_LOD( TVE_MotionTex_Objects, samplerTVE_MotionTex_Objects, temp_output_39_38_g33154, 0.0 );
			half4 Custom33_g33162 = SAMPLE_TEXTURE2D_LOD( TVE_MotionTex_User, samplerTVE_MotionTex_User, temp_output_39_38_g33154, 0.0 );
			half4 localUSE_BUFFERS33_g33162 = USE_BUFFERS( Legacy33_g33162 , Vegetation33_g33162 , Grass33_g33162 , Objects33_g33162 , Custom33_g33162 );
			float4 break322_g33180 = localUSE_BUFFERS33_g33162;
			half Wind_Power369_g33180 = saturate( ( (break322_g33180.z*2.0 + -1.0) + TVE_WindPower ) );
			float lerpResult376_g33180 = lerp( 0.1 , 1.0 , Wind_Power369_g33180);
			half Wind_Power_203109_g33115 = lerpResult376_g33180;
			half Mesh_Motion_260_g33115 = v.texcoord3.y;
			#ifdef TVE_IS_GRASS_SHADER
				float2 staticSwitch160_g33200 = TVE_NoiseSpeed_Grass;
			#else
				float2 staticSwitch160_g33200 = TVE_NoiseSpeed_Vegetation;
			#endif
			float4x4 break19_g33202 = unity_ObjectToWorld;
			float3 appendResult20_g33202 = (float3(break19_g33202[ 0 ][ 3 ] , break19_g33202[ 1 ][ 3 ] , break19_g33202[ 2 ][ 3 ]));
			half3 Off19_g33203 = appendResult20_g33202;
			float4 transform68_g33202 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 appendResult95_g33202 = (float3(v.texcoord.z , 0.0 , v.texcoord.w));
			float4 transform62_g33202 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult95_g33202 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g33202 = ( (transform68_g33202).xyz - (transform62_g33202).xyz );
			half3 On20_g33203 = ObjectPositionWithPivots28_g33202;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g33203 = On20_g33203;
			#else
				float3 staticSwitch14_g33203 = Off19_g33203;
			#endif
			half3 ObjectData20_g33204 = staticSwitch14_g33203;
			half3 WorldData19_g33204 = Off19_g33203;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g33204 = WorldData19_g33204;
			#else
				float3 staticSwitch14_g33204 = ObjectData20_g33204;
			#endif
			float3 temp_output_42_0_g33202 = staticSwitch14_g33204;
			half3 ObjectData20_g33201 = temp_output_42_0_g33202;
			half3 WorldData19_g33201 = ase_worldPos;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g33201 = WorldData19_g33201;
			#else
				float3 staticSwitch14_g33201 = ObjectData20_g33201;
			#endif
			#ifdef TVE_IS_GRASS_SHADER
				float2 staticSwitch164_g33200 = (ase_worldPos).xz;
			#else
				float2 staticSwitch164_g33200 = (staticSwitch14_g33201).xz;
			#endif
			#ifdef TVE_IS_GRASS_SHADER
				float staticSwitch161_g33200 = TVE_NoiseSize_Grass;
			#else
				float staticSwitch161_g33200 = TVE_NoiseSize_Vegetation;
			#endif
			float2 panner73_g33200 = ( _Time.y * staticSwitch160_g33200 + ( staticSwitch164_g33200 * staticSwitch161_g33200 ));
			float4 tex2DNode75_g33200 = SAMPLE_TEXTURE2D_LOD( TVE_NoiseTex, samplerTVE_NoiseTex, panner73_g33200, 0.0 );
			float4 saferPower77_g33200 = max( abs( tex2DNode75_g33200 ) , 0.0001 );
			float4 temp_cast_7 = (TVE_NoiseContrast).xxxx;
			float4 break142_g33200 = pow( saferPower77_g33200 , temp_cast_7 );
			half Global_NoiseTex_R34_g33115 = break142_g33200.r;
			half Motion_Use20162_g33115 = _Motion_20;
			float4x4 break19_g33148 = unity_ObjectToWorld;
			float3 appendResult20_g33148 = (float3(break19_g33148[ 0 ][ 3 ] , break19_g33148[ 1 ][ 3 ] , break19_g33148[ 2 ][ 3 ]));
			half3 Off19_g33149 = appendResult20_g33148;
			float4 transform68_g33148 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 appendResult95_g33148 = (float3(v.texcoord.z , 0.0 , v.texcoord.w));
			float4 transform62_g33148 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult95_g33148 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g33148 = ( (transform68_g33148).xyz - (transform62_g33148).xyz );
			half3 On20_g33149 = ObjectPositionWithPivots28_g33148;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g33149 = On20_g33149;
			#else
				float3 staticSwitch14_g33149 = Off19_g33149;
			#endif
			half3 ObjectData20_g33150 = staticSwitch14_g33149;
			half3 WorldData19_g33150 = Off19_g33149;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g33150 = WorldData19_g33150;
			#else
				float3 staticSwitch14_g33150 = ObjectData20_g33150;
			#endif
			float3 temp_output_42_0_g33148 = staticSwitch14_g33150;
			float3 break9_g33148 = temp_output_42_0_g33148;
			half Variation_Complex102_g33145 = frac( ( v.color.r + ( break9_g33148.x + break9_g33148.z ) ) );
			float ObjectData20_g33147 = Variation_Complex102_g33145;
			half Variation_Simple105_g33145 = v.color.r;
			float WorldData19_g33147 = Variation_Simple105_g33145;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g33147 = WorldData19_g33147;
			#else
				float staticSwitch14_g33147 = ObjectData20_g33147;
			#endif
			half Variation3073_g33115 = staticSwitch14_g33147;
			float temp_output_116_0_g33124 = Variation3073_g33115;
			float mulTime98_g33124 = _Time.y * 0.5;
			float lerpResult110_g33124 = lerp( ( ceil( saturate( ( frac( ( temp_output_116_0_g33124 + 0.3576 ) ) - 0.5 ) ) ) * 0.5 ) , ceil( saturate( ( frac( ( temp_output_116_0_g33124 + 0.1258 ) ) - 0.8 ) ) ) , (sin( mulTime98_g33124 )*0.5 + 0.5));
			half Wind_Power2223_g33115 = Wind_Power369_g33180;
			float lerpResult118_g33124 = lerp( 0.25 , 0.75 , Wind_Power2223_g33115);
			float lerpResult111_g33124 = lerp( lerpResult110_g33124 , 1.0 , ( lerpResult118_g33124 * lerpResult118_g33124 * lerpResult118_g33124 * lerpResult118_g33124 ));
			half Motion_Selective3182_g33115 = lerpResult111_g33124;
			half Input_Speed62_g33172 = _MotionSpeed_20;
			float mulTime354_g33172 = _Time.y * Input_Speed62_g33172;
			float temp_output_342_0_g33172 = ( ( _MotionVariation_20 * Variation3073_g33115 ) * v.color.r );
			float4x4 break19_g33173 = unity_ObjectToWorld;
			float3 appendResult20_g33173 = (float3(break19_g33173[ 0 ][ 3 ] , break19_g33173[ 1 ][ 3 ] , break19_g33173[ 2 ][ 3 ]));
			half3 Off19_g33174 = appendResult20_g33173;
			float4 transform68_g33173 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 appendResult95_g33173 = (float3(v.texcoord.z , 0.0 , v.texcoord.w));
			float4 transform62_g33173 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult95_g33173 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g33173 = ( (transform68_g33173).xyz - (transform62_g33173).xyz );
			half3 On20_g33174 = ObjectPositionWithPivots28_g33173;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g33174 = On20_g33174;
			#else
				float3 staticSwitch14_g33174 = Off19_g33174;
			#endif
			half3 ObjectData20_g33175 = staticSwitch14_g33174;
			half3 WorldData19_g33175 = Off19_g33174;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g33175 = WorldData19_g33175;
			#else
				float3 staticSwitch14_g33175 = ObjectData20_g33175;
			#endif
			float3 temp_output_42_0_g33173 = staticSwitch14_g33175;
			float3 break9_g33173 = temp_output_42_0_g33173;
			float ObjectData20_g33178 = ( temp_output_342_0_g33172 + ( break9_g33173.x + break9_g33173.z ) );
			float WorldData19_g33178 = temp_output_342_0_g33172;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g33178 = WorldData19_g33178;
			#else
				float staticSwitch14_g33178 = ObjectData20_g33178;
			#endif
			float Motion_Variation284_g33172 = staticSwitch14_g33178;
			float Motion_Scale287_g33172 = ( _MotionScale_20 * ase_worldPos.x );
			half Motion_Rolling138_g33115 = ( ( MotionAmplitude203095_g33115 * Motion_Max_Rolling1137_g33115 ) * ( Wind_Power_203109_g33115 * Mesh_Motion_260_g33115 * Global_NoiseTex_R34_g33115 * Motion_Use20162_g33115 * Motion_Selective3182_g33115 ) * sin( ( mulTime354_g33172 + Motion_Variation284_g33172 + Motion_Scale287_g33172 ) ) );
			half Angle44_g33118 = Motion_Rolling138_g33115;
			half3 VertexPos40_g33132 = ( VertexPosRotationAxis50_g33118 + ( VertexPosOtherAxis82_g33118 * cos( Angle44_g33118 ) ) + ( cross( float3(0,1,0) , VertexPosOtherAxis82_g33118 ) * sin( Angle44_g33118 ) ) );
			float3 appendResult74_g33132 = (float3(VertexPos40_g33132.x , 0.0 , 0.0));
			half3 VertexPosRotationAxis50_g33132 = appendResult74_g33132;
			float3 break84_g33132 = VertexPos40_g33132;
			float3 appendResult81_g33132 = (float3(0.0 , break84_g33132.y , break84_g33132.z));
			half3 VertexPosOtherAxis82_g33132 = appendResult81_g33132;
			float ObjectData20_g33209 = 3.14;
			float Bounds_Height374_g33115 = _MaxBoundsInfo.y;
			float WorldData19_g33209 = ( Bounds_Height374_g33115 * 3.14 );
			#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g33209 = WorldData19_g33209;
			#else
				float staticSwitch14_g33209 = ObjectData20_g33209;
			#endif
			float Motion_Max_Bending1133_g33115 = staticSwitch14_g33209;
			half Wind_Power_103106_g33115 = Wind_Power369_g33180;
			float3 appendResult323_g33180 = (float3(break322_g33180.x , 0.0 , break322_g33180.y));
			float3 temp_output_324_0_g33180 = (appendResult323_g33180*2.0 + -1.0);
			float3 ase_parentObjectScale = (1.0/float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ));
			float3 temp_output_339_0_g33180 = ( mul( unity_WorldToObject, float4( temp_output_324_0_g33180 , 0.0 ) ).xyz * ase_parentObjectScale );
			half2 Wind_DirectionOS39_g33115 = (temp_output_339_0_g33180).xz;
			half Motion_Use1056_g33115 = _Motion_10;
			half Input_Speed62_g33131 = _MotionSpeed_10;
			float mulTime373_g33131 = _Time.y * Input_Speed62_g33131;
			half Motion_Variation284_g33131 = ( _MotionVariation_10 * Variation3073_g33115 );
			float2 appendResult344_g33131 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 Motion_Scale287_g33131 = ( _MotionScale_10 * appendResult344_g33131 );
			half2 Sine_MinusOneToOne281_g33131 = sin( ( mulTime373_g33131 + Motion_Variation284_g33131 + Motion_Scale287_g33131 ) );
			float2 temp_cast_12 = (1.0).xx;
			half Input_Turbulence327_g33131 = Global_NoiseTex_R34_g33115;
			float2 lerpResult321_g33131 = lerp( Sine_MinusOneToOne281_g33131 , temp_cast_12 , Input_Turbulence327_g33131);
			half2 Motion_Bending2258_g33115 = ( ( _MotionAmplitude_10 * Motion_Max_Bending1133_g33115 ) * Wind_Power_103106_g33115 * Wind_DirectionOS39_g33115 * Motion_Use1056_g33115 * Global_NoiseTex_R34_g33115 * lerpResult321_g33131 );
			half Motion_UseInteraction2097_g33115 = _Motion_Interaction;
			half Motion_InteractionMask66_g33115 = break322_g33180.w;
			float lerpResult3307_g33115 = lerp( 1.0 , Variation3073_g33115 , _InteractionVariation);
			half2 Motion_Interaction53_g33115 = ( _InteractionAmplitude * Motion_Max_Bending1133_g33115 * Motion_UseInteraction2097_g33115 * Motion_InteractionMask66_g33115 * Motion_InteractionMask66_g33115 * Wind_DirectionOS39_g33115 * lerpResult3307_g33115 );
			float2 lerpResult109_g33115 = lerp( Motion_Bending2258_g33115 , Motion_Interaction53_g33115 , Motion_InteractionMask66_g33115);
			half Mesh_Motion_182_g33115 = v.texcoord3.x;
			float2 break143_g33115 = ( lerpResult109_g33115 * Mesh_Motion_182_g33115 );
			half Motion_Z190_g33115 = break143_g33115.y;
			half Angle44_g33132 = Motion_Z190_g33115;
			half3 VertexPos40_g33117 = ( VertexPosRotationAxis50_g33132 + ( VertexPosOtherAxis82_g33132 * cos( Angle44_g33132 ) ) + ( cross( float3(1,0,0) , VertexPosOtherAxis82_g33132 ) * sin( Angle44_g33132 ) ) );
			float3 appendResult74_g33117 = (float3(0.0 , 0.0 , VertexPos40_g33117.z));
			half3 VertexPosRotationAxis50_g33117 = appendResult74_g33117;
			float3 break84_g33117 = VertexPos40_g33117;
			float3 appendResult81_g33117 = (float3(break84_g33117.x , break84_g33117.y , 0.0));
			half3 VertexPosOtherAxis82_g33117 = appendResult81_g33117;
			half Motion_X216_g33115 = break143_g33115.x;
			half Angle44_g33117 = -Motion_X216_g33115;
			half Motion_Scale321_g33123 = ( _MotionScale_30 * 10.0 );
			half Input_Speed62_g33123 = _MotionSpeed_30;
			float mulTime350_g33123 = _Time.y * Input_Speed62_g33123;
			float Motion_Variation330_g33123 = ( _MotionVariation_30 * v.color.r );
			half Input_Amplitude58_g33123 = ( _MotionAmplitude_30 * Bounds_Radius121_g33115 * 0.1 );
			float3 ase_vertexNormal = v.normal.xyz;
			half Global_NoiseTex_G38_g33115 = break142_g33200.g;
			half Global_NoiseTex_B132_g33115 = break142_g33200.b;
			half Mesh_Motion_3144_g33115 = v.texcoord3.z;
			half Motion_Use302011_g33115 = _Motion_30;
			float lerpResult378_g33180 = lerp( 0.5 , 1.0 , Wind_Power369_g33180);
			half Wind_Power_303112_g33115 = lerpResult378_g33180;
			half3 Motion_Leaves1988_g33115 = ( ( sin( ( ( ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z ) * Motion_Scale321_g33123 ) + mulTime350_g33123 + Motion_Variation330_g33123 ) ) * Input_Amplitude58_g33123 * ase_vertexNormal ) * ( ( Global_NoiseTex_G38_g33115 + Global_NoiseTex_B132_g33115 ) * Mesh_Motion_3144_g33115 * Motion_Use302011_g33115 * Wind_Power_303112_g33115 ) );
			half Motion_Scale321_g33122 = ( _MotionScale_32 * 10.0 );
			half Input_Speed62_g33122 = _MotionSpeed_32;
			float mulTime349_g33122 = _Time.y * Input_Speed62_g33122;
			float Motion_Variation330_g33122 = ( _MotionVariation_32 * v.color.r );
			half Input_Amplitude58_g33122 = ( _MotionAmplitude_32 * Bounds_Radius121_g33115 * 0.1 );
			float3 appendResult345_g33122 = (float3(v.color.r , ( 1.0 - v.color.r ) , v.color.r));
			half Motion_Use322013_g33115 = _Motion_32;
			half Wind_Power_323115_g33115 = lerpResult376_g33180;
			half3 Motion_Flutter263_g33115 = ( ( sin( ( ( ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z ) * Motion_Scale321_g33122 ) + mulTime349_g33122 + Motion_Variation330_g33122 ) ) * Input_Amplitude58_g33122 * appendResult345_g33122 ) * ( ( Global_NoiseTex_R34_g33115 + Global_NoiseTex_B132_g33115 ) * Mesh_Motion_3144_g33115 * Motion_Use322013_g33115 * Wind_Power_323115_g33115 ) );
			half Wind_Mode3167_g33115 = TVE_WindMode;
			float3 lerpResult3168_g33115 = lerp( ase_vertex3Pos , ( ( ( VertexPosRotationAxis50_g33117 + ( VertexPosOtherAxis82_g33117 * cos( Angle44_g33117 ) ) + ( cross( float3(0,0,1) , VertexPosOtherAxis82_g33117 ) * sin( Angle44_g33117 ) ) ) + Motion_Leaves1988_g33115 ) + Motion_Flutter263_g33115 ) , Wind_Mode3167_g33115);
			float3 Vertex_Motion_Object833_g33115 = lerpResult3168_g33115;
			float3 appendResult2047_g33115 = (float3(Motion_Rolling138_g33115 , 0.0 , -Motion_Rolling138_g33115));
			float3 appendResult2043_g33115 = (float3(Motion_X216_g33115 , 0.0 , Motion_Z190_g33115));
			float3 lerpResult3173_g33115 = lerp( ase_vertex3Pos , ( ( ( ( ase_vertex3Pos + appendResult2047_g33115 ) + appendResult2043_g33115 ) + Motion_Leaves1988_g33115 ) + Motion_Flutter263_g33115 ) , Wind_Mode3167_g33115);
			float3 Vertex_Motion_World1118_g33115 = lerpResult3173_g33115;
			float3 temp_output_3331_0_g33115 = ( ( _VertexCat * _VertexMotionSpace * _VertexMotionMode * _VertexDataMode ) + Vertex_Motion_World1118_g33115 );
			#if defined(TVE_VERTEX_DATA_OBJECT)
				float3 staticSwitch3312_g33115 = Vertex_Motion_Object833_g33115;
			#elif defined(TVE_VERTEX_DATA_WORLD)
				float3 staticSwitch3312_g33115 = temp_output_3331_0_g33115;
			#elif defined(TVE_VERTEX_DATA_BATCHED)
				float3 staticSwitch3312_g33115 = temp_output_3331_0_g33115;
			#else
				float3 staticSwitch3312_g33115 = Vertex_Motion_Object833_g33115;
			#endif
			half3 ObjectData20_g33179 = staticSwitch3312_g33115;
			half3 WorldData19_g33179 = Vertex_Motion_World1118_g33115;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g33179 = WorldData19_g33179;
			#else
				float3 staticSwitch14_g33179 = ObjectData20_g33179;
			#endif
			float4x4 break19_g33195 = unity_ObjectToWorld;
			float3 appendResult20_g33195 = (float3(break19_g33195[ 0 ][ 3 ] , break19_g33195[ 1 ][ 3 ] , break19_g33195[ 2 ][ 3 ]));
			half3 Off19_g33196 = appendResult20_g33195;
			float4 transform68_g33195 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 appendResult93_g33195 = (float3(v.texcoord.z , v.texcoord3.w , v.texcoord.w));
			float4 transform62_g33195 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult93_g33195 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g33195 = ( (transform68_g33195).xyz - (transform62_g33195).xyz );
			half3 On20_g33196 = ObjectPositionWithPivots28_g33195;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g33196 = On20_g33196;
			#else
				float3 staticSwitch14_g33196 = Off19_g33196;
			#endif
			half3 ObjectData20_g33197 = staticSwitch14_g33196;
			half3 WorldData19_g33197 = Off19_g33196;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g33197 = WorldData19_g33197;
			#else
				float3 staticSwitch14_g33197 = ObjectData20_g33197;
			#endif
			float3 temp_output_42_0_g33195 = staticSwitch14_g33197;
			float temp_output_7_0_g33119 = TVE_SizeFadeEnd;
			float ObjectData20_g33194 = saturate( ( ( ( distance( _WorldSpaceCameraPos , temp_output_42_0_g33195 ) * _GlobalSizeFade ) - temp_output_7_0_g33119 ) / ( TVE_SizeFadeStart - temp_output_7_0_g33119 ) ) );
			float WorldData19_g33194 = 1.0;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g33194 = WorldData19_g33194;
			#else
				float staticSwitch14_g33194 = ObjectData20_g33194;
			#endif
			float Vertex_SizeFade1740_g33115 = staticSwitch14_g33194;
			float4x4 break19_g33185 = unity_ObjectToWorld;
			float3 appendResult20_g33185 = (float3(break19_g33185[ 0 ][ 3 ] , break19_g33185[ 1 ][ 3 ] , break19_g33185[ 2 ][ 3 ]));
			half3 Off19_g33186 = appendResult20_g33185;
			float4 transform68_g33185 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 appendResult95_g33185 = (float3(v.texcoord.z , 0.0 , v.texcoord.w));
			float4 transform62_g33185 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult95_g33185 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g33185 = ( (transform68_g33185).xyz - (transform62_g33185).xyz );
			half3 On20_g33186 = ObjectPositionWithPivots28_g33185;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g33186 = On20_g33186;
			#else
				float3 staticSwitch14_g33186 = Off19_g33186;
			#endif
			half3 ObjectData20_g33187 = staticSwitch14_g33186;
			half3 WorldData19_g33187 = Off19_g33186;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g33187 = WorldData19_g33187;
			#else
				float3 staticSwitch14_g33187 = ObjectData20_g33187;
			#endif
			float3 temp_output_42_0_g33185 = staticSwitch14_g33187;
			half3 ObjectData20_g33184 = temp_output_42_0_g33185;
			half3 WorldData19_g33184 = ase_worldPos;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g33184 = WorldData19_g33184;
			#else
				float3 staticSwitch14_g33184 = ObjectData20_g33184;
			#endif
			float2 temp_output_43_38_g33182 = ( (TVE_VolumeCoord).zw + ( (TVE_VolumeCoord).xy * (staticSwitch14_g33184).xz ) );
			half4 Legacy33_g33183 = SAMPLE_TEXTURE2D_LOD( TVE_ExtrasTex, samplerTVE_ExtrasTex, temp_output_43_38_g33182, 0.0 );
			half4 Vegetation33_g33183 = SAMPLE_TEXTURE2D_LOD( TVE_ExtrasTex_Vegetation, samplerTVE_ExtrasTex_Vegetation, temp_output_43_38_g33182, 0.0 );
			half4 Grass33_g33183 = SAMPLE_TEXTURE2D_LOD( TVE_ExtrasTex_Grass, samplerTVE_ExtrasTex_Grass, temp_output_43_38_g33182, 0.0 );
			half4 Objects33_g33183 = SAMPLE_TEXTURE2D_LOD( TVE_ExtrasTex_Objects, samplerTVE_ExtrasTex_Objects, temp_output_43_38_g33182, 0.0 );
			half4 Custom33_g33183 = SAMPLE_TEXTURE2D_LOD( TVE_ExtrasTex_User, samplerTVE_ExtrasTex_User, temp_output_43_38_g33182, 0.0 );
			half4 localUSE_BUFFERS33_g33183 = USE_BUFFERS( Legacy33_g33183 , Vegetation33_g33183 , Grass33_g33183 , Objects33_g33183 , Custom33_g33183 );
			float4 break49_g33182 = localUSE_BUFFERS33_g33183;
			half Global_ExtrasTex_G305_g33115 = break49_g33182.y;
			float lerpResult346_g33115 = lerp( 1.0 , Global_ExtrasTex_G305_g33115 , _GlobalSize);
			float ObjectData20_g33193 = ( lerpResult346_g33115 * _LocalSize );
			float WorldData19_g33193 = 1.0;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g33193 = WorldData19_g33193;
			#else
				float staticSwitch14_g33193 = ObjectData20_g33193;
			#endif
			half Vertex_Size1741_g33115 = staticSwitch14_g33193;
			half3 Grass_Coverage2661_g33115 = half3(0,0,0);
			float3 Final_VertexPosition890_g33115 = ( ( staticSwitch14_g33179 * Vertex_SizeFade1740_g33115 * Vertex_Size1741_g33115 ) + Mesh_PivotsOS2291_g33115 + Grass_Coverage2661_g33115 );
			v.vertex.xyz = Final_VertexPosition890_g33115;
			v.vertex.w = 1;
			half2 Noise_UVs3274_g33115 = ( (ase_worldPos).xz * ( ( _NoiseScaleValue * 0.1 ) + _MoiseCat ) );
			float temp_output_7_0_g33141 = _NoiseMinValue;
			half Noise_Mask3162_g33115 = saturate( ( ( SAMPLE_TEXTURE2D_LOD( _NoiseTex, sampler_NoiseTex, Noise_UVs3274_g33115, 0.0 ).r - temp_output_7_0_g33141 ) / ( _NoiseMaxValue - temp_output_7_0_g33141 ) ) );
			float4 lerpResult2800_g33115 = lerp( _NoiseTintTwo , _NoiseTintOne , Noise_Mask3162_g33115);
			half3 Noise_Tint2802_g33115 = (lerpResult2800_g33115).rgb;
			o.vertexToFrag3225_g33115 = Noise_Tint2802_g33115;
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
			half2 Main_UVs15_g33115 = ( ( i.uv_texcoord * (_MainUVs).xy ) + (_MainUVs).zw );
			float4 tex2DNode117_g33115 = SAMPLE_TEXTURE2D( _MainNormalTex, sampler_MainAlbedoTex, Main_UVs15_g33115 );
			float2 appendResult88_g33121 = (float2(tex2DNode117_g33115.a , tex2DNode117_g33115.g));
			float2 temp_output_90_0_g33121 = ( (appendResult88_g33121*2.0 + -1.0) * _MainNormalValue );
			float3 appendResult91_g33121 = (float3(temp_output_90_0_g33121 , 1.0));
			half3 Main_Normal137_g33115 = appendResult91_g33121;
			float3 temp_output_13_0_g33139 = Main_Normal137_g33115;
			float3 switchResult12_g33139 = (((i.ASEVFace>0)?(temp_output_13_0_g33139):(( temp_output_13_0_g33139 * _render_normals_options ))));
			half3 Blend_Normal312_g33115 = switchResult12_g33139;
			half3 Final_Normal366_g33115 = Blend_Normal312_g33115;
			o.Normal = Final_Normal366_g33115;
			float temp_output_7_0_g33137 = _GradientMinValue;
			float4 lerpResult2779_g33115 = lerp( _GradientColorTwo , _GradientColorOne , saturate( ( ( i.vertexColor.a - temp_output_7_0_g33137 ) / ( ( _GradientMaxValue + _GradientCat ) - temp_output_7_0_g33137 ) ) ));
			half3 Gradient_Tint2784_g33115 = (lerpResult2779_g33115).rgb;
			float4 tex2DNode29_g33115 = SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, Main_UVs15_g33115 );
			float4 temp_output_51_0_g33115 = ( _MainColor * tex2DNode29_g33115 );
			half3 Main_AlbedoRaw99_g33115 = (temp_output_51_0_g33115).rgb;
			half3 Main_AlbedoTinted2808_g33115 = ( Gradient_Tint2784_g33115 * i.vertexToFrag3225_g33115 * Main_AlbedoRaw99_g33115 * float3(1,1,1) );
			float4x4 break19_g33164 = unity_ObjectToWorld;
			float3 appendResult20_g33164 = (float3(break19_g33164[ 0 ][ 3 ] , break19_g33164[ 1 ][ 3 ] , break19_g33164[ 2 ][ 3 ]));
			half3 Off19_g33165 = appendResult20_g33164;
			float4 ase_vertex4Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float4 transform68_g33164 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float3 appendResult95_g33164 = (float3(i.uv_tex4coord.z , 0.0 , i.uv_tex4coord.w));
			float4 transform62_g33164 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult95_g33164 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g33164 = ( (transform68_g33164).xyz - (transform62_g33164).xyz );
			half3 On20_g33165 = ObjectPositionWithPivots28_g33164;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g33165 = On20_g33165;
			#else
				float3 staticSwitch14_g33165 = Off19_g33165;
			#endif
			half3 ObjectData20_g33166 = staticSwitch14_g33165;
			half3 WorldData19_g33166 = Off19_g33165;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g33166 = WorldData19_g33166;
			#else
				float3 staticSwitch14_g33166 = ObjectData20_g33166;
			#endif
			float3 temp_output_42_0_g33164 = staticSwitch14_g33166;
			half3 ObjectData20_g33170 = temp_output_42_0_g33164;
			float3 ase_worldPos = i.worldPos;
			half3 WorldData19_g33170 = ase_worldPos;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g33170 = WorldData19_g33170;
			#else
				float3 staticSwitch14_g33170 = ObjectData20_g33170;
			#endif
			float2 temp_output_35_38_g33163 = ( (TVE_VolumeCoord).zw + ( (TVE_VolumeCoord).xy * (staticSwitch14_g33170).xz ) );
			half4 Legacy33_g33169 = SAMPLE_TEXTURE2D( TVE_ColorsTex, samplerTVE_ColorsTex, temp_output_35_38_g33163 );
			half4 Vegetation33_g33169 = SAMPLE_TEXTURE2D( TVE_ColorsTex_Vegetation, samplerTVE_ColorsTex_Vegetation, temp_output_35_38_g33163 );
			half4 Grass33_g33169 = SAMPLE_TEXTURE2D( TVE_ColorsTex_Grass, samplerTVE_ColorsTex_Grass, temp_output_35_38_g33163 );
			half4 Objects33_g33169 = SAMPLE_TEXTURE2D( TVE_ColorsTex_Objects, samplerTVE_ColorsTex_Objects, temp_output_35_38_g33163 );
			half4 Custom33_g33169 = SAMPLE_TEXTURE2D( TVE_ColorsTex_User, samplerTVE_ColorsTex_User, temp_output_35_38_g33163 );
			half4 localUSE_BUFFERS33_g33169 = USE_BUFFERS( Legacy33_g33169 , Vegetation33_g33169 , Grass33_g33169 , Objects33_g33169 , Custom33_g33169 );
			float4 temp_output_45_0_g33163 = localUSE_BUFFERS33_g33169;
			half3 Global_ColorsTex_RGB1700_g33115 = (temp_output_45_0_g33163).xyz;
			#ifdef UNITY_COLORSPACE_GAMMA
				float staticSwitch1_g33134 = 2.0;
			#else
				float staticSwitch1_g33134 = 4.594794;
			#endif
			float4 tex2DNode35_g33115 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainAlbedoTex, Main_UVs15_g33115 );
			half Main_Mask_Raw57_g33115 = tex2DNode35_g33115.b;
			float temp_output_7_0_g33208 = _MainMaskMinValue;
			half Main_Mask_Remap3201_g33115 = saturate( ( ( Main_Mask_Raw57_g33115 - temp_output_7_0_g33208 ) / ( _MainMaskMaxValue - temp_output_7_0_g33208 ) ) );
			float lerpResult2105_g33115 = lerp( 1.0 , Main_Mask_Remap3201_g33115 , _ColorsMaskValue);
			float3 lerpResult108_g33115 = lerp( float3( 1,1,1 ) , ( (_LocalColors).rgb * ( Global_ColorsTex_RGB1700_g33115 * staticSwitch1_g33134 ) ) , ( _GlobalColors * lerpResult2105_g33115 ));
			half3 Global_Colors1954_g33115 = lerpResult108_g33115;
			float3 temp_output_123_0_g33115 = ( Main_AlbedoTinted2808_g33115 * Global_Colors1954_g33115 );
			half3 Main_AlbedoColored863_g33115 = temp_output_123_0_g33115;
			half3 Blend_Albedo265_g33115 = Main_AlbedoColored863_g33115;
			float3 lerpResult2929_g33115 = lerp( float3( 1,1,1 ) , (TVE_MainLightParams).rgb , _SubsurfaceLightValue);
			half3 Subsurface_Color1722_g33115 = ( (_SubsurfaceColor).rgb * lerpResult2929_g33115 );
			half Global_ColorsTex_A1701_g33115 = (temp_output_45_0_g33163).w;
			float lerpResult1720_g33115 = lerp( 1.0 , Global_ColorsTex_A1701_g33115 , _GlobalHealthiness);
			half Subsurface_Intensity1752_g33115 = ( ( _SubsurfaceValue * lerpResult1720_g33115 ) + _SubsurfaceCat );
			float lerpResult3210_g33115 = lerp( 1.0 , Main_Mask_Remap3201_g33115 , _SubsurfaceMaskValue);
			half Subsurface_Mask1557_g33115 = lerpResult3210_g33115;
			half3 Subsurface_Transmission884_g33115 = ( Subsurface_Color1722_g33115 * Subsurface_Intensity1752_g33115 * Subsurface_Mask1557_g33115 );
			float3 normalizeResult1983_g33115 = normalize( ( _WorldSpaceCameraPos - ase_worldPos ) );
			float dotResult785_g33115 = dot( -TVE_MainLightDirection , normalizeResult1983_g33115 );
			float saferPower1624_g33115 = max( (dotResult785_g33115*0.5 + 0.5) , 0.0001 );
			#ifdef UNITY_PASS_FORWARDADD
				float staticSwitch1602_g33115 = 0.0;
			#else
				float staticSwitch1602_g33115 = ( pow( saferPower1624_g33115 , _SubsurfaceAngleValue ) * _SubsurfaceViewValue );
			#endif
			half Mask_Subsurface_View782_g33115 = staticSwitch1602_g33115;
			half3 Subsurface_Forward1691_g33115 = ( Subsurface_Transmission884_g33115 * Mask_Subsurface_View782_g33115 );
			half3 Blend_AlbedoAndSubsurface149_g33115 = ( Blend_Albedo265_g33115 + Subsurface_Forward1691_g33115 );
			half3 Global_OverlayColor1758_g33115 = (TVE_OverlayColor).rgb;
			half3 Blend_NormalRaw1051_g33115 = Main_Normal137_g33115;
			float3 switchResult1063_g33115 = (((i.ASEVFace>0)?(Blend_NormalRaw1051_g33115):(( Blend_NormalRaw1051_g33115 * float3(-1,-1,-1) ))));
			half Overlay_Contrast1405_g33115 = _OverlayContrastValue;
			float3 appendResult1439_g33115 = (float3(Overlay_Contrast1405_g33115 , Overlay_Contrast1405_g33115 , 1.0));
			half Global_OverlayIntensity154_g33115 = TVE_OverlayIntensity;
			float4x4 break19_g33185 = unity_ObjectToWorld;
			float3 appendResult20_g33185 = (float3(break19_g33185[ 0 ][ 3 ] , break19_g33185[ 1 ][ 3 ] , break19_g33185[ 2 ][ 3 ]));
			half3 Off19_g33186 = appendResult20_g33185;
			float4 transform68_g33185 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 appendResult95_g33185 = (float3(i.uv_tex4coord.z , 0.0 , i.uv_tex4coord.w));
			float4 transform62_g33185 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult95_g33185 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g33185 = ( (transform68_g33185).xyz - (transform62_g33185).xyz );
			half3 On20_g33186 = ObjectPositionWithPivots28_g33185;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g33186 = On20_g33186;
			#else
				float3 staticSwitch14_g33186 = Off19_g33186;
			#endif
			half3 ObjectData20_g33187 = staticSwitch14_g33186;
			half3 WorldData19_g33187 = Off19_g33186;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g33187 = WorldData19_g33187;
			#else
				float3 staticSwitch14_g33187 = ObjectData20_g33187;
			#endif
			float3 temp_output_42_0_g33185 = staticSwitch14_g33187;
			half3 ObjectData20_g33184 = temp_output_42_0_g33185;
			half3 WorldData19_g33184 = ase_worldPos;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g33184 = WorldData19_g33184;
			#else
				float3 staticSwitch14_g33184 = ObjectData20_g33184;
			#endif
			float2 temp_output_43_38_g33182 = ( (TVE_VolumeCoord).zw + ( (TVE_VolumeCoord).xy * (staticSwitch14_g33184).xz ) );
			half4 Legacy33_g33183 = SAMPLE_TEXTURE2D( TVE_ExtrasTex, samplerTVE_ExtrasTex, temp_output_43_38_g33182 );
			half4 Vegetation33_g33183 = SAMPLE_TEXTURE2D( TVE_ExtrasTex_Vegetation, samplerTVE_ExtrasTex_Vegetation, temp_output_43_38_g33182 );
			half4 Grass33_g33183 = SAMPLE_TEXTURE2D( TVE_ExtrasTex_Grass, samplerTVE_ExtrasTex_Grass, temp_output_43_38_g33182 );
			half4 Objects33_g33183 = SAMPLE_TEXTURE2D( TVE_ExtrasTex_Objects, samplerTVE_ExtrasTex_Objects, temp_output_43_38_g33182 );
			half4 Custom33_g33183 = SAMPLE_TEXTURE2D( TVE_ExtrasTex_User, samplerTVE_ExtrasTex_User, temp_output_43_38_g33182 );
			half4 localUSE_BUFFERS33_g33183 = USE_BUFFERS( Legacy33_g33183 , Vegetation33_g33183 , Grass33_g33183 , Objects33_g33183 , Custom33_g33183 );
			float4 break49_g33182 = localUSE_BUFFERS33_g33183;
			half Global_ExtrasTex_B156_g33115 = break49_g33182.z;
			float temp_output_1025_0_g33115 = ( Global_OverlayIntensity154_g33115 * _GlobalOverlay * Global_ExtrasTex_B156_g33115 );
			float lerpResult1065_g33115 = lerp( 1.0 , i.vertexColor.r , _OverlayVariationValue);
			half Overlay_Commons1365_g33115 = ( temp_output_1025_0_g33115 * lerpResult1065_g33115 );
			half Overlay_Mask269_g33115 = saturate( ( saturate( (WorldNormalVector( i , ( switchResult1063_g33115 * appendResult1439_g33115 ) )).y ) - ( 1.0 - Overlay_Commons1365_g33115 ) ) );
			float3 lerpResult336_g33115 = lerp( Blend_AlbedoAndSubsurface149_g33115 , Global_OverlayColor1758_g33115 , Overlay_Mask269_g33115);
			half3 Final_Albedo359_g33115 = lerpResult336_g33115;
			half Main_Alpha316_g33115 = (temp_output_51_0_g33115).a;
			float lerpResult354_g33115 = lerp( 1.0 , Main_Alpha316_g33115 , _render_premul);
			half Final_Premultiply355_g33115 = lerpResult354_g33115;
			float3 temp_output_410_0_g33115 = ( Final_Albedo359_g33115 * Final_Premultiply355_g33115 );
			float3 temp_cast_12 = (1.0).xxx;
			half Mesh_Occlusion318_g33115 = i.vertexColor.g;
			float saferPower1201_g33115 = max( Mesh_Occlusion318_g33115 , 0.0001 );
			float3 lerpResult2945_g33115 = lerp( (_VertexOcclusionColor).rgb , temp_cast_12 , saturate( pow( saferPower1201_g33115 , ( _VertexOcclusionValue + _OcclusionCat ) ) ));
			half3 Vertex_Occlusion648_g33115 = lerpResult2945_g33115;
			o.Albedo = ( temp_output_410_0_g33115 * Vertex_Occlusion648_g33115 );
			half Main_Smoothness227_g33115 = ( tex2DNode35_g33115.a * _MainSmoothnessValue );
			half Blend_Smoothness314_g33115 = Main_Smoothness227_g33115;
			half Global_OverlaySmoothness311_g33115 = TVE_OverlaySmoothness;
			float lerpResult343_g33115 = lerp( Blend_Smoothness314_g33115 , Global_OverlaySmoothness311_g33115 , Overlay_Mask269_g33115);
			half Final_Smoothness371_g33115 = lerpResult343_g33115;
			half Global_Wetness1016_g33115 = ( TVE_Wetness * _GlobalWetness );
			half Global_ExtrasTex_A1033_g33115 = break49_g33182.w;
			float lerpResult1037_g33115 = lerp( Final_Smoothness371_g33115 , saturate( ( Final_Smoothness371_g33115 + Global_Wetness1016_g33115 ) ) , Global_ExtrasTex_A1033_g33115);
			o.Smoothness = lerpResult1037_g33115;
			float lerpResult240_g33115 = lerp( 1.0 , tex2DNode35_g33115.g , _MainOcclusionValue);
			half Main_Occlusion247_g33115 = lerpResult240_g33115;
			half Blend_Occlusion323_g33115 = Main_Occlusion247_g33115;
			o.Occlusion = Blend_Occlusion323_g33115;
			o.Transmission = Subsurface_Transmission884_g33115;
			o.Alpha = Main_Alpha316_g33115;
			half Main_AlphaRaw1203_g33115 = tex2DNode29_g33115.a;
			float Mesh_Variation16_g33115 = i.vertexColor.r;
			float lerpResult2262_g33115 = lerp( 0.9 , Mesh_Variation16_g33115 , _LeavesVariationValue);
			half Global_ExtrasTex_R174_g33115 = break49_g33182.x;
			float lerpResult2624_g33115 = lerp( 1.0 , Global_ExtrasTex_R174_g33115 , _GlobalLeaves);
			half AlphaTreshold2132_g33115 = _Cutoff;
			half Mask_Leaves315_g33115 = ( ( (lerpResult2262_g33115*0.5 + 0.5) - ( 1.0 - ( lerpResult2624_g33115 * _LocalLeaves ) ) ) + AlphaTreshold2132_g33115 );
			half Alpha5_g33144 = ( Main_AlphaRaw1203_g33115 * Mask_Leaves315_g33115 );
			#ifdef _ALPHATEST_ON
				float staticSwitch2_g33144 = Alpha5_g33144;
			#else
				float staticSwitch2_g33144 = 1.0;
			#endif
			half Final_Clip914_g33115 = staticSwitch2_g33144;
			clip( Final_Clip914_g33115 - _render_cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "TVEShaderCoreGUI"
}
/*ASEBEGIN
Version=18600
1927;1;1906;1020;2747.382;896.3802;1.09087;True;False
Node;AmplifyShaderEditor.RangedFloatNode;7;-1552,-640;Half;False;Property;_render_dst;_render_dst;211;1;[HideInInspector];Create;True;2;Opaque;0;Transparent;1;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;168;-1968,-768;Half;False;Property;_IsLeafShader;_IsLeafShader;204;1;[HideInInspector];Create;True;0;0;True;0;False;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;81;-1776,-768;Half;False;Property;_IsStandardShader;_IsStandardShader;205;1;[HideInInspector];Create;True;0;0;True;0;False;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;697;-2176,-256;Inherit;False;Base Shader;1;;33115;856f7164d1c579d43a5cf4968a75ca43;50,1300,1,1298,1,1271,1,1962,1,1708,1,1712,3,1964,1,1969,1,1719,1,893,1,1745,1,1742,1,1718,1,1714,1,1715,1,1717,1,916,1,1949,1,1763,0,1762,0,1776,1,1646,1,1690,0,1757,0,3221,3,1981,0,2807,1,2953,1,3243,0,2172,0,2658,0,1734,0,1733,0,1735,0,1736,0,1966,0,1968,0,1737,0,878,0,1550,0,860,1,2750,0,2261,1,2260,1,2054,1,2032,1,2060,1,2036,1,2062,1,2039,1;0;15;FLOAT3;0;FLOAT3;528;FLOAT3;2489;FLOAT;529;FLOAT;530;FLOAT;531;FLOAT;1235;FLOAT3;1230;FLOAT;1461;FLOAT;1290;FLOAT;721;FLOAT;532;FLOAT;653;FLOAT;629;FLOAT3;534
Node;AmplifyShaderEditor.RangedFloatNode;21;-2176,-640;Half;False;Property;_render_cutoff;_render_cutoff;208;1;[HideInInspector];Create;True;4;Alpha;0;Premultiply;1;Additive;2;Multiply;3;0;True;0;False;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1920,-640;Half;False;Property;_render_cull;_render_cull;209;1;[HideInInspector];Create;True;3;Both;0;Back;1;Front;2;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1376,-640;Half;False;Property;_render_zw;_render_zw;212;1;[HideInInspector];Create;True;2;Opaque;0;Transparent;1;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1744,-640;Half;False;Property;_render_src;_render_src;210;1;[HideInInspector];Create;True;0;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;471;-2176,384;Inherit;False;Use TVE_IS_VEGETATION_SHADER;-1;;33114;b458122dd75182d488380bd0f592b9e6;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;271;-1552,-768;Half;False;Property;_IsLitShader;_IsLitShader;206;1;[HideInInspector];Create;True;0;0;True;0;False;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;404;-1376,-768;Half;False;Property;_IsForwardPathShader;_IsForwardPathShader;207;1;[HideInInspector];Create;True;0;0;True;0;False;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-2176,-768;Half;False;Property;_Banner;Banner;0;0;Create;True;0;0;True;1;StyledBanner(Leaf Subsurface Lit);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-1376,-256;Float;False;True;-1;2;TVEShaderCoreGUI;0;0;Standard;BOXOPHOBIC/The Vegetation Engine/Vegetation/Leaf Subsurface Lit;False;False;False;False;False;False;False;True;False;False;False;False;True;True;True;False;True;False;False;False;True;Back;0;True;17;0;False;-1;False;0;False;-1;-1;False;-1;False;0;Custom;0.5;True;True;0;True;Opaque;;Geometry;ForwardOnly;11;d3d11;glcore;gles3;metal;vulkan;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;1;0;True;20;0;True;7;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Absolute;0;;-1;-1;-1;-1;0;False;0;0;True;10;-1;0;True;21;0;0;0;False;0.1;False;-1;0;False;-1;True;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;37;-2176,-896;Inherit;False;1023.392;100;Internal;0;;1,0.252,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;449;-2176,256;Inherit;False;1026.438;100;Features;0;;0,1,0.5,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;33;-2176,-384;Inherit;False;1024.392;100;Final;0;;0,1,0.5,1;0;0
WireConnection;0;0;697;0
WireConnection;0;1;697;528
WireConnection;0;4;697;530
WireConnection;0;5;697;531
WireConnection;0;6;697;1230
WireConnection;0;9;697;532
WireConnection;0;10;697;653
WireConnection;0;11;697;534
ASEEND*/
//CHKSM=B83200D0E05C12C548D00BA0580AB6A32C84AE2B
