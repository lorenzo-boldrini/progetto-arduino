// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Vegetation Engine/Vegetation/Cross Subsurface Lit"
{
	Properties
	{
		[StyledBanner(Cross Subsurface Lit)]_Banner("Banner", Float) = 0
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
		_GlobalHealthiness("Global Healthiness", Range( 0 , 1)) = 1
		_GlobalSize("Global Size", Range( 0 , 1)) = 1
		_GlobalSizeFade("Global Size Fade", Range( 0 , 1)) = 0
		[StyledSpace(10)]_GlobalSpace("# Global Space", Float) = 0
		[HideInInspector][HDR]_LocalColors("Local Colors", Color) = (1,1,1,1)
		[HideInInspector]_LocalSize("Local Size", Range( 0 , 1)) = 1
		_ColorsMaskValue("Colors Use Mask (main mask)", Range( 0 , 1)) = 0
		_OverlayContrastValue("Overlay Contrast", Range( 0 , 10)) = 4
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
		[StyledCategory(Billboard Settings)]_BillboardCat("[ Billboard Cat ]", Float) = 0
		_BillboardFadeHValue("Billboard Fade Horizontal", Range( 0 , 4)) = 0
		_BillboardFadeVValue("Billboard Fade Verical", Range( 0 , 4)) = 0
		[StyledCategory(Vertex Settings)]_VertexCat("[ Vertex Cat ]", Float) = 0
		[StyledMessage(Info, The Object motion feature allows for high quality bending motion and interaction. The motion and global elements are calculated per instance., _VertexMotionMode, 0 , 2, 0)]_ObjectDataMessage("# Object Data Message", Float) = 0
		[StyledMessage(Info, The World motion feature allows for simpler and cheaper translation motion and interaction. The motion is calculated in world space but the global elements are calculated per instance., _VertexMotionMode, 1 , 2, 0)]_WorldDataMessage("# World Data Message", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[StyledMessage(Info, The Baked pivots feature allows for using per mesh element interaction and elements influence. This feature requires pre baked pivots on prefab conversion. Useful for latge grass meshes., _VertexPivotMode, 1 , 0, 0)]_PivotsMessage("# Pivots Message", Float) = 0
		[Enum(Object,0,World,1)][Space(10)]_VertexMotionMode("Vertex Motion", Float) = 0
		[StyledSpace(10)]_VertexMotionSpace("# Vertex Motion Space", Float) = 0
		_Motion_10("Motion Bending", Range( 0 , 1)) = 1
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
		[HideInInspector]_IsStandardShader("_IsStandardShader", Float) = 1
		[HideInInspector]_IsLitShader("_IsLitShader", Float) = 1
		[HideInInspector]_IsForwardPathShader("_IsForwardPathShader", Float) = 1
		[HideInInspector]_IsCrossShader("_IsCrossShader", Float) = 1
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
		
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
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

		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			half ASEVFace : VFACE;
			float4 vertexColor : COLOR;
			float3 vertexToFrag3225_g32155;
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

		uniform half _Banner;
		uniform half _render_src;
		uniform half _render_dst;
		uniform half _render_cutoff;
		uniform half _render_cull;
		uniform half _IsStandardShader;
		uniform half _IsCrossShader;
		uniform half _IsForwardPathShader;
		uniform half _render_zw;
		uniform half _IsLitShader;
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
		uniform half _Motion_10;
		UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_NoiseTex);
		uniform float2 TVE_NoiseSpeed_Vegetation;
		uniform float2 TVE_NoiseSpeed_Grass;
		uniform half TVE_NoiseSize_Vegetation;
		uniform half TVE_NoiseSize_Grass;
		SamplerState samplerTVE_NoiseTex;
		uniform half TVE_NoiseContrast;
		uniform half _Motion_Interaction;
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
		uniform half _render_premul;
		uniform half _MainSmoothnessValue;
		uniform half TVE_OverlaySmoothness;
		uniform float TVE_Wetness;
		uniform half _GlobalWetness;
		uniform half _MainOcclusionValue;
		uniform half _BillboardFadeHValue;
		uniform half _BillboardFadeVValue;
		uniform half _BillboardCat;


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
			half3 Mesh_PivotsOS2291_g32155 = _Vector1;
			float3 temp_output_2283_0_g32155 = ( ase_vertex3Pos - Mesh_PivotsOS2291_g32155 );
			half3 VertexPos40_g32302 = temp_output_2283_0_g32155;
			float3 appendResult74_g32302 = (float3(VertexPos40_g32302.x , 0.0 , 0.0));
			half3 VertexPosRotationAxis50_g32302 = appendResult74_g32302;
			float3 break84_g32302 = VertexPos40_g32302;
			float3 appendResult81_g32302 = (float3(0.0 , break84_g32302.y , break84_g32302.z));
			half3 VertexPosOtherAxis82_g32302 = appendResult81_g32302;
			float ObjectData20_g32379 = 3.14;
			float Bounds_Height374_g32155 = _MaxBoundsInfo.y;
			float WorldData19_g32379 = ( Bounds_Height374_g32155 * 3.14 );
			#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g32379 = WorldData19_g32379;
			#else
				float staticSwitch14_g32379 = ObjectData20_g32379;
			#endif
			float Motion_Max_Bending1133_g32155 = staticSwitch14_g32379;
			float4x4 break19_g32326 = unity_ObjectToWorld;
			float3 appendResult20_g32326 = (float3(break19_g32326[ 0 ][ 3 ] , break19_g32326[ 1 ][ 3 ] , break19_g32326[ 2 ][ 3 ]));
			half3 Off19_g32327 = appendResult20_g32326;
			float4 ase_vertex4Pos = v.vertex;
			float4 transform68_g32326 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 appendResult93_g32326 = (float3(v.texcoord.z , v.texcoord3.w , v.texcoord.w));
			float4 transform62_g32326 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult93_g32326 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g32326 = ( (transform68_g32326).xyz - (transform62_g32326).xyz );
			half3 On20_g32327 = ObjectPositionWithPivots28_g32326;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g32327 = On20_g32327;
			#else
				float3 staticSwitch14_g32327 = Off19_g32327;
			#endif
			half3 ObjectData20_g32328 = staticSwitch14_g32327;
			half3 WorldData19_g32328 = Off19_g32327;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g32328 = WorldData19_g32328;
			#else
				float3 staticSwitch14_g32328 = ObjectData20_g32328;
			#endif
			float3 temp_output_42_0_g32326 = staticSwitch14_g32328;
			half3 ObjectData20_g32331 = temp_output_42_0_g32326;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			half3 WorldData19_g32331 = ase_worldPos;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g32331 = WorldData19_g32331;
			#else
				float3 staticSwitch14_g32331 = ObjectData20_g32331;
			#endif
			float2 temp_output_39_38_g32324 = ( (TVE_VolumeCoord).zw + ( (TVE_VolumeCoord).xy * (staticSwitch14_g32331).xz ) );
			half4 Legacy33_g32332 = SAMPLE_TEXTURE2D_LOD( TVE_MotionTex, samplerTVE_MotionTex, temp_output_39_38_g32324, 0.0 );
			half4 Vegetation33_g32332 = SAMPLE_TEXTURE2D_LOD( TVE_MotionTex_Vegetation, samplerTVE_MotionTex_Vegetation, temp_output_39_38_g32324, 0.0 );
			half4 Grass33_g32332 = SAMPLE_TEXTURE2D_LOD( TVE_MotionTex_Grass, samplerTVE_MotionTex_Grass, temp_output_39_38_g32324, 0.0 );
			half4 Objects33_g32332 = SAMPLE_TEXTURE2D_LOD( TVE_MotionTex_Objects, samplerTVE_MotionTex_Objects, temp_output_39_38_g32324, 0.0 );
			half4 Custom33_g32332 = SAMPLE_TEXTURE2D_LOD( TVE_MotionTex_User, samplerTVE_MotionTex_User, temp_output_39_38_g32324, 0.0 );
			half4 localUSE_BUFFERS33_g32332 = USE_BUFFERS( Legacy33_g32332 , Vegetation33_g32332 , Grass33_g32332 , Objects33_g32332 , Custom33_g32332 );
			float4 break322_g32350 = localUSE_BUFFERS33_g32332;
			half Wind_Power369_g32350 = saturate( ( (break322_g32350.z*2.0 + -1.0) + TVE_WindPower ) );
			half Wind_Power_103106_g32155 = Wind_Power369_g32350;
			float3 appendResult323_g32350 = (float3(break322_g32350.x , 0.0 , break322_g32350.y));
			float3 temp_output_324_0_g32350 = (appendResult323_g32350*2.0 + -1.0);
			float3 ase_parentObjectScale = (1.0/float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ));
			float3 temp_output_339_0_g32350 = ( mul( unity_WorldToObject, float4( temp_output_324_0_g32350 , 0.0 ) ).xyz * ase_parentObjectScale );
			half2 Wind_DirectionOS39_g32155 = (temp_output_339_0_g32350).xz;
			half Motion_Use1056_g32155 = _Motion_10;
			#ifdef TVE_IS_GRASS_SHADER
				float2 staticSwitch160_g32370 = TVE_NoiseSpeed_Grass;
			#else
				float2 staticSwitch160_g32370 = TVE_NoiseSpeed_Vegetation;
			#endif
			float4x4 break19_g32372 = unity_ObjectToWorld;
			float3 appendResult20_g32372 = (float3(break19_g32372[ 0 ][ 3 ] , break19_g32372[ 1 ][ 3 ] , break19_g32372[ 2 ][ 3 ]));
			half3 Off19_g32373 = appendResult20_g32372;
			float4 transform68_g32372 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 appendResult95_g32372 = (float3(v.texcoord.z , 0.0 , v.texcoord.w));
			float4 transform62_g32372 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult95_g32372 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g32372 = ( (transform68_g32372).xyz - (transform62_g32372).xyz );
			half3 On20_g32373 = ObjectPositionWithPivots28_g32372;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g32373 = On20_g32373;
			#else
				float3 staticSwitch14_g32373 = Off19_g32373;
			#endif
			half3 ObjectData20_g32374 = staticSwitch14_g32373;
			half3 WorldData19_g32374 = Off19_g32373;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g32374 = WorldData19_g32374;
			#else
				float3 staticSwitch14_g32374 = ObjectData20_g32374;
			#endif
			float3 temp_output_42_0_g32372 = staticSwitch14_g32374;
			half3 ObjectData20_g32371 = temp_output_42_0_g32372;
			half3 WorldData19_g32371 = ase_worldPos;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g32371 = WorldData19_g32371;
			#else
				float3 staticSwitch14_g32371 = ObjectData20_g32371;
			#endif
			#ifdef TVE_IS_GRASS_SHADER
				float2 staticSwitch164_g32370 = (ase_worldPos).xz;
			#else
				float2 staticSwitch164_g32370 = (staticSwitch14_g32371).xz;
			#endif
			#ifdef TVE_IS_GRASS_SHADER
				float staticSwitch161_g32370 = TVE_NoiseSize_Grass;
			#else
				float staticSwitch161_g32370 = TVE_NoiseSize_Vegetation;
			#endif
			float2 panner73_g32370 = ( _Time.y * staticSwitch160_g32370 + ( staticSwitch164_g32370 * staticSwitch161_g32370 ));
			float4 tex2DNode75_g32370 = SAMPLE_TEXTURE2D_LOD( TVE_NoiseTex, samplerTVE_NoiseTex, panner73_g32370, 0.0 );
			float4 saferPower77_g32370 = max( abs( tex2DNode75_g32370 ) , 0.0001 );
			float4 temp_cast_9 = (TVE_NoiseContrast).xxxx;
			float4 break142_g32370 = pow( saferPower77_g32370 , temp_cast_9 );
			half Global_NoiseTex_R34_g32155 = break142_g32370.r;
			half Input_Speed62_g32301 = _MotionSpeed_10;
			float mulTime373_g32301 = _Time.y * Input_Speed62_g32301;
			float4x4 break19_g32318 = unity_ObjectToWorld;
			float3 appendResult20_g32318 = (float3(break19_g32318[ 0 ][ 3 ] , break19_g32318[ 1 ][ 3 ] , break19_g32318[ 2 ][ 3 ]));
			half3 Off19_g32319 = appendResult20_g32318;
			float4 transform68_g32318 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 appendResult95_g32318 = (float3(v.texcoord.z , 0.0 , v.texcoord.w));
			float4 transform62_g32318 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult95_g32318 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g32318 = ( (transform68_g32318).xyz - (transform62_g32318).xyz );
			half3 On20_g32319 = ObjectPositionWithPivots28_g32318;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g32319 = On20_g32319;
			#else
				float3 staticSwitch14_g32319 = Off19_g32319;
			#endif
			half3 ObjectData20_g32320 = staticSwitch14_g32319;
			half3 WorldData19_g32320 = Off19_g32319;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g32320 = WorldData19_g32320;
			#else
				float3 staticSwitch14_g32320 = ObjectData20_g32320;
			#endif
			float3 temp_output_42_0_g32318 = staticSwitch14_g32320;
			float3 break9_g32318 = temp_output_42_0_g32318;
			half Variation_Complex102_g32315 = frac( ( v.color.r + ( break9_g32318.x + break9_g32318.z ) ) );
			float ObjectData20_g32317 = Variation_Complex102_g32315;
			half Variation_Simple105_g32315 = v.color.r;
			float WorldData19_g32317 = Variation_Simple105_g32315;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g32317 = WorldData19_g32317;
			#else
				float staticSwitch14_g32317 = ObjectData20_g32317;
			#endif
			half Variation3073_g32155 = staticSwitch14_g32317;
			half Motion_Variation284_g32301 = ( _MotionVariation_10 * Variation3073_g32155 );
			float2 appendResult344_g32301 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 Motion_Scale287_g32301 = ( _MotionScale_10 * appendResult344_g32301 );
			half2 Sine_MinusOneToOne281_g32301 = sin( ( mulTime373_g32301 + Motion_Variation284_g32301 + Motion_Scale287_g32301 ) );
			float2 temp_cast_11 = (1.0).xx;
			half Input_Turbulence327_g32301 = Global_NoiseTex_R34_g32155;
			float2 lerpResult321_g32301 = lerp( Sine_MinusOneToOne281_g32301 , temp_cast_11 , Input_Turbulence327_g32301);
			half2 Motion_Bending2258_g32155 = ( ( _MotionAmplitude_10 * Motion_Max_Bending1133_g32155 ) * Wind_Power_103106_g32155 * Wind_DirectionOS39_g32155 * Motion_Use1056_g32155 * Global_NoiseTex_R34_g32155 * lerpResult321_g32301 );
			half Motion_UseInteraction2097_g32155 = _Motion_Interaction;
			half Motion_InteractionMask66_g32155 = break322_g32350.w;
			float lerpResult3307_g32155 = lerp( 1.0 , Variation3073_g32155 , _InteractionVariation);
			half2 Motion_Interaction53_g32155 = ( _InteractionAmplitude * Motion_Max_Bending1133_g32155 * Motion_UseInteraction2097_g32155 * Motion_InteractionMask66_g32155 * Motion_InteractionMask66_g32155 * Wind_DirectionOS39_g32155 * lerpResult3307_g32155 );
			float2 lerpResult109_g32155 = lerp( Motion_Bending2258_g32155 , Motion_Interaction53_g32155 , Motion_InteractionMask66_g32155);
			half Mesh_Motion_182_g32155 = v.texcoord3.x;
			float2 break143_g32155 = ( lerpResult109_g32155 * Mesh_Motion_182_g32155 );
			half Motion_Z190_g32155 = break143_g32155.y;
			half Angle44_g32302 = Motion_Z190_g32155;
			half3 VertexPos40_g32282 = ( VertexPosRotationAxis50_g32302 + ( VertexPosOtherAxis82_g32302 * cos( Angle44_g32302 ) ) + ( cross( float3(1,0,0) , VertexPosOtherAxis82_g32302 ) * sin( Angle44_g32302 ) ) );
			float3 appendResult74_g32282 = (float3(0.0 , 0.0 , VertexPos40_g32282.z));
			half3 VertexPosRotationAxis50_g32282 = appendResult74_g32282;
			float3 break84_g32282 = VertexPos40_g32282;
			float3 appendResult81_g32282 = (float3(break84_g32282.x , break84_g32282.y , 0.0));
			half3 VertexPosOtherAxis82_g32282 = appendResult81_g32282;
			half Motion_X216_g32155 = break143_g32155.x;
			half Angle44_g32282 = -Motion_X216_g32155;
			half Wind_Mode3167_g32155 = TVE_WindMode;
			float3 lerpResult3168_g32155 = lerp( ase_vertex3Pos , ( VertexPosRotationAxis50_g32282 + ( VertexPosOtherAxis82_g32282 * cos( Angle44_g32282 ) ) + ( cross( float3(0,0,1) , VertexPosOtherAxis82_g32282 ) * sin( Angle44_g32282 ) ) ) , Wind_Mode3167_g32155);
			float3 Vertex_Motion_Object833_g32155 = lerpResult3168_g32155;
			float3 appendResult2043_g32155 = (float3(Motion_X216_g32155 , 0.0 , Motion_Z190_g32155));
			float3 lerpResult3173_g32155 = lerp( ase_vertex3Pos , ( ase_vertex3Pos + appendResult2043_g32155 ) , Wind_Mode3167_g32155);
			float3 Vertex_Motion_World1118_g32155 = lerpResult3173_g32155;
			float3 temp_output_3331_0_g32155 = ( ( _VertexCat * _VertexMotionSpace * _VertexMotionMode * _VertexDataMode ) + Vertex_Motion_World1118_g32155 );
			#if defined(TVE_VERTEX_DATA_OBJECT)
				float3 staticSwitch3312_g32155 = Vertex_Motion_Object833_g32155;
			#elif defined(TVE_VERTEX_DATA_WORLD)
				float3 staticSwitch3312_g32155 = temp_output_3331_0_g32155;
			#elif defined(TVE_VERTEX_DATA_BATCHED)
				float3 staticSwitch3312_g32155 = temp_output_3331_0_g32155;
			#else
				float3 staticSwitch3312_g32155 = Vertex_Motion_Object833_g32155;
			#endif
			half3 ObjectData20_g32349 = staticSwitch3312_g32155;
			half3 WorldData19_g32349 = Vertex_Motion_World1118_g32155;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g32349 = WorldData19_g32349;
			#else
				float3 staticSwitch14_g32349 = ObjectData20_g32349;
			#endif
			float4x4 break19_g32365 = unity_ObjectToWorld;
			float3 appendResult20_g32365 = (float3(break19_g32365[ 0 ][ 3 ] , break19_g32365[ 1 ][ 3 ] , break19_g32365[ 2 ][ 3 ]));
			half3 Off19_g32366 = appendResult20_g32365;
			float4 transform68_g32365 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 appendResult93_g32365 = (float3(v.texcoord.z , v.texcoord3.w , v.texcoord.w));
			float4 transform62_g32365 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult93_g32365 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g32365 = ( (transform68_g32365).xyz - (transform62_g32365).xyz );
			half3 On20_g32366 = ObjectPositionWithPivots28_g32365;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g32366 = On20_g32366;
			#else
				float3 staticSwitch14_g32366 = Off19_g32366;
			#endif
			half3 ObjectData20_g32367 = staticSwitch14_g32366;
			half3 WorldData19_g32367 = Off19_g32366;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g32367 = WorldData19_g32367;
			#else
				float3 staticSwitch14_g32367 = ObjectData20_g32367;
			#endif
			float3 temp_output_42_0_g32365 = staticSwitch14_g32367;
			float temp_output_7_0_g32284 = TVE_SizeFadeEnd;
			float ObjectData20_g32364 = saturate( ( ( ( distance( _WorldSpaceCameraPos , temp_output_42_0_g32365 ) * _GlobalSizeFade ) - temp_output_7_0_g32284 ) / ( TVE_SizeFadeStart - temp_output_7_0_g32284 ) ) );
			float WorldData19_g32364 = 1.0;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g32364 = WorldData19_g32364;
			#else
				float staticSwitch14_g32364 = ObjectData20_g32364;
			#endif
			float Vertex_SizeFade1740_g32155 = staticSwitch14_g32364;
			float4x4 break19_g32355 = unity_ObjectToWorld;
			float3 appendResult20_g32355 = (float3(break19_g32355[ 0 ][ 3 ] , break19_g32355[ 1 ][ 3 ] , break19_g32355[ 2 ][ 3 ]));
			half3 Off19_g32356 = appendResult20_g32355;
			float4 transform68_g32355 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 appendResult95_g32355 = (float3(v.texcoord.z , 0.0 , v.texcoord.w));
			float4 transform62_g32355 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult95_g32355 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g32355 = ( (transform68_g32355).xyz - (transform62_g32355).xyz );
			half3 On20_g32356 = ObjectPositionWithPivots28_g32355;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g32356 = On20_g32356;
			#else
				float3 staticSwitch14_g32356 = Off19_g32356;
			#endif
			half3 ObjectData20_g32357 = staticSwitch14_g32356;
			half3 WorldData19_g32357 = Off19_g32356;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g32357 = WorldData19_g32357;
			#else
				float3 staticSwitch14_g32357 = ObjectData20_g32357;
			#endif
			float3 temp_output_42_0_g32355 = staticSwitch14_g32357;
			half3 ObjectData20_g32354 = temp_output_42_0_g32355;
			half3 WorldData19_g32354 = ase_worldPos;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g32354 = WorldData19_g32354;
			#else
				float3 staticSwitch14_g32354 = ObjectData20_g32354;
			#endif
			float2 temp_output_43_38_g32352 = ( (TVE_VolumeCoord).zw + ( (TVE_VolumeCoord).xy * (staticSwitch14_g32354).xz ) );
			half4 Legacy33_g32353 = SAMPLE_TEXTURE2D_LOD( TVE_ExtrasTex, samplerTVE_ExtrasTex, temp_output_43_38_g32352, 0.0 );
			half4 Vegetation33_g32353 = SAMPLE_TEXTURE2D_LOD( TVE_ExtrasTex_Vegetation, samplerTVE_ExtrasTex_Vegetation, temp_output_43_38_g32352, 0.0 );
			half4 Grass33_g32353 = SAMPLE_TEXTURE2D_LOD( TVE_ExtrasTex_Grass, samplerTVE_ExtrasTex_Grass, temp_output_43_38_g32352, 0.0 );
			half4 Objects33_g32353 = SAMPLE_TEXTURE2D_LOD( TVE_ExtrasTex_Objects, samplerTVE_ExtrasTex_Objects, temp_output_43_38_g32352, 0.0 );
			half4 Custom33_g32353 = SAMPLE_TEXTURE2D_LOD( TVE_ExtrasTex_User, samplerTVE_ExtrasTex_User, temp_output_43_38_g32352, 0.0 );
			half4 localUSE_BUFFERS33_g32353 = USE_BUFFERS( Legacy33_g32353 , Vegetation33_g32353 , Grass33_g32353 , Objects33_g32353 , Custom33_g32353 );
			float4 break49_g32352 = localUSE_BUFFERS33_g32353;
			half Global_ExtrasTex_G305_g32155 = break49_g32352.y;
			float lerpResult346_g32155 = lerp( 1.0 , Global_ExtrasTex_G305_g32155 , _GlobalSize);
			float ObjectData20_g32363 = ( lerpResult346_g32155 * _LocalSize );
			float WorldData19_g32363 = 1.0;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g32363 = WorldData19_g32363;
			#else
				float staticSwitch14_g32363 = ObjectData20_g32363;
			#endif
			half Vertex_Size1741_g32155 = staticSwitch14_g32363;
			half3 Grass_Coverage2661_g32155 = half3(0,0,0);
			float3 Final_VertexPosition890_g32155 = ( ( staticSwitch14_g32349 * Vertex_SizeFade1740_g32155 * Vertex_Size1741_g32155 ) + Mesh_PivotsOS2291_g32155 + Grass_Coverage2661_g32155 );
			v.vertex.xyz = Final_VertexPosition890_g32155;
			v.vertex.w = 1;
			half2 Noise_UVs3274_g32155 = ( (ase_worldPos).xz * ( ( _NoiseScaleValue * 0.1 ) + _MoiseCat ) );
			float temp_output_7_0_g32311 = _NoiseMinValue;
			half Noise_Mask3162_g32155 = saturate( ( ( SAMPLE_TEXTURE2D_LOD( _NoiseTex, sampler_NoiseTex, Noise_UVs3274_g32155, 0.0 ).r - temp_output_7_0_g32311 ) / ( _NoiseMaxValue - temp_output_7_0_g32311 ) ) );
			float4 lerpResult2800_g32155 = lerp( _NoiseTintTwo , _NoiseTintOne , Noise_Mask3162_g32155);
			half3 Noise_Tint2802_g32155 = (lerpResult2800_g32155).rgb;
			o.vertexToFrag3225_g32155 = Noise_Tint2802_g32155;
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
			half2 Main_UVs15_g32155 = ( ( i.uv_texcoord * (_MainUVs).xy ) + (_MainUVs).zw );
			float4 tex2DNode117_g32155 = SAMPLE_TEXTURE2D( _MainNormalTex, sampler_MainAlbedoTex, Main_UVs15_g32155 );
			float2 appendResult88_g32286 = (float2(tex2DNode117_g32155.a , tex2DNode117_g32155.g));
			float2 temp_output_90_0_g32286 = ( (appendResult88_g32286*2.0 + -1.0) * _MainNormalValue );
			float3 appendResult91_g32286 = (float3(temp_output_90_0_g32286 , 1.0));
			half3 Main_Normal137_g32155 = appendResult91_g32286;
			float3 temp_output_13_0_g32309 = Main_Normal137_g32155;
			float3 switchResult12_g32309 = (((i.ASEVFace>0)?(temp_output_13_0_g32309):(( temp_output_13_0_g32309 * _render_normals_options ))));
			half3 Blend_Normal312_g32155 = switchResult12_g32309;
			half3 Final_Normal366_g32155 = Blend_Normal312_g32155;
			o.Normal = Final_Normal366_g32155;
			float temp_output_7_0_g32307 = _GradientMinValue;
			float4 lerpResult2779_g32155 = lerp( _GradientColorTwo , _GradientColorOne , saturate( ( ( i.vertexColor.a - temp_output_7_0_g32307 ) / ( ( _GradientMaxValue + _GradientCat ) - temp_output_7_0_g32307 ) ) ));
			half3 Gradient_Tint2784_g32155 = (lerpResult2779_g32155).rgb;
			float4 tex2DNode29_g32155 = SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, Main_UVs15_g32155 );
			float4 temp_output_51_0_g32155 = ( _MainColor * tex2DNode29_g32155 );
			half3 Main_AlbedoRaw99_g32155 = (temp_output_51_0_g32155).rgb;
			half3 Main_AlbedoTinted2808_g32155 = ( Gradient_Tint2784_g32155 * i.vertexToFrag3225_g32155 * Main_AlbedoRaw99_g32155 * float3(1,1,1) );
			float4x4 break19_g32334 = unity_ObjectToWorld;
			float3 appendResult20_g32334 = (float3(break19_g32334[ 0 ][ 3 ] , break19_g32334[ 1 ][ 3 ] , break19_g32334[ 2 ][ 3 ]));
			half3 Off19_g32335 = appendResult20_g32334;
			float4 ase_vertex4Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float4 transform68_g32334 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float3 appendResult95_g32334 = (float3(i.uv_tex4coord.z , 0.0 , i.uv_tex4coord.w));
			float4 transform62_g32334 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult95_g32334 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g32334 = ( (transform68_g32334).xyz - (transform62_g32334).xyz );
			half3 On20_g32335 = ObjectPositionWithPivots28_g32334;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g32335 = On20_g32335;
			#else
				float3 staticSwitch14_g32335 = Off19_g32335;
			#endif
			half3 ObjectData20_g32336 = staticSwitch14_g32335;
			half3 WorldData19_g32336 = Off19_g32335;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g32336 = WorldData19_g32336;
			#else
				float3 staticSwitch14_g32336 = ObjectData20_g32336;
			#endif
			float3 temp_output_42_0_g32334 = staticSwitch14_g32336;
			half3 ObjectData20_g32340 = temp_output_42_0_g32334;
			float3 ase_worldPos = i.worldPos;
			half3 WorldData19_g32340 = ase_worldPos;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g32340 = WorldData19_g32340;
			#else
				float3 staticSwitch14_g32340 = ObjectData20_g32340;
			#endif
			float2 temp_output_35_38_g32333 = ( (TVE_VolumeCoord).zw + ( (TVE_VolumeCoord).xy * (staticSwitch14_g32340).xz ) );
			half4 Legacy33_g32339 = SAMPLE_TEXTURE2D( TVE_ColorsTex, samplerTVE_ColorsTex, temp_output_35_38_g32333 );
			half4 Vegetation33_g32339 = SAMPLE_TEXTURE2D( TVE_ColorsTex_Vegetation, samplerTVE_ColorsTex_Vegetation, temp_output_35_38_g32333 );
			half4 Grass33_g32339 = SAMPLE_TEXTURE2D( TVE_ColorsTex_Grass, samplerTVE_ColorsTex_Grass, temp_output_35_38_g32333 );
			half4 Objects33_g32339 = SAMPLE_TEXTURE2D( TVE_ColorsTex_Objects, samplerTVE_ColorsTex_Objects, temp_output_35_38_g32333 );
			half4 Custom33_g32339 = SAMPLE_TEXTURE2D( TVE_ColorsTex_User, samplerTVE_ColorsTex_User, temp_output_35_38_g32333 );
			half4 localUSE_BUFFERS33_g32339 = USE_BUFFERS( Legacy33_g32339 , Vegetation33_g32339 , Grass33_g32339 , Objects33_g32339 , Custom33_g32339 );
			float4 temp_output_45_0_g32333 = localUSE_BUFFERS33_g32339;
			half3 Global_ColorsTex_RGB1700_g32155 = (temp_output_45_0_g32333).xyz;
			#ifdef UNITY_COLORSPACE_GAMMA
				float staticSwitch1_g32304 = 2.0;
			#else
				float staticSwitch1_g32304 = 4.594794;
			#endif
			float4 tex2DNode35_g32155 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainAlbedoTex, Main_UVs15_g32155 );
			half Main_Mask_Raw57_g32155 = tex2DNode35_g32155.b;
			float temp_output_7_0_g32378 = _MainMaskMinValue;
			half Main_Mask_Remap3201_g32155 = saturate( ( ( Main_Mask_Raw57_g32155 - temp_output_7_0_g32378 ) / ( _MainMaskMaxValue - temp_output_7_0_g32378 ) ) );
			float lerpResult2105_g32155 = lerp( 1.0 , Main_Mask_Remap3201_g32155 , _ColorsMaskValue);
			float3 lerpResult108_g32155 = lerp( float3( 1,1,1 ) , ( (_LocalColors).rgb * ( Global_ColorsTex_RGB1700_g32155 * staticSwitch1_g32304 ) ) , ( _GlobalColors * lerpResult2105_g32155 ));
			half3 Global_Colors1954_g32155 = lerpResult108_g32155;
			float3 temp_output_123_0_g32155 = ( Main_AlbedoTinted2808_g32155 * Global_Colors1954_g32155 );
			half3 Main_AlbedoColored863_g32155 = temp_output_123_0_g32155;
			half3 Blend_Albedo265_g32155 = Main_AlbedoColored863_g32155;
			float3 lerpResult2929_g32155 = lerp( float3( 1,1,1 ) , (TVE_MainLightParams).rgb , _SubsurfaceLightValue);
			half3 Subsurface_Color1722_g32155 = ( (_SubsurfaceColor).rgb * lerpResult2929_g32155 );
			half Global_ColorsTex_A1701_g32155 = (temp_output_45_0_g32333).w;
			float lerpResult1720_g32155 = lerp( 1.0 , Global_ColorsTex_A1701_g32155 , _GlobalHealthiness);
			half Subsurface_Intensity1752_g32155 = ( ( _SubsurfaceValue * lerpResult1720_g32155 ) + _SubsurfaceCat );
			float lerpResult3210_g32155 = lerp( 1.0 , Main_Mask_Remap3201_g32155 , _SubsurfaceMaskValue);
			half Subsurface_Mask1557_g32155 = lerpResult3210_g32155;
			half3 Subsurface_Transmission884_g32155 = ( Subsurface_Color1722_g32155 * Subsurface_Intensity1752_g32155 * Subsurface_Mask1557_g32155 );
			float3 normalizeResult1983_g32155 = normalize( ( _WorldSpaceCameraPos - ase_worldPos ) );
			float dotResult785_g32155 = dot( -TVE_MainLightDirection , normalizeResult1983_g32155 );
			float saferPower1624_g32155 = max( (dotResult785_g32155*0.5 + 0.5) , 0.0001 );
			#ifdef UNITY_PASS_FORWARDADD
				float staticSwitch1602_g32155 = 0.0;
			#else
				float staticSwitch1602_g32155 = ( pow( saferPower1624_g32155 , _SubsurfaceAngleValue ) * _SubsurfaceViewValue );
			#endif
			half Mask_Subsurface_View782_g32155 = staticSwitch1602_g32155;
			half3 Subsurface_Forward1691_g32155 = ( Subsurface_Transmission884_g32155 * Mask_Subsurface_View782_g32155 );
			half3 Blend_AlbedoAndSubsurface149_g32155 = ( Blend_Albedo265_g32155 + Subsurface_Forward1691_g32155 );
			half3 Global_OverlayColor1758_g32155 = (TVE_OverlayColor).rgb;
			float2 break93_g32286 = temp_output_90_0_g32286;
			half Main_NormalY2095_g32155 = break93_g32286.y;
			half Overlay_Contrast1405_g32155 = _OverlayContrastValue;
			half Global_OverlayIntensity154_g32155 = TVE_OverlayIntensity;
			float4x4 break19_g32355 = unity_ObjectToWorld;
			float3 appendResult20_g32355 = (float3(break19_g32355[ 0 ][ 3 ] , break19_g32355[ 1 ][ 3 ] , break19_g32355[ 2 ][ 3 ]));
			half3 Off19_g32356 = appendResult20_g32355;
			float4 transform68_g32355 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 appendResult95_g32355 = (float3(i.uv_tex4coord.z , 0.0 , i.uv_tex4coord.w));
			float4 transform62_g32355 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult95_g32355 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g32355 = ( (transform68_g32355).xyz - (transform62_g32355).xyz );
			half3 On20_g32356 = ObjectPositionWithPivots28_g32355;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g32356 = On20_g32356;
			#else
				float3 staticSwitch14_g32356 = Off19_g32356;
			#endif
			half3 ObjectData20_g32357 = staticSwitch14_g32356;
			half3 WorldData19_g32357 = Off19_g32356;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g32357 = WorldData19_g32357;
			#else
				float3 staticSwitch14_g32357 = ObjectData20_g32357;
			#endif
			float3 temp_output_42_0_g32355 = staticSwitch14_g32357;
			half3 ObjectData20_g32354 = temp_output_42_0_g32355;
			half3 WorldData19_g32354 = ase_worldPos;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g32354 = WorldData19_g32354;
			#else
				float3 staticSwitch14_g32354 = ObjectData20_g32354;
			#endif
			float2 temp_output_43_38_g32352 = ( (TVE_VolumeCoord).zw + ( (TVE_VolumeCoord).xy * (staticSwitch14_g32354).xz ) );
			half4 Legacy33_g32353 = SAMPLE_TEXTURE2D( TVE_ExtrasTex, samplerTVE_ExtrasTex, temp_output_43_38_g32352 );
			half4 Vegetation33_g32353 = SAMPLE_TEXTURE2D( TVE_ExtrasTex_Vegetation, samplerTVE_ExtrasTex_Vegetation, temp_output_43_38_g32352 );
			half4 Grass33_g32353 = SAMPLE_TEXTURE2D( TVE_ExtrasTex_Grass, samplerTVE_ExtrasTex_Grass, temp_output_43_38_g32352 );
			half4 Objects33_g32353 = SAMPLE_TEXTURE2D( TVE_ExtrasTex_Objects, samplerTVE_ExtrasTex_Objects, temp_output_43_38_g32352 );
			half4 Custom33_g32353 = SAMPLE_TEXTURE2D( TVE_ExtrasTex_User, samplerTVE_ExtrasTex_User, temp_output_43_38_g32352 );
			half4 localUSE_BUFFERS33_g32353 = USE_BUFFERS( Legacy33_g32353 , Vegetation33_g32353 , Grass33_g32353 , Objects33_g32353 , Custom33_g32353 );
			float4 break49_g32352 = localUSE_BUFFERS33_g32353;
			half Global_ExtrasTex_B156_g32155 = break49_g32352.z;
			float temp_output_1025_0_g32155 = ( Global_OverlayIntensity154_g32155 * _GlobalOverlay * Global_ExtrasTex_B156_g32155 );
			half Overlay_Commons1365_g32155 = temp_output_1025_0_g32155;
			half Overlay_Mask269_g32155 = saturate( ( saturate( ( i.vertexColor.a + ( Main_NormalY2095_g32155 * Overlay_Contrast1405_g32155 ) ) ) - ( 1.0 - Overlay_Commons1365_g32155 ) ) );
			float3 lerpResult336_g32155 = lerp( Blend_AlbedoAndSubsurface149_g32155 , Global_OverlayColor1758_g32155 , Overlay_Mask269_g32155);
			half3 Final_Albedo359_g32155 = lerpResult336_g32155;
			half Main_Alpha316_g32155 = (temp_output_51_0_g32155).a;
			float lerpResult354_g32155 = lerp( 1.0 , Main_Alpha316_g32155 , _render_premul);
			half Final_Premultiply355_g32155 = lerpResult354_g32155;
			float3 temp_output_410_0_g32155 = ( Final_Albedo359_g32155 * Final_Premultiply355_g32155 );
			o.Albedo = temp_output_410_0_g32155;
			half Main_Smoothness227_g32155 = ( tex2DNode35_g32155.a * _MainSmoothnessValue );
			half Blend_Smoothness314_g32155 = Main_Smoothness227_g32155;
			half Global_OverlaySmoothness311_g32155 = TVE_OverlaySmoothness;
			float lerpResult343_g32155 = lerp( Blend_Smoothness314_g32155 , Global_OverlaySmoothness311_g32155 , Overlay_Mask269_g32155);
			half Final_Smoothness371_g32155 = lerpResult343_g32155;
			half Global_Wetness1016_g32155 = ( TVE_Wetness * _GlobalWetness );
			half Global_ExtrasTex_A1033_g32155 = break49_g32352.w;
			float lerpResult1037_g32155 = lerp( Final_Smoothness371_g32155 , saturate( ( Final_Smoothness371_g32155 + Global_Wetness1016_g32155 ) ) , Global_ExtrasTex_A1033_g32155);
			o.Smoothness = lerpResult1037_g32155;
			float lerpResult240_g32155 = lerp( 1.0 , tex2DNode35_g32155.g , _MainOcclusionValue);
			half Main_Occlusion247_g32155 = lerpResult240_g32155;
			half Blend_Occlusion323_g32155 = Main_Occlusion247_g32155;
			o.Occlusion = Blend_Occlusion323_g32155;
			o.Transmission = Subsurface_Transmission884_g32155;
			o.Alpha = Main_Alpha316_g32155;
			half Main_AlphaRaw1203_g32155 = tex2DNode29_g32155.a;
			float3 normalizeResult2169_g32155 = normalize( ( _WorldSpaceCameraPos - ase_worldPos ) );
			float dotResult2161_g32155 = dot( normalizeResult2169_g32155 , (WorldNormalVector( i , half3(0.001,0.001,1) )) );
			float3 normalizeResult2210_g32155 = normalize( ( _WorldSpaceCameraPos - ase_worldPos ) );
			float dotResult2212_g32155 = dot( normalizeResult2210_g32155 , float3(0,1,0) );
			half Mask_HView2656_g32155 = abs( dotResult2212_g32155 );
			float lerpResult2221_g32155 = lerp( _BillboardFadeHValue , _BillboardFadeVValue , Mask_HView2656_g32155);
			half Billboard_Fade2175_g32155 = ( pow( ( dotResult2161_g32155 * dotResult2161_g32155 ) , lerpResult2221_g32155 ) + _BillboardCat );
			half Alpha5_g32314 = ( Main_AlphaRaw1203_g32155 * Billboard_Fade2175_g32155 );
			#ifdef _ALPHATEST_ON
				float staticSwitch2_g32314 = Alpha5_g32314;
			#else
				float staticSwitch2_g32314 = 1.0;
			#endif
			half Final_Clip914_g32155 = staticSwitch2_g32314;
			clip( Final_Clip914_g32155 - _render_cutoff );
		}

		ENDCG
		CGPROGRAM
		#pragma exclude_renderers d3d9 d3d11_9x gles 
		#pragma surface surf StandardCustom keepalpha fullforwardshadows exclude_path:deferred nodynlightmap dithercrossfade vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
		#pragma multi_compile_instancing
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 customPack2 : TEXCOORD2;
				float4 customPack3 : TEXCOORD3;
				float4 tSpace0 : TEXCOORD4;
				float4 tSpace1 : TEXCOORD5;
				float4 tSpace2 : TEXCOORD6;
				half4 color : COLOR0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.customPack2.xyz = customInputData.vertexToFrag3225_g32155;
				o.customPack3.xyzw = customInputData.uv_tex4coord;
				o.customPack3.xyzw = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.color = v.color;
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				surfIN.vertexToFrag3225_g32155 = IN.customPack2.xyz;
				surfIN.uv_tex4coord = IN.customPack3.xyzw;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				surfIN.vertexColor = IN.color;
				SurfaceOutputStandardCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandardCustom, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "TVEShaderCoreGUI"
}
/*ASEBEGIN
Version=18600
1927;1;1906;1020;2719.203;1027.363;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;17;-1344,-768;Half;False;Property;_render_zw;_render_zw;212;1;[HideInInspector];Create;True;2;Opaque;0;Transparent;1;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;268;-1392,-896;Half;False;Property;_IsForwardPathShader;_IsForwardPathShader;206;1;[HideInInspector];Create;True;0;0;True;0;False;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;81;-1984,-896;Half;False;Property;_IsCrossShader;_IsCrossShader;207;1;[HideInInspector];Create;True;0;0;True;0;False;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;364;-2176,-384;Inherit;False;Base Shader;1;;32155;856f7164d1c579d43a5cf4968a75ca43;50,1300,1,1298,1,1271,0,1962,1,1708,1,1712,3,1964,1,1969,1,1719,1,893,0,1745,1,1742,1,1718,1,1714,1,1715,1,1717,1,916,0,1949,1,1763,0,1762,0,1776,0,1646,1,1690,0,1757,0,3221,3,1981,0,2807,1,2953,1,3243,0,2172,1,2658,0,1734,0,1733,0,1735,0,1736,0,1966,0,1968,0,1737,0,878,0,1550,0,860,1,2750,0,2261,1,2260,1,2054,0,2032,0,2060,0,2036,0,2062,0,2039,0;0;15;FLOAT3;0;FLOAT3;528;FLOAT3;2489;FLOAT;529;FLOAT;530;FLOAT;531;FLOAT;1235;FLOAT3;1230;FLOAT;1461;FLOAT;1290;FLOAT;721;FLOAT;532;FLOAT;653;FLOAT;629;FLOAT3;534
Node;AmplifyShaderEditor.FunctionNode;354;-2176,256;Inherit;False;Use TVE_IS_VEGETATION_SHADER;-1;;32154;b458122dd75182d488380bd0f592b9e6;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;141;-1568,-896;Half;False;Property;_IsLitShader;_IsLitShader;205;1;[HideInInspector];Create;True;0;0;True;0;False;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1536,-768;Half;False;Property;_render_dst;_render_dst;211;1;[HideInInspector];Create;True;2;Opaque;0;Transparent;1;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1728,-769;Half;False;Property;_render_src;_render_src;210;1;[HideInInspector];Create;True;0;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-2176,-896;Half;False;Property;_Banner;Banner;0;0;Create;True;0;0;True;1;StyledBanner(Cross Subsurface Lit);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;129;-1792,-896;Half;False;Property;_IsStandardShader;_IsStandardShader;204;1;[HideInInspector];Create;True;0;0;True;0;False;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1920,-768;Half;False;Property;_render_cull;_render_cull;209;1;[HideInInspector];Create;True;3;Both;0;Back;1;Front;2;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-2176,-767;Half;False;Property;_render_cutoff;_render_cutoff;208;1;[HideInInspector];Create;True;4;Alpha;0;Premultiply;1;Additive;2;Multiply;3;0;True;0;False;0.5;0.719;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-1376,-384;Float;False;True;-1;2;TVEShaderCoreGUI;0;0;Standard;BOXOPHOBIC/The Vegetation Engine/Vegetation/Cross Subsurface Lit;False;False;False;False;False;False;False;True;False;False;False;False;True;True;True;False;True;False;False;False;False;Back;0;True;17;0;False;-1;False;0;False;-1;-10;False;-1;False;0;Custom;0.719;True;True;0;True;Opaque;;Geometry;ForwardOnly;11;d3d11;glcore;gles3;metal;vulkan;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;1;0;True;20;0;True;7;0;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Absolute;0;;-1;-1;-1;-1;0;False;0;0;True;10;-1;0;True;21;0;0;0;False;0.1;False;-1;0;False;-1;True;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;33;-2176,-512;Inherit;False;1024.392;100;Final;0;;0,1,0.5,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;266;-2176,128;Inherit;False;1026.438;100;Features;0;;0,1,0.5,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;37;-2176,-1024;Inherit;False;1023.392;100;Internal;0;;1,0.252,0,1;0;0
WireConnection;0;0;364;0
WireConnection;0;1;364;528
WireConnection;0;4;364;530
WireConnection;0;5;364;531
WireConnection;0;6;364;1230
WireConnection;0;9;364;532
WireConnection;0;10;364;653
WireConnection;0;11;364;534
ASEEND*/
//CHKSM=5362134885C7918759D04307CF39214FE920845E
