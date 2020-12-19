// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Vegetation Engine/Objects/Prop Standard Lit"
{
	Properties
	{
		[StyledBanner(Prop Standard Lit)]_Banner("Banner", Float) = 0
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
		[StyledSpace(10)]_GlobalSpace("# Global Space", Float) = 0
		_OverlayContrastValue("Overlay Contrast", Range( 0 , 10)) = 4
		[StyledCategory(Main Settings)]_MainCat("[ Main Cat ]", Float) = 0
		[NoScaleOffset]_MainAlbedoTex("Main Albedo", 2D) = "white" {}
		[NoScaleOffset]_MainNormalTex("Main Normal", 2D) = "gray" {}
		[NoScaleOffset]_MainMaskTex("Main Mask", 2D) = "white" {}
		[Space(10)]_MainUVs("Main UVs", Vector) = (1,1,0,0)
		[HDR]_MainColor("Main Color", Color) = (1,1,1,1)
		_MainNormalValue("Main Normal", Range( -8 , 8)) = 1
		_MainMetallicValue("Main Metallic", Range( 0 , 1)) = 0
		_MainOcclusionValue("Main Occlusion", Range( 0 , 1)) = 1
		_MainSmoothnessValue("Main Smoothness", Range( 0 , 1)) = 1
		[StyledCategory(Detail Settings)]_DetailCat("[ Detail Cat ]", Float) = 0
		[Enum(Off,0,Overlay,1,Replace,2)]_DetailMode("Detail Mode", Float) = 0
		[Enum(Vertex Paint,0,Projection,1)]_DetailTypeMode("Detail Type", Float) = 0
		[Enum(UV 0,0,UV 2,1)]_DetailCoordMode("Detail Coord", Float) = 0
		[Enum(Top,0,Bottom,1)]_DetailProjectionMode("Detail Projection", Float) = 0
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
		_SecondMetallicValue("Detail Metallic", Range( 0 , 1)) = 0
		_SecondOcclusionValue("Detail Occlusion", Range( 0 , 1)) = 1
		_SecondSmoothnessValue("Detail Smoothness", Range( 0 , 1)) = 1
		[Space(10)]_DetailNormalValue("Detail Use Main Normal", Range( 0 , 1)) = 0.5
		[Space(10)]_DetailMeshValue("Detail Mask Offset", Range( -1 , 1)) = 0
		_DetailMaskValue("Detail Mask Power", Range( -1 , 1)) = 0
		_DetailMaskContrast("Detail Mask Contrast", Range( 0 , 1)) = 0.25
		[HideInInspector][ASEDiffusionProfile(_SubsurfaceDiffusion)]_SubsurfaceDiffusion_asset("Subsurface Diffusion", Vector) = (0,0,0,0)
		[StyledMessage(Info, The Object motion feature allows for high quality bending motion and interaction. The motion and global elements are calculated per instance., _VertexMotionMode, 0 , 2, 0)]_ObjectDataMessage("# Object Data Message", Float) = 0
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[StyledMessage(Info, The World motion feature allows for simpler and cheaper translation motion and interaction. The motion is calculated in world space but the global elements are calculated per instance., _VertexMotionMode, 1 , 2, 0)]_WorldDataMessage("# World Data Message", Float) = 0
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[StyledMessage(Info, The Baked pivots feature allows for using per mesh element interaction and elements influence. This feature requires pre baked pivots on prefab conversion. Useful for latge grass meshes., _VertexPivotMode, 1 , 0, 0)]_PivotsMessage("# Pivots Message", Float) = 0
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
		[HideInInspector]_IsPropShader("_IsPropShader", Float) = 1
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
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" }
		Cull [_render_cull]
		ZWrite [_render_zw]
		Blend [_render_src] [_render_dst]
		
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma multi_compile_instancing
		#pragma shader_feature_local _ALPHATEST_ON
		#pragma shader_feature_local TVE_DETAIL_MODE_OFF TVE_DETAIL_MODE_OVERLAY TVE_DETAIL_MODE_REPLACE
		#pragma shader_feature_local TVE_DETAIL_MAPS_STANDARD TVE_DETAIL_MAPS_PACKED
		#pragma shader_feature_local TVE_DETAIL_TYPE_VERTEX_BLUE TVE_DETAIL_TYPE_PROJECTION
		#define TVE_IS_OBJECT_SHADER
		#define TVE_VERTEX_DATA_BATCHED
		  
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
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows nodynlightmap dithercrossfade 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float2 uv2_texcoord2;
			float3 worldPos;
			float4 vertexColor : COLOR;
			float3 worldNormal;
			INTERNAL_DATA
			half ASEVFace : VFACE;
			float4 uv_tex4coord;
		};

		uniform half _render_dst;
		uniform half _render_zw;
		uniform half _render_cull;
		uniform half _render_cutoff;
		uniform half _render_src;
		uniform half _Banner;
		uniform half _IsStandardShader;
		uniform half _IsAnyPathShader;
		uniform half _IsPropShader;
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
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MainNormalTex);
		SamplerState sampler_MainNormalTex;
		uniform half4 _MainUVs;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MainAlbedoTex);
		SamplerState sampler_MainAlbedoTex;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondNormalTex);
		SamplerState sampler_SecondNormalTex;
		uniform half _DetailCoordMode;
		uniform half4 _SecondUVs;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondMaskTex);
		SamplerState sampler_SecondMaskTex;
		uniform half _SecondNormalValue;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondPackedTex);
		SamplerState sampler_SecondPackedTex;
		uniform half _DetailMeshValue;
		uniform half _DetailProjectionMode;
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
		UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_ExtrasTex);
		uniform half4 TVE_VolumeCoord;
		uniform half _vertex_pivot_mode;
		SamplerState samplerTVE_ExtrasTex;
		UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_ExtrasTex_Vegetation);
		SamplerState samplerTVE_ExtrasTex_Vegetation;
		UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_ExtrasTex_Grass);
		SamplerState samplerTVE_ExtrasTex_Grass;
		UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_ExtrasTex_Objects);
		SamplerState samplerTVE_ExtrasTex_Objects;
		UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_ExtrasTex_User);
		SamplerState samplerTVE_ExtrasTex_User;
		uniform half _render_premul;
		uniform half _MainMetallicValue;
		uniform half _SecondMetallicValue;
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


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			half2 Main_UVs15_g32330 = ( ( i.uv_texcoord * (_MainUVs).xy ) + (_MainUVs).zw );
			float4 tex2DNode117_g32330 = SAMPLE_TEXTURE2D( _MainNormalTex, sampler_MainAlbedoTex, Main_UVs15_g32330 );
			float2 appendResult88_g32336 = (float2(tex2DNode117_g32330.a , tex2DNode117_g32330.g));
			float2 temp_output_90_0_g32336 = ( (appendResult88_g32336*2.0 + -1.0) * _MainNormalValue );
			float3 appendResult91_g32336 = (float3(temp_output_90_0_g32336 , 1.0));
			half3 Main_Normal137_g32330 = appendResult91_g32336;
			float2 lerpResult1545_g32330 = lerp( i.uv_texcoord , i.uv2_texcoord2 , _DetailCoordMode);
			float3 ase_worldPos = i.worldPos;
			#if defined(TVE_DETAIL_TYPE_VERTEX_BLUE)
				float2 staticSwitch3466_g32330 = lerpResult1545_g32330;
			#elif defined(TVE_DETAIL_TYPE_PROJECTION)
				float2 staticSwitch3466_g32330 = (ase_worldPos).xz;
			#else
				float2 staticSwitch3466_g32330 = lerpResult1545_g32330;
			#endif
			half2 Second_UVs17_g32330 = ( ( staticSwitch3466_g32330 * (_SecondUVs).xy ) + (_SecondUVs).zw );
			float4 tex2DNode145_g32330 = SAMPLE_TEXTURE2D( _SecondNormalTex, sampler_SecondMaskTex, Second_UVs17_g32330 );
			float2 appendResult88_g32357 = (float2(tex2DNode145_g32330.a , tex2DNode145_g32330.g));
			float2 temp_output_90_0_g32357 = ( (appendResult88_g32357*2.0 + -1.0) * _SecondNormalValue );
			float3 appendResult91_g32357 = (float3(temp_output_90_0_g32357 , 1.0));
			float4 tex2DNode3380_g32330 = SAMPLE_TEXTURE2D( _SecondPackedTex, sampler_SecondMaskTex, Second_UVs17_g32330 );
			half Packed_NormalX3387_g32330 = tex2DNode3380_g32330.a;
			half Packed_NormalY3386_g32330 = tex2DNode3380_g32330.g;
			float2 appendResult88_g32340 = (float2(Packed_NormalX3387_g32330 , Packed_NormalY3386_g32330));
			float2 temp_output_90_0_g32340 = ( (appendResult88_g32340*2.0 + -1.0) * _SecondNormalValue );
			float3 appendResult91_g32340 = (float3(temp_output_90_0_g32340 , 1.0));
			#if defined(TVE_DETAIL_MAPS_STANDARD)
				float3 staticSwitch3450_g32330 = appendResult91_g32357;
			#elif defined(TVE_DETAIL_MAPS_PACKED)
				float3 staticSwitch3450_g32330 = appendResult91_g32340;
			#else
				float3 staticSwitch3450_g32330 = appendResult91_g32357;
			#endif
			half3 Second_Normal179_g32330 = staticSwitch3450_g32330;
			half Mesh_DetailMask90_g32330 = i.vertexColor.b;
			float temp_output_989_0_g32330 = ( ( Mesh_DetailMask90_g32330 - 0.5 ) + _DetailMeshValue );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 lerpResult1537_g32330 = lerp( float3(0,1,0) , float3(0,-1,0) , _DetailProjectionMode);
			float dotResult1532_g32330 = dot( ase_worldNormal , lerpResult1537_g32330 );
			#if defined(TVE_DETAIL_TYPE_VERTEX_BLUE)
				float staticSwitch3467_g32330 = temp_output_989_0_g32330;
			#elif defined(TVE_DETAIL_TYPE_PROJECTION)
				float staticSwitch3467_g32330 = ( ( dotResult1532_g32330 * 0.5 ) + _DetailMeshValue );
			#else
				float staticSwitch3467_g32330 = temp_output_989_0_g32330;
			#endif
			half Blend_Source1540_g32330 = staticSwitch3467_g32330;
			float4 tex2DNode35_g32330 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainAlbedoTex, Main_UVs15_g32330 );
			half Main_Mask_Raw57_g32330 = tex2DNode35_g32330.b;
			float4 tex2DNode33_g32330 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, Second_UVs17_g32330 );
			half Second_Mask81_g32330 = tex2DNode33_g32330.b;
			float lerpResult1327_g32330 = lerp( Main_Mask_Raw57_g32330 , Second_Mask81_g32330 , _DetailMaskMode);
			float temp_output_7_0_g32344 = _DetailMaskContrast;
			float temp_output_973_0_g32330 = saturate( ( ( saturate( ( Blend_Source1540_g32330 + ( Blend_Source1540_g32330 * ( ( ( 1.0 - lerpResult1327_g32330 ) - 0.5 ) + _DetailMaskValue ) ) ) ) - temp_output_7_0_g32344 ) / ( ( 1.0 - _DetailMaskContrast ) - temp_output_7_0_g32344 ) ) );
			half Mask_Detail147_g32330 = temp_output_973_0_g32330;
			float3 lerpResult230_g32330 = lerp( float3( 0,0,1 ) , Second_Normal179_g32330 , Mask_Detail147_g32330);
			float3 lerpResult3372_g32330 = lerp( float3( 0,0,1 ) , Main_Normal137_g32330 , _DetailNormalValue);
			float3 lerpResult3376_g32330 = lerp( Main_Normal137_g32330 , BlendNormals( lerpResult3372_g32330 , Second_Normal179_g32330 ) , Mask_Detail147_g32330);
			#if defined(TVE_DETAIL_MODE_OFF)
				float3 staticSwitch267_g32330 = Main_Normal137_g32330;
			#elif defined(TVE_DETAIL_MODE_OVERLAY)
				float3 staticSwitch267_g32330 = BlendNormals( Main_Normal137_g32330 , lerpResult230_g32330 );
			#elif defined(TVE_DETAIL_MODE_REPLACE)
				float3 staticSwitch267_g32330 = lerpResult3376_g32330;
			#else
				float3 staticSwitch267_g32330 = Main_Normal137_g32330;
			#endif
			float3 temp_output_13_0_g32354 = staticSwitch267_g32330;
			float3 switchResult12_g32354 = (((i.ASEVFace>0)?(temp_output_13_0_g32354):(( temp_output_13_0_g32354 * _render_normals_options ))));
			half3 Blend_Normal312_g32330 = switchResult12_g32354;
			half3 Final_Normal366_g32330 = Blend_Normal312_g32330;
			o.Normal = Final_Normal366_g32330;
			float4 tex2DNode29_g32330 = SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, Main_UVs15_g32330 );
			float4 temp_output_51_0_g32330 = ( _MainColor * tex2DNode29_g32330 );
			half3 Main_AlbedoRaw99_g32330 = (temp_output_51_0_g32330).rgb;
			half3 Main_AlbedoTinted2808_g32330 = ( float3(1,1,1) * float3(1,1,1) * Main_AlbedoRaw99_g32330 * float3(1,1,1) );
			half3 Main_AlbedoColored863_g32330 = Main_AlbedoTinted2808_g32330;
			half Packed_Albedo3385_g32330 = tex2DNode3380_g32330.r;
			float4 temp_cast_0 = (Packed_Albedo3385_g32330).xxxx;
			#if defined(TVE_DETAIL_MAPS_STANDARD)
				float4 staticSwitch3449_g32330 = SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondMaskTex, Second_UVs17_g32330 );
			#elif defined(TVE_DETAIL_MAPS_PACKED)
				float4 staticSwitch3449_g32330 = temp_cast_0;
			#else
				float4 staticSwitch3449_g32330 = SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondMaskTex, Second_UVs17_g32330 );
			#endif
			half3 Second_Albedo153_g32330 = (( _SecondColor * staticSwitch3449_g32330 )).rgb;
			half3 Second_AlbedoColored1963_g32330 = Second_Albedo153_g32330;
			#ifdef UNITY_COLORSPACE_GAMMA
				float staticSwitch1_g32350 = 2.0;
			#else
				float staticSwitch1_g32350 = 4.594794;
			#endif
			float3 lerpResult235_g32330 = lerp( Main_AlbedoColored863_g32330 , ( Main_AlbedoColored863_g32330 * Second_AlbedoColored1963_g32330 * staticSwitch1_g32350 ) , Mask_Detail147_g32330);
			float3 lerpResult208_g32330 = lerp( Main_AlbedoColored863_g32330 , Second_AlbedoColored1963_g32330 , Mask_Detail147_g32330);
			#if defined(TVE_DETAIL_MODE_OFF)
				float3 staticSwitch255_g32330 = Main_AlbedoColored863_g32330;
			#elif defined(TVE_DETAIL_MODE_OVERLAY)
				float3 staticSwitch255_g32330 = lerpResult235_g32330;
			#elif defined(TVE_DETAIL_MODE_REPLACE)
				float3 staticSwitch255_g32330 = lerpResult208_g32330;
			#else
				float3 staticSwitch255_g32330 = Main_AlbedoColored863_g32330;
			#endif
			half3 Blend_Albedo265_g32330 = staticSwitch255_g32330;
			half3 Blend_AlbedoAndSubsurface149_g32330 = Blend_Albedo265_g32330;
			half3 Global_OverlayColor1758_g32330 = (TVE_OverlayColor).rgb;
			half3 Blend_NormalRaw1051_g32330 = staticSwitch267_g32330;
			float3 switchResult1063_g32330 = (((i.ASEVFace>0)?(Blend_NormalRaw1051_g32330):(( Blend_NormalRaw1051_g32330 * float3(-1,-1,-1) ))));
			half Overlay_Contrast1405_g32330 = _OverlayContrastValue;
			float3 appendResult1439_g32330 = (float3(Overlay_Contrast1405_g32330 , Overlay_Contrast1405_g32330 , 1.0));
			half Global_OverlayIntensity154_g32330 = TVE_OverlayIntensity;
			float4x4 break19_g32400 = unity_ObjectToWorld;
			float3 appendResult20_g32400 = (float3(break19_g32400[ 0 ][ 3 ] , break19_g32400[ 1 ][ 3 ] , break19_g32400[ 2 ][ 3 ]));
			half3 Off19_g32401 = appendResult20_g32400;
			float4 ase_vertex4Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float4 transform68_g32400 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float3 appendResult95_g32400 = (float3(i.uv_tex4coord.z , 0.0 , i.uv_tex4coord.w));
			float4 transform62_g32400 = mul(unity_ObjectToWorld,float4( ( ase_vertex3Pos - ( appendResult95_g32400 * _vertex_pivot_mode ) ) , 0.0 ));
			float3 ObjectPositionWithPivots28_g32400 = ( (transform68_g32400).xyz - (transform62_g32400).xyz );
			half3 On20_g32401 = ObjectPositionWithPivots28_g32400;
			#ifdef TVE_PIVOT_DATA_BAKED
				float3 staticSwitch14_g32401 = On20_g32401;
			#else
				float3 staticSwitch14_g32401 = Off19_g32401;
			#endif
			half3 ObjectData20_g32402 = staticSwitch14_g32401;
			half3 WorldData19_g32402 = Off19_g32401;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g32402 = WorldData19_g32402;
			#else
				float3 staticSwitch14_g32402 = ObjectData20_g32402;
			#endif
			float3 temp_output_42_0_g32400 = staticSwitch14_g32402;
			half3 ObjectData20_g32399 = temp_output_42_0_g32400;
			half3 WorldData19_g32399 = ase_worldPos;
			#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g32399 = WorldData19_g32399;
			#else
				float3 staticSwitch14_g32399 = ObjectData20_g32399;
			#endif
			float2 temp_output_43_38_g32397 = ( (TVE_VolumeCoord).zw + ( (TVE_VolumeCoord).xy * (staticSwitch14_g32399).xz ) );
			half4 Legacy33_g32398 = SAMPLE_TEXTURE2D( TVE_ExtrasTex, samplerTVE_ExtrasTex, temp_output_43_38_g32397 );
			half4 Vegetation33_g32398 = SAMPLE_TEXTURE2D( TVE_ExtrasTex_Vegetation, samplerTVE_ExtrasTex_Vegetation, temp_output_43_38_g32397 );
			half4 Grass33_g32398 = SAMPLE_TEXTURE2D( TVE_ExtrasTex_Grass, samplerTVE_ExtrasTex_Grass, temp_output_43_38_g32397 );
			half4 Objects33_g32398 = SAMPLE_TEXTURE2D( TVE_ExtrasTex_Objects, samplerTVE_ExtrasTex_Objects, temp_output_43_38_g32397 );
			half4 Custom33_g32398 = SAMPLE_TEXTURE2D( TVE_ExtrasTex_User, samplerTVE_ExtrasTex_User, temp_output_43_38_g32397 );
			half4 localUSE_BUFFERS33_g32398 = USE_BUFFERS( Legacy33_g32398 , Vegetation33_g32398 , Grass33_g32398 , Objects33_g32398 , Custom33_g32398 );
			float4 break49_g32397 = localUSE_BUFFERS33_g32398;
			half Global_ExtrasTex_B156_g32330 = break49_g32397.z;
			float temp_output_1025_0_g32330 = ( Global_OverlayIntensity154_g32330 * _GlobalOverlay * Global_ExtrasTex_B156_g32330 );
			half Overlay_Commons1365_g32330 = temp_output_1025_0_g32330;
			half Overlay_Mask269_g32330 = saturate( ( saturate( (WorldNormalVector( i , ( switchResult1063_g32330 * appendResult1439_g32330 ) )).y ) - ( 1.0 - Overlay_Commons1365_g32330 ) ) );
			float3 lerpResult336_g32330 = lerp( Blend_AlbedoAndSubsurface149_g32330 , Global_OverlayColor1758_g32330 , Overlay_Mask269_g32330);
			half3 Final_Albedo359_g32330 = lerpResult336_g32330;
			half Main_Alpha316_g32330 = (temp_output_51_0_g32330).a;
			float lerpResult354_g32330 = lerp( 1.0 , Main_Alpha316_g32330 , _render_premul);
			half Final_Premultiply355_g32330 = lerpResult354_g32330;
			float3 temp_output_410_0_g32330 = ( Final_Albedo359_g32330 * Final_Premultiply355_g32330 );
			o.Albedo = temp_output_410_0_g32330;
			half Main_Metallic237_g32330 = ( tex2DNode35_g32330.r * _MainMetallicValue );
			#if defined(TVE_DETAIL_MAPS_STANDARD)
				float staticSwitch3451_g32330 = ( tex2DNode33_g32330.r * _SecondMetallicValue );
			#elif defined(TVE_DETAIL_MAPS_PACKED)
				float staticSwitch3451_g32330 = 0.0;
			#else
				float staticSwitch3451_g32330 = ( tex2DNode33_g32330.r * _SecondMetallicValue );
			#endif
			half Second_Metallic226_g32330 = staticSwitch3451_g32330;
			float lerpResult278_g32330 = lerp( Main_Metallic237_g32330 , Second_Metallic226_g32330 , Mask_Detail147_g32330);
			#if defined(TVE_DETAIL_MODE_OFF)
				float staticSwitch299_g32330 = Main_Metallic237_g32330;
			#elif defined(TVE_DETAIL_MODE_OVERLAY)
				float staticSwitch299_g32330 = Main_Metallic237_g32330;
			#elif defined(TVE_DETAIL_MODE_REPLACE)
				float staticSwitch299_g32330 = lerpResult278_g32330;
			#else
				float staticSwitch299_g32330 = Main_Metallic237_g32330;
			#endif
			half Blend_Metallic306_g32330 = staticSwitch299_g32330;
			float lerpResult342_g32330 = lerp( Blend_Metallic306_g32330 , 0.0 , Overlay_Mask269_g32330);
			half Final_Metallic367_g32330 = lerpResult342_g32330;
			o.Metallic = Final_Metallic367_g32330;
			half Main_Smoothness227_g32330 = ( tex2DNode35_g32330.a * _MainSmoothnessValue );
			half Packed_Smoothness3388_g32330 = tex2DNode3380_g32330.b;
			#if defined(TVE_DETAIL_MAPS_STANDARD)
				float staticSwitch3456_g32330 = tex2DNode33_g32330.a;
			#elif defined(TVE_DETAIL_MAPS_PACKED)
				float staticSwitch3456_g32330 = Packed_Smoothness3388_g32330;
			#else
				float staticSwitch3456_g32330 = tex2DNode33_g32330.a;
			#endif
			half Second_Smoothness236_g32330 = ( staticSwitch3456_g32330 * _SecondSmoothnessValue );
			float lerpResult266_g32330 = lerp( Main_Smoothness227_g32330 , Second_Smoothness236_g32330 , Mask_Detail147_g32330);
			#if defined(TVE_DETAIL_MODE_OFF)
				float staticSwitch297_g32330 = Main_Smoothness227_g32330;
			#elif defined(TVE_DETAIL_MODE_OVERLAY)
				float staticSwitch297_g32330 = Main_Smoothness227_g32330;
			#elif defined(TVE_DETAIL_MODE_REPLACE)
				float staticSwitch297_g32330 = lerpResult266_g32330;
			#else
				float staticSwitch297_g32330 = Main_Smoothness227_g32330;
			#endif
			half Blend_Smoothness314_g32330 = staticSwitch297_g32330;
			half Global_OverlaySmoothness311_g32330 = TVE_OverlaySmoothness;
			float lerpResult343_g32330 = lerp( Blend_Smoothness314_g32330 , Global_OverlaySmoothness311_g32330 , Overlay_Mask269_g32330);
			half Final_Smoothness371_g32330 = lerpResult343_g32330;
			half Global_Wetness1016_g32330 = ( TVE_Wetness * _GlobalWetness );
			half Global_ExtrasTex_A1033_g32330 = break49_g32397.w;
			float lerpResult1037_g32330 = lerp( Final_Smoothness371_g32330 , saturate( ( Final_Smoothness371_g32330 + Global_Wetness1016_g32330 ) ) , Global_ExtrasTex_A1033_g32330);
			o.Smoothness = lerpResult1037_g32330;
			float lerpResult240_g32330 = lerp( 1.0 , tex2DNode35_g32330.g , _MainOcclusionValue);
			half Main_Occlusion247_g32330 = lerpResult240_g32330;
			float lerpResult239_g32330 = lerp( 1.0 , tex2DNode33_g32330.g , _SecondOcclusionValue);
			#if defined(TVE_DETAIL_MAPS_STANDARD)
				float staticSwitch3455_g32330 = lerpResult239_g32330;
			#elif defined(TVE_DETAIL_MAPS_PACKED)
				float staticSwitch3455_g32330 = 1.0;
			#else
				float staticSwitch3455_g32330 = lerpResult239_g32330;
			#endif
			half Second_Occlusion251_g32330 = staticSwitch3455_g32330;
			float lerpResult294_g32330 = lerp( Main_Occlusion247_g32330 , Second_Occlusion251_g32330 , Mask_Detail147_g32330);
			#if defined(TVE_DETAIL_MODE_OFF)
				float staticSwitch310_g32330 = Main_Occlusion247_g32330;
			#elif defined(TVE_DETAIL_MODE_OVERLAY)
				float staticSwitch310_g32330 = ( Main_Occlusion247_g32330 * Second_Occlusion251_g32330 );
			#elif defined(TVE_DETAIL_MODE_REPLACE)
				float staticSwitch310_g32330 = lerpResult294_g32330;
			#else
				float staticSwitch310_g32330 = Main_Occlusion247_g32330;
			#endif
			half Blend_Occlusion323_g32330 = staticSwitch310_g32330;
			o.Occlusion = Blend_Occlusion323_g32330;
			o.Alpha = Main_Alpha316_g32330;
			half Main_AlphaRaw1203_g32330 = tex2DNode29_g32330.a;
			half Alpha5_g32359 = Main_AlphaRaw1203_g32330;
			#ifdef _ALPHATEST_ON
				float staticSwitch2_g32359 = Alpha5_g32359;
			#else
				float staticSwitch2_g32359 = 1.0;
			#endif
			half Final_Clip914_g32330 = staticSwitch2_g32359;
			clip( Final_Clip914_g32330 - _render_cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "TVEShaderCoreGUI"
}
/*ASEBEGIN
Version=18600
1927;1;1906;1020;2804.561;498.999;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;342;-1376,-896;Half;False;Property;_IsAnyPathShader;_IsAnyPathShader;205;1;[HideInInspector];Create;True;0;0;True;0;False;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;134;-1776,-896;Half;False;Property;_IsStandardShader;_IsStandardShader;207;1;[HideInInspector];Create;True;0;0;True;0;False;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;341;-2176,256;Inherit;False;Use TVE_VERTEX_DATA_BATCHED;-1;;32329;749c61e1189c7f8408d9e6db94560d1d;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;364;-2176,-384;Inherit;False;Base Shader;1;;32330;856f7164d1c579d43a5cf4968a75ca43;50,1300,1,1298,1,1271,0,1962,0,1708,0,1712,0,1964,1,1969,1,1719,0,893,0,1745,0,1742,0,1718,1,1714,1,1715,1,1717,1,916,1,1949,1,1763,0,1762,0,1776,0,1646,0,1690,0,1757,0,3221,3,1981,0,2807,0,2953,0,3243,0,2172,0,2658,0,1734,1,1733,1,1735,1,1736,1,1966,1,1968,1,1737,1,878,1,1550,1,860,0,2750,0,2261,1,2260,1,2054,1,2032,1,2060,1,2036,1,2062,1,2039,1;0;15;FLOAT3;0;FLOAT3;528;FLOAT3;2489;FLOAT;529;FLOAT;530;FLOAT;531;FLOAT;1235;FLOAT3;1230;FLOAT;1461;FLOAT;1290;FLOAT;721;FLOAT;532;FLOAT;653;FLOAT;629;FLOAT3;534
Node;AmplifyShaderEditor.RangedFloatNode;81;-1552,-896;Half;False;Property;_IsLitShader;_IsLitShader;206;1;[HideInInspector];Create;True;0;0;True;0;False;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;127;-1984,-896;Half;False;Property;_IsPropShader;_IsPropShader;204;1;[HideInInspector];Create;True;0;0;True;0;False;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-2176,-896;Half;False;Property;_Banner;Banner;0;0;Create;True;0;0;True;1;StyledBanner(Prop Standard Lit);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;343;-2176,320;Inherit;False;Use TVE_IS_OBJECT_SHADER;-1;;32328;1237b3cc9fbfe714d8343c91216dc9b4;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1344,-768;Half;False;Property;_render_zw;_render_zw;212;1;[HideInInspector];Create;True;2;Opaque;0;Transparent;1;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1536,-768;Half;False;Property;_render_dst;_render_dst;211;1;[HideInInspector];Create;True;2;Opaque;0;Transparent;1;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1728,-768;Half;False;Property;_render_src;_render_src;210;1;[HideInInspector];Create;True;0;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-2176,-768;Half;False;Property;_render_cutoff;_render_cutoff;208;1;[HideInInspector];Create;True;4;Alpha;0;Premultiply;1;Additive;2;Multiply;3;0;True;0;False;0.5;0.719;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1920,-769;Half;False;Property;_render_cull;_render_cull;209;1;[HideInInspector];Create;True;3;Both;0;Back;1;Front;2;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-1376,-384;Float;False;True;-1;2;TVEShaderCoreGUI;0;0;Standard;BOXOPHOBIC/The Vegetation Engine/Objects/Prop Standard Lit;False;False;False;False;False;False;False;True;False;False;False;False;True;False;True;False;True;False;False;False;True;Back;0;True;17;0;False;-1;False;0;False;-1;-1;False;-1;False;0;Custom;0.719;True;True;0;True;Opaque;;Geometry;All;11;d3d11;glcore;gles3;metal;vulkan;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;1;0;True;20;0;True;7;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Absolute;0;;-1;-1;-1;-1;0;False;0;0;True;10;-1;0;True;21;0;0;0;False;0.1;False;-1;0;False;-1;True;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;33;-2176,-512;Inherit;False;1022.896;100;Final;0;;0,1,0.5,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;340;-2176,128;Inherit;False;1026.438;100;Features;0;;0,1,0.5,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;37;-2176,-1024;Inherit;False;1026.438;100;Internal;0;;1,0.252,0,1;0;0
WireConnection;0;0;364;0
WireConnection;0;1;364;528
WireConnection;0;3;364;529
WireConnection;0;4;364;530
WireConnection;0;5;364;531
WireConnection;0;9;364;532
WireConnection;0;10;364;653
ASEEND*/
//CHKSM=AF5749D962B354CCEB119FF4805526AF99F1103C
