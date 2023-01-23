// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "TsunaMoo/Mirror FX vO"
{
	Properties
	{
		[HideInInspector]shader_is_using_thry_editor("", Float) = 0
		[HideInInspector]shader_presets("TsunaMooShaders", Float) = 0
		[HideInInspector]shader_properties_label_file("TsunaMooLabels", Float) = 0
		[HideInInspector]shader_master_label("<color=#ffffffff>Tsuna</color> <color=#000000ff>Moo</color> <color=#ffffffff>Shader</color> <color=#000000ff>Lab</color>--{texture:{name:tsuna_moo_icon,height:128}}", Float) = 0
		[HideInInspector]shader_on_swap_to("--{actions:[{type:SET_PROPERTY,data:variant_selector=0}]}", Float) = 0
		[Enum(Opaque,0,Transparent,1)]variant_selector("Variant--{onVariant--{on_value_actions:[{value:0,actions:[{type:SET_SHADER,data:TsunaMoo/Mirror FX vO}]},{value:1,actions:[{type:SET_SHADER,data:TsunaMoo/Mirror FX vT}]}]}", Float) = 0
		[HideInInspector]Instancing("Instancing", Float) = 0
		[HideInInspector]m_ChromaOptions("Chroma--{reference_property:_ChromaToggle}", Float) = 0
		_Speed("Speed", Range( 0 , 3)) = 0
		[HideInInspector]m_Distance("Distance Fade", Float) = 0
		_PixelLimiterMin("Min--{tooltip:Controls the distance at which the screen is still completely visible}", Float) = 5
		[HideInInspector]_ReflectionTex0("_ReflectionTex0", 2D) = "white" {}
		[HideInInspector]_ReflectionTex1("_ReflectionTex1", 2D) = "white" {}
		_PixelLimiterMax("Max--{tooltip:Controls the distance at which the screen stops being visible}", Float) = 25
		[HideInInspector]footer_discord("", Float) = 0
		[HideInInspector]footer_patreon("", Float) = 0
		[HideInInspector]footer_booth("", Float) = 0
		[HideInInspector]footer_github("", Float) = 0
		_ReplacementMap("Replacement Map--{reference_property:_ReplacementColor}", 2D) = "white" {}
		[HideInInspector]_ReplacementColor("ReplacementColor", Color) = (1,1,1,0)
		[HideInInspector][Toggle(_Chroma_ON)] _ChromaToggle("Toggle Chroma", Float) = 0
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityCG.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _Chroma_ON
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float3 worldPos;
			float4 uv2_texcoord2;
			float2 uv_texcoord;
		};

		uniform float shader_is_using_thry_editor;
		uniform float footer_booth;
		uniform float shader_master_label;
		uniform float shader_on_swap_to;
		uniform float shader_properties_label_file;
		uniform float m_ChromaOptions;
		uniform float m_Distance;
		uniform float variant_selector;
		uniform float footer_patreon;
		uniform float footer_discord;
		uniform float shader_presets;
		uniform float Instancing;
		uniform float footer_github;
		uniform sampler2D _ReflectionTex1;
		uniform sampler2D _ReflectionTex0;
		uniform float _Speed;
		uniform float4 _ReplacementColor;
		uniform sampler2D _ReplacementMap;
		uniform float4 _ReplacementMap_ST;
		uniform float _PixelLimiterMax;
		uniform float _PixelLimiterMin;


		float StereoEyeIndex2(  )
		{
			 return unity_StereoEyeIndex;
		}


		float2 UnStereo( float2 UV )
		{
			#if UNITY_SINGLE_PASS_STEREO
			float4 scaleOffset = unity_StereoScaleOffset[ unity_StereoEyeIndex ];
			UV.xy = (UV.xy - scaleOffset.zw) / scaleOffset.xy;
			#endif
			return UV;
		}


		float4 ProjectionCoordinates11( float4 In )
		{
			 return UNITY_PROJ_COORD(In);
		}


		float4 Tex2DProjection17( sampler2D TD, float4 F4 )
		{
			 return tex2Dproj(TD, F4);
		}


		float4 Tex2DProjection15( sampler2D TD, float4 F4 )
		{
			 return tex2Dproj(TD, F4);
		}


		float3 HSVToRGB( float3 c )
		{
			float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
			float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
			return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
		}


		float3 RGBToHSV(float3 c)
		{
			float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
			float4 p = lerp( float4( c.bg, K.wz ), float4( c.gb, K.xy ), step( c.b, c.g ) );
			float4 q = lerp( float4( p.xyw, c.r ), float4( c.r, p.yzx ), step( p.x, c.r ) );
			float d = q.x - min( q.w, q.y );
			float e = 1.0e-10;
			return float3( abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float localStereoEyeIndex2 = StereoEyeIndex2();
			sampler2D TD17 = _ReflectionTex1;
			float4 ase_vertex4Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float4 unityObjectToClipPos13 = UnityObjectToClipPos( ase_vertex4Pos.xyz );
			float4 computeScreenPos29 = ComputeScreenPos( unityObjectToClipPos13 );
			computeScreenPos29 = computeScreenPos29 / computeScreenPos29.w;
			computeScreenPos29.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? computeScreenPos29.z : computeScreenPos29.z* 0.5 + 0.5;
			float2 UV22_g1 = computeScreenPos29.xy;
			float2 localUnStereo22_g1 = UnStereo( UV22_g1 );
			float4 appendResult28 = (float4(localUnStereo22_g1 , i.uv2_texcoord2.z , i.uv2_texcoord2.w));
			float4 In11 = appendResult28;
			float4 localProjectionCoordinates11 = ProjectionCoordinates11( In11 );
			float4 F417 = localProjectionCoordinates11;
			float4 localTex2DProjection17 = Tex2DProjection17( TD17 , F417 );
			sampler2D TD15 = _ReflectionTex0;
			float4 F415 = localProjectionCoordinates11;
			float4 localTex2DProjection15 = Tex2DProjection15( TD15 , F415 );
			float4 ifLocalVar3 = 0;
			if( localStereoEyeIndex2 == 0.0 )
				ifLocalVar3 = localTex2DProjection15;
			else
				ifLocalVar3 = localTex2DProjection17;
			float mulTime39 = _Time.y * _Speed;
			float3 hsvTorgb40 = RGBToHSV( ifLocalVar3.xyz );
			float3 hsvTorgb41 = HSVToRGB( float3(( frac( mulTime39 ) + hsvTorgb40.x ),hsvTorgb40.y,hsvTorgb40.z) );
			#ifdef _Chroma_ON
				float4 staticSwitch76 = float4( hsvTorgb41 , 0.0 );
			#else
				float4 staticSwitch76 = ifLocalVar3;
			#endif
			float2 uv_ReplacementMap = i.uv_texcoord * _ReplacementMap_ST.xy + _ReplacementMap_ST.zw;
			float3 ase_worldPos = i.worldPos;
			float4 lerpResult67 = lerp( staticSwitch76 , ( _ReplacementColor * tex2D( _ReplacementMap, uv_ReplacementMap ) ) , saturate( (1.0 + (distance( _WorldSpaceCameraPos , ase_worldPos ) - _PixelLimiterMax) * (0.0 - 1.0) / (_PixelLimiterMin - _PixelLimiterMax)) ));
			o.Emission = lerpResult67.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "Thry.ShaderEditor"
}
/*ASEBEGIN
Version=18921
2694.4;729.6;1735;841;-866.1717;124.4109;1.202209;True;False
Node;AmplifyShaderEditor.CommentaryNode;52;-3764.135,-579.1208;Inherit;False;2399.681;860.3535;Do not edit this;13;3;17;2;15;11;22;25;28;27;26;29;13;14;Mirror Code;1,1,1,1;0;0
Node;AmplifyShaderEditor.PosVertexDataNode;14;-3694.624,-363.7726;Inherit;True;1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.UnityObjToClipPosHlpNode;13;-3406.624,-283.7726;Inherit;False;1;0;FLOAT3;0,0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComputeScreenPosHlpNode;29;-3166.624,-251.7726;Inherit;False;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;27;-2894.624,-123.7726;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;26;-2894.624,-203.7726;Inherit;False;Non Stereo Screen Pos;-1;;1;1731ee083b93c104880efc701e11b49b;0;1;23;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;28;-2574.624,-139.7726;Inherit;False;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexturePropertyNode;22;-2382.624,-459.7726;Inherit;True;Property;_ReflectionTex0;_ReflectionTex0;11;1;[HideInInspector];Create;False;0;0;0;False;0;False;None;None;False;white;LockedToTexture2D;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.CustomExpressionNode;11;-2366.624,-155.7726;Inherit;False; return UNITY_PROJ_COORD(In)@;4;Create;1;True;In;FLOAT4;0,0,0,0;In;;Inherit;False;Projection Coordinates;True;False;0;;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexturePropertyNode;25;-2366.624,36.22736;Inherit;True;Property;_ReflectionTex1;_ReflectionTex1;12;1;[HideInInspector];Create;False;0;0;0;False;0;False;None;None;False;white;LockedToTexture2D;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.CommentaryNode;51;-501.9256,-415.1648;Inherit;False;1520.372;700.4823;;7;41;42;40;43;39;44;76;Chroma;1,1,1,1;0;0
Node;AmplifyShaderEditor.CustomExpressionNode;15;-1966.624,-187.7726;Inherit;False; return tex2Dproj(TD, F4)@;4;Create;2;True;TD;SAMPLER2D;0,0,0,0;In;;Inherit;False;True;F4;FLOAT4;0,0,0,0;In;;Inherit;False;Tex2DProjection;True;False;0;;False;2;0;SAMPLER2D;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CustomExpressionNode;17;-1966.624,-75.77264;Inherit;False; return tex2Dproj(TD, F4)@;4;Create;2;True;TD;SAMPLER2D;0,0;In;;Inherit;False;True;F4;FLOAT4;0,0,0,0;In;;Inherit;False;Tex2DProjection;True;False;0;;False;2;0;SAMPLER2D;0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-427.93,-342.6522;Inherit;False;Property;_Speed;Speed;8;0;Create;True;0;0;0;False;0;False;0;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;2;-1966.624,-363.7726;Inherit;False; return unity_StereoEyeIndex@;1;Create;0;Stereo Eye Index;True;False;0;;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;3;-1598.624,-219.7726;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;59;-528.2122,-1023.715;Inherit;False;1821.77;483.6047;;9;68;67;66;65;64;63;62;61;60;Distance;0.9438051,0.6367924,1,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;39;-117.3789,-297.1371;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;61;-435.9633,-783.6794;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RGBToHSVNode;40;-127.1315,-38.25643;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FractNode;43;78.24458,-225.9138;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;60;-499.9184,-935.89;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DistanceOpNode;64;-144.616,-924.692;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;42;250.8269,-147.3933;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;63;-204.9749,-811.1484;Float;False;Property;_PixelLimiterMax;Max--{tooltip:Controls the distance at which the screen stops being visible};13;0;Create;False;0;0;0;False;0;False;25;0.04;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-206.2498,-726.3185;Float;False;Property;_PixelLimiterMin;Min--{tooltip:Controls the distance at which the screen is still completely visible};10;0;Create;False;0;0;0;False;0;False;5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;71;121.2855,-1333.64;Inherit;False;Property;_ReplacementColor;ReplacementColor;19;1;[HideInInspector];Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;65;122.8038,-832.0904;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;69;105.7653,-1140.046;Inherit;True;Property;_ReplacementMap;Replacement Map--{reference_property:_ReplacementColor};18;0;Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.HSVToRGBNode;41;467.129,-34.54106;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StaticSwitch;76;797.7076,-61.40094;Inherit;False;Property;_ChromaToggle;Toggle Chroma;20;0;Create;False;0;0;0;False;1;HideInInspector;False;0;0;0;True;_Chroma_ON;Toggle;2;Key0;Key1;Create;True;False;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SaturateNode;66;352.6122,-843.5904;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;469.9539,-1112.464;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;54;-2613.194,477.4787;Inherit;False;1239.025;445.4762;;9;32;31;34;30;35;37;36;49;33;ThryEditor;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;55;-1177.935,532.8911;Inherit;False;741.2661;134.4619;;1;56;Settings;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-2321.175,661.0566;Inherit;False;Property;shader_properties_label_file;TsunaMooLabels;2;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;73;2249.581,527.0454;Inherit;False;Property;shader_on_swap_to;--{actions:[{type:SET_PROPERTY,data:variant_selector=0}]};4;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;68;1046.519,-759.5934;Inherit;False;Property;m_Distance;Distance Fade;9;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-2579.405,561.7542;Inherit;False;Property;shader_is_using_thry_editor;;0;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-1711.051,627.2844;Inherit;False;Property;m_ChromaOptions;Chroma--{reference_property:_ChromaToggle};7;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-2404.063,561.0418;Inherit;False;Property;shader_master_label;<color=#ffffffff>Tsuna</color> <color=#000000ff>Moo</color> <color=#ffffffff>Shader</color> <color=#000000ff>Lab</color>--{texture:{name:tsuna_moo_icon,height:128}};3;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-2585.552,785.6388;Inherit;False;Property;footer_booth;;16;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-2089.568,779.8573;Inherit;False;Property;footer_discord;;14;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-2583.068,659.9258;Inherit;False;Property;shader_presets;TsunaMooShaders;1;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;67;622.7433,-895.0565;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;56;-972.935,577.891;Inherit;False;Property;Instancing;Instancing;6;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-2264.746,781.0939;Inherit;False;Property;footer_github;;17;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-2434.697,785.8103;Inherit;False;Property;footer_patreon;;15;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;74;1949.056,525.8207;Inherit;False;Property;variant_selector;Variant--{onVariant--{on_value_actions:[{value:0,actions:[{type:SET_SHADER,data:TsunaMoo/Mirror FX vO}]},{value:1,actions:[{type:SET_SHADER,data:TsunaMoo/Mirror FX vT}]}]};5;1;[Enum];Create;False;0;2;Opaque;0;Transparent;1;0;True;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2320.934,-300.0715;Float;False;True;-1;2;Thry.ShaderEditor;0;0;Unlit;TsunaMoo/Mirror FX vO;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;13;0;14;0
WireConnection;29;0;13;0
WireConnection;26;23;29;0
WireConnection;28;0;26;0
WireConnection;28;2;27;3
WireConnection;28;3;27;4
WireConnection;11;0;28;0
WireConnection;15;0;22;0
WireConnection;15;1;11;0
WireConnection;17;0;25;0
WireConnection;17;1;11;0
WireConnection;3;0;2;0
WireConnection;3;2;17;0
WireConnection;3;3;15;0
WireConnection;3;4;17;0
WireConnection;39;0;44;0
WireConnection;40;0;3;0
WireConnection;43;0;39;0
WireConnection;64;0;60;0
WireConnection;64;1;61;0
WireConnection;42;0;43;0
WireConnection;42;1;40;1
WireConnection;65;0;64;0
WireConnection;65;1;63;0
WireConnection;65;2;62;0
WireConnection;41;0;42;0
WireConnection;41;1;40;2
WireConnection;41;2;40;3
WireConnection;76;1;3;0
WireConnection;76;0;41;0
WireConnection;66;0;65;0
WireConnection;72;0;71;0
WireConnection;72;1;69;0
WireConnection;67;0;76;0
WireConnection;67;1;72;0
WireConnection;67;2;66;0
WireConnection;0;2;67;0
ASEEND*/
//CHKSM=76932C826505ECDC164DAC9FC2C2709CD03AEB32