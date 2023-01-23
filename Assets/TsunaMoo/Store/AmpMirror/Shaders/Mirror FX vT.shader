// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "TsunaMoo/Mirror FX vT"
{
	Properties
	{
		[HideInInspector]shader_is_using_thry_editor("", Float) = 0
		[HideInInspector]shader_presets("TsunaMooShaders", Float) = 0
		[HideInInspector]shader_properties_label_file("TsunaMooLabels", Float) = 0
		[HideInInspector]shader_master_label("<color=#ffffffff>Tsuna</color> <color=#000000ff>Moo</color> <color=#ffffffff>Shader</color> <color=#000000ff>Lab</color>--{texture:{name:tsuna_moo_icon,height:128}}", Float) = 0
		[HideInInspector]shader_on_swap_to("--{actions:[{type:SET_PROPERTY,data:variant_selector=1}]}", Float) = 0
		[Enum(Opaque,0,Transparent,1)]variant_selector("Variant--{on_value_actions:[{value:0,actions:[{type:SET_SHADER,data:TsunaMoo/Mirror FX vO}]},{value:1,actions:[{type:SET_SHADER,data:TsunaMoo/Mirror FX vT}]}]}", Float) = 1
		[HideInInspector]Instancing("Instancing", Float) = 0
		_Transparency("Transparency", Range( 0 , 1)) = 0
		[HideInInspector]m_ChromaOptions("Chroma--{reference_property:_ChromaToggle}", Float) = 0
		_Speed("Speed", Range( 0 , 3)) = 0
		[HideInInspector]_ReflectionTex0("_ReflectionTex0", 2D) = "white" {}
		[HideInInspector]_ReflectionTex1("_ReflectionTex1", 2D) = "white" {}
		[HideInInspector]m_Distance("Distance Fade", Float) = 0
		_PixelLimiterMin("Min--{tooltip:Controls the distance at which the screen is still completely visible}", Float) = 5
		_PixelLimiterMax("Max--{tooltip:Controls the distance at which the screen stops being visible}", Float) = 25
		[HideInInspector]footer_discord("", Float) = 0
		[HideInInspector]footer_patreon("", Float) = 0
		[HideInInspector]footer_booth("", Float) = 0
		[HideInInspector]footer_github("", Float) = 0
		[HideInInspector][Toggle(_Chroma_ON)] _ChromaToggle("Toggle Chroma", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityCG.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _Chroma_ON
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float3 worldPos;
			float4 uv_texcoord;
		};

		uniform half shader_on_swap_to;
		uniform half shader_presets;
		uniform half shader_properties_label_file;
		uniform half m_ChromaOptions;
		uniform half Instancing;
		uniform half footer_github;
		uniform half shader_master_label;
		uniform half shader_is_using_thry_editor;
		uniform half m_Distance;
		uniform half footer_booth;
		uniform half footer_patreon;
		uniform half variant_selector;
		uniform half footer_discord;
		uniform sampler2D _ReflectionTex1;
		uniform sampler2D _ReflectionTex0;
		uniform float _PixelLimiterMax;
		uniform float _PixelLimiterMin;
		uniform half _Speed;
		uniform half _Transparency;


		half StereoEyeIndex2(  )
		{
			 return unity_StereoEyeIndex;
		}


		half2 UnStereo( float2 UV )
		{
			#if UNITY_SINGLE_PASS_STEREO
			float4 scaleOffset = unity_StereoScaleOffset[ unity_StereoEyeIndex ];
			UV.xy = (UV.xy - scaleOffset.zw) / scaleOffset.xy;
			#endif
			return UV;
		}


		half4 ProjectionCoordinates11( half4 In )
		{
			 return UNITY_PROJ_COORD(In);
		}


		half4 Tex2DProjection17( sampler2D TD, half4 F4 )
		{
			 return tex2Dproj(TD, F4);
		}


		half4 Tex2DProjection15( sampler2D TD, half4 F4 )
		{
			 return tex2Dproj(TD, F4);
		}


		half3 HSVToRGB( half3 c )
		{
			half4 K = half4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
			half3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
			return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
		}


		half3 RGBToHSV(half3 c)
		{
			half4 K = half4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
			half4 p = lerp( half4( c.bg, K.wz ), half4( c.gb, K.xy ), step( c.b, c.g ) );
			half4 q = lerp( half4( p.xyw, c.r ), half4( c.r, p.yzx ), step( p.x, c.r ) );
			half d = q.x - min( q.w, q.y );
			half e = 1.0e-10;
			return half3( abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			half localStereoEyeIndex2 = StereoEyeIndex2();
			sampler2D TD17 = _ReflectionTex1;
			float4 ase_vertex4Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			half4 unityObjectToClipPos13 = UnityObjectToClipPos( ase_vertex4Pos.xyz );
			half4 computeScreenPos29 = ComputeScreenPos( unityObjectToClipPos13 );
			computeScreenPos29 = computeScreenPos29 / computeScreenPos29.w;
			computeScreenPos29.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? computeScreenPos29.z : computeScreenPos29.z* 0.5 + 0.5;
			half2 UV22_g1 = computeScreenPos29.xy;
			half2 localUnStereo22_g1 = UnStereo( UV22_g1 );
			half4 appendResult28 = (half4(localUnStereo22_g1 , i.uv_texcoord.z , i.uv_texcoord.w));
			half4 In11 = appendResult28;
			half4 localProjectionCoordinates11 = ProjectionCoordinates11( In11 );
			half4 F417 = localProjectionCoordinates11;
			half4 localTex2DProjection17 = Tex2DProjection17( TD17 , F417 );
			sampler2D TD15 = _ReflectionTex0;
			half4 F415 = localProjectionCoordinates11;
			half4 localTex2DProjection15 = Tex2DProjection15( TD15 , F415 );
			half4 ifLocalVar3 = 0;
			if( localStereoEyeIndex2 == 0.0 )
				ifLocalVar3 = localTex2DProjection15;
			else
				ifLocalVar3 = localTex2DProjection17;
			float3 ase_worldPos = i.worldPos;
			half temp_output_56_0 = saturate( (1.0 + (distance( _WorldSpaceCameraPos , ase_worldPos ) - _PixelLimiterMax) * (0.0 - 1.0) / (_PixelLimiterMin - _PixelLimiterMax)) );
			half4 lerpResult57 = lerp( ifLocalVar3 , float4( 0,0,0,0 ) , temp_output_56_0);
			half mulTime65 = _Time.y * _Speed;
			half3 hsvTorgb67 = RGBToHSV( lerpResult57.xyz );
			half3 hsvTorgb71 = HSVToRGB( half3(( frac( mulTime65 ) + hsvTorgb67.x ),hsvTorgb67.y,hsvTorgb67.z) );
			#ifdef _Chroma_ON
				half4 staticSwitch73 = half4( hsvTorgb71 , 0.0 );
			#else
				half4 staticSwitch73 = lerpResult57;
			#endif
			o.Emission = staticSwitch73.xyz;
			o.Alpha = (1.0 + (( _Transparency + temp_output_56_0 ) - 0.0) * (0.0 - 1.0) / (1.0 - 0.0));
		}

		ENDCG
		CGPROGRAM
		#pragma exclude_renderers xbox360 xboxone xboxseries ps4 playstation psp2 n3ds wiiu switch 
		#pragma surface surf Unlit alpha:fade keepalpha fullforwardshadows noshadow exclude_path:deferred noambient nolightmap  nodirlightmap nometa noforwardadd 

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
				float4 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
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
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xyzw = customInputData.uv_texcoord;
				o.customPack1.xyzw = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
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
				surfIN.uv_texcoord = IN.customPack1.xyzw;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
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
	CustomEditor "Thry.ShaderEditor"
}
/*ASEBEGIN
Version=18921
2816;539.2;1735;841;-8.337585;46.4422;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;39;-3493.543,-653.7323;Inherit;False;2369.495;802.5955;Do not edit this;13;3;2;15;17;11;25;22;28;27;26;29;13;14;Mirror Code;1,1,1,1;0;0
Node;AmplifyShaderEditor.PosVertexDataNode;14;-3453.179,-505.6833;Inherit;True;1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.UnityObjToClipPosHlpNode;13;-3171.179,-426.6833;Inherit;False;1;0;FLOAT3;0,0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComputeScreenPosHlpNode;29;-2918.151,-395.9605;Inherit;False;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;26;-2655.275,-349.8939;Inherit;False;Non Stereo Screen Pos;-1;;1;1731ee083b93c104880efc701e11b49b;0;1;23;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;49;-878.1646,-867.4156;Inherit;False;1821.77;483.6047;;9;58;57;56;55;54;53;52;51;50;Distance;0.9438051,0.6367924,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;27;-2651.091,-269.2961;Inherit;False;0;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;28;-2325.322,-293.1272;Inherit;False;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WorldPosInputsNode;51;-785.9154,-627.3804;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceCameraPos;50;-849.8706,-779.5909;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TexturePropertyNode;22;-2131.695,-601.6287;Inherit;True;Property;_ReflectionTex0;_ReflectionTex0;10;1;[HideInInspector];Create;False;0;0;0;False;0;False;None;None;False;white;LockedToTexture2D;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.CustomExpressionNode;11;-2116.169,-306.8457;Inherit;False; return UNITY_PROJ_COORD(In)@;4;Create;1;True;In;FLOAT4;0,0,0,0;In;;Inherit;False;Projection Coordinates;True;False;0;;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;52;-556.2021,-570.0193;Float;False;Property;_PixelLimiterMin;Min--{tooltip:Controls the distance at which the screen is still completely visible};13;0;Create;False;0;0;0;False;0;False;5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;53;-554.9272,-654.8493;Float;False;Property;_PixelLimiterMax;Max--{tooltip:Controls the distance at which the screen stops being visible};14;0;Create;False;0;0;0;False;0;False;25;0.04;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;25;-2118.087,-113.0364;Inherit;True;Property;_ReflectionTex1;_ReflectionTex1;11;1;[HideInInspector];Create;False;0;0;0;False;0;False;None;None;False;white;LockedToTexture2D;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.DistanceOpNode;54;-494.5686,-768.3929;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;63;1714.386,-1169.405;Inherit;False;1520.372;700.4823;;7;73;71;69;67;66;65;64;Chroma;1,1,1,1;0;0
Node;AmplifyShaderEditor.CustomExpressionNode;2;-1720.392,-508.7199;Inherit;False; return unity_StereoEyeIndex@;1;Create;0;Stereo Eye Index;True;False;0;;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;17;-1721.039,-225.526;Inherit;False; return tex2Dproj(TD, F4)@;4;Create;2;True;TD;SAMPLER2D;0,0;In;;Inherit;False;True;F4;FLOAT4;0,0,0,0;In;;Inherit;False;Tex2DProjection;True;False;0;;False;2;0;SAMPLER2D;0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CustomExpressionNode;15;-1719.497,-340.1743;Inherit;False; return tex2Dproj(TD, F4)@;4;Create;2;True;TD;SAMPLER2D;0,0,0,0;In;;Inherit;False;True;F4;FLOAT4;0,0,0,0;In;;Inherit;False;Tex2DProjection;True;False;0;;False;2;0;SAMPLER2D;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TFHCRemapNode;55;-227.1488,-675.7913;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;56;2.659606,-687.2913;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;3;-1359.893,-369.1609;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;64;1788.381,-1096.893;Inherit;False;Property;_Speed;Speed;9;0;Create;True;0;0;0;False;0;False;0;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;57;272.7906,-738.7574;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleTimeNode;65;2098.932,-1051.378;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RGBToHSVNode;67;2089.18,-792.4971;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FractNode;66;2294.556,-980.1543;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;555.4949,89.82667;Inherit;False;Property;_Transparency;Transparency;7;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;69;2467.139,-901.6338;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;60;871.0951,6.04425;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;42;-1391.52,453.4081;Inherit;False;741.2661;134.4619;;1;45;Settings;1,1,1,1;0;0
Node;AmplifyShaderEditor.HSVToRGBNode;71;2683.441,-788.7816;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;40;-2439.649,302.5784;Inherit;False;911.3306;437.3574;;8;34;31;37;36;32;35;33;30;ThryEditor;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-2082.586,584.2772;Inherit;False;Property;footer_github;;18;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;48;1029.86,31.80833;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-2400.908,463.109;Inherit;False;Property;shader_presets;TsunaMooShaders;1;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-2139.015,464.2399;Inherit;False;Property;shader_properties_label_file;TsunaMooLabels;2;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;61;1097.068,441.8653;Inherit;False;Property;shader_on_swap_to;--{actions:[{type:SET_PROPERTY,data:variant_selector=1}]};4;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;73;3014.019,-815.6415;Inherit;False;Property;_ChromaToggle;Toggle Chroma;19;0;Create;False;0;0;0;False;1;HideInInspector;False;0;0;0;True;_Chroma_ON;Toggle;2;Key0;Key1;Create;True;False;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;45;-1186.52,498.4079;Inherit;False;Property;Instancing;Instancing;6;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;706.1674,-504.0943;Inherit;False;Property;m_Distance;Distance Fade;12;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-2221.903,364.2251;Inherit;False;Property;shader_master_label;<color=#ffffffff>Tsuna</color> <color=#000000ff>Moo</color> <color=#ffffffff>Shader</color> <color=#000000ff>Lab</color>--{texture:{name:tsuna_moo_icon,height:128}};3;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-2397.245,364.9375;Inherit;False;Property;shader_is_using_thry_editor;;0;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;795.3413,440.6406;Inherit;False;Property;variant_selector;Variant--{on_value_actions:[{value:0,actions:[{type:SET_SHADER,data:TsunaMoo/Mirror FX vO}]},{value:1,actions:[{type:SET_SHADER,data:TsunaMoo/Mirror FX vT}]}]};5;1;[Enum];Create;False;0;2;Opaque;0;Transparent;1;0;True;0;False;1;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-2403.392,588.8221;Inherit;False;Property;footer_booth;;17;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-2252.537,588.9936;Inherit;False;Property;footer_patreon;;16;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-1907.408,583.0406;Inherit;False;Property;footer_discord;;15;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;75;596.1543,270.9998;Inherit;False;Property;m_ChromaOptions;Chroma--{reference_property:_ChromaToggle};8;1;[HideInInspector];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3285.017,-191.5614;Half;False;True;-1;2;Thry.ShaderEditor;0;0;Unlit;TsunaMoo/Mirror FX vT;False;False;False;False;True;False;True;False;True;False;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;ForwardOnly;9;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;vulkan;nomrt;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;13;0;14;0
WireConnection;29;0;13;0
WireConnection;26;23;29;0
WireConnection;28;0;26;0
WireConnection;28;2;27;3
WireConnection;28;3;27;4
WireConnection;11;0;28;0
WireConnection;54;0;50;0
WireConnection;54;1;51;0
WireConnection;17;0;25;0
WireConnection;17;1;11;0
WireConnection;15;0;22;0
WireConnection;15;1;11;0
WireConnection;55;0;54;0
WireConnection;55;1;53;0
WireConnection;55;2;52;0
WireConnection;56;0;55;0
WireConnection;3;0;2;0
WireConnection;3;2;17;0
WireConnection;3;3;15;0
WireConnection;3;4;17;0
WireConnection;57;0;3;0
WireConnection;57;2;56;0
WireConnection;65;0;64;0
WireConnection;67;0;57;0
WireConnection;66;0;65;0
WireConnection;69;0;66;0
WireConnection;69;1;67;1
WireConnection;60;0;47;0
WireConnection;60;1;56;0
WireConnection;71;0;69;0
WireConnection;71;1;67;2
WireConnection;71;2;67;3
WireConnection;48;0;60;0
WireConnection;73;1;57;0
WireConnection;73;0;71;0
WireConnection;0;2;73;0
WireConnection;0;9;48;0
ASEEND*/
//CHKSM=5650ECBA564839985871A2974711DFA6AA9E91AE