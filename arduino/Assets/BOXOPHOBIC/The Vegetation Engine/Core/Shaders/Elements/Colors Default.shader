// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Vegetation Engine/Elements/Default/Colors Default"
{
	Properties
	{
		[StyledBanner(Color Element)]_Banner("Banner", Float) = 0
		[StyledMessage(Info, Use the Colors elements to add color tinting to the vegetation assets. Element Texture R is used as alpha mask. Particle Color RGB is used as Main multiplier and Alpha as Element Intensity multiplier., 0,0)]_Message("Message", Float) = 0
		[StyledCategory(Render Settings)]_RenderCat("[ Render Cat ]", Float) = 0
		[StyledMessage(Info, This Element requires a Volume Buffer set to Vegetation to render to and it will affect the Vegetation shaders only. Read more about Volume Buffers and Layers in the documentation., _ElementLayer, 10, 0, 10)]_ElementLayerVegetationMessage("Element Layer Vegetation Message", Float) = 0
		[StyledMessage(Info, This Element requires a Volume Buffer set to Objects to render to and it will affect the Objects shaders only. Read more about Volume Buffers and Layers in the documentation., _ElementLayer, 30, 0, 10)]_ElementLayerObjectsMessage("Element Layer Objects Message", Float) = 0
		[StyledMessage(Info, This Element requires a Volume Buffer set to Grass to render to and it will affect the Grass shaders only. Read more about Volume Buffers and Layers in the documentation., _ElementLayer, 20, 0, 10)]_ElementLayerGrassMessage("Element Layer Grass Message", Float) = 0
		[StyledMessage(Info, This Element requires a Volume Buffer set to Custom to render to and it will affect the Custom shaders only. Read more about Volume Buffers and Layers in the documentation., _ElementLayer, 100, 0, 10)]_ElementLayerCustomMessage("Element Layer Custom Message", Float) = 0
		[Enum(Any,0,Vegetation,10,Grass,20,Objects,30,Custom,100)]_ElementLayer("Element Layer", Float) = 0
		[Enum(Main,0,Seasons,1)]_ElementMode("Element Mode", Float) = 0
		[StyledCategory(Element Settings)]_ElementCat("[ Element Cat ]", Float) = 0
		_ElementIntensity("Element Intensity", Range( 0 , 1)) = 1
		[NoScaleOffset][Space(10)]_MainTex("Element Texture", 2D) = "white" {}
		_MainTexMinValue("Element Min", Range( 0 , 1)) = 0
		_MainTexMaxValue("Element Max", Range( 0 , 1)) = 1
		[Space(10)]_MainUVs("Element UVs", Vector) = (1,1,0,0)
		[HDR][Gamma]_MainColor("Main", Color) = (0.5019608,0.5019608,0.5019608,1)
		[HDR][Gamma]_AdditionalColor1("Winter", Color) = (0.5019608,0.5019608,0.5019608,1)
		[HDR][Gamma]_AdditionalColor2("Spring", Color) = (0.5019608,0.5019608,0.5019608,1)
		[HDR][Gamma]_AdditionalColor3("Summer", Color) = (0.5019608,0.5019608,0.5019608,1)
		[HDR][Gamma]_AdditionalColor4("Autumn", Color) = (0.5019608,0.5019608,0.5019608,1)
		[StyledCategory(Advanced)]_AdvancedCat("[ Advanced Cat ]", Float) = 0
		[StyledMessage(Info, Use this feature to fade out elements that are close to the edge of the Global Volume to avoid rendering issues., _ElementFadeSupport, 1, 2, 10)]_ElementFadeMessage("Enable Fade Message", Float) = 0
		[Toggle]_ElementFadeSupport("Enable Edge Fade Support", Float) = 1
		[HideInInspector]_IsVersion("_IsVersion", Float) = 200
		[HideInInspector]_IsElementShader("_IsElementShader", Float) = 1
		[HideInInspector]_WinterColor("_WinterColor", Color) = (0.5019608,0.5019608,0.5019608,1)
		[HideInInspector]_SpringColor("_SpringColor", Color) = (0.5019608,0.5019608,0.5019608,1)
		[HideInInspector]_SummerColor("_SummerColor", Color) = (0.5019608,0.5019608,0.5019608,1)
		[HideInInspector]_AutumnColor("_AutumnColor", Color) = (0.5019608,0.5019608,0.5019608,1)
		[HideInInspector]_WinterValue("_WinterValue", Float) = 0
		[HideInInspector]_SpringValue("_SpringValue", Float) = 0
		[HideInInspector]_SummerValue("_SummerValue", Float) = 0
		[HideInInspector]_AutumnValue("_AutumnValue", Float) = 0
		[HideInInspector]_IsColorsShader("_IsColorsShader", Float) = 1

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Transparent" "Queue"="Transparent" "PreviewType"="Plane" }
	LOD 0

		CGINCLUDE
		#pragma target 2.0
		ENDCG
		Blend SrcAlpha OneMinusSrcAlpha
		AlphaToMask Off
		Cull Off
		ColorMask RGB
		ZWrite Off
		ZTest LEqual
		
		
		
		Pass
		{
			Name "Unlit"
			//Tags { "LightMode"="ForwardBase" }
			CGPROGRAM

			

			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			#define ASE_NEEDS_FRAG_COLOR
			#define ASE_NEEDS_FRAG_WORLD_POSITION


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 worldPos : TEXCOORD0;
				#endif
				float4 ase_color : COLOR;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform half _Banner;
			uniform half _ElementLayer;
			uniform half4 _WinterColor;
			uniform half _IsElementShader;
			uniform half4 _SummerColor;
			uniform half _ElementLayerVegetationMessage;
			uniform half _ElementLayerObjectsMessage;
			uniform half _ElementLayerGrassMessage;
			uniform half _ElementCat;
			uniform half _ElementFadeMessage;
			uniform half _ElementLayerCustomMessage;
			uniform half _WinterValue;
			uniform half _AdvancedCat;
			uniform half _SummerValue;
			uniform half _AutumnValue;
			uniform half _RenderCat;
			uniform half _SpringValue;
			uniform half4 _SpringColor;
			uniform half _IsVersion;
			uniform half4 _AutumnColor;
			uniform half _IsColorsShader;
			uniform half _Message;
			uniform half4 _MainColor;
			uniform half4 TVE_SeasonOptions;
			uniform half4 _AdditionalColor1;
			uniform half4 _AdditionalColor2;
			uniform half TVE_SeasonLerp;
			uniform half4 _AdditionalColor3;
			uniform half4 _AdditionalColor4;
			uniform half _ElementMode;
			uniform sampler2D _MainTex;
			uniform half4 _MainUVs;
			uniform half _MainTexMinValue;
			uniform half _MainTexMaxValue;
			uniform half _ElementIntensity;
			uniform half4 TVE_VolumeCoord;
			uniform half TVE_ElementFadeContrast;
			uniform half _ElementFadeSupport;

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_color = v.color;
				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = vertexValue;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);

				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				#endif
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 WorldPosition = i.worldPos;
				#endif
				half4 Color_Main_RGBA49_g18778 = _MainColor;
				half TVE_SeasonOptions_X50_g18778 = TVE_SeasonOptions.x;
				half4 Color_Winter_RGBA58_g18778 = _AdditionalColor1;
				half4 Color_Spring_RGBA59_g18778 = _AdditionalColor2;
				half TVE_SeasonLerp54_g18778 = TVE_SeasonLerp;
				half4 lerpResult13_g18778 = lerp( Color_Winter_RGBA58_g18778 , Color_Spring_RGBA59_g18778 , TVE_SeasonLerp54_g18778);
				half TVE_SeasonOptions_Y51_g18778 = TVE_SeasonOptions.y;
				half4 Color_Summer_RGBA60_g18778 = _AdditionalColor3;
				half4 lerpResult14_g18778 = lerp( Color_Spring_RGBA59_g18778 , Color_Summer_RGBA60_g18778 , TVE_SeasonLerp54_g18778);
				half TVE_SeasonOptions_Z52_g18778 = TVE_SeasonOptions.z;
				half4 Color_Autumn_RGBA61_g18778 = _AdditionalColor4;
				half4 lerpResult15_g18778 = lerp( Color_Summer_RGBA60_g18778 , Color_Autumn_RGBA61_g18778 , TVE_SeasonLerp54_g18778);
				half TVE_SeasonOptions_W53_g18778 = TVE_SeasonOptions.w;
				half4 lerpResult12_g18778 = lerp( Color_Autumn_RGBA61_g18778 , Color_Winter_RGBA58_g18778 , TVE_SeasonLerp54_g18778);
				half Element_Mode55_g18778 = _ElementMode;
				half4 lerpResult30_g18778 = lerp( Color_Main_RGBA49_g18778 , ( ( TVE_SeasonOptions_X50_g18778 * lerpResult13_g18778 ) + ( TVE_SeasonOptions_Y51_g18778 * lerpResult14_g18778 ) + ( TVE_SeasonOptions_Z52_g18778 * lerpResult15_g18778 ) + ( TVE_SeasonOptions_W53_g18778 * lerpResult12_g18778 ) ) , Element_Mode55_g18778);
				half3 Final_Colors_RGB142_g18778 = (( lerpResult30_g18778 * i.ase_color )).rgb;
				half4 tex2DNode17_g18778 = tex2D( _MainTex, ( ( i.ase_texcoord1.xy * (_MainUVs).xy ) + (_MainUVs).zw ) );
				half temp_output_7_0_g18784 = _MainTexMinValue;
				half4 temp_cast_0 = (temp_output_7_0_g18784).xxxx;
				half4 break469_g18778 = saturate( ( ( tex2DNode17_g18778 - temp_cast_0 ) / ( _MainTexMaxValue - temp_output_7_0_g18784 ) ) );
				half MainTex_R73_g18778 = break469_g18778.r;
				half temp_output_7_0_g18786 = TVE_ElementFadeContrast;
				half2 temp_cast_1 = (temp_output_7_0_g18786).xx;
				half Enable_Fade_Support454_g18778 = _ElementFadeSupport;
				half lerpResult654_g18778 = lerp( 1.0 , ( 1.0 - saturate( ( pow( saturate( ( ( abs( (( (TVE_VolumeCoord).zw + ( (TVE_VolumeCoord).xy * (WorldPosition).xz ) )*2.0 + -1.0) ) - temp_cast_1 ) / ( 1.0 - temp_output_7_0_g18786 ) ) ) , 2.0 ).x + 0.0 ) ) ) , Enable_Fade_Support454_g18778);
				half FadeOut_Mask656_g18778 = lerpResult654_g18778;
				half Element_Intensity56_g18778 = ( _ElementIntensity * i.ase_color.a * FadeOut_Mask656_g18778 );
				half Final_Colors_A144_g18778 = ( MainTex_R73_g18778 * Element_Intensity56_g18778 );
				half4 appendResult470_g18778 = (half4(Final_Colors_RGB142_g18778 , Final_Colors_A144_g18778));
				
				
				finalColor = appendResult470_g18778;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "TVEShaderElementGUI"
	
	
}
/*ASEBEGIN
Version=18600
1927;1;1906;1020;1456.167;1085.316;1;True;False
Node;AmplifyShaderEditor.FunctionNode;108;-304,-768;Inherit;False;Is Colors Shader;46;;18789;378049ebac362e14aae08c2daa8ed737;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;100;-480,-768;Half;False;Property;_Message;Message;1;0;Create;True;0;0;True;1;StyledMessage(Info, Use the Colors elements to add color tinting to the vegetation assets. Element Texture R is used as alpha mask. Particle Color RGB is used as Main multiplier and Alpha as Element Intensity multiplier., 0,0);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;97;-640,-768;Half;False;Property;_Banner;Banner;0;0;Create;True;0;0;True;1;StyledBanner(Color Element);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;155;-640,-512;Inherit;False;Base Element;2;;18778;0e972c73cae2ee54ea51acc9738801d0;6,477,1,478,0,145,0,481,0,576,1,491,1;0;1;FLOAT4;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;-304,-512;Half;False;True;-1;2;TVEShaderElementGUI;0;1;BOXOPHOBIC/The Vegetation Engine/Elements/Default/Colors Default;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;2;5;False;-1;10;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;True;0;False;-1;True;2;False;-1;True;True;True;True;False;0;False;-1;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;2;False;-1;True;0;False;-1;True;False;0;False;-1;0;False;-1;True;3;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;PreviewType=Plane;True;0;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;False;0
WireConnection;0;0;155;0
ASEEND*/
//CHKSM=0FF1F874AF6F1839A420E6B65440EA2615C0C820