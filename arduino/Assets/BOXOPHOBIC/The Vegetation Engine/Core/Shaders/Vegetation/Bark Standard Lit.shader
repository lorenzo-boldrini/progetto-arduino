// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Vegetation Engine/Vegetation/Bark Standard Lit"
{
	Properties
	{
		[StyledBanner(Bark Standard Lit)]_Banner("Banner", Float) = 0
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
		_GlobalOverlay("Global Overlay", Range( 0 , 1)) = 1
		_GlobalWetness("Global Wetness", Range( 0 , 1)) = 1
		_GlobalSize("Global Size", Range( 0 , 1)) = 1
		_GlobalSizeFade("Global Size Fade", Range( 0 , 1)) = 0
		[StyledSpace(10)]_GlobalSpace("# Global Space", Float) = 0
		[HideInInspector]_LocalSize("Local Size", Range( 0 , 1)) = 1
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
		[StyledCategory(Detail Settings)]_DetailCat("[ Detail Cat ]", Float) = 0
		[Enum(Off,0,Overlay,1,Replace,2)]_DetailMode("Detail Mode", Float) = 0
		[Enum(Vertex Paint,0,Projection,1)]_DetailTypeMode("Detail Type", Float) = 0
		[Enum(Standard,0,Packed,1)]_DetailMapsMode("Detail Maps", Float) = 0
		[Enum(Main Mask,0,Detail Mask,1)]_DetailMaskMode("Detail Mask", Float) = 0
		[StyledSpace(10)]_DetailSpace("# Detail Space", Float) = 0
		[NoScaleOffset]_SecondPackedTex("Detail Packed", 2D) = "white" {}
		[NoScaleOffset]_SecondAlbedoTex("Detail Albedo", 2D) = "white" {}
		[NoScaleOffset]_SecondNormalTex("Detail Normal", 2D) = "gray" {}
		[NoScaleOffset]_SecondMaskTex("Detail Mask", 2D) = "white" {}
		[Space(10)]_SecondUVs("Detail UVs", Vector) = (1,1,0,0)
		[HDR]_SecondColor("Detail Color", Color) = (1,1,1,1)
		_SecondNormalValue("Detail Normal", Range( -8 , 8)) = 1
		_SecondOcclusionValue("Detail Occlusion", Range( 0 , 1)) = 1
		_SecondSmoothnessValue("Detail Smoothness", Range( 0 , 1)) = 1
		[Space(10)]_DetailNormalValue("Detail Use Main Normal", Range( 0 , 1)) = 0.5
		[Space(10)]_DetailMeshValue("Detail Mask Offset", Range( -1 , 1)) = 0
		_DetailMaskValue("Detail Mask Power", Range( -1 , 1)) = 0
		_DetailMaskContrast("Detail Mask Contrast", Range( 0 , 1)) = 0.25
		[StyledCategory(Occlusion Settings)]_OcclusionCat("[ Occlusion Cat ]", Float) = 0
		[HDR]_VertexOcclusionColor("Vertex Occlusion Color", Color) = (0,0,0,0)
		_VertexOcclusionValue("Vertex Occlusion Power", Range( 0 , 8)) = 0
		[HideInInspector][ASEDiffusionProfile(_SubsurfaceDiffusion)]_SubsurfaceDiffusion_asset("Subsurface Diffusion", Vector) = (0,0,0,0)
		[StyledCategory(Vertex Settings)]_VertexCat("[ Vertex Cat ]", Float) = 0
		[StyledMessage(Info, The Object motion feature allows for high quality bending motion and interaction. The motion and global elements are calculated per instance., _VertexMotionMode, 0 , 2, 0)]_ObjectDataMessage("# Object Data Message", Float) = 0
		[StyledMessage(Info, The World motion feature allows for simpler and cheaper translation motion and interaction. The motion is calculated in world space but the global elements are calculated per instance., _VertexMotionMode, 1 , 2, 0)]_WorldDataMessage("# World Data Message", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[StyledMessage(Info, The Baked pivots feature allows for using per mesh element interaction and elements influence. This feature requires pre baked pivots on prefab conversion. Useful for latge grass meshes., _VertexPivotMode, 1 , 0, 0)]_PivotsMessage("# Pivots Message", Float) = 0
		[Enum(Object,0,World,1)][Space(10)]_VertexMotionMode("Vertex Motion", Float) = 0
		[StyledSpace(10)]_VertexMotionSpace("# Vertex Motion Space", Float) = 0
		_Motion_10("Motion Bending", Range( 0 , 1)) = 1
		_Motion_20("Motion Rolling", Range( 0 , 1)) = 1
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
		[HideInInspector]_IsBarkShader("_IsBarkShader", Float) = 1
		[HideInInspector]_IsAnyPathShader("_IsAnyPathShader", Float) = 1
		[HideInInspector]_IsLitShader("_IsLitShader", Float) = 1
		[HideInInspector]_IsStandardShader("_IsStandardShader", Float) = 1
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
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma multi_compile_instancing
		#pragma shader_feature_local _ALPHATEST_ON
		#pragma shader_feature_local TVE_VERTEX_DATA_OBJECT TVE_VERTEX_DATA_WORLD TVE_VERTEX_DATA_BATCHED
		#pragma shader_feature_local TVE_DETAIL_MODE_OFF TVE_DETAIL_MODE_OVERLAY TVE_DETAIL_MODE_REPLACE
		#pragma shader_feature_local TVE_DETAIL_MAPS_STANDARD TVE_DETAIL_MAPS_PACKED
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
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows nodynlightmap dithercrossfade vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			float4 uv_tex4coord;
			float4 vertexColor : COLOR;
			half ASEVFace : VFACE;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform half _IsAnyPathShader;
		uniform half _IsStandardShader;
		uniform half _render_cull;
		uniform half _IsBarkShader;
		uniform half _Banner;
		uniform half _IsLitShader;
		uniform half _render_zw;
		uniform half _render_cutoff;
		uniform half _render_src;
		uniform half _render_dst;
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
		UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondNormalTex);
		SamplerState sampler_SecondNormalTex;
		uniform half4 _SecondUVs;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondMaskTex);
		SamplerState sampler_SecondMaskTex;
		uniform half _SecondNormalValue;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondPackedTex);
		SamplerState sampler_SecondPackedTex;
		uniform half _DetailMeshValue;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MainMaskTex);
		SamplerState sampler_MainMaskTex;
		uniform half _DetailMaskMode;
		uniform half _DetailMaskValue;
		uniform half _DetailMaskContrast;
		uniform half _DetailNormalValue;
		uniform half4 _MainColor;
		uniform half4 _SecondColor;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondAlbedoTex);
		uniform half4 TVE_OverlayColor;
		uniform half _OverlayContrastValue;
		uniform half TVE_OverlayIntensity;
		uniform half _GlobalOverlay;
		uniform half _render_premul;
		uniform half4 _VertexOcclusionColor;
		uniform half _VertexOcclusionValue;
		uniform half _OcclusionCat;
		uniform half _MainSmoothnessValue;
		uniform half _SecondSmoothnessValue;
		uniform half TVE_OverlaySmoothness;
		uniform float TVE_Wetness;
		uniform half _GlobalWetness;
		uniform half _MainOcclusionValue;
		uniform half _SecondOcclusionValue;


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
			half3 Mesh_PivotsOS2291_g32819 = _Vector1;
			float3 temp_output_2283_0_g32819 = ( ase_vertex3Pos - Mesh_PivotsOS2291_g32819 );
			half3 VertexPos40_g32822 = temp_output_2283_0_g32819;
			float3 appendResult74_g32822 = (float3(0.0 , VertexPos40_g32822.y , 0.0));
			float3 VertexPosRotationAxis50_g32822 = appendResult74_g32822;
			float3 break84_g32822 = VertexPos40_g32822;
			float3 appendResult81_g32822 = (float3(break84_g32822.x , 0.0 , break84_g32822.z));
			float3 VertexPosOtherAxis82_g32822 = appendResult81_g32822;
			half MotionAmplitude203095_g32819 = _MotionAmplitude_20;
			float ObjectData20_g32911 = 3.14;
			float Bounds_Radius121_g32819 = _MaxBoundsInfo.x;
			float WorldData19_g32911 = Bounds_Radius121_g32819;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g32911 = WorldData19_g32911;
			#else
				float staticSwitch14_g32911 = ObjectData20_g32911;
			#endif
			float Motion_Max_Rolling1137_g32819 = staticSwitch14_g32911;
			float4x4 break19_g32860 = unity_ObjectToWorld;
			float3 appendResult20_g32860 = (float3(break19_g32860[ 0 ][ 3 ] , break19_g32860[ 1 ][ 3 ] , break19_g32860[ 2 ][ 3 ]));
			half3 Off19_g32861 = appendResult20_g32860;
			float4 ase_vertex4Pos = v.vertex;
			float4 transform68_g32860 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 appendResult93_g32860 = (float3(v.texcoord.z , v.texcoord3.w , v.texcoord.w));
			float4 transform62_g32860 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult93_g32860 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g32860 = ( (transform68_g32860).xyz - (transform62_g32860).xyz );
			half3 On20_g32861 = ObjectPositionWithPivots28_g32860;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g32861 = On20_g32861;
			#else
				float3 staticSwitch14_g32861 = Off19_g32861;
			#endif
			half3 ObjectData20_g32862 = staticSwitch14_g32861;
			half3 WorldData19_g32862 = Off19_g32861;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g32862 = WorldData19_g32862;
			#else
				float3 staticSwitch14_g32862 = ObjectData20_g32862;
			#endif
			float3 temp_output_42_0_g32860 = staticSwitch14_g32862;
			half3 ObjectData20_g32865 = temp_output_42_0_g32860;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			half3 WorldData19_g32865 = ase_worldPos;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g32865 = WorldData19_g32865;
			#else
				float3 staticSwitch14_g32865 = ObjectData20_g32865;
			#endif
			float2 temp_output_39_38_g32858 = ( (TVE_VolumeCoord).zw + ( (TVE_VolumeCoord).xy * (staticSwitch14_g32865).xz ) );
			half4 Legacy33_g32866 = SAMPLE_TEXTURE2D_LOD( TVE_MotionTex, samplerTVE_MotionTex, temp_output_39_38_g32858, 0.0 );
			half4 Vegetation33_g32866 = SAMPLE_TEXTURE2D_LOD( TVE_MotionTex_Vegetation, samplerTVE_MotionTex_Vegetation, temp_output_39_38_g32858, 0.0 );
			half4 Grass33_g32866 = SAMPLE_TEXTURE2D_LOD( TVE_MotionTex_Grass, samplerTVE_MotionTex_Grass, temp_output_39_38_g32858, 0.0 );
			half4 Objects33_g32866 = SAMPLE_TEXTURE2D_LOD( TVE_MotionTex_Objects, samplerTVE_MotionTex_Objects, temp_output_39_38_g32858, 0.0 );
			half4 Custom33_g32866 = SAMPLE_TEXTURE2D_LOD( TVE_MotionTex_User, samplerTVE_MotionTex_User, temp_output_39_38_g32858, 0.0 );
			half4 localUSE_BUFFERS33_g32866 = USE_BUFFERS( Legacy33_g32866 , Vegetation33_g32866 , Grass33_g32866 , Objects33_g32866 , Custom33_g32866 );
			float4 break322_g32884 = localUSE_BUFFERS33_g32866;
			half Wind_Power369_g32884 = saturate( ( (break322_g32884.z*2.0 + -1.0) + TVE_WindPower ) );
			float lerpResult376_g32884 = lerp( 0.1 , 1.0 , Wind_Power369_g32884);
			half Wind_Power_203109_g32819 = lerpResult376_g32884;
			half Mesh_Motion_260_g32819 = v.texcoord3.y;
			#ifdef TVE_IS_GRASS_SHADER
				float2 staticSwitch160_g32904 = TVE_NoiseSpeed_Grass;
			#else
				float2 staticSwitch160_g32904 = TVE_NoiseSpeed_Vegetation;
			#endif
			float4x4 break19_g32906 = unity_ObjectToWorld;
			float3 appendResult20_g32906 = (float3(break19_g32906[ 0 ][ 3 ] , break19_g32906[ 1 ][ 3 ] , break19_g32906[ 2 ][ 3 ]));
			half3 Off19_g32907 = appendResult20_g32906;
			float4 transform68_g32906 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 appendResult95_g32906 = (float3(v.texcoord.z , 0.0 , v.texcoord.w));
			float4 transform62_g32906 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult95_g32906 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g32906 = ( (transform68_g32906).xyz - (transform62_g32906).xyz );
			half3 On20_g32907 = ObjectPositionWithPivots28_g32906;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g32907 = On20_g32907;
			#else
				float3 staticSwitch14_g32907 = Off19_g32907;
			#endif
			half3 ObjectData20_g32908 = staticSwitch14_g32907;
			half3 WorldData19_g32908 = Off19_g32907;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g32908 = WorldData19_g32908;
			#else
				float3 staticSwitch14_g32908 = ObjectData20_g32908;
			#endif
			float3 temp_output_42_0_g32906 = staticSwitch14_g32908;
			half3 ObjectData20_g32905 = temp_output_42_0_g32906;
			half3 WorldData19_g32905 = ase_worldPos;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g32905 = WorldData19_g32905;
			#else
				float3 staticSwitch14_g32905 = ObjectData20_g32905;
			#endif
			#ifdef TVE_IS_GRASS_SHADER
				float2 staticSwitch164_g32904 = (ase_worldPos).xz;
			#else
				float2 staticSwitch164_g32904 = (staticSwitch14_g32905).xz;
			#endif
			#ifdef TVE_IS_GRASS_SHADER
				float staticSwitch161_g32904 = TVE_NoiseSize_Grass;
			#else
				float staticSwitch161_g32904 = TVE_NoiseSize_Vegetation;
			#endif
			float2 panner73_g32904 = ( _Time.y * staticSwitch160_g32904 + ( staticSwitch164_g32904 * staticSwitch161_g32904 ));
			float4 tex2DNode75_g32904 = SAMPLE_TEXTURE2D_LOD( TVE_NoiseTex, samplerTVE_NoiseTex, panner73_g32904, 0.0 );
			float4 saferPower77_g32904 = max( abs( tex2DNode75_g32904 ) , 0.0001 );
			float4 temp_cast_7 = (TVE_NoiseContrast).xxxx;
			float4 break142_g32904 = pow( saferPower77_g32904 , temp_cast_7 );
			half Global_NoiseTex_R34_g32819 = break142_g32904.r;
			half Motion_Use20162_g32819 = _Motion_20;
			float4x4 break19_g32852 = unity_ObjectToWorld;
			float3 appendResult20_g32852 = (float3(break19_g32852[ 0 ][ 3 ] , break19_g32852[ 1 ][ 3 ] , break19_g32852[ 2 ][ 3 ]));
			half3 Off19_g32853 = appendResult20_g32852;
			float4 transform68_g32852 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 appendResult95_g32852 = (float3(v.texcoord.z , 0.0 , v.texcoord.w));
			float4 transform62_g32852 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult95_g32852 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g32852 = ( (transform68_g32852).xyz - (transform62_g32852).xyz );
			half3 On20_g32853 = ObjectPositionWithPivots28_g32852;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g32853 = On20_g32853;
			#else
				float3 staticSwitch14_g32853 = Off19_g32853;
			#endif
			half3 ObjectData20_g32854 = staticSwitch14_g32853;
			half3 WorldData19_g32854 = Off19_g32853;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g32854 = WorldData19_g32854;
			#else
				float3 staticSwitch14_g32854 = ObjectData20_g32854;
			#endif
			float3 temp_output_42_0_g32852 = staticSwitch14_g32854;
			float3 break9_g32852 = temp_output_42_0_g32852;
			half Variation_Complex102_g32849 = frac( ( v.color.r + ( break9_g32852.x + break9_g32852.z ) ) );
			float ObjectData20_g32851 = Variation_Complex102_g32849;
			half Variation_Simple105_g32849 = v.color.r;
			float WorldData19_g32851 = Variation_Simple105_g32849;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g32851 = WorldData19_g32851;
			#else
				float staticSwitch14_g32851 = ObjectData20_g32851;
			#endif
			half Variation3073_g32819 = staticSwitch14_g32851;
			float temp_output_116_0_g32828 = Variation3073_g32819;
			float mulTime98_g32828 = _Time.y * 0.5;
			float lerpResult110_g32828 = lerp( ( ceil( saturate( ( frac( ( temp_output_116_0_g32828 + 0.3576 ) ) - 0.5 ) ) ) * 0.5 ) , ceil( saturate( ( frac( ( temp_output_116_0_g32828 + 0.1258 ) ) - 0.8 ) ) ) , (sin( mulTime98_g32828 )*0.5 + 0.5));
			half Wind_Power2223_g32819 = Wind_Power369_g32884;
			float lerpResult118_g32828 = lerp( 0.25 , 0.75 , Wind_Power2223_g32819);
			float lerpResult111_g32828 = lerp( lerpResult110_g32828 , 1.0 , ( lerpResult118_g32828 * lerpResult118_g32828 * lerpResult118_g32828 * lerpResult118_g32828 ));
			half Motion_Selective3182_g32819 = lerpResult111_g32828;
			half Input_Speed62_g32876 = _MotionSpeed_20;
			float mulTime354_g32876 = _Time.y * Input_Speed62_g32876;
			float temp_output_342_0_g32876 = ( ( _MotionVariation_20 * Variation3073_g32819 ) * v.color.r );
			float4x4 break19_g32877 = unity_ObjectToWorld;
			float3 appendResult20_g32877 = (float3(break19_g32877[ 0 ][ 3 ] , break19_g32877[ 1 ][ 3 ] , break19_g32877[ 2 ][ 3 ]));
			half3 Off19_g32878 = appendResult20_g32877;
			float4 transform68_g32877 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 appendResult95_g32877 = (float3(v.texcoord.z , 0.0 , v.texcoord.w));
			float4 transform62_g32877 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult95_g32877 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g32877 = ( (transform68_g32877).xyz - (transform62_g32877).xyz );
			half3 On20_g32878 = ObjectPositionWithPivots28_g32877;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g32878 = On20_g32878;
			#else
				float3 staticSwitch14_g32878 = Off19_g32878;
			#endif
			half3 ObjectData20_g32879 = staticSwitch14_g32878;
			half3 WorldData19_g32879 = Off19_g32878;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g32879 = WorldData19_g32879;
			#else
				float3 staticSwitch14_g32879 = ObjectData20_g32879;
			#endif
			float3 temp_output_42_0_g32877 = staticSwitch14_g32879;
			float3 break9_g32877 = temp_output_42_0_g32877;
			float ObjectData20_g32882 = ( temp_output_342_0_g32876 + ( break9_g32877.x + break9_g32877.z ) );
			float WorldData19_g32882 = temp_output_342_0_g32876;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g32882 = WorldData19_g32882;
			#else
				float staticSwitch14_g32882 = ObjectData20_g32882;
			#endif
			float Motion_Variation284_g32876 = staticSwitch14_g32882;
			float Motion_Scale287_g32876 = ( _MotionScale_20 * ase_worldPos.x );
			half Motion_Rolling138_g32819 = ( ( MotionAmplitude203095_g32819 * Motion_Max_Rolling1137_g32819 ) * ( Wind_Power_203109_g32819 * Mesh_Motion_260_g32819 * Global_NoiseTex_R34_g32819 * Motion_Use20162_g32819 * Motion_Selective3182_g32819 ) * sin( ( mulTime354_g32876 + Motion_Variation284_g32876 + Motion_Scale287_g32876 ) ) );
			half Angle44_g32822 = Motion_Rolling138_g32819;
			half3 VertexPos40_g32836 = ( VertexPosRotationAxis50_g32822 + ( VertexPosOtherAxis82_g32822 * cos( Angle44_g32822 ) ) + ( cross( float3(0,1,0) , VertexPosOtherAxis82_g32822 ) * sin( Angle44_g32822 ) ) );
			float3 appendResult74_g32836 = (float3(VertexPos40_g32836.x , 0.0 , 0.0));
			half3 VertexPosRotationAxis50_g32836 = appendResult74_g32836;
			float3 break84_g32836 = VertexPos40_g32836;
			float3 appendResult81_g32836 = (float3(0.0 , break84_g32836.y , break84_g32836.z));
			half3 VertexPosOtherAxis82_g32836 = appendResult81_g32836;
			float ObjectData20_g32913 = 3.14;
			float Bounds_Height374_g32819 = _MaxBoundsInfo.y;
			float WorldData19_g32913 = ( Bounds_Height374_g32819 * 3.14 );
			#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g32913 = WorldData19_g32913;
			#else
				float staticSwitch14_g32913 = ObjectData20_g32913;
			#endif
			float Motion_Max_Bending1133_g32819 = staticSwitch14_g32913;
			half Wind_Power_103106_g32819 = Wind_Power369_g32884;
			float3 appendResult323_g32884 = (float3(break322_g32884.x , 0.0 , break322_g32884.y));
			float3 temp_output_324_0_g32884 = (appendResult323_g32884*2.0 + -1.0);
			float3 ase_parentObjectScale = (1.0/float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ));
			float3 temp_output_339_0_g32884 = ( mul( unity_WorldToObject, float4( temp_output_324_0_g32884 , 0.0 ) ).xyz * ase_parentObjectScale );
			half2 Wind_DirectionOS39_g32819 = (temp_output_339_0_g32884).xz;
			half Motion_Use1056_g32819 = _Motion_10;
			half Input_Speed62_g32835 = _MotionSpeed_10;
			float mulTime373_g32835 = _Time.y * Input_Speed62_g32835;
			half Motion_Variation284_g32835 = ( _MotionVariation_10 * Variation3073_g32819 );
			float2 appendResult344_g32835 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 Motion_Scale287_g32835 = ( _MotionScale_10 * appendResult344_g32835 );
			half2 Sine_MinusOneToOne281_g32835 = sin( ( mulTime373_g32835 + Motion_Variation284_g32835 + Motion_Scale287_g32835 ) );
			float2 temp_cast_12 = (1.0).xx;
			half Input_Turbulence327_g32835 = Global_NoiseTex_R34_g32819;
			float2 lerpResult321_g32835 = lerp( Sine_MinusOneToOne281_g32835 , temp_cast_12 , Input_Turbulence327_g32835);
			half2 Motion_Bending2258_g32819 = ( ( _MotionAmplitude_10 * Motion_Max_Bending1133_g32819 ) * Wind_Power_103106_g32819 * Wind_DirectionOS39_g32819 * Motion_Use1056_g32819 * Global_NoiseTex_R34_g32819 * lerpResult321_g32835 );
			half Motion_UseInteraction2097_g32819 = _Motion_Interaction;
			half Motion_InteractionMask66_g32819 = break322_g32884.w;
			float lerpResult3307_g32819 = lerp( 1.0 , Variation3073_g32819 , _InteractionVariation);
			half2 Motion_Interaction53_g32819 = ( _InteractionAmplitude * Motion_Max_Bending1133_g32819 * Motion_UseInteraction2097_g32819 * Motion_InteractionMask66_g32819 * Motion_InteractionMask66_g32819 * Wind_DirectionOS39_g32819 * lerpResult3307_g32819 );
			float2 lerpResult109_g32819 = lerp( Motion_Bending2258_g32819 , Motion_Interaction53_g32819 , Motion_InteractionMask66_g32819);
			half Mesh_Motion_182_g32819 = v.texcoord3.x;
			float2 break143_g32819 = ( lerpResult109_g32819 * Mesh_Motion_182_g32819 );
			half Motion_Z190_g32819 = break143_g32819.y;
			half Angle44_g32836 = Motion_Z190_g32819;
			half3 VertexPos40_g32821 = ( VertexPosRotationAxis50_g32836 + ( VertexPosOtherAxis82_g32836 * cos( Angle44_g32836 ) ) + ( cross( float3(1,0,0) , VertexPosOtherAxis82_g32836 ) * sin( Angle44_g32836 ) ) );
			float3 appendResult74_g32821 = (float3(0.0 , 0.0 , VertexPos40_g32821.z));
			half3 VertexPosRotationAxis50_g32821 = appendResult74_g32821;
			float3 break84_g32821 = VertexPos40_g32821;
			float3 appendResult81_g32821 = (float3(break84_g32821.x , break84_g32821.y , 0.0));
			half3 VertexPosOtherAxis82_g32821 = appendResult81_g32821;
			half Motion_X216_g32819 = break143_g32819.x;
			half Angle44_g32821 = -Motion_X216_g32819;
			half Wind_Mode3167_g32819 = TVE_WindMode;
			float3 lerpResult3168_g32819 = lerp( ase_vertex3Pos , ( VertexPosRotationAxis50_g32821 + ( VertexPosOtherAxis82_g32821 * cos( Angle44_g32821 ) ) + ( cross( float3(0,0,1) , VertexPosOtherAxis82_g32821 ) * sin( Angle44_g32821 ) ) ) , Wind_Mode3167_g32819);
			float3 Vertex_Motion_Object833_g32819 = lerpResult3168_g32819;
			float3 appendResult2047_g32819 = (float3(Motion_Rolling138_g32819 , 0.0 , -Motion_Rolling138_g32819));
			float3 appendResult2043_g32819 = (float3(Motion_X216_g32819 , 0.0 , Motion_Z190_g32819));
			float3 lerpResult3173_g32819 = lerp( ase_vertex3Pos , ( ( ase_vertex3Pos + appendResult2047_g32819 ) + appendResult2043_g32819 ) , Wind_Mode3167_g32819);
			float3 Vertex_Motion_World1118_g32819 = lerpResult3173_g32819;
			float3 temp_output_3331_0_g32819 = ( ( _VertexCat * _VertexMotionSpace * _VertexMotionMode * _VertexDataMode ) + Vertex_Motion_World1118_g32819 );
			#if defined(TVE_VERTEX_DATA_OBJECT)
				float3 staticSwitch3312_g32819 = Vertex_Motion_Object833_g32819;
			#elif defined(TVE_VERTEX_DATA_WORLD)
				float3 staticSwitch3312_g32819 = temp_output_3331_0_g32819;
			#elif defined(TVE_VERTEX_DATA_BATCHED)
				float3 staticSwitch3312_g32819 = temp_output_3331_0_g32819;
			#else
				float3 staticSwitch3312_g32819 = Vertex_Motion_Object833_g32819;
			#endif
			half3 ObjectData20_g32883 = staticSwitch3312_g32819;
			half3 WorldData19_g32883 = Vertex_Motion_World1118_g32819;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g32883 = WorldData19_g32883;
			#else
				float3 staticSwitch14_g32883 = ObjectData20_g32883;
			#endif
			float4x4 break19_g32899 = unity_ObjectToWorld;
			float3 appendResult20_g32899 = (float3(break19_g32899[ 0 ][ 3 ] , break19_g32899[ 1 ][ 3 ] , break19_g32899[ 2 ][ 3 ]));
			half3 Off19_g32900 = appendResult20_g32899;
			float4 transform68_g32899 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 appendResult93_g32899 = (float3(v.texcoord.z , v.texcoord3.w , v.texcoord.w));
			float4 transform62_g32899 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult93_g32899 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g32899 = ( (transform68_g32899).xyz - (transform62_g32899).xyz );
			half3 On20_g32900 = ObjectPositionWithPivots28_g32899;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g32900 = On20_g32900;
			#else
				float3 staticSwitch14_g32900 = Off19_g32900;
			#endif
			half3 ObjectData20_g32901 = staticSwitch14_g32900;
			half3 WorldData19_g32901 = Off19_g32900;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g32901 = WorldData19_g32901;
			#else
				float3 staticSwitch14_g32901 = ObjectData20_g32901;
			#endif
			float3 temp_output_42_0_g32899 = staticSwitch14_g32901;
			float temp_output_7_0_g32823 = TVE_SizeFadeEnd;
			float ObjectData20_g32898 = saturate( ( ( ( distance( _WorldSpaceCameraPos , temp_output_42_0_g32899 ) * _GlobalSizeFade ) - temp_output_7_0_g32823 ) / ( TVE_SizeFadeStart - temp_output_7_0_g32823 ) ) );
			float WorldData19_g32898 = 1.0;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g32898 = WorldData19_g32898;
			#else
				float staticSwitch14_g32898 = ObjectData20_g32898;
			#endif
			float Vertex_SizeFade1740_g32819 = staticSwitch14_g32898;
			float4x4 break19_g32889 = unity_ObjectToWorld;
			float3 appendResult20_g32889 = (float3(break19_g32889[ 0 ][ 3 ] , break19_g32889[ 1 ][ 3 ] , break19_g32889[ 2 ][ 3 ]));
			half3 Off19_g32890 = appendResult20_g32889;
			float4 transform68_g32889 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 appendResult95_g32889 = (float3(v.texcoord.z , 0.0 , v.texcoord.w));
			float4 transform62_g32889 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult95_g32889 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g32889 = ( (transform68_g32889).xyz - (transform62_g32889).xyz );
			half3 On20_g32890 = ObjectPositionWithPivots28_g32889;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g32890 = On20_g32890;
			#else
				float3 staticSwitch14_g32890 = Off19_g32890;
			#endif
			half3 ObjectData20_g32891 = staticSwitch14_g32890;
			half3 WorldData19_g32891 = Off19_g32890;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g32891 = WorldData19_g32891;
			#else
				float3 staticSwitch14_g32891 = ObjectData20_g32891;
			#endif
			float3 temp_output_42_0_g32889 = staticSwitch14_g32891;
			half3 ObjectData20_g32888 = temp_output_42_0_g32889;
			half3 WorldData19_g32888 = ase_worldPos;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g32888 = WorldData19_g32888;
			#else
				float3 staticSwitch14_g32888 = ObjectData20_g32888;
			#endif
			float2 temp_output_43_38_g32886 = ( (TVE_VolumeCoord).zw + ( (TVE_VolumeCoord).xy * (staticSwitch14_g32888).xz ) );
			half4 Legacy33_g32887 = SAMPLE_TEXTURE2D_LOD( TVE_ExtrasTex, samplerTVE_ExtrasTex, temp_output_43_38_g32886, 0.0 );
			half4 Vegetation33_g32887 = SAMPLE_TEXTURE2D_LOD( TVE_ExtrasTex_Vegetation, samplerTVE_ExtrasTex_Vegetation, temp_output_43_38_g32886, 0.0 );
			half4 Grass33_g32887 = SAMPLE_TEXTURE2D_LOD( TVE_ExtrasTex_Grass, samplerTVE_ExtrasTex_Grass, temp_output_43_38_g32886, 0.0 );
			half4 Objects33_g32887 = SAMPLE_TEXTURE2D_LOD( TVE_ExtrasTex_Objects, samplerTVE_ExtrasTex_Objects, temp_output_43_38_g32886, 0.0 );
			half4 Custom33_g32887 = SAMPLE_TEXTURE2D_LOD( TVE_ExtrasTex_User, samplerTVE_ExtrasTex_User, temp_output_43_38_g32886, 0.0 );
			half4 localUSE_BUFFERS33_g32887 = USE_BUFFERS( Legacy33_g32887 , Vegetation33_g32887 , Grass33_g32887 , Objects33_g32887 , Custom33_g32887 );
			float4 break49_g32886 = localUSE_BUFFERS33_g32887;
			half Global_ExtrasTex_G305_g32819 = break49_g32886.y;
			float lerpResult346_g32819 = lerp( 1.0 , Global_ExtrasTex_G305_g32819 , _GlobalSize);
			float ObjectData20_g32897 = ( lerpResult346_g32819 * _LocalSize );
			float WorldData19_g32897 = 1.0;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g32897 = WorldData19_g32897;
			#else
				float staticSwitch14_g32897 = ObjectData20_g32897;
			#endif
			half Vertex_Size1741_g32819 = staticSwitch14_g32897;
			half3 Grass_Coverage2661_g32819 = half3(0,0,0);
			float3 Final_VertexPosition890_g32819 = ( ( staticSwitch14_g32883 * Vertex_SizeFade1740_g32819 * Vertex_Size1741_g32819 ) + Mesh_PivotsOS2291_g32819 + Grass_Coverage2661_g32819 );
			v.vertex.xyz = Final_VertexPosition890_g32819;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			half2 Main_UVs15_g32819 = ( ( i.uv_texcoord * (_MainUVs).xy ) + (_MainUVs).zw );
			float4 tex2DNode117_g32819 = SAMPLE_TEXTURE2D( _MainNormalTex, sampler_MainAlbedoTex, Main_UVs15_g32819 );
			float2 appendResult88_g32825 = (float2(tex2DNode117_g32819.a , tex2DNode117_g32819.g));
			float2 temp_output_90_0_g32825 = ( (appendResult88_g32825*2.0 + -1.0) * _MainNormalValue );
			float3 appendResult91_g32825 = (float3(temp_output_90_0_g32825 , 1.0));
			half3 Main_Normal137_g32819 = appendResult91_g32825;
			float2 appendResult21_g32824 = (float2(i.uv_tex4coord.z , i.uv_tex4coord.w));
			float2 Mesh_DetailCoord3_g32819 = appendResult21_g32824;
			half2 Second_UVs17_g32819 = ( ( Mesh_DetailCoord3_g32819 * (_SecondUVs).xy ) + (_SecondUVs).zw );
			float4 tex2DNode145_g32819 = SAMPLE_TEXTURE2D( _SecondNormalTex, sampler_SecondMaskTex, Second_UVs17_g32819 );
			float2 appendResult88_g32846 = (float2(tex2DNode145_g32819.a , tex2DNode145_g32819.g));
			float2 temp_output_90_0_g32846 = ( (appendResult88_g32846*2.0 + -1.0) * _SecondNormalValue );
			float3 appendResult91_g32846 = (float3(temp_output_90_0_g32846 , 1.0));
			float4 tex2DNode3380_g32819 = SAMPLE_TEXTURE2D( _SecondPackedTex, sampler_SecondMaskTex, Second_UVs17_g32819 );
			half Packed_NormalX3387_g32819 = tex2DNode3380_g32819.a;
			half Packed_NormalY3386_g32819 = tex2DNode3380_g32819.g;
			float2 appendResult88_g32829 = (float2(Packed_NormalX3387_g32819 , Packed_NormalY3386_g32819));
			float2 temp_output_90_0_g32829 = ( (appendResult88_g32829*2.0 + -1.0) * _SecondNormalValue );
			float3 appendResult91_g32829 = (float3(temp_output_90_0_g32829 , 1.0));
			#if defined(TVE_DETAIL_MAPS_STANDARD)
				float3 staticSwitch3450_g32819 = appendResult91_g32846;
			#elif defined(TVE_DETAIL_MAPS_PACKED)
				float3 staticSwitch3450_g32819 = appendResult91_g32829;
			#else
				float3 staticSwitch3450_g32819 = appendResult91_g32846;
			#endif
			half3 Second_Normal179_g32819 = staticSwitch3450_g32819;
			half Mesh_DetailMask90_g32819 = i.vertexColor.b;
			float temp_output_989_0_g32819 = ( ( Mesh_DetailMask90_g32819 - 0.5 ) + _DetailMeshValue );
			half Blend_Source1540_g32819 = temp_output_989_0_g32819;
			float4 tex2DNode35_g32819 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainAlbedoTex, Main_UVs15_g32819 );
			half Main_Mask_Raw57_g32819 = tex2DNode35_g32819.b;
			float4 tex2DNode33_g32819 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, Second_UVs17_g32819 );
			half Second_Mask81_g32819 = tex2DNode33_g32819.b;
			float lerpResult1327_g32819 = lerp( Main_Mask_Raw57_g32819 , Second_Mask81_g32819 , _DetailMaskMode);
			float temp_output_7_0_g32833 = _DetailMaskContrast;
			float temp_output_973_0_g32819 = saturate( ( ( saturate( ( Blend_Source1540_g32819 + ( Blend_Source1540_g32819 * ( ( ( 1.0 - lerpResult1327_g32819 ) - 0.5 ) + _DetailMaskValue ) ) ) ) - temp_output_7_0_g32833 ) / ( ( 1.0 - _DetailMaskContrast ) - temp_output_7_0_g32833 ) ) );
			half Mask_Detail147_g32819 = temp_output_973_0_g32819;
			float3 lerpResult230_g32819 = lerp( float3( 0,0,1 ) , Second_Normal179_g32819 , Mask_Detail147_g32819);
			float3 lerpResult3372_g32819 = lerp( float3( 0,0,1 ) , Main_Normal137_g32819 , _DetailNormalValue);
			float3 lerpResult3376_g32819 = lerp( Main_Normal137_g32819 , BlendNormals( lerpResult3372_g32819 , Second_Normal179_g32819 ) , Mask_Detail147_g32819);
			#if defined(TVE_DETAIL_MODE_OFF)
				float3 staticSwitch267_g32819 = Main_Normal137_g32819;
			#elif defined(TVE_DETAIL_MODE_OVERLAY)
				float3 staticSwitch267_g32819 = BlendNormals( Main_Normal137_g32819 , lerpResult230_g32819 );
			#elif defined(TVE_DETAIL_MODE_REPLACE)
				float3 staticSwitch267_g32819 = lerpResult3376_g32819;
			#else
				float3 staticSwitch267_g32819 = Main_Normal137_g32819;
			#endif
			float3 temp_output_13_0_g32843 = staticSwitch267_g32819;
			float3 switchResult12_g32843 = (((i.ASEVFace>0)?(temp_output_13_0_g32843):(( temp_output_13_0_g32843 * _render_normals_options ))));
			half3 Blend_Normal312_g32819 = switchResult12_g32843;
			half3 Final_Normal366_g32819 = Blend_Normal312_g32819;
			o.Normal = Final_Normal366_g32819;
			float4 tex2DNode29_g32819 = SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, Main_UVs15_g32819 );
			float4 temp_output_51_0_g32819 = ( _MainColor * tex2DNode29_g32819 );
			half3 Main_AlbedoRaw99_g32819 = (temp_output_51_0_g32819).rgb;
			half3 Main_AlbedoTinted2808_g32819 = ( float3(1,1,1) * float3(1,1,1) * Main_AlbedoRaw99_g32819 * float3(1,1,1) );
			half3 Main_AlbedoColored863_g32819 = Main_AlbedoTinted2808_g32819;
			half Packed_Albedo3385_g32819 = tex2DNode3380_g32819.r;
			float4 temp_cast_0 = (Packed_Albedo3385_g32819).xxxx;
			#if defined(TVE_DETAIL_MAPS_STANDARD)
				float4 staticSwitch3449_g32819 = SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondMaskTex, Second_UVs17_g32819 );
			#elif defined(TVE_DETAIL_MAPS_PACKED)
				float4 staticSwitch3449_g32819 = temp_cast_0;
			#else
				float4 staticSwitch3449_g32819 = SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondMaskTex, Second_UVs17_g32819 );
			#endif
			half3 Second_Albedo153_g32819 = (( _SecondColor * staticSwitch3449_g32819 )).rgb;
			half3 Second_AlbedoColored1963_g32819 = Second_Albedo153_g32819;
			#ifdef UNITY_COLORSPACE_GAMMA
				float staticSwitch1_g32839 = 2.0;
			#else
				float staticSwitch1_g32839 = 4.594794;
			#endif
			float3 lerpResult235_g32819 = lerp( Main_AlbedoColored863_g32819 , ( Main_AlbedoColored863_g32819 * Second_AlbedoColored1963_g32819 * staticSwitch1_g32839 ) , Mask_Detail147_g32819);
			float3 lerpResult208_g32819 = lerp( Main_AlbedoColored863_g32819 , Second_AlbedoColored1963_g32819 , Mask_Detail147_g32819);
			#if defined(TVE_DETAIL_MODE_OFF)
				float3 staticSwitch255_g32819 = Main_AlbedoColored863_g32819;
			#elif defined(TVE_DETAIL_MODE_OVERLAY)
				float3 staticSwitch255_g32819 = lerpResult235_g32819;
			#elif defined(TVE_DETAIL_MODE_REPLACE)
				float3 staticSwitch255_g32819 = lerpResult208_g32819;
			#else
				float3 staticSwitch255_g32819 = Main_AlbedoColored863_g32819;
			#endif
			half3 Blend_Albedo265_g32819 = staticSwitch255_g32819;
			half3 Blend_AlbedoAndSubsurface149_g32819 = Blend_Albedo265_g32819;
			half3 Global_OverlayColor1758_g32819 = (TVE_OverlayColor).rgb;
			half3 Blend_NormalRaw1051_g32819 = staticSwitch267_g32819;
			float3 switchResult1063_g32819 = (((i.ASEVFace>0)?(Blend_NormalRaw1051_g32819):(( Blend_NormalRaw1051_g32819 * float3(-1,-1,-1) ))));
			half Overlay_Contrast1405_g32819 = _OverlayContrastValue;
			float3 appendResult1439_g32819 = (float3(Overlay_Contrast1405_g32819 , Overlay_Contrast1405_g32819 , 1.0));
			half Global_OverlayIntensity154_g32819 = TVE_OverlayIntensity;
			float4x4 break19_g32889 = unity_ObjectToWorld;
			float3 appendResult20_g32889 = (float3(break19_g32889[ 0 ][ 3 ] , break19_g32889[ 1 ][ 3 ] , break19_g32889[ 2 ][ 3 ]));
			half3 Off19_g32890 = appendResult20_g32889;
			float4 ase_vertex4Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float4 transform68_g32889 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float3 appendResult95_g32889 = (float3(i.uv_tex4coord.z , 0.0 , i.uv_tex4coord.w));
			float4 transform62_g32889 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult95_g32889 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g32889 = ( (transform68_g32889).xyz - (transform62_g32889).xyz );
			half3 On20_g32890 = ObjectPositionWithPivots28_g32889;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g32890 = On20_g32890;
			#else
				float3 staticSwitch14_g32890 = Off19_g32890;
			#endif
			half3 ObjectData20_g32891 = staticSwitch14_g32890;
			half3 WorldData19_g32891 = Off19_g32890;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g32891 = WorldData19_g32891;
			#else
				float3 staticSwitch14_g32891 = ObjectData20_g32891;
			#endif
			float3 temp_output_42_0_g32889 = staticSwitch14_g32891;
			half3 ObjectData20_g32888 = temp_output_42_0_g32889;
			float3 ase_worldPos = i.worldPos;
			half3 WorldData19_g32888 = ase_worldPos;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g32888 = WorldData19_g32888;
			#else
				float3 staticSwitch14_g32888 = ObjectData20_g32888;
			#endif
			float2 temp_output_43_38_g32886 = ( (TVE_VolumeCoord).zw + ( (TVE_VolumeCoord).xy * (staticSwitch14_g32888).xz ) );
			half4 Legacy33_g32887 = SAMPLE_TEXTURE2D( TVE_ExtrasTex, samplerTVE_ExtrasTex, temp_output_43_38_g32886 );
			half4 Vegetation33_g32887 = SAMPLE_TEXTURE2D( TVE_ExtrasTex_Vegetation, samplerTVE_ExtrasTex_Vegetation, temp_output_43_38_g32886 );
			half4 Grass33_g32887 = SAMPLE_TEXTURE2D( TVE_ExtrasTex_Grass, samplerTVE_ExtrasTex_Grass, temp_output_43_38_g32886 );
			half4 Objects33_g32887 = SAMPLE_TEXTURE2D( TVE_ExtrasTex_Objects, samplerTVE_ExtrasTex_Objects, temp_output_43_38_g32886 );
			half4 Custom33_g32887 = SAMPLE_TEXTURE2D( TVE_ExtrasTex_User, samplerTVE_ExtrasTex_User, temp_output_43_38_g32886 );
			half4 localUSE_BUFFERS33_g32887 = USE_BUFFERS( Legacy33_g32887 , Vegetation33_g32887 , Grass33_g32887 , Objects33_g32887 , Custom33_g32887 );
			float4 break49_g32886 = localUSE_BUFFERS33_g32887;
			half Global_ExtrasTex_B156_g32819 = break49_g32886.z;
			float temp_output_1025_0_g32819 = ( Global_OverlayIntensity154_g32819 * _GlobalOverlay * Global_ExtrasTex_B156_g32819 );
			half Overlay_Commons1365_g32819 = temp_output_1025_0_g32819;
			half Overlay_Mask269_g32819 = saturate( ( saturate( (WorldNormalVector( i , ( switchResult1063_g32819 * appendResult1439_g32819 ) )).y ) - ( 1.0 - Overlay_Commons1365_g32819 ) ) );
			float3 lerpResult336_g32819 = lerp( Blend_AlbedoAndSubsurface149_g32819 , Global_OverlayColor1758_g32819 , Overlay_Mask269_g32819);
			half3 Final_Albedo359_g32819 = lerpResult336_g32819;
			half Main_Alpha316_g32819 = (temp_output_51_0_g32819).a;
			float lerpResult354_g32819 = lerp( 1.0 , Main_Alpha316_g32819 , _render_premul);
			half Final_Premultiply355_g32819 = lerpResult354_g32819;
			float3 temp_output_410_0_g32819 = ( Final_Albedo359_g32819 * Final_Premultiply355_g32819 );
			float3 temp_cast_7 = (1.0).xxx;
			half Mesh_Occlusion318_g32819 = i.vertexColor.g;
			float saferPower1201_g32819 = max( Mesh_Occlusion318_g32819 , 0.0001 );
			float3 lerpResult2945_g32819 = lerp( (_VertexOcclusionColor).rgb , temp_cast_7 , saturate( pow( saferPower1201_g32819 , ( _VertexOcclusionValue + _OcclusionCat ) ) ));
			half3 Vertex_Occlusion648_g32819 = lerpResult2945_g32819;
			o.Albedo = ( temp_output_410_0_g32819 * Vertex_Occlusion648_g32819 );
			half Main_Smoothness227_g32819 = ( tex2DNode35_g32819.a * _MainSmoothnessValue );
			half Packed_Smoothness3388_g32819 = tex2DNode3380_g32819.b;
			#if defined(TVE_DETAIL_MAPS_STANDARD)
				float staticSwitch3456_g32819 = tex2DNode33_g32819.a;
			#elif defined(TVE_DETAIL_MAPS_PACKED)
				float staticSwitch3456_g32819 = Packed_Smoothness3388_g32819;
			#else
				float staticSwitch3456_g32819 = tex2DNode33_g32819.a;
			#endif
			half Second_Smoothness236_g32819 = ( staticSwitch3456_g32819 * _SecondSmoothnessValue );
			float lerpResult266_g32819 = lerp( Main_Smoothness227_g32819 , Second_Smoothness236_g32819 , Mask_Detail147_g32819);
			#if defined(TVE_DETAIL_MODE_OFF)
				float staticSwitch297_g32819 = Main_Smoothness227_g32819;
			#elif defined(TVE_DETAIL_MODE_OVERLAY)
				float staticSwitch297_g32819 = Main_Smoothness227_g32819;
			#elif defined(TVE_DETAIL_MODE_REPLACE)
				float staticSwitch297_g32819 = lerpResult266_g32819;
			#else
				float staticSwitch297_g32819 = Main_Smoothness227_g32819;
			#endif
			half Blend_Smoothness314_g32819 = staticSwitch297_g32819;
			half Global_OverlaySmoothness311_g32819 = TVE_OverlaySmoothness;
			float lerpResult343_g32819 = lerp( Blend_Smoothness314_g32819 , Global_OverlaySmoothness311_g32819 , Overlay_Mask269_g32819);
			half Final_Smoothness371_g32819 = lerpResult343_g32819;
			half Global_Wetness1016_g32819 = ( TVE_Wetness * _GlobalWetness );
			half Global_ExtrasTex_A1033_g32819 = break49_g32886.w;
			float lerpResult1037_g32819 = lerp( Final_Smoothness371_g32819 , saturate( ( Final_Smoothness371_g32819 + Global_Wetness1016_g32819 ) ) , Global_ExtrasTex_A1033_g32819);
			o.Smoothness = lerpResult1037_g32819;
			float lerpResult240_g32819 = lerp( 1.0 , tex2DNode35_g32819.g , _MainOcclusionValue);
			half Main_Occlusion247_g32819 = lerpResult240_g32819;
			float lerpResult239_g32819 = lerp( 1.0 , tex2DNode33_g32819.g , _SecondOcclusionValue);
			#if defined(TVE_DETAIL_MAPS_STANDARD)
				float staticSwitch3455_g32819 = lerpResult239_g32819;
			#elif defined(TVE_DETAIL_MAPS_PACKED)
				float staticSwitch3455_g32819 = 1.0;
			#else
				float staticSwitch3455_g32819 = lerpResult239_g32819;
			#endif
			half Second_Occlusion251_g32819 = staticSwitch3455_g32819;
			float lerpResult294_g32819 = lerp( Main_Occlusion247_g32819 , Second_Occlusion251_g32819 , Mask_Detail147_g32819);
			#if defined(TVE_DETAIL_MODE_OFF)
				float staticSwitch310_g32819 = Main_Occlusion247_g32819;
			#elif defined(TVE_DETAIL_MODE_OVERLAY)
				float staticSwitch310_g32819 = ( Main_Occlusion247_g32819 * Second_Occlusion251_g32819 );
			#elif defined(TVE_DETAIL_MODE_REPLACE)
				float staticSwitch310_g32819 = lerpResult294_g32819;
			#else
				float staticSwitch310_g32819 = Main_Occlusion247_g32819;
			#endif
			half Blend_Occlusion323_g32819 = staticSwitch310_g32819;
			o.Occlusion = Blend_Occlusion323_g32819;
			o.Alpha = Main_Alpha316_g32819;
			half Main_AlphaRaw1203_g32819 = tex2DNode29_g32819.a;
			half Alpha5_g32848 = Main_AlphaRaw1203_g32819;
			#ifdef _ALPHATEST_ON
				float staticSwitch2_g32848 = Alpha5_g32848;
			#else
				float staticSwitch2_g32848 = 1.0;
			#endif
			half Final_Clip914_g32819 = staticSwitch2_g32848;
			clip( Final_Clip914_g32819 - _render_cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "TVEShaderCoreGUI"
}
/*ASEBEGIN
Version=18600
1927;1;1906;1020;2878.353;751.9063;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;306;-1376,-896;Half;False;Property;_IsAnyPathShader;_IsAnyPathShader;205;1;[HideInInspector];Create;True;0;0;True;0;False;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;134;-1776,-896;Half;False;Property;_IsStandardShader;_IsStandardShader;207;1;[HideInInspector];Create;True;0;0;True;0;False;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1920,-768;Half;False;Property;_render_cull;_render_cull;209;1;[HideInInspector];Create;True;3;Both;0;Back;1;Front;2;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;127;-1984,-896;Half;False;Property;_IsBarkShader;_IsBarkShader;204;1;[HideInInspector];Create;True;0;0;True;0;False;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-2176,-896;Half;False;Property;_Banner;Banner;0;0;Create;True;0;0;True;1;StyledBanner(Bark Standard Lit);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;81;-1552,-896;Half;False;Property;_IsLitShader;_IsLitShader;206;1;[HideInInspector];Create;True;0;0;True;0;False;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;307;-2176,256;Inherit;False;Use TVE_IS_VEGETATION_SHADER;-1;;32818;b458122dd75182d488380bd0f592b9e6;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1344,-768;Half;False;Property;_render_zw;_render_zw;212;1;[HideInInspector];Create;True;2;Opaque;0;Transparent;1;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-2176,-768;Half;False;Property;_render_cutoff;_render_cutoff;208;1;[HideInInspector];Create;True;4;Alpha;0;Premultiply;1;Additive;2;Multiply;3;0;True;0;False;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1728,-768;Half;False;Property;_render_src;_render_src;210;1;[HideInInspector];Create;True;0;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1536,-768;Half;False;Property;_render_dst;_render_dst;211;1;[HideInInspector];Create;True;2;Opaque;0;Transparent;1;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;334;-2176,-384;Inherit;False;Base Shader;1;;32819;856f7164d1c579d43a5cf4968a75ca43;50,1300,1,1298,1,1271,1,1962,0,1708,0,1712,1,1964,1,1969,1,1719,0,893,0,1745,1,1742,1,1718,1,1714,1,1715,1,1717,1,916,1,1949,1,1763,0,1762,0,1776,0,1646,0,1690,0,1757,0,3221,3,1981,0,2807,0,2953,0,3243,0,2172,0,2658,0,1734,1,1733,1,1735,1,1736,1,1966,1,1968,1,1737,1,878,0,1550,0,860,1,2750,0,2261,1,2260,1,2054,1,2032,1,2060,0,2036,0,2062,0,2039,0;0;15;FLOAT3;0;FLOAT3;528;FLOAT3;2489;FLOAT;529;FLOAT;530;FLOAT;531;FLOAT;1235;FLOAT3;1230;FLOAT;1461;FLOAT;1290;FLOAT;721;FLOAT;532;FLOAT;653;FLOAT;629;FLOAT3;534
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-1376,-384;Float;False;True;-1;2;TVEShaderCoreGUI;0;0;Standard;BOXOPHOBIC/The Vegetation Engine/Vegetation/Bark Standard Lit;False;False;False;False;False;False;False;True;False;False;False;False;True;True;True;False;True;False;False;False;True;Back;0;True;17;0;False;-1;False;0;False;-1;-1;False;-1;False;0;Custom;0.5;True;True;0;True;Opaque;;Geometry;All;11;d3d11;glcore;gles3;metal;vulkan;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;1;0;True;20;0;True;7;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Absolute;0;;-1;-1;-1;-1;0;False;0;0;True;10;-1;0;True;21;0;0;0;False;0.1;False;-1;0;False;-1;True;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;285;-2176,128;Inherit;False;1026.438;100;Features;0;;0,1,0.5,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;33;-2176,-512;Inherit;False;1022.896;100;Final;0;;0,1,0.5,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;37;-2176,-1024;Inherit;False;1026.438;100;Internal;0;;1,0.252,0,1;0;0
WireConnection;0;0;334;0
WireConnection;0;1;334;528
WireConnection;0;4;334;530
WireConnection;0;5;334;531
WireConnection;0;9;334;532
WireConnection;0;10;334;653
WireConnection;0;11;334;534
ASEEND*/
//CHKSM=EA27A3AA1E32BEAC9BA46739C279CA4A1A447C95
