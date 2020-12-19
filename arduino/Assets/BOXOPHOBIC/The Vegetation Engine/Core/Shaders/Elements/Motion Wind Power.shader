// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Vegetation Engine/Elements/Default/Motion Wind Power"
{
	Properties
	{
		[HideInInspector]_IsMotionShader("_IsMotionShader", Float) = 1
		[StyledBanner(Wind Power Element)]_Banner("Banner", Float) = 0
		[StyledMessage(Info, Use the Wind Power elements to control the global wind power. Element Texture R is used as alpha mask. Particle Color R is used as values multiplier and Alpha as Element Intensity multiplier. The Wind Power values are additive where 0.5 does not have any effect on the global wind power., 0,0)]_Message("Message", Float) = 0
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
		[Space(10)]_MainValue("Main", Range( 0 , 1)) = 1
		[Space(10)]_AdditionalValue1("Winter", Range( 0 , 1)) = 1
		_AdditionalValue2("Spring", Range( 0 , 1)) = 1
		_AdditionalValue3("Summer", Range( 0 , 1)) = 1
		_AdditionalValue4("Autumn", Range( 0 , 1)) = 1
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
		Cull Back
		ColorMask B
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

			uniform half _IsMotionShader;
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
			uniform half _Message;
			uniform half _Banner;
			uniform half _MainValue;
			uniform half4 TVE_SeasonOptions;
			uniform half _AdditionalValue1;
			uniform half _AdditionalValue2;
			uniform half TVE_SeasonLerp;
			uniform half _AdditionalValue3;
			uniform half _AdditionalValue4;
			uniform half _ElementMode;
			uniform half _ElementIntensity;
			uniform half4 TVE_VolumeCoord;
			uniform half TVE_ElementFadeContrast;
			uniform half _ElementFadeSupport;
			uniform sampler2D _MainTex;
			uniform half4 _MainUVs;
			uniform half _MainTexMinValue;
			uniform half _MainTexMaxValue;

			
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
				half Value_Main157_g18633 = _MainValue;
				half TVE_SeasonOptions_X50_g18633 = TVE_SeasonOptions.x;
				half Value_Winter158_g18633 = _AdditionalValue1;
				half Value_Spring159_g18633 = _AdditionalValue2;
				half TVE_SeasonLerp54_g18633 = TVE_SeasonLerp;
				half lerpResult168_g18633 = lerp( Value_Winter158_g18633 , Value_Spring159_g18633 , TVE_SeasonLerp54_g18633);
				half TVE_SeasonOptions_Y51_g18633 = TVE_SeasonOptions.y;
				half Value_Summer160_g18633 = _AdditionalValue3;
				half lerpResult167_g18633 = lerp( Value_Spring159_g18633 , Value_Summer160_g18633 , TVE_SeasonLerp54_g18633);
				half TVE_SeasonOptions_Z52_g18633 = TVE_SeasonOptions.z;
				half Value_Autumn161_g18633 = _AdditionalValue4;
				half lerpResult166_g18633 = lerp( Value_Summer160_g18633 , Value_Autumn161_g18633 , TVE_SeasonLerp54_g18633);
				half TVE_SeasonOptions_W53_g18633 = TVE_SeasonOptions.w;
				half lerpResult165_g18633 = lerp( Value_Autumn161_g18633 , Value_Winter158_g18633 , TVE_SeasonLerp54_g18633);
				half Element_Mode55_g18633 = _ElementMode;
				half lerpResult181_g18633 = lerp( Value_Main157_g18633 , ( ( TVE_SeasonOptions_X50_g18633 * lerpResult168_g18633 ) + ( TVE_SeasonOptions_Y51_g18633 * lerpResult167_g18633 ) + ( TVE_SeasonOptions_Z52_g18633 * lerpResult166_g18633 ) + ( TVE_SeasonOptions_W53_g18633 * lerpResult165_g18633 ) ) , Element_Mode55_g18633);
				half Base_Extras_RGB213_g18633 = ( lerpResult181_g18633 * i.ase_color.r );
				half temp_output_7_0_g18641 = TVE_ElementFadeContrast;
				half2 temp_cast_0 = (temp_output_7_0_g18641).xx;
				half Enable_Fade_Support454_g18633 = _ElementFadeSupport;
				half lerpResult654_g18633 = lerp( 1.0 , ( 1.0 - saturate( ( pow( saturate( ( ( abs( (( (TVE_VolumeCoord).zw + ( (TVE_VolumeCoord).xy * (WorldPosition).xz ) )*2.0 + -1.0) ) - temp_cast_0 ) / ( 1.0 - temp_output_7_0_g18641 ) ) ) , 2.0 ).x + 0.0 ) ) ) , Enable_Fade_Support454_g18633);
				half FadeOut_Mask656_g18633 = lerpResult654_g18633;
				half Element_Intensity56_g18633 = ( _ElementIntensity * i.ase_color.a * FadeOut_Mask656_g18633 );
				half lerpResult584_g18633 = lerp( 1.0 , Base_Extras_RGB213_g18633 , Element_Intensity56_g18633);
				half3 appendResult582_g18633 = (half3(0.0 , 0.0 , lerpResult584_g18633));
				half3 Final_Wind_RGB566_g18633 = appendResult582_g18633;
				half4 tex2DNode17_g18633 = tex2D( _MainTex, ( ( i.ase_texcoord1.xy * (_MainUVs).xy ) + (_MainUVs).zw ) );
				half temp_output_7_0_g18639 = _MainTexMinValue;
				half4 temp_cast_1 = (temp_output_7_0_g18639).xxxx;
				half4 break469_g18633 = saturate( ( ( tex2DNode17_g18633 - temp_cast_1 ) / ( _MainTexMaxValue - temp_output_7_0_g18639 ) ) );
				half MainTex_R73_g18633 = break469_g18633.r;
				half Final_Wind_A564_g18633 = MainTex_R73_g18633;
				half4 appendResult573_g18633 = (half4(Final_Wind_RGB566_g18633 , Final_Wind_A564_g18633));
				
				
				finalColor = appendResult573_g18633;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "TVEShaderElementGUI"
	
	
}
/*ASEBEGIN
Version=18600
1927;1;1906;1020;1137.101;2038.539;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;120;-96,-1536;Half;False;Property;_Message;Message;3;0;Create;True;0;0;True;1;StyledMessage(Info, Use the Wind Power elements to control the global wind power. Element Texture R is used as alpha mask. Particle Color R is used as values multiplier and Alpha as Element Intensity multiplier. The Wind Power values are additive where 0.5 does not have any effect on the global wind power., 0,0);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;115;-256,-1536;Half;False;Property;_Banner;Banner;2;0;Create;True;0;0;True;1;StyledBanner(Wind Power Element);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;131;80,-1536;Inherit;False;Is Motion Shader;0;;18632;6eebc31017d99e84e811285e6a5d199d;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;139;-256,-1280;Inherit;False;Base Element;4;;18633;0e972c73cae2ee54ea51acc9738801d0;6,477,0,478,0,145,3,481,3,576,1,491,1;0;1;FLOAT4;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;80,-1280;Half;False;True;-1;2;TVEShaderElementGUI;0;1;BOXOPHOBIC/The Vegetation Engine/Elements/Default/Motion Wind Power;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;2;5;False;-1;10;False;-1;0;2;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;True;0;False;-1;True;0;False;-1;True;False;False;True;False;0;False;-1;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;2;False;-1;True;0;False;-1;True;False;0;False;-1;0;False;-1;True;3;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;PreviewType=Plane;True;0;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;False;0
WireConnection;0;0;139;0
ASEEND*/
//CHKSM=FF1095235C19D50E1AA93E9B541A2C5FC6F9A884