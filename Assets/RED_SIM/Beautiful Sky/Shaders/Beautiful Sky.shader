// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "RED_SIM/Beautiful Sky"
{
	Properties
	{
		[Header(Sky Color Settings)]_DayColorTop("Day Color Top", Color) = (0.3455882,0.8104462,1,0)
		_DayColorBottom("Day Color Bottom", Color) = (0.1544118,0.5451319,1,0)
		_NightColorTop("Night Color Top", Color) = (0,0.1359026,0.2941176,0)
		_NightColorBottom("Night Color Bottom", Color) = (0.0537526,0,0.1470588,0)
		_SunsetHorizonColor("Sunset Horizon Color", Color) = (1,0.2705882,0.1686275,0)
		_SkyHorizonGradient("Sky Horizon Gradient", Range( 1 , 10)) = 1
		[Header(Clouds Color Settings)]_CloudDayColor("Cloud Day Color", Color) = (1,1,1,0)
		_CloudDayColorBottom("Cloud Day Color Bottom", Color) = (0,0,0,0)
		_CloudSunsetColor("Cloud Sunset Color", Color) = (1,0.8382353,0.8382353,0)
		_CloudSunsetColorBottom("Cloud Sunset Color Bottom", Color) = (0,0,0,0)
		_CloudNightColor("Cloud Night Color", Color) = (1,1,1,0)
		_CloudNightColorBottom("Cloud Night Color Bottom", Color) = (0,0,0,0)
		_CloudBottomContrast("Cloud Bottom Contrast", Range( 0 , 2)) = 0
		[NoScaleOffset][Header(Clouds Volumetric Settings)]_PerlinNoise("Perlin Noise", 2D) = "white" {}
		[IntRange]_CloudParallaxLayers("Cloud Parallax Layers", Range( 1 , 64)) = 0
		_Cloudiness("Cloudiness", Range( 0 , 1)) = 0
		_CloudsHeight("Clouds Height", Range( 0 , 1)) = 0
		_CloudsThickness("Clouds Thickness", Range( 0 , 0.1)) = 0
		_CloudsTopSizeReduce("Clouds Top Size Reduce", Range( 0 , 1)) = 0
		[IntRange]_CloudBottomLayers("Cloud Bottom Layers", Range( 0 , 32)) = 0
		[Header(Clouds Wind Settings)]_WindX("WindX", Range( -0.5 , 0.5)) = 0
		_WindY("WindY", Range( -0.5 , 0.5)) = 0
		[Toggle]_ManualCloudPosition("Manual Cloud Position", Float) = 0
		_ManualCloudX("Manual Cloud X", Float) = 0
		_ManualCloudY("Manual Cloud Y", Float) = 0
		[Header(Clouds Visual Settings)]_CloudBrightness("Cloud Brightness", Range( 0 , 0.999999)) = 0
		_CloudContrast("Cloud Contrast", Range( 0 , 100)) = 0
		_CloudFeatheringPower("Cloud Feathering Power", Range( 0 , 0.1)) = 0
		_CloudFeatheringSize("Cloud Feathering Size", Range( 0 , 1)) = 1
		_CloudFeatheringPower2nd("Cloud Feathering Power 2nd", Range( 0 , 0.1)) = 0
		_CloudFeatheringSize2nd("Cloud Feathering Size 2nd", Range( 0 , 1)) = 1
		_CloudsHorizonHeight("Clouds Horizon Height", Range( 0 , 3)) = 0
		_CloudsHorizonGradient("Clouds Horizon Gradient", Range( 0 , 25)) = 1
		_CloudMasking("Cloud Masking", Range( 0 , 5)) = 0.85
		[Toggle]_WorldSpaceClouds("World Space Clouds", Float) = 1
		[Header(Mini Clouds Settings)]_MiniCloudsHeight("Mini Clouds Height", Range( 0 , 10)) = 0
		_MiniCloudsOpacity("Mini Clouds Opacity", Range( 0 , 1)) = 0
		[IntRange]_MiniCloudsLayersLimit("Mini Clouds Layers Limit", Range( 0 , 64)) = 0
		[HDR][Header(Sun Settings)]_SunDayColor("Sun Day Color", Color) = (1,1,1,0)
		[HDR]_SunSunsetColor("Sun Sunset Color", Color) = (1,0.8823529,0.8823529,0)
		_SunRadius("Sun Radius", Range( 0 , 1)) = 0.11
		_SunHaloRadius("Sun Halo Radius", Range( 0 , 1)) = 0.11
		_SunHaloSize("Sun Halo Size", Range( 0 , 1)) = 0
		_SunsetHorizonHeight("Sunset Horizon Height", Range( 1 , 10)) = 2.04
		_SunsetSize("Sunset Size", Range( 0 , 5)) = 3.14
		_SunScattering("Sun Scattering", Range( 0 , 4)) = 0
		_SunScatteringRadius("Sun Scattering Radius", Range( 0 , 1)) = 0
		[NoScaleOffset][Header(Moon Settings)]_Moon("Moon", 2D) = "black" {}
		_MoonScattering("Moon Scattering", Range( 0 , 4)) = 0
		_MoonScatteringRadius("Moon Scattering Radius", Range( 0 , 2)) = 0
		_MoonSize("Moon Size", Range( 0 , 30)) = 1
		_MoonDayColor("Moon Day Color", Color) = (0,0,0,0)
		_MoonNightColor("Moon Night Color", Color) = (0,0,0,0)
		_MoonAngleOffset("Moon Angle Offset", Float) = 0
		_MoonRotationAngle("Moon Rotation Angle", Range( -180 , 180)) = 0
		_MoonRotationAxis("Moon Rotation Axis", Vector) = (0.85,1,0,0)
		[NoScaleOffset][Header(Stars Settings)]_Tex("Stars Cubmep", CUBE) = "black" {}
		[HDR]_StarsColor("StarsColor", Color) = (1,1,1,0)
		_NightSkyBrightness("Night Sky Brightness", Range( 0 , 10)) = 0.22
		_StarsHorizonFade("Stars Horizon Fade", Range( 0 , 1)) = 1
		_StarsBlinkBrightness("Stars Blink Brightness", Range( 0 , 10)) = 0
		_StarmapRotationAngle("Starmap Rotation Angle", Range( -180 , 180)) = 0
		_StarmapRotationAxis("Starmap Rotation Axis", Vector) = (0.85,1,0,0)
		[NoScaleOffset]_StarsBlinkNoise("Stars Blink Noise", 2D) = "white" {}
		_StarsBlinkNoiseSize("Stars Blink Noise Size", Float) = 1
		_StarsBlinkSpeed("Stars Blink Speed", Float) = 0.2
		[Header(Other Settings)][Toggle]_AutoLightDirection("Auto Light Direction", Float) = 1
		_ManualLightDirection("Manual Light Direction", Vector) = (0,0,0,0)
		[Toggle]_MirrorWorld("Mirror World", Float) = 1
		[Toggle]_InvertWorld("Invert World", Float) = 0
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("Cull Mode", Float) = 2
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull [_CullMode]
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow nofog 
		struct Input
		{
			float3 worldPos;
		};

		uniform float _InvertWorld;
		uniform float _MirrorWorld;
		uniform float _AutoLightDirection;
		uniform float3 _ManualLightDirection;
		uniform float _SunHaloRadius;
		uniform float _SunHaloSize;
		uniform float _SunRadius;
		uniform float _CloudContrast;
		uniform sampler2D _PerlinNoise;
		uniform float _CloudParallaxLayers;
		uniform float _CloudsTopSizeReduce;
		uniform float _CloudsThickness;
		uniform float _CloudsHeight;
		uniform float _Cloudiness;
		uniform float _MiniCloudsHeight;
		uniform float _WorldSpaceClouds;
		uniform float _ManualCloudPosition;
		uniform float _WindX;
		uniform float _WindY;
		uniform float _ManualCloudX;
		uniform float _ManualCloudY;
		uniform float _CloudFeatheringSize;
		uniform float _CloudFeatheringPower;
		uniform float _CloudBottomLayers;
		uniform float _MiniCloudsLayersLimit;
		uniform float _CloudFeatheringSize2nd;
		uniform float _CloudFeatheringPower2nd;
		uniform float _MiniCloudsOpacity;
		uniform float _CloudBrightness;
		uniform float _CloudMasking;
		uniform float _CloudsHorizonGradient;
		uniform float _CloudsHorizonHeight;
		uniform float4 _SunDayColor;
		uniform float4 _SunSunsetColor;
		uniform float _SunsetHorizonHeight;
		uniform float _SunsetSize;
		uniform float4 _NightColorBottom;
		uniform float4 _NightColorTop;
		uniform float _SkyHorizonGradient;
		uniform float4 _DayColorBottom;
		uniform float4 _DayColorTop;
		uniform float4 _SunsetHorizonColor;
		uniform samplerCUBE _Tex;
		uniform float3 _StarmapRotationAxis;
		uniform float _StarmapRotationAngle;
		uniform float4 _StarsColor;
		uniform float _StarsHorizonFade;
		uniform sampler2D _StarsBlinkNoise;
		uniform float _StarsBlinkSpeed;
		uniform float _StarsBlinkNoiseSize;
		uniform float _StarsBlinkBrightness;
		uniform float _NightSkyBrightness;
		uniform float3 _MoonRotationAxis;
		uniform float _MoonRotationAngle;
		uniform float _MoonAngleOffset;
		uniform sampler2D _Moon;
		uniform float _MoonSize;
		uniform float4 _MoonNightColor;
		uniform float4 _MoonDayColor;
		uniform float _SunScatteringRadius;
		uniform float _SunScattering;
		uniform float4 _CloudNightColor;
		uniform float4 _CloudDayColor;
		uniform float4 _CloudSunsetColor;
		uniform float4 _CloudNightColorBottom;
		uniform float4 _CloudDayColorBottom;
		uniform float4 _CloudSunsetColorBottom;
		uniform float _CloudBottomContrast;
		uniform float _MoonScatteringRadius;
		uniform float _MoonScattering;
		uniform float _CullMode;


		float3 CloudGenerator112( sampler2D ParallaxMap , int Iterations , float CloudinessIncrement , float Increment , float Height , float Cloudiness , float2 ParallaxMapUV , float UV2Scale , float2 UVShift , float FeatheringSize , float FeatheringPower , int BottomLayersCount , int MiniCloudsIterations , float FeatheringSize2 , float FeatheringPower2 )
		{
			float3 parallax = float3(0,0,0);
			float featheringShift = tex2D( ParallaxMap, ParallaxMapUV * (Height + FeatheringSize) + UVShift ).z * FeatheringPower;
			float featheringShift2 = tex2D( ParallaxMap, ParallaxMapUV * (Height + FeatheringSize2) + UVShift ).z * FeatheringPower2;
			for (int j = 0; j < Iterations; j ++) {
				float low2 = Cloudiness + CloudinessIncrement * j;
				low2 *= low2;
				float4 layer;
				if( j < BottomLayersCount) {
					layer.x =  tex2D( ParallaxMap, ParallaxMapUV * (Height + Increment * j) + featheringShift + UVShift ).x;
					layer.x = saturate(layer.x * (1 + low2) - low2);
					parallax.z +=  layer.x;
				} else {
					layer.x =  tex2D( ParallaxMap, ParallaxMapUV * (Height + Increment * j) + featheringShift + featheringShift2 + UVShift ).x;
					layer.x = saturate(layer.x * (1 + low2) - low2);
				}
				
				if( j < MiniCloudsIterations ) {	
					layer.y =  tex2D( ParallaxMap, ParallaxMapUV * (Height * UV2Scale + Increment * j) + featheringShift + featheringShift2 + UVShift ).y;
					parallax.y  +=  saturate(layer.y * (1 + low2) - low2);
				}
				parallax.x  +=  layer.x;
				
			}
			parallax /= Iterations;
			return parallax;
		}


		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float3 ase_worldPos = i.worldPos;
			float3 appendResult901 = (float3(_WorldSpaceCameraPos.x , 0.0 , _WorldSpaceCameraPos.z));
			float3 break899 = ( ase_worldPos - appendResult901 );
			float2 appendResult581 = (float2(break899.x , break899.z));
			float2 break582 = (( _InvertWorld )?( -appendResult581 ):( appendResult581 ));
			float3 appendResult573 = (float3(break582.x , (( _MirrorWorld )?( abs( break899.y ) ):( break899.y )) , break582.y));
			float3 normalizeResult253 = normalize( appendResult573 );
			float3 WorldPositionNormalised254 = normalizeResult253;
			float3 normalizeResult664 = normalize( _ManualLightDirection );
			float3 ifLocalVar662 = 0;
			if( distance( _ManualLightDirection , float3( 0,0,0 ) ) == 0.0 )
				ifLocalVar662 = float3(0,1,0);
			else
				ifLocalVar662 = normalizeResult664;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float3 LightDirection622 = (( _AutoLightDirection )?( ase_worldlightDir ):( ifLocalVar662 ));
			float SunMask262 = distance( WorldPositionNormalised254 , LightDirection622 );
			float temp_output_212_0 = ( ( (LightDirection622).y * 3.0 ) + -0.4 );
			float SunsetProgressNoAbs819 = saturate( ( 1.0 - temp_output_212_0 ) );
			float lerpResult684 = lerp( _SunHaloSize , 0.0 , saturate( SunsetProgressNoAbs819 ));
			float smoothstepResult681 = smoothstep( 0.0 , 1.0 , saturate( ( saturate( (lerpResult684 + (( SunMask262 / _SunHaloRadius ) - 0.0) * (0.0 - lerpResult684) / (1.0 - 0.0)) ) + saturate( (( _SunRadius * 250.0 ) + (( SunMask262 / _SunRadius ) - 0.0) * (0.0 - ( _SunRadius * 250.0 )) / (1.0 - 0.0)) ) ) ));
			float temp_output_13_0_g1816 = _CloudContrast;
			sampler2D ParallaxMap112 = _PerlinNoise;
			int Iterations112 = (int)_CloudParallaxLayers;
			float CloudinessIncrement112 = ( _CloudsTopSizeReduce / _CloudParallaxLayers );
			float Increment112 = ( _CloudsThickness / _CloudParallaxLayers );
			float CloudsHeight534 = _CloudsHeight;
			float Height112 = CloudsHeight534;
			float Cloudiness112 = ( 4.0 - (0.0 + (pow( _Cloudiness , 0.25 ) - 0.0) * (4.0 - 0.0) / (1.0 - 0.0)) );
			float3 break99 = WorldPositionNormalised254;
			float2 appendResult102 = (float2(break99.x , break99.z));
			float ifLocalVar101 = 0;
			if( break99.y == 0.0 )
				ifLocalVar101 = 1E-05;
			else
				ifLocalVar101 = break99.y;
			float2 CloudsUV107 = ( appendResult102 / ifLocalVar101 );
			float2 ParallaxMapUV112 = CloudsUV107;
			float UV2Scale112 = _MiniCloudsHeight;
			float2 WorldShift536 = ( ((( _WorldSpaceClouds )?( _WorldSpaceCameraPos ):( float3( 0,0,0 ) ))).xz / ( 10000.0 * CloudsHeight534 ) );
			float2 appendResult162 = (float2(_WindX , _WindY));
			float2 appendResult833 = (float2(_ManualCloudX , _ManualCloudY));
			float2 UVShift112 = ( WorldShift536 + (( _ManualCloudPosition )?( appendResult833 ):( ( _Time.y * appendResult162 ) )) );
			float FeatheringSize112 = _CloudFeatheringSize;
			float FeatheringPower112 = _CloudFeatheringPower;
			int BottomLayersCount112 = (int)_CloudBottomLayers;
			int MiniCloudsIterations112 = (int)_MiniCloudsLayersLimit;
			float FeatheringSize2112 = _CloudFeatheringSize2nd;
			float FeatheringPower2112 = _CloudFeatheringPower2nd;
			float3 localCloudGenerator112 = CloudGenerator112( ParallaxMap112 , Iterations112 , CloudinessIncrement112 , Increment112 , Height112 , Cloudiness112 , ParallaxMapUV112 , UV2Scale112 , UVShift112 , FeatheringSize112 , FeatheringPower112 , BottomLayersCount112 , MiniCloudsIterations112 , FeatheringSize2112 , FeatheringPower2112 );
			float3 break133 = localCloudGenerator112;
			float lerpResult174 = lerp( break133.x , break133.y , _MiniCloudsOpacity);
			float temp_output_5_0_g1816 = lerpResult174;
			float temp_output_45_0_g1816 = ( ( tan( ( ( ( saturate( temp_output_5_0_g1816 ) - 0.5 ) * UNITY_PI ) / ( ( 0.5 * UNITY_PI ) / atan( ( temp_output_13_0_g1816 / 2.0 ) ) ) ) ) / temp_output_13_0_g1816 ) + 0.5 );
			float ifLocalVar46_g1816 = 0;
			if( temp_output_13_0_g1816 == 0.0 )
				ifLocalVar46_g1816 = temp_output_5_0_g1816;
			else
				ifLocalVar46_g1816 = temp_output_45_0_g1816;
			float CloudMask194 = (0.0 + (ifLocalVar46_g1816 - 0.0) * (1.0 - 0.0) / (( 1.0 - _CloudBrightness ) - 0.0));
			float CloudMasking269 = _CloudMasking;
			float SkyMask291 = saturate( ( ( (WorldPositionNormalised254).y * _CloudsHorizonGradient ) - _CloudsHorizonHeight ) );
			float lerpResult278 = lerp( smoothstepResult681 , 0.0 , saturate( ( CloudMask194 * CloudMasking269 * SkyMask291 ) ));
			float temp_output_222_0 = saturate( ( 1.0 - abs( temp_output_212_0 ) ) );
			float SunsetMask225 = ( ( 1.0 - saturate( ( abs( (WorldPositionNormalised254).y ) * _SunsetHorizonHeight ) ) ) * ( 1.0 - saturate( ( ( SunMask262 / ( 1.0 - abs( (LightDirection622).y ) ) ) / _SunsetSize ) ) ) * temp_output_222_0 );
			float4 lerpResult277 = lerp( _SunDayColor , _SunSunsetColor , SunsetMask225);
			float4 Sun280 = ( lerpResult278 * lerpResult277 );
			float smoothstepResult245 = smoothstep( 0.0 , 1.0 , saturate( ( (WorldPositionNormalised254).y * _SkyHorizonGradient ) ));
			float4 lerpResult249 = lerp( _NightColorBottom , _NightColorTop , smoothstepResult245);
			float4 lerpResult248 = lerp( _DayColorBottom , _DayColorTop , smoothstepResult245);
			float smoothstepResult357 = smoothstep( 0.0 , 1.0 , saturate( ( ( (LightDirection622).y + 0.2 ) * 1.2 ) ));
			float DaynightProgress235 = smoothstepResult357;
			float4 lerpResult250 = lerp( lerpResult249 , lerpResult248 , DaynightProgress235);
			float4 lerpResult227 = lerp( lerpResult250 , _SunsetHorizonColor , SunsetMask225);
			float4 SkyColor228 = lerpResult227;
			float3 normalizeResult730 = normalize( _StarmapRotationAxis );
			float3 temp_output_1_0_g1758 = normalizeResult730;
			float3 temp_output_2_0_g1758 = float3(0,1,0);
			float dotResult3_g1758 = dot( temp_output_1_0_g1758 , temp_output_2_0_g1758 );
			float3 break19_g1758 = cross( temp_output_1_0_g1758 , temp_output_2_0_g1758 );
			float4 appendResult23_g1758 = (float4(break19_g1758.x , break19_g1758.y , break19_g1758.z , ( dotResult3_g1758 + 1.0 )));
			float4 normalizeResult24_g1758 = normalize( appendResult23_g1758 );
			float4 ifLocalVar25_g1758 = 0;
			if( dotResult3_g1758 <= 0.999999 )
				ifLocalVar25_g1758 = normalizeResult24_g1758;
			else
				ifLocalVar25_g1758 = float4(0,0,0,1);
			float temp_output_4_0_g1759 = ( UNITY_PI / 2.0 );
			float3 temp_output_8_0_g1758 = cross( float3(1,0,0) , temp_output_1_0_g1758 );
			float3 ifLocalVar10_g1758 = 0;
			if( length( temp_output_8_0_g1758 ) >= 1E-06 )
				ifLocalVar10_g1758 = temp_output_8_0_g1758;
			else
				ifLocalVar10_g1758 = cross( float3(0,1,0) , temp_output_1_0_g1758 );
			float3 normalizeResult13_g1758 = normalize( ifLocalVar10_g1758 );
			float3 break10_g1759 = ( sin( temp_output_4_0_g1759 ) * normalizeResult13_g1758 );
			float4 appendResult8_g1759 = (float4(break10_g1759.x , break10_g1759.y , break10_g1759.z , cos( temp_output_4_0_g1759 )));
			float4 ifLocalVar4_g1758 = 0;
			if( dotResult3_g1758 >= -0.999999 )
				ifLocalVar4_g1758 = ifLocalVar25_g1758;
			else
				ifLocalVar4_g1758 = appendResult8_g1759;
			float4 temp_output_2_0_g1763 = ifLocalVar4_g1758;
			float4 temp_output_1_0_g1764 = temp_output_2_0_g1763;
			float3 temp_output_7_0_g1764 = (temp_output_1_0_g1764).xyz;
			float temp_output_4_0_g1750 = ( radians( _StarmapRotationAngle ) / 2.0 );
			float3 break10_g1750 = ( sin( temp_output_4_0_g1750 ) * normalizeResult730 );
			float4 appendResult8_g1750 = (float4(break10_g1750.x , break10_g1750.y , break10_g1750.z , cos( temp_output_4_0_g1750 )));
			float4 temp_output_2_0_g1760 = appendResult8_g1750;
			float4 temp_output_1_0_g1761 = temp_output_2_0_g1760;
			float3 temp_output_7_0_g1761 = (temp_output_1_0_g1761).xyz;
			float3 break8_g1760 = WorldPositionNormalised254;
			float4 appendResult9_g1760 = (float4(break8_g1760.x , break8_g1760.y , break8_g1760.z , 0.0));
			float4 temp_output_1_0_g1762 = appendResult9_g1760;
			float3 temp_output_7_0_g1762 = (temp_output_1_0_g1762).xyz;
			float4 temp_output_2_0_g1762 = ( temp_output_2_0_g1760 * float4(-1,-1,-1,1) );
			float temp_output_10_0_g1762 = (temp_output_2_0_g1762).w;
			float3 temp_output_3_0_g1762 = (temp_output_2_0_g1762).xyz;
			float temp_output_11_0_g1762 = (temp_output_1_0_g1762).w;
			float3 break17_g1762 = ( ( temp_output_7_0_g1762 * temp_output_10_0_g1762 ) + cross( temp_output_1_0_g1762.xyz , temp_output_2_0_g1762.xyz ) + ( temp_output_3_0_g1762 * temp_output_11_0_g1762 ) );
			float dotResult16_g1762 = dot( temp_output_7_0_g1762 , temp_output_3_0_g1762 );
			float4 appendResult18_g1762 = (float4(break17_g1762.x , break17_g1762.y , break17_g1762.z , ( ( temp_output_11_0_g1762 * temp_output_10_0_g1762 ) - dotResult16_g1762 )));
			float4 temp_output_2_0_g1761 = appendResult18_g1762;
			float temp_output_10_0_g1761 = (temp_output_2_0_g1761).w;
			float3 temp_output_3_0_g1761 = (temp_output_2_0_g1761).xyz;
			float temp_output_11_0_g1761 = (temp_output_1_0_g1761).w;
			float3 break17_g1761 = ( ( temp_output_7_0_g1761 * temp_output_10_0_g1761 ) + cross( temp_output_1_0_g1761.xyz , temp_output_2_0_g1761.xyz ) + ( temp_output_3_0_g1761 * temp_output_11_0_g1761 ) );
			float dotResult16_g1761 = dot( temp_output_7_0_g1761 , temp_output_3_0_g1761 );
			float4 appendResult18_g1761 = (float4(break17_g1761.x , break17_g1761.y , break17_g1761.z , ( ( temp_output_11_0_g1761 * temp_output_10_0_g1761 ) - dotResult16_g1761 )));
			float3 break8_g1763 = (appendResult18_g1761).xyz;
			float4 appendResult9_g1763 = (float4(break8_g1763.x , break8_g1763.y , break8_g1763.z , 0.0));
			float4 temp_output_1_0_g1765 = appendResult9_g1763;
			float3 temp_output_7_0_g1765 = (temp_output_1_0_g1765).xyz;
			float4 temp_output_2_0_g1765 = ( temp_output_2_0_g1763 * float4(-1,-1,-1,1) );
			float temp_output_10_0_g1765 = (temp_output_2_0_g1765).w;
			float3 temp_output_3_0_g1765 = (temp_output_2_0_g1765).xyz;
			float temp_output_11_0_g1765 = (temp_output_1_0_g1765).w;
			float3 break17_g1765 = ( ( temp_output_7_0_g1765 * temp_output_10_0_g1765 ) + cross( temp_output_1_0_g1765.xyz , temp_output_2_0_g1765.xyz ) + ( temp_output_3_0_g1765 * temp_output_11_0_g1765 ) );
			float dotResult16_g1765 = dot( temp_output_7_0_g1765 , temp_output_3_0_g1765 );
			float4 appendResult18_g1765 = (float4(break17_g1765.x , break17_g1765.y , break17_g1765.z , ( ( temp_output_11_0_g1765 * temp_output_10_0_g1765 ) - dotResult16_g1765 )));
			float4 temp_output_2_0_g1764 = appendResult18_g1765;
			float temp_output_10_0_g1764 = (temp_output_2_0_g1764).w;
			float3 temp_output_3_0_g1764 = (temp_output_2_0_g1764).xyz;
			float temp_output_11_0_g1764 = (temp_output_1_0_g1764).w;
			float3 break17_g1764 = ( ( temp_output_7_0_g1764 * temp_output_10_0_g1764 ) + cross( temp_output_1_0_g1764.xyz , temp_output_2_0_g1764.xyz ) + ( temp_output_3_0_g1764 * temp_output_11_0_g1764 ) );
			float dotResult16_g1764 = dot( temp_output_7_0_g1764 , temp_output_3_0_g1764 );
			float4 appendResult18_g1764 = (float4(break17_g1764.x , break17_g1764.y , break17_g1764.z , ( ( temp_output_11_0_g1764 * temp_output_10_0_g1764 ) - dotResult16_g1764 )));
			float3 StarmapRotation731 = (appendResult18_g1764).xyz;
			float4 texCUBENode493 = texCUBE( _Tex, StarmapRotation731 );
			float4 StarsColor514 = texCUBENode493;
			float SkyGradientMask592 = smoothstepResult245;
			float2 temp_cast_11 = (_StarsBlinkSpeed).xx;
			float2 panner921 = ( 1.0 * _Time.y * temp_cast_11 + ( (WorldPositionNormalised254).xz / pow( (WorldPositionNormalised254).y , 0.1 ) ));
			float clampResult936 = clamp( ( ( (-1.0 + (tex2D( _StarsBlinkNoise, ( panner921 * _StarsBlinkNoiseSize ) ).b - 0.0) * (1.0 - -1.0) / (1.0 - 0.0)) * _StarsBlinkBrightness ) + _NightSkyBrightness ) , 0.0 , 100.0 );
			float StarsMask513 = ( saturate( ( (LightDirection622).y * -5.0 ) ) * saturate( ( ( texCUBENode493.r + texCUBENode493.g + texCUBENode493.b ) / 3.0 ) ) * ( 1.0 - saturate( ( CloudMask194 * SkyMask291 * CloudMasking269 ) ) ) * saturate( ( ( 1.0 - _StarsHorizonFade ) + SkyGradientMask592 ) ) * clampResult936 );
			float3 normalizeResult740 = normalize( _MoonRotationAxis );
			float3 temp_output_1_0_g1742 = normalizeResult740;
			float3 temp_output_2_0_g1742 = float3(0,1,0);
			float dotResult3_g1742 = dot( temp_output_1_0_g1742 , temp_output_2_0_g1742 );
			float3 break19_g1742 = cross( temp_output_1_0_g1742 , temp_output_2_0_g1742 );
			float4 appendResult23_g1742 = (float4(break19_g1742.x , break19_g1742.y , break19_g1742.z , ( dotResult3_g1742 + 1.0 )));
			float4 normalizeResult24_g1742 = normalize( appendResult23_g1742 );
			float4 ifLocalVar25_g1742 = 0;
			if( dotResult3_g1742 <= 0.999999 )
				ifLocalVar25_g1742 = normalizeResult24_g1742;
			else
				ifLocalVar25_g1742 = float4(0,0,0,1);
			float temp_output_4_0_g1743 = ( UNITY_PI / 2.0 );
			float3 temp_output_8_0_g1742 = cross( float3(1,0,0) , temp_output_1_0_g1742 );
			float3 ifLocalVar10_g1742 = 0;
			if( length( temp_output_8_0_g1742 ) >= 1E-06 )
				ifLocalVar10_g1742 = temp_output_8_0_g1742;
			else
				ifLocalVar10_g1742 = cross( float3(0,1,0) , temp_output_1_0_g1742 );
			float3 normalizeResult13_g1742 = normalize( ifLocalVar10_g1742 );
			float3 break10_g1743 = ( sin( temp_output_4_0_g1743 ) * normalizeResult13_g1742 );
			float4 appendResult8_g1743 = (float4(break10_g1743.x , break10_g1743.y , break10_g1743.z , cos( temp_output_4_0_g1743 )));
			float4 ifLocalVar4_g1742 = 0;
			if( dotResult3_g1742 >= -0.999999 )
				ifLocalVar4_g1742 = ifLocalVar25_g1742;
			else
				ifLocalVar4_g1742 = appendResult8_g1743;
			float4 temp_output_2_0_g1751 = ifLocalVar4_g1742;
			float4 temp_output_1_0_g1752 = temp_output_2_0_g1751;
			float3 temp_output_7_0_g1752 = (temp_output_1_0_g1752).xyz;
			float temp_output_4_0_g1736 = ( radians( ( _MoonRotationAngle + _MoonAngleOffset ) ) / 2.0 );
			float3 break10_g1736 = ( sin( temp_output_4_0_g1736 ) * normalizeResult740 );
			float4 appendResult8_g1736 = (float4(break10_g1736.x , break10_g1736.y , break10_g1736.z , cos( temp_output_4_0_g1736 )));
			float4 temp_output_2_0_g1744 = appendResult8_g1736;
			float4 temp_output_1_0_g1745 = temp_output_2_0_g1744;
			float3 temp_output_7_0_g1745 = (temp_output_1_0_g1745).xyz;
			float3 break8_g1744 = WorldPositionNormalised254;
			float4 appendResult9_g1744 = (float4(break8_g1744.x , break8_g1744.y , break8_g1744.z , 0.0));
			float4 temp_output_1_0_g1746 = appendResult9_g1744;
			float3 temp_output_7_0_g1746 = (temp_output_1_0_g1746).xyz;
			float4 temp_output_2_0_g1746 = ( temp_output_2_0_g1744 * float4(-1,-1,-1,1) );
			float temp_output_10_0_g1746 = (temp_output_2_0_g1746).w;
			float3 temp_output_3_0_g1746 = (temp_output_2_0_g1746).xyz;
			float temp_output_11_0_g1746 = (temp_output_1_0_g1746).w;
			float3 break17_g1746 = ( ( temp_output_7_0_g1746 * temp_output_10_0_g1746 ) + cross( temp_output_1_0_g1746.xyz , temp_output_2_0_g1746.xyz ) + ( temp_output_3_0_g1746 * temp_output_11_0_g1746 ) );
			float dotResult16_g1746 = dot( temp_output_7_0_g1746 , temp_output_3_0_g1746 );
			float4 appendResult18_g1746 = (float4(break17_g1746.x , break17_g1746.y , break17_g1746.z , ( ( temp_output_11_0_g1746 * temp_output_10_0_g1746 ) - dotResult16_g1746 )));
			float4 temp_output_2_0_g1745 = appendResult18_g1746;
			float temp_output_10_0_g1745 = (temp_output_2_0_g1745).w;
			float3 temp_output_3_0_g1745 = (temp_output_2_0_g1745).xyz;
			float temp_output_11_0_g1745 = (temp_output_1_0_g1745).w;
			float3 break17_g1745 = ( ( temp_output_7_0_g1745 * temp_output_10_0_g1745 ) + cross( temp_output_1_0_g1745.xyz , temp_output_2_0_g1745.xyz ) + ( temp_output_3_0_g1745 * temp_output_11_0_g1745 ) );
			float dotResult16_g1745 = dot( temp_output_7_0_g1745 , temp_output_3_0_g1745 );
			float4 appendResult18_g1745 = (float4(break17_g1745.x , break17_g1745.y , break17_g1745.z , ( ( temp_output_11_0_g1745 * temp_output_10_0_g1745 ) - dotResult16_g1745 )));
			float3 break8_g1751 = (appendResult18_g1745).xyz;
			float4 appendResult9_g1751 = (float4(break8_g1751.x , break8_g1751.y , break8_g1751.z , 0.0));
			float4 temp_output_1_0_g1753 = appendResult9_g1751;
			float3 temp_output_7_0_g1753 = (temp_output_1_0_g1753).xyz;
			float4 temp_output_2_0_g1753 = ( temp_output_2_0_g1751 * float4(-1,-1,-1,1) );
			float temp_output_10_0_g1753 = (temp_output_2_0_g1753).w;
			float3 temp_output_3_0_g1753 = (temp_output_2_0_g1753).xyz;
			float temp_output_11_0_g1753 = (temp_output_1_0_g1753).w;
			float3 break17_g1753 = ( ( temp_output_7_0_g1753 * temp_output_10_0_g1753 ) + cross( temp_output_1_0_g1753.xyz , temp_output_2_0_g1753.xyz ) + ( temp_output_3_0_g1753 * temp_output_11_0_g1753 ) );
			float dotResult16_g1753 = dot( temp_output_7_0_g1753 , temp_output_3_0_g1753 );
			float4 appendResult18_g1753 = (float4(break17_g1753.x , break17_g1753.y , break17_g1753.z , ( ( temp_output_11_0_g1753 * temp_output_10_0_g1753 ) - dotResult16_g1753 )));
			float4 temp_output_2_0_g1752 = appendResult18_g1753;
			float temp_output_10_0_g1752 = (temp_output_2_0_g1752).w;
			float3 temp_output_3_0_g1752 = (temp_output_2_0_g1752).xyz;
			float temp_output_11_0_g1752 = (temp_output_1_0_g1752).w;
			float3 break17_g1752 = ( ( temp_output_7_0_g1752 * temp_output_10_0_g1752 ) + cross( temp_output_1_0_g1752.xyz , temp_output_2_0_g1752.xyz ) + ( temp_output_3_0_g1752 * temp_output_11_0_g1752 ) );
			float dotResult16_g1752 = dot( temp_output_7_0_g1752 , temp_output_3_0_g1752 );
			float4 appendResult18_g1752 = (float4(break17_g1752.x , break17_g1752.y , break17_g1752.z , ( ( temp_output_11_0_g1752 * temp_output_10_0_g1752 ) - dotResult16_g1752 )));
			float3 temp_output_746_0 = (appendResult18_g1752).xyz;
			float3 MoonRotation747 = temp_output_746_0;
			float4 tex2DNode462 = tex2D( _Moon, saturate( ( (( MoonRotation747 * _MoonSize )).xy + 0.5 ) ) );
			float temp_output_463_0 = ( ( 1.0 - saturate( (MoonRotation747).z ) ) * tex2DNode462.a );
			float MoonMask466 = temp_output_463_0;
			float4 lerpResult519 = lerp( SkyColor228 , ( StarsColor514 * _StarsColor ) , ( _StarsColor.a * StarsMask513 * ( 1.0 - MoonMask466 ) ));
			float4 lerpResult471 = lerp( _MoonNightColor , _MoonDayColor , DaynightProgress235);
			float4 MoonLightColor489 = lerpResult471;
			float4 Moon467 = ( tex2DNode462 * MoonLightColor489 );
			float MoonSkyMask725 = ( temp_output_463_0 * (lerpResult471).a );
			float4 lerpResult469 = lerp( ( Sun280 + lerpResult519 ) , Moon467 , MoonSkyMask725);
			float smoothstepResult331 = smoothstep( 0.0 , 1.0 , ( ( 1.0 - SunMask262 ) - _SunScatteringRadius ));
			float temp_output_327_0 = ( smoothstepResult331 * _SunScattering );
			float ScatteringMask362 = temp_output_327_0;
			float4 lerpResult303 = lerp( _CloudNightColor , _CloudDayColor , DaynightProgress235);
			float4 lerpResult566 = lerp( lerpResult303 , _CloudSunsetColor , SunsetMask225);
			float4 lerpResult567 = lerp( _CloudNightColorBottom , _CloudDayColorBottom , DaynightProgress235);
			float4 lerpResult569 = lerp( lerpResult567 , _CloudSunsetColorBottom , SunsetMask225);
			float ifLocalVar190 = 0;
			if( _CloudBottomLayers <= 0.0 )
				ifLocalVar190 = 1.0;
			else
				ifLocalVar190 = _CloudBottomLayers;
			float ParallaxLayerCount449 = _CloudParallaxLayers;
			float CloudBottomMask192 = ( break133.z * ( _CloudBottomContrast / ifLocalVar190 ) * ParallaxLayerCount449 );
			float4 lerpResult407 = lerp( lerpResult566 , lerpResult569 , CloudBottomMask192);
			float MoonGradient762 = ( 1.0 - (temp_output_746_0).z );
			float smoothstepResult492 = smoothstep( 0.0 , 1.0 , ( saturate( ( MoonGradient762 - _MoonScatteringRadius ) ) * _MoonScattering ));
			float MoonScatteringMask486 = smoothstepResult492;
			float4 CloudsColor405 = ( ( ( ( 1.0 - ( SunsetMask225 * saturate( SkyMask291 ) ) ) * DaynightProgress235 ) * ScatteringMask362 ) + lerpResult407 + ( MoonScatteringMask486 * MoonLightColor489 ) );
			float4 lerpResult309 = lerp( lerpResult469 , saturate( CloudsColor405 ) , saturate( ( SkyMask291 * CloudMask194 ) ));
			o.Emission = ( lerpResult309 + ( _CullMode * 0.0 ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17800
1927;10;1906;987;5242.499;-1506.434;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;577;-2928.664,670.6166;Inherit;False;2439.877;448.2189;World Position;14;901;254;253;573;578;582;579;574;583;581;899;900;897;252;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;897;-2910.117,906.1874;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;901;-2638.117,932.1874;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode;252;-2672.053,752.4282;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;900;-2410.117,785.1874;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;899;-2276.117,772.1874;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;581;-2030.731,942.1154;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NegateNode;583;-1876.731,1034.115;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.AbsOpNode;574;-1758.674,822.9929;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;579;-1705.731,942.1154;Float;False;Property;_InvertWorld;Invert World;72;0;Create;True;0;0;False;0;0;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;667;-4329.629,6307.667;Inherit;False;1296.304;469.4434;Light Direction;8;618;622;619;662;664;666;663;660;;1,1,1,1;0;0
Node;AmplifyShaderEditor.BreakToComponentsNode;582;-1456.731,944.1154;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ToggleSwitchNode;578;-1612.372,721.2026;Float;False;Property;_MirrorWorld;Mirror World;71;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;660;-4298.146,6412.119;Float;False;Property;_ManualLightDirection;Manual Light Direction;70;0;Create;True;0;0;False;0;0,0,0;-2.6,0.94,-3.57;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;196;-4526.519,1210.195;Inherit;False;3098.077;1509.692;Clouds Mask;49;133;112;194;123;174;192;182;450;189;181;449;190;191;127;124;175;113;156;116;129;108;152;184;541;542;148;131;183;122;117;110;164;538;159;162;169;168;534;115;544;830;831;832;833;896;902;931;933;934;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;573;-1183.287,839.635;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DistanceOpNode;663;-4023.878,6369.601;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;253;-1004.861,861.1582;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;666;-4030.589,6539.023;Float;False;Constant;_Vector0;Vector 0;61;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NormalizeNode;664;-4020.878,6466.601;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;535;-4519.482,340.2049;Inherit;False;1320.331;311.6899;World Shift;7;525;526;529;530;532;531;536;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;115;-4401.107,1781.897;Float;False;Property;_CloudsHeight;Clouds Height;16;0;Create;True;0;0;False;0;0;0.09;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;106;-4524.604,698.657;Inherit;False;1469.849;403.1014;Clouds UV;7;107;104;101;102;103;99;576;;0.4779412,1,0.9135903,1;0;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;525;-4463.878,422.8004;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;619;-3804.793,6572.46;Inherit;True;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;534;-4028.93,1817.4;Float;False;CloudsHeight;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;662;-3755.877,6393.601;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;254;-830.2899,849.7617;Float;False;WorldPositionNormalised;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;529;-4171.622,547.8495;Inherit;False;534;CloudsHeight;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;618;-3517.773,6491.127;Float;False;Property;_AutoLightDirection;Auto Light Direction;69;0;Create;True;0;0;False;1;Header(Other Settings);1;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;576;-4386.985,800.5428;Inherit;False;254;WorldPositionNormalised;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;526;-4174.478,393.2307;Float;False;Property;_WorldSpaceClouds;World Space Clouds;34;0;Create;True;0;0;False;0;1;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;103;-3867.814,969.8896;Float;False;Constant;_Float0;Float 0;0;0;Create;True;0;0;False;0;1E-05;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;168;-4479.719,2128.594;Float;False;Property;_WindX;WindX;20;0;Create;True;0;0;False;1;Header(Clouds Wind Settings);0;0.01;-0.5;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;622;-3266.371,6491.097;Float;False;LightDirection;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;169;-4475.719,2212.594;Float;False;Property;_WindY;WindY;21;0;Create;True;0;0;False;0;0;0;-0.5;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;197;-4760.445,4042.061;Inherit;False;2895.711;937.9996;Sunset;35;626;625;571;228;227;226;225;224;221;223;222;220;218;219;216;217;215;211;214;213;210;212;206;209;208;205;204;202;200;256;627;628;819;821;820;;1,0.3931034,0,1;0;0
Node;AmplifyShaderEditor.ComponentMaskNode;532;-3929.396,397.6518;Inherit;False;True;False;True;False;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;99;-3979.053,812.9435;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.CommentaryNode;737;-1364.77,8574.709;Inherit;False;2597.563;651.1992;Moon Rotation;16;762;761;747;746;744;745;742;743;741;739;740;738;825;827;828;829;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;530;-3913.456,523.1931;Inherit;False;2;2;0;FLOAT;10000;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;832;-4483.676,2425.645;Float;False;Property;_ManualCloudY;Manual Cloud Y;24;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;159;-4146.103,2107.383;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;162;-4157.372,2186.645;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;116;-4400.408,1869.596;Float;False;Property;_Cloudiness;Cloudiness;15;0;Create;True;0;0;False;0;0;0.477;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;101;-3581.392,904.431;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;831;-4484.676,2335.645;Float;False;Property;_ManualCloudX;Manual Cloud X;23;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;739;-1256.303,8712.329;Float;False;Property;_MoonRotationAngle;Moon Rotation Angle;54;0;Create;True;0;0;False;0;0;-125;-180;180;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;531;-3700.779,451.5151;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;10;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;102;-3582.486,802.9902;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;829;-1237.882,8797.729;Float;False;Property;_MoonAngleOffset;Moon Angle Offset;53;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;627;-4052.844,4712.927;Inherit;False;622;LightDirection;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;257;-5056.27,4994.934;Inherit;False;3310.459;692.9037;Sun Generation;33;280;279;277;278;275;274;276;273;681;271;272;268;265;690;692;691;270;686;269;706;685;264;684;267;700;687;266;263;683;262;261;624;281;;1,0.8482759,0,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;828;-969.8814,8723.729;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;934;-4100.576,1889.865;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;0.25;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;202;-3845.825,4794.938;Float;False;Constant;_SunsetHorizonScale;Sunset Horizon Scale;18;0;Create;True;0;0;False;0;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;164;-3968.459,2112.589;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;833;-4275.676,2369.645;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;536;-3547.554,454.5856;Float;False;WorldShift;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;628;-3824.844,4710.927;Inherit;False;False;True;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;738;-1004.458,8841.57;Float;False;Property;_MoonRotationAxis;Moon Rotation Axis;55;0;Create;True;0;0;False;0;0.85,1,0;4.12,-4.83,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleDivideOpNode;104;-3406.791,804.4182;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;208;-3562.238,4736.262;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;281;-4991.924,5101.763;Inherit;False;254;WorldPositionNormalised;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;740;-691.8742,8844.664;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;122;-4398.182,1509.166;Float;False;Property;_CloudParallaxLayers;Cloud Parallax Layers;14;1;[IntRange];Create;True;0;0;False;0;0;16;1;64;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;495;-1569.242,4487.112;Inherit;False;2977.248;1160.298;Stars;39;514;513;512;510;509;508;609;591;586;505;587;511;605;589;633;585;594;604;506;593;925;493;632;504;907;501;503;590;494;921;922;917;911;920;914;913;928;929;936;;0.2593305,0.1985294,1,1;0;0
Node;AmplifyShaderEditor.RadiansOpNode;825;-826.6114,8716.77;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;538;-3793.154,2018.768;Inherit;False;536;WorldShift;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;624;-4959.701,5194.322;Inherit;False;622;LightDirection;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;830;-3798.676,2099.645;Float;False;Property;_ManualCloudPosition;Manual Cloud Position;22;0;Create;True;0;0;False;0;0;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;209;-3900.953,4873.139;Float;False;Constant;_SunsetHorizonVerticalOffset;Sunset Horizon Vertical Offset;18;0;Create;True;0;0;False;0;-0.4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;107;-3273.885,800.657;Float;False;CloudsUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;117;-4391.437,1590.711;Float;False;Property;_CloudsTopSizeReduce;Clouds Top Size Reduce;18;0;Create;True;0;0;False;0;0;0.36;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;625;-4713.844,4461.927;Inherit;False;622;LightDirection;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCRemapNode;931;-3789.576,1850.865;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;680;-1375.025,7866.515;Inherit;False;2005.616;652.8975;Starmap Rotation;11;731;734;735;679;736;669;670;730;676;673;826;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;110;-4385.754,1688.185;Float;False;Property;_CloudsThickness;Clouds Thickness;17;0;Create;True;0;0;False;0;0;0.0202;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;184;-3958.264,2472.439;Float;False;Property;_MiniCloudsLayersLimit;Mini Clouds Layers Limit;37;1;[IntRange];Create;True;0;0;False;0;0;4;0;64;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;113;-4349.434,1307.21;Float;True;Property;_PerlinNoise;Perlin Noise;13;1;[NoScaleOffset];Create;True;0;0;False;1;Header(Clouds Volumetric Settings);None;cd14613d6b1fe6841890e5c2111473e8;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.FunctionNode;741;-492.78,8733.945;Inherit;True;RotateAngleAxis;-1;;1736;72edad85bb5dea440905ae88eddfa489;0;2;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;282;-4383.126,5762.271;Inherit;False;1369.3;515.5005;Skymask;8;291;290;288;285;293;289;287;286;;0.5294118,0.9026368,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;742;-526.8781,8645.533;Inherit;False;254;WorldPositionNormalised;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;676;-1270.352,8012.78;Float;False;Property;_StarmapRotationAngle;Starmap Rotation Angle;61;0;Create;True;0;0;False;0;0;0;-180;180;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;913;-1518.18,4917.265;Inherit;False;254;WorldPositionNormalised;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;152;-3946.128,2323.54;Float;False;Property;_CloudFeatheringSize;Cloud Feathering Size;28;0;Create;True;0;0;False;0;1;0.12;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;212;-3416.654,4737.239;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;261;-4706.743,5143.183;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;129;-4069.182,1706.166;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;183;-3660.472,2335.525;Float;False;Property;_CloudBottomLayers;Cloud Bottom Layers;19;1;[IntRange];Create;True;0;0;False;0;0;3;0;32;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;673;-1054.428,8133.376;Float;False;Property;_StarmapRotationAxis;Starmap Rotation Axis;62;0;Create;True;0;0;False;0;0.85,1,0;-4.12,3,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;148;-3949.518,2399.603;Float;False;Property;_CloudFeatheringPower;Cloud Feathering Power;27;0;Create;True;0;0;False;0;0;0.0127;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;108;-4313.82,1944.872;Inherit;False;107;CloudsUV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;542;-3954.083,2628.533;Float;False;Property;_CloudFeatheringPower2nd;Cloud Feathering Power 2nd;29;0;Create;True;0;0;False;0;0;0.0029;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;743;-709.0792,8994.857;Float;False;Constant;_Vector5;Vector 5;56;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;156;-4399.297,2029.839;Float;False;Property;_MiniCloudsHeight;Mini Clouds Height;35;0;Create;True;0;0;False;1;Header(Mini Clouds Settings);0;1.5;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;896;-3509.645,2018.434;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;541;-3955.129,2548.896;Float;False;Property;_CloudFeatheringSize2nd;Cloud Feathering Size 2nd;30;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;131;-4068.182,1605.166;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;933;-3432.576,1902.865;Inherit;False;2;0;FLOAT;4;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;626;-4485.844,4459.927;Inherit;False;False;True;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;207;-4728.4,2807.23;Inherit;False;2230.498;1180.077;Day/Night Sky;23;630;629;250;248;249;246;242;243;244;235;592;357;245;234;241;233;240;232;231;238;239;229;255;;0.1544118,0.4401624,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;262;-4553.814,5120.891;Float;False;SunMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;914;-1213.502,4991.418;Inherit;False;False;True;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;821;-3179.438,4860.7;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;745;-215.0759,8693.008;Inherit;True;RotateVector;-1;;1744;5c6ddc37cb38dfb458f9519ddf619b0c;0;2;1;FLOAT3;0,0,0;False;2;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;744;-512.8621,8955.709;Inherit;True;FromToRotation;-1;;1742;ad10913350839ec49a3853aee4185e18;0;2;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.AbsOpNode;200;-4195.569,4498.693;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;293;-4359.265,5870.771;Inherit;False;254;WorldPositionNormalised;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;730;-741.8439,8136.47;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RadiansOpNode;826;-907.1144,8008.976;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;256;-4401.385,4167.208;Inherit;False;254;WorldPositionNormalised;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CustomExpressionNode;112;-3125.364,1819.011;Float;False;float3 parallax = float3(0,0,0)@$float featheringShift = tex2D( ParallaxMap, ParallaxMapUV * (Height + FeatheringSize) + UVShift ).z * FeatheringPower@$float featheringShift2 = tex2D( ParallaxMap, ParallaxMapUV * (Height + FeatheringSize2) + UVShift ).z * FeatheringPower2@$$for (int j = 0@ j < Iterations@ j ++) {$$	float low2 = Cloudiness + CloudinessIncrement * j@$	low2 *= low2@$$	float4 layer@$$	if( j < BottomLayersCount) {$		layer.x =  tex2D( ParallaxMap, ParallaxMapUV * (Height + Increment * j) + featheringShift + UVShift ).x@$		layer.x = saturate(layer.x * (1 + low2) - low2)@$		parallax.z +=  layer.x@$	} else {$		layer.x =  tex2D( ParallaxMap, ParallaxMapUV * (Height + Increment * j) + featheringShift + featheringShift2 + UVShift ).x@$		layer.x = saturate(layer.x * (1 + low2) - low2)@$	}$	$$	if( j < MiniCloudsIterations ) {	$		layer.y =  tex2D( ParallaxMap, ParallaxMapUV * (Height * UV2Scale + Increment * j) + featheringShift + featheringShift2 + UVShift ).y@$		parallax.y  +=  saturate(layer.y * (1 + low2) - low2)@$	}$$	parallax.x  +=  layer.x@$	$}$$parallax /= Iterations@$return parallax@;3;False;15;True;ParallaxMap;SAMPLER2D;0,0;In;;Float;False;True;Iterations;INT;0;In;;Float;False;True;CloudinessIncrement;FLOAT;0;In;;Float;False;True;Increment;FLOAT;0;In;;Float;False;True;Height;FLOAT;0;In;;Float;False;True;Cloudiness;FLOAT;0;In;;Float;False;True;ParallaxMapUV;FLOAT2;0,0;In;;Float;False;True;UV2Scale;FLOAT;0;In;;Float;False;True;UVShift;FLOAT2;0,0;In;;Float;False;True;FeatheringSize;FLOAT;0;In;;Float;False;True;FeatheringPower;FLOAT;0;In;;Float;False;True;BottomLayersCount;INT;0;In;;Float;False;True;MiniCloudsIterations;INT;0;In;;Float;False;True;FeatheringSize2;FLOAT;0;In;;Float;False;True;FeatheringPower2;FLOAT;0;In;;Float;False;Cloud Generator;True;False;0;15;0;SAMPLER2D;0,0;False;1;INT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT2;0,0;False;7;FLOAT;0;False;8;FLOAT2;0,0;False;9;FLOAT;0;False;10;FLOAT;0;False;11;INT;0;False;12;INT;0;False;13;FLOAT;0;False;14;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;746;103.4538,8907.279;Inherit;True;RotateVector;-1;;1751;5c6ddc37cb38dfb458f9519ddf619b0c;0;2;1;FLOAT3;0,0,0;False;2;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PowerNode;920;-999.2718,4975.825;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;629;-4652.029,3705.171;Inherit;False;622;LightDirection;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;736;-759.049,8286.663;Float;False;Constant;_Vector2;Vector 2;56;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ComponentMaskNode;911;-1190.268,4900.185;Inherit;False;True;False;True;False;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;286;-4010.97,5866.704;Inherit;False;False;True;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;820;-2994.438,4857.7;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;285;-4080.969,6008.806;Float;False;Property;_CloudsHorizonGradient;Clouds Horizon Gradient;32;0;Create;True;0;0;False;0;1;7.1;0;25;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;255;-4410.853,3187.267;Inherit;False;254;WorldPositionNormalised;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;669;-542.7499,8025.751;Inherit;True;RotateAngleAxis;-1;;1750;72edad85bb5dea440905ae88eddfa489;0;2;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.OneMinusNode;204;-4065.016,4522.524;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;205;-3946.095,4167.05;Inherit;False;False;True;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;175;-2816.682,1992.874;Float;False;Property;_MiniCloudsOpacity;Mini Clouds Opacity;36;0;Create;True;0;0;False;0;0;0.13;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;206;-4120.899,4400.182;Inherit;False;262;SunMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;133;-2810.004,1825.908;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;670;-576.848,7937.338;Inherit;False;254;WorldPositionNormalised;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;761;504.5921,8978.908;Inherit;True;False;False;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;679;-265.0457,7984.813;Inherit;True;RotateVector;-1;;1760;5c6ddc37cb38dfb458f9519ddf619b0c;0;2;1;FLOAT3;0,0,0;False;2;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;174;-2541.663,1831.28;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;917;-850.478,4911.053;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;211;-3867.115,4468.646;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;544;-2456.711,1651.98;Float;False;Property;_CloudContrast;Cloud Contrast;26;0;Create;True;0;0;False;0;0;32;0;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;819;-2829.438,4853.7;Float;False;SunsetProgressNoAbs;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;922;-1121.447,5072.503;Inherit;False;Property;_StarsBlinkSpeed;Stars Blink Speed;65;0;Create;True;0;0;False;0;0.2;0.32;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;210;-3844.22,4271.936;Float;False;Property;_SunsetHorizonHeight;Sunset Horizon Height;43;0;Create;True;0;0;False;0;2.04;1.04;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;214;-3675.812,4165.832;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;287;-3773.97,5891.704;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;229;-4423.767,3794.729;Float;False;Constant;_VerticalNightTimeShift;Vertical Night Time Shift;16;0;Create;True;0;0;False;0;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;735;-562.832,8247.515;Inherit;True;FromToRotation;-1;;1758;ad10913350839ec49a3853aee4185e18;0;2;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;239;-4090.366,3286.101;Float;False;Property;_SkyHorizonGradient;Sky Horizon Gradient;5;0;Create;True;0;0;False;0;1;2;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;747;545.4264,8868.755;Float;False;MoonRotation;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;288;-3884.045,6112.602;Float;False;Property;_CloudsHorizonHeight;Clouds Horizon Height;31;0;Create;True;0;0;False;0;0;0.34;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;630;-4424.029,3703.171;Inherit;False;False;True;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;124;-2815.589,2088.118;Float;False;Property;_CloudBrightness;Cloud Brightness;25;0;Create;True;0;0;False;1;Header(Clouds Visual Settings);0;0.512;0;0.999999;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;451;-3580.586,6950.904;Inherit;False;2116.419;908.2753;Moon;23;473;472;471;466;467;463;465;462;461;460;459;457;458;455;456;454;452;453;474;476;489;725;726;;0.4558824,0.4558824,0.4558824,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;213;-4316.942,4613.106;Float;False;Property;_SunsetSize;Sunset Size;44;0;Create;True;0;0;False;0;3.14;3.26;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;238;-4018.943,3185.578;Inherit;False;False;True;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;216;-3740.412,4528.506;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;921;-700.8276,4913.402;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;452;-3483.846,7114.311;Inherit;False;747;MoonRotation;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;289;-3584.97,5890.704;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;929;-759.4102,5042.762;Inherit;False;Property;_StarsBlinkNoiseSize;Stars Blink Noise Size;64;0;Create;True;0;0;False;0;1;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;127;-2534.588,2092.118;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;902;-2106.021,1767.37;Inherit;False;TgContrast;-1;;1816;b6c9a31911662164faebb1535cfec412;0;2;5;FLOAT;0;False;13;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;240;-3778.742,3207.781;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;215;-3496.596,4199.614;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;232;-4427.513,3899.903;Float;False;Constant;_NightTimeProgressShift;Night Time Progress Shift;17;0;Create;True;0;0;False;0;1.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;453;-3533.239,7217.969;Float;False;Property;_MoonSize;Moon Size;50;0;Create;True;0;0;False;0;1;16;0;30;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;231;-4115.284,3742.273;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;734;53.48365,8199.085;Inherit;True;RotateVector;-1;;1763;5c6ddc37cb38dfb458f9519ddf619b0c;0;2;1;FLOAT3;0,0,0;False;2;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.AbsOpNode;217;-3293.891,4733.345;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;827;767.0748,8977.365;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;683;-4964.44,5441.674;Inherit;False;819;SunsetProgressNoAbs;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;233;-3971.659,3744.771;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;218;-3287.371,4202.354;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;731;342.4034,8201.928;Float;False;StarmapRotation;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;762;971.2201,8969.036;Float;False;MoonGradient;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;928;-501.4102,4938.762;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;454;-3215.48,7178.937;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;266;-4971.603,5363.536;Float;False;Property;_SunHaloSize;Sun Halo Size;42;0;Create;True;0;0;False;0;0;0.347;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;290;-3411.852,5892.064;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;123;-1908.576,1912.928;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;241;-3640.752,3211.771;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;687;-4985.204,5518.026;Float;False;Property;_SunRadius;Sun Radius;40;0;Create;True;0;0;False;0;0.11;0.02;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;267;-3540.966,5398.859;Float;False;Property;_CloudMasking;Cloud Masking;33;0;Create;True;0;0;False;0;0.85;1.16;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;220;-3610.104,4465.578;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;700;-4693.062,5447.087;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;219;-3172.919,4739.426;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;439;-2972.869,5767.698;Inherit;False;1525.489;972.7324;Scattering Masks;19;316;320;322;319;317;488;360;346;363;486;362;327;492;328;326;331;324;325;321;;1,0.9168357,0.6985294,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;263;-4979.349,5278.806;Float;False;Property;_SunHaloRadius;Sun Halo Radius;41;0;Create;True;0;0;False;0;0.11;0.321;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;264;-4280.958,5128.175;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;907;-345.699,4905.472;Inherit;True;Property;_StarsBlinkNoise;Stars Blink Noise;63;1;[NoScaleOffset];Create;True;0;0;False;0;-1;None;cd14613d6b1fe6841890e5c2111473e8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;316;-2932.065,5911.851;Inherit;True;262;SunMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;684;-4503.882,5352.623;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;245;-3494.636,3207.356;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;488;-2858.629,6492.583;Float;False;Property;_MoonScatteringRadius;Moon Scattering Radius;49;0;Create;True;0;0;False;0;0;1.928346;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;685;-4248.888,5365.911;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;234;-3830.483,3742.595;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;456;-3042.614,7223.632;Float;False;Constant;_Float5;Float 5;56;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;221;-3429.437,4456.112;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;706;-4468.976,5537.132;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;250;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;194;-1721.736,1806.708;Float;False;CloudMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;317;-2804.965,6254.747;Inherit;True;762;MoonGradient;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;269;-3263.405,5399.166;Float;False;CloudMasking;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;455;-3067.154,7123.234;Inherit;False;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;494;-1375.057,4737.892;Inherit;False;731;StarmapRotation;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;222;-3024.031,4737.815;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;291;-3252.238,5885.676;Float;True;SkyMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;223;-3129.297,4200.905;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;321;-2530.113,6347.065;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;925;-6.562636,4932.614;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;224;-2833.372,4456.912;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;457;-2864.753,7191.133;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;438;-1369.194,5776.665;Inherit;False;2734.094;1541.347;Clouds Color;30;565;563;304;564;408;405;414;490;427;487;436;407;491;305;413;435;434;303;298;433;301;299;431;429;430;566;567;568;569;570;;0.75,0.9586207,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;604;-276.544,5148.843;Float;False;Property;_StarsBlinkBrightness;Stars Blink Brightness;60;0;Create;True;0;0;False;0;0;10;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;320;-2698.824,6003.119;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;191;-3528.132,2430.147;Float;False;Constant;_Float1;Float 1;19;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;592;-3269.229,3249.713;Float;False;SkyGradientMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;501;-740.6801,5412.042;Inherit;False;269;CloudMasking;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;458;-3069.615,7027.149;Inherit;False;False;False;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;270;-4132.693,5130.116;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;590;-488.428,5319.47;Float;False;Property;_StarsHorizonFade;Stars Horizon Fade;59;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;493;-1078.829,4709.795;Inherit;True;Property;_Tex;Stars Cubmep;56;1;[NoScaleOffset];Create;False;0;0;False;1;Header(Stars Settings);-1;None;352c424c6217dff4290715ecd68092b0;True;0;False;black;LockedToCube;False;Object;-1;Auto;Cube;6;0;SAMPLER2D;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;357;-3547.313,3801.166;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;686;-4121.341,5364.625;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;632;-750.5719,4585.803;Inherit;False;622;LightDirection;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;504;-739.9429,5212.388;Inherit;True;291;SkyMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;319;-2833.649,6118.642;Float;False;Property;_SunScatteringRadius;Sun Scattering Radius;46;0;Create;True;0;0;False;0;0;0.575;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;503;-725.1029,5137.025;Inherit;False;194;CloudMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;459;-2746.549,7139.633;Inherit;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;460;-2617.905,7033.465;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;605;209.3706,5037.012;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;243;-3661.709,3510.414;Float;False;Property;_NightColorTop;Night Color Top;2;0;Create;True;0;0;False;0;0,0.1359026,0.2941176,0;0.01896559,0,0.1617583,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;594;-201.7712,5325.77;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;225;-2582.568,4468.996;Float;False;SunsetMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;511;-274.9621,5239.896;Float;False;Property;_NightSkyBrightness;Night Sky Brightness;58;0;Create;True;0;0;False;0;0.22;10;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;506;-512.4371,5182.71;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;324;-2288.747,6353.059;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;449;-4095.639,1510.501;Float;False;ParallaxLayerCount;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;181;-2815.442,2186.432;Float;False;Property;_CloudBottomContrast;Cloud Bottom Contrast;12;0;Create;True;0;0;False;0;0;1.215;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;585;-697.0543,4740.196;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;593;-489.7712,5410.77;Inherit;False;592;SkyGradientMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;633;-522.5711,4583.803;Inherit;False;False;True;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;190;-3329.232,2349.547;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;325;-2610.032,6619.078;Float;False;Property;_MoonScattering;Moon Scattering;48;0;Create;True;0;0;False;0;0;2.001874;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;322;-2544.132,6001.279;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;244;-3650.809,3346.045;Float;False;Property;_NightColorBottom;Night Color Bottom;3;0;Create;True;0;0;False;0;0.0537526,0,0.1470588,0;0.0350346,0.06512431,0.2646992,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;430;-202.837,5924.84;Inherit;False;291;SkyMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;246;-3641.055,2853.272;Float;False;Property;_DayColorBottom;Day Color Bottom;1;0;Create;True;0;0;False;0;0.1544118,0.5451319,1,0;0.7352942,0.9014199,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;235;-3194.626,3801.397;Float;False;DaynightProgress;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;242;-3649.354,3026.904;Float;False;Property;_DayColorTop;Day Color Top;0;0;Create;True;0;0;False;1;Header(Sky Color Settings);0.3455882,0.8104462,1,0;0.2426369,0.7179518,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;692;-3827.858,5120.41;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;691;-3837.893,5366.695;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;328;-2488.164,6115.48;Float;False;Property;_SunScattering;Sun Scattering;45;0;Create;True;0;0;False;0;0;4;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;268;-3095.381,5531.769;Inherit;False;291;SkyMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;474;-2740.234,7362.479;Float;False;Property;_MoonNightColor;Moon Night Color;52;0;Create;True;0;0;False;0;0,0,0,0;0.764151,0.7269046,0.6524119,0.228;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;189;-2486.028,2190.254;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;586;-503.0544,4717.196;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;249;-3260.794,3486.51;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;609;380.3405,5067.675;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;462;-2551.544,7138.266;Inherit;True;Property;_Moon;Moon;47;1;[NoScaleOffset];Create;True;0;0;False;1;Header(Moon Settings);-1;None;558bd318dfe571a4287b5fcee3a4806d;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;690;-3668.965,5140.748;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;589;-21.42809,5376.47;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;326;-2127.376,6356.5;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;450;-2617.641,2296.674;Inherit;False;449;ParallaxLayerCount;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;248;-3263.619,2972.469;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;472;-2748.109,7725.844;Inherit;False;235;DaynightProgress;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;265;-3405.051,5223.104;Inherit;False;194;CloudMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;331;-2389.285,5987.945;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;505;-287.1489,4603.073;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;587;-334.5518,4778.206;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;473;-2747.109,7546.844;Float;False;Property;_MoonDayColor;Moon Day Color;51;0;Create;True;0;0;False;0;0,0,0,0;1,1,1,0.066;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;461;-2434.306,7027.66;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;431;-208.41,5833.013;Inherit;False;225;SunsetMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;429;-25.36677,5930.352;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;591;99.57196,5376.47;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;272;-3443.854,5104.064;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;508;-125.2075,4611.005;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;563;-1296.658,6647.703;Float;False;Property;_CloudNightColorBottom;Cloud Night Color Bottom;11;0;Create;True;0;0;False;0;0,0,0,0;0.03507483,0.005839106,0.1985231,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;564;-1286.822,6826.183;Float;False;Property;_CloudDayColorBottom;Cloud Day Color Bottom;7;0;Create;True;0;0;False;0;0,0,0,0;0.7525951,0.8197231,0.8529412,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;327;-2175.408,5997.74;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;299;-1304.009,6000.787;Float;False;Property;_CloudNightColor;Cloud Night Color;10;0;Create;True;0;0;False;0;1,1,1,0;0.03529412,0.06666165,0.2627384,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;471;-2411.109,7417.844;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;182;-2305.369,2119.131;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;301;-1314.587,6361.213;Inherit;False;235;DaynightProgress;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;271;-2892.344,5225.224;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;298;-1303.957,6183.206;Float;False;Property;_CloudDayColor;Cloud Day Color;6;0;Create;True;0;0;False;1;Header(Clouds Color Settings);1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;510;-186.7793,4697.649;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;250;-2903.462,3286.419;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;433;133.0762,5905.251;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;509;-198.6551,4780.494;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;463;-2087.012,7039.755;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;568;-1281.045,7015.146;Inherit;False;235;DaynightProgress;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;936;564.451,5044.312;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;100;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;492;-1898.046,6358.346;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;276;-2710.631,5556.691;Inherit;False;225;SunsetMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;305;-1056.755,6561.945;Inherit;False;225;SunsetMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;512;792.8547,4879.242;Inherit;True;5;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;275;-2739.775,5145.883;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;567;-984.7471,6806.15;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;274;-2748.465,5386.86;Float;False;Property;_SunSunsetColor;Sun Sunset Color;39;1;[HDR];Create;True;0;0;False;0;1,0.8823529,0.8823529,0;2.828427,2.451303,2.25165,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;251;-2467.418,3396.372;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;192;-1887.199,2108.573;Float;False;CloudBottomMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;226;-2870.212,4233.475;Float;False;Property;_SunsetHorizonColor;Sunset Horizon Color;4;0;Create;True;0;0;False;0;1,0.2705882,0.1686275,0;1,0.3517173,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;681;-3198.182,5089.761;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;489;-2217.83,7322.927;Float;False;MoonLightColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;362;-1711.899,6047.075;Float;False;ScatteringMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;466;-1768.709,7036.962;Float;False;MoonMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;303;-996.1274,6161.735;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;570;-1020.462,7200.331;Inherit;False;225;SunsetMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;304;-1289.438,6458.277;Float;False;Property;_CloudSunsetColor;Cloud Sunset Color;8;0;Create;True;0;0;False;0;1,0.8382353,0.8382353,0;1,0.5793101,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;434;271.7317,5923.977;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;486;-1709.94,6354.445;Float;False;MoonScatteringMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;435;151.3348,6081.234;Inherit;False;235;DaynightProgress;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;273;-2735.934,5221.544;Float;False;Property;_SunDayColor;Sun Day Color;38;1;[HDR];Create;True;0;0;False;1;Header(Sun Settings);1,1,1,0;2.118547,2.063088,1.863434,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;565;-1302.05,7113.326;Float;False;Property;_CloudSunsetColorBottom;Cloud Sunset Color Bottom;9;0;Create;True;0;0;False;0;0,0,0,0;1,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;277;-2486.431,5409.254;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;487;179.2546,6623.255;Inherit;False;486;MoonScatteringMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;436;425.1556,6060.026;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;413;319.0221,6214.243;Inherit;False;362;ScatteringMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;728;-1608.832,3981.681;Inherit;True;466;MoonMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;227;-2360.464,4393.305;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;491;209.6663,6703.58;Inherit;False;489;MoonLightColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;569;-799.5615,7090.543;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;566;-799.5613,6439.747;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;514;-755.9669,4662.508;Float;False;StarsColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;408;-815.9762,6634.868;Inherit;False;192;CloudBottomMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;513;1051.385,4755.657;Float;False;StarsMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;278;-2502.746,5093.156;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;407;-406.3379,6473.386;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;279;-2314.784,5302.875;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;476;-2205.734,7437.078;Inherit;False;False;False;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;517;-1419.551,3789.068;Inherit;True;513;StarsMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;228;-2156.428,4389.655;Float;True;SkyColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;516;-1405.806,3418.678;Inherit;True;514;StarsColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;427;576.1823,6195.576;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;522;-1442.569,3613.38;Float;False;Property;_StarsColor;StarsColor;57;1;[HDR];Create;True;0;0;False;0;1,1,1,0;2,1.669028,1.518868,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;490;503.6663,6638.58;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;729;-1388.379,4004.08;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;726;-1965.25,7146.324;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;294;-1405.503,3218.404;Inherit;True;228;SkyColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;465;-1943.256,7276.325;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;414;716.6162,6437.205;Inherit;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;523;-1166.569,3498.38;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;524;-1182.569,3774.38;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;280;-2012.538,5285.664;Float;True;Sun;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;296;-393.9393,4248.707;Inherit;False;194;CloudMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;519;-974.5695,3449.38;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;295;-1398.46,3005.565;Inherit;True;280;Sun;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;467;-1770.27,7267.646;Float;False;Moon;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;359;-362.8285,4170.972;Inherit;False;291;SkyMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;725;-1763.75,7143.725;Float;False;MoonSkyMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;405;852.3064,6433.657;Float;False;CloudsColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;358;-46.85588,4207.903;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;406;-288.5311,4061.959;Inherit;False;405;CloudsColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;470;-684.0779,3549.921;Inherit;True;467;Moon;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;297;-756.7664,3291.602;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;468;-694.5834,3744.626;Inherit;True;725;MoonSkyMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;412;82.02927,4131.343;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;905;17.16364,4324.336;Inherit;False;Property;_CullMode;Cull Mode;74;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;False;0;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;469;-415.7822,3528.939;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;411;93.49756,4201.458;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;309;291.1356,4152.877;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;904;286.1636,4326.336;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;748;-4063.751,7936.955;Inherit;False;2593.502;1029.328;Sun Rotation (Unused);23;798;803;806;795;788;758;756;775;752;779;751;754;799;780;750;789;786;794;787;791;797;802;804;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;440;-1367.099,7400.724;Inherit;False;2555.921;440.1101;Sky Rotation;11;447;650;651;648;446;448;444;441;623;539;732;;0.1172416,1,0,1;0;0
Node;AmplifyShaderEditor.FunctionNode;775;-2356.45,8133.07;Inherit;True;RotateVector;-1;;1843;5c6ddc37cb38dfb458f9519ddf619b0c;0;2;1;FLOAT3;0,0,0;False;2;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;446;-412.5264,7488.552;Inherit;True;RotateVector;-1;;1840;5c6ddc37cb38dfb458f9519ddf619b0c;0;2;1;FLOAT3;0,0,0;False;2;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NegateNode;651;118.2406,7504.723;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;756;-2069.497,8456.789;Inherit;True;RotateVector;-1;;1846;5c6ddc37cb38dfb458f9519ddf619b0c;0;2;1;FLOAT3;0,0,0;False;2;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TanOpNode;798;-3301.436,8761.669;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RadiansOpNode;804;-3718.851,8465.409;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;794;-2860.851,8653.409;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;788;-3993.018,8464.78;Float;False;Property;_SunOrbitAngle;Sun Orbit Angle;67;0;Create;True;0;0;False;0;0;53.4;0;89.999;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;780;-3002.017,8376.339;Float;False;Constant;_Vector3;Vector 3;56;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;754;-2750.431,8024.9;Inherit;True;254;WorldPositionNormalised;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;448;-762.7927,7465.393;Inherit;False;254;WorldPositionNormalised;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;360;-1739.982,5929.91;Float;False;SunsetScatteringMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;787;-3031.852,8237.409;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;650;249.0925,7506.348;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;903;562.0925,4223.285;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;732;260.9834,7700.054;Inherit;False;731;StarmapRotation;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NegateNode;803;-3527.831,8771.725;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;750;-2840.681,8501.039;Float;False;Property;_SunRotationAngle;Sun Rotation Angle;66;0;Create;True;0;0;False;0;0;8;-180;180;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;346;-2232.045,5798.72;Inherit;True;225;SunsetMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;648;-119.1008,7505.412;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;623;-1207.61,7477.003;Inherit;False;622;LightDirection;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;363;-1893.132,5926.854;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;795;-3948.485,8768.725;Float;False;Property;_SunOrbitShift;Sun Orbit Shift;68;0;Create;True;0;0;False;0;0;37.6;0;89.999;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;447;864.5827,7491.536;Float;False;SkyRotation;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;789;-2707.851,8645.409;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NegateNode;791;-2998.851,8648.409;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;441;-1253.756,7653.476;Float;False;Constant;_Vector1;Vector 1;56;0;Create;True;0;0;False;0;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RadiansOpNode;799;-2563.851,8504.409;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;779;-2631.917,8237.539;Inherit;True;FromToRotation;-1;;1831;ad10913350839ec49a3853aee4185e18;0;2;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.NegateNode;802;-3501.851,8462.409;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;758;-1776.19,8449.03;Float;True;SunRotation;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;571;-2818.856,4732.06;Float;False;SunsetProgressAbs;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;751;-2552.295,8645.449;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;786;-2823.075,8233.358;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TanOpNode;797;-3325.851,8453.409;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;539;552.2611,7573.402;Float;False;Property;_AutoStarsDirection;Auto Stars Direction;73;0;Create;True;0;0;False;0;0;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;444;-727.3556,7558.725;Inherit;True;FromToRotation;-1;;1837;ad10913350839ec49a3853aee4185e18;0;2;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RadiansOpNode;806;-3675.978,8771.282;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;752;-2347.201,8497.729;Inherit;True;RotateAngleAxis;-1;;1839;72edad85bb5dea440905ae88eddfa489;0;2;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;774.4088,4061.254;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;RED_SIM/Beautiful Sky;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;False;False;False;False;False;Front;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;True;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;905;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;901;0;897;1
WireConnection;901;2;897;3
WireConnection;900;0;252;0
WireConnection;900;1;901;0
WireConnection;899;0;900;0
WireConnection;581;0;899;0
WireConnection;581;1;899;2
WireConnection;583;0;581;0
WireConnection;574;0;899;1
WireConnection;579;0;581;0
WireConnection;579;1;583;0
WireConnection;582;0;579;0
WireConnection;578;0;899;1
WireConnection;578;1;574;0
WireConnection;573;0;582;0
WireConnection;573;1;578;0
WireConnection;573;2;582;1
WireConnection;663;0;660;0
WireConnection;253;0;573;0
WireConnection;664;0;660;0
WireConnection;534;0;115;0
WireConnection;662;0;663;0
WireConnection;662;2;664;0
WireConnection;662;3;666;0
WireConnection;662;4;664;0
WireConnection;254;0;253;0
WireConnection;618;0;662;0
WireConnection;618;1;619;0
WireConnection;526;1;525;0
WireConnection;622;0;618;0
WireConnection;532;0;526;0
WireConnection;99;0;576;0
WireConnection;530;1;529;0
WireConnection;162;0;168;0
WireConnection;162;1;169;0
WireConnection;101;0;99;1
WireConnection;101;2;99;1
WireConnection;101;3;103;0
WireConnection;101;4;99;1
WireConnection;531;0;532;0
WireConnection;531;1;530;0
WireConnection;102;0;99;0
WireConnection;102;1;99;2
WireConnection;828;0;739;0
WireConnection;828;1;829;0
WireConnection;934;0;116;0
WireConnection;164;0;159;0
WireConnection;164;1;162;0
WireConnection;833;0;831;0
WireConnection;833;1;832;0
WireConnection;536;0;531;0
WireConnection;628;0;627;0
WireConnection;104;0;102;0
WireConnection;104;1;101;0
WireConnection;208;0;628;0
WireConnection;208;1;202;0
WireConnection;740;0;738;0
WireConnection;825;0;828;0
WireConnection;830;0;164;0
WireConnection;830;1;833;0
WireConnection;107;0;104;0
WireConnection;931;0;934;0
WireConnection;741;2;825;0
WireConnection;741;3;740;0
WireConnection;212;0;208;0
WireConnection;212;1;209;0
WireConnection;261;0;281;0
WireConnection;261;1;624;0
WireConnection;129;0;110;0
WireConnection;129;1;122;0
WireConnection;896;0;538;0
WireConnection;896;1;830;0
WireConnection;131;0;117;0
WireConnection;131;1;122;0
WireConnection;933;1;931;0
WireConnection;626;0;625;0
WireConnection;262;0;261;0
WireConnection;914;0;913;0
WireConnection;821;0;212;0
WireConnection;745;1;742;0
WireConnection;745;2;741;0
WireConnection;744;1;740;0
WireConnection;744;2;743;0
WireConnection;200;0;626;0
WireConnection;730;0;673;0
WireConnection;826;0;676;0
WireConnection;112;0;113;0
WireConnection;112;1;122;0
WireConnection;112;2;131;0
WireConnection;112;3;129;0
WireConnection;112;4;534;0
WireConnection;112;5;933;0
WireConnection;112;6;108;0
WireConnection;112;7;156;0
WireConnection;112;8;896;0
WireConnection;112;9;152;0
WireConnection;112;10;148;0
WireConnection;112;11;183;0
WireConnection;112;12;184;0
WireConnection;112;13;541;0
WireConnection;112;14;542;0
WireConnection;746;1;745;0
WireConnection;746;2;744;0
WireConnection;920;0;914;0
WireConnection;911;0;913;0
WireConnection;286;0;293;0
WireConnection;820;0;821;0
WireConnection;669;2;826;0
WireConnection;669;3;730;0
WireConnection;204;0;200;0
WireConnection;205;0;256;0
WireConnection;133;0;112;0
WireConnection;761;0;746;0
WireConnection;679;1;670;0
WireConnection;679;2;669;0
WireConnection;174;0;133;0
WireConnection;174;1;133;1
WireConnection;174;2;175;0
WireConnection;917;0;911;0
WireConnection;917;1;920;0
WireConnection;211;0;206;0
WireConnection;211;1;204;0
WireConnection;819;0;820;0
WireConnection;214;0;205;0
WireConnection;287;0;286;0
WireConnection;287;1;285;0
WireConnection;735;1;730;0
WireConnection;735;2;736;0
WireConnection;747;0;746;0
WireConnection;630;0;629;0
WireConnection;238;0;255;0
WireConnection;216;0;211;0
WireConnection;216;1;213;0
WireConnection;921;0;917;0
WireConnection;921;2;922;0
WireConnection;289;0;287;0
WireConnection;289;1;288;0
WireConnection;127;0;124;0
WireConnection;902;5;174;0
WireConnection;902;13;544;0
WireConnection;240;0;238;0
WireConnection;240;1;239;0
WireConnection;215;0;214;0
WireConnection;215;1;210;0
WireConnection;231;0;630;0
WireConnection;231;1;229;0
WireConnection;734;1;679;0
WireConnection;734;2;735;0
WireConnection;217;0;212;0
WireConnection;827;0;761;0
WireConnection;233;0;231;0
WireConnection;233;1;232;0
WireConnection;218;0;215;0
WireConnection;731;0;734;0
WireConnection;762;0;827;0
WireConnection;928;0;921;0
WireConnection;928;1;929;0
WireConnection;454;0;452;0
WireConnection;454;1;453;0
WireConnection;290;0;289;0
WireConnection;123;0;902;0
WireConnection;123;2;127;0
WireConnection;241;0;240;0
WireConnection;220;0;216;0
WireConnection;700;0;683;0
WireConnection;219;0;217;0
WireConnection;264;0;262;0
WireConnection;264;1;263;0
WireConnection;907;1;928;0
WireConnection;684;0;266;0
WireConnection;684;2;700;0
WireConnection;245;0;241;0
WireConnection;685;0;262;0
WireConnection;685;1;687;0
WireConnection;234;0;233;0
WireConnection;221;0;220;0
WireConnection;706;0;687;0
WireConnection;194;0;123;0
WireConnection;269;0;267;0
WireConnection;455;0;454;0
WireConnection;222;0;219;0
WireConnection;291;0;290;0
WireConnection;223;0;218;0
WireConnection;321;0;317;0
WireConnection;321;1;488;0
WireConnection;925;0;907;3
WireConnection;224;0;223;0
WireConnection;224;1;221;0
WireConnection;224;2;222;0
WireConnection;457;0;455;0
WireConnection;457;1;456;0
WireConnection;320;0;316;0
WireConnection;592;0;245;0
WireConnection;458;0;452;0
WireConnection;270;0;264;0
WireConnection;270;3;684;0
WireConnection;493;1;494;0
WireConnection;357;0;234;0
WireConnection;686;0;685;0
WireConnection;686;3;706;0
WireConnection;459;0;457;0
WireConnection;460;0;458;0
WireConnection;605;0;925;0
WireConnection;605;1;604;0
WireConnection;594;0;590;0
WireConnection;225;0;224;0
WireConnection;506;0;503;0
WireConnection;506;1;504;0
WireConnection;506;2;501;0
WireConnection;324;0;321;0
WireConnection;449;0;122;0
WireConnection;585;0;493;1
WireConnection;585;1;493;2
WireConnection;585;2;493;3
WireConnection;633;0;632;0
WireConnection;190;0;183;0
WireConnection;190;2;183;0
WireConnection;190;3;191;0
WireConnection;190;4;191;0
WireConnection;322;0;320;0
WireConnection;322;1;319;0
WireConnection;235;0;357;0
WireConnection;692;0;270;0
WireConnection;691;0;686;0
WireConnection;189;0;181;0
WireConnection;189;1;190;0
WireConnection;586;0;585;0
WireConnection;249;0;244;0
WireConnection;249;1;243;0
WireConnection;249;2;245;0
WireConnection;609;0;605;0
WireConnection;609;1;511;0
WireConnection;462;1;459;0
WireConnection;690;0;692;0
WireConnection;690;1;691;0
WireConnection;589;0;594;0
WireConnection;589;1;593;0
WireConnection;326;0;324;0
WireConnection;326;1;325;0
WireConnection;248;0;246;0
WireConnection;248;1;242;0
WireConnection;248;2;245;0
WireConnection;331;0;322;0
WireConnection;505;0;633;0
WireConnection;587;0;506;0
WireConnection;461;0;460;0
WireConnection;429;0;430;0
WireConnection;591;0;589;0
WireConnection;272;0;690;0
WireConnection;508;0;505;0
WireConnection;327;0;331;0
WireConnection;327;1;328;0
WireConnection;471;0;474;0
WireConnection;471;1;473;0
WireConnection;471;2;472;0
WireConnection;182;0;133;2
WireConnection;182;1;189;0
WireConnection;182;2;450;0
WireConnection;271;0;265;0
WireConnection;271;1;269;0
WireConnection;271;2;268;0
WireConnection;510;0;586;0
WireConnection;250;0;249;0
WireConnection;250;1;248;0
WireConnection;250;2;235;0
WireConnection;433;0;431;0
WireConnection;433;1;429;0
WireConnection;509;0;587;0
WireConnection;463;0;461;0
WireConnection;463;1;462;4
WireConnection;936;0;609;0
WireConnection;492;0;326;0
WireConnection;512;0;508;0
WireConnection;512;1;510;0
WireConnection;512;2;509;0
WireConnection;512;3;591;0
WireConnection;512;4;936;0
WireConnection;275;0;271;0
WireConnection;567;0;563;0
WireConnection;567;1;564;0
WireConnection;567;2;568;0
WireConnection;251;0;250;0
WireConnection;192;0;182;0
WireConnection;681;0;272;0
WireConnection;489;0;471;0
WireConnection;362;0;327;0
WireConnection;466;0;463;0
WireConnection;303;0;299;0
WireConnection;303;1;298;0
WireConnection;303;2;301;0
WireConnection;434;0;433;0
WireConnection;486;0;492;0
WireConnection;277;0;273;0
WireConnection;277;1;274;0
WireConnection;277;2;276;0
WireConnection;436;0;434;0
WireConnection;436;1;435;0
WireConnection;227;0;251;0
WireConnection;227;1;226;0
WireConnection;227;2;225;0
WireConnection;569;0;567;0
WireConnection;569;1;565;0
WireConnection;569;2;570;0
WireConnection;566;0;303;0
WireConnection;566;1;304;0
WireConnection;566;2;305;0
WireConnection;514;0;493;0
WireConnection;513;0;512;0
WireConnection;278;0;681;0
WireConnection;278;2;275;0
WireConnection;407;0;566;0
WireConnection;407;1;569;0
WireConnection;407;2;408;0
WireConnection;279;0;278;0
WireConnection;279;1;277;0
WireConnection;476;0;471;0
WireConnection;228;0;227;0
WireConnection;427;0;436;0
WireConnection;427;1;413;0
WireConnection;490;0;487;0
WireConnection;490;1;491;0
WireConnection;729;0;728;0
WireConnection;726;0;463;0
WireConnection;726;1;476;0
WireConnection;465;0;462;0
WireConnection;465;1;489;0
WireConnection;414;0;427;0
WireConnection;414;1;407;0
WireConnection;414;2;490;0
WireConnection;523;0;516;0
WireConnection;523;1;522;0
WireConnection;524;0;522;4
WireConnection;524;1;517;0
WireConnection;524;2;729;0
WireConnection;280;0;279;0
WireConnection;519;0;294;0
WireConnection;519;1;523;0
WireConnection;519;2;524;0
WireConnection;467;0;465;0
WireConnection;725;0;726;0
WireConnection;405;0;414;0
WireConnection;358;0;359;0
WireConnection;358;1;296;0
WireConnection;297;0;295;0
WireConnection;297;1;519;0
WireConnection;412;0;406;0
WireConnection;469;0;297;0
WireConnection;469;1;470;0
WireConnection;469;2;468;0
WireConnection;411;0;358;0
WireConnection;309;0;469;0
WireConnection;309;1;412;0
WireConnection;309;2;411;0
WireConnection;904;0;905;0
WireConnection;775;1;754;0
WireConnection;775;2;779;0
WireConnection;446;1;448;0
WireConnection;446;2;444;0
WireConnection;651;0;648;0
WireConnection;756;1;775;0
WireConnection;756;2;752;0
WireConnection;798;0;803;0
WireConnection;804;0;788;0
WireConnection;794;0;791;0
WireConnection;794;1;798;0
WireConnection;360;0;363;0
WireConnection;787;0;797;0
WireConnection;650;0;651;0
WireConnection;650;1;648;1
WireConnection;650;2;648;2
WireConnection;903;0;309;0
WireConnection;903;1;904;0
WireConnection;803;0;806;0
WireConnection;648;0;446;0
WireConnection;363;0;346;0
WireConnection;363;1;327;0
WireConnection;447;0;539;0
WireConnection;789;0;794;0
WireConnection;791;0;797;0
WireConnection;799;0;750;0
WireConnection;779;1;786;0
WireConnection;779;2;780;0
WireConnection;802;0;804;0
WireConnection;758;0;756;0
WireConnection;571;0;222;0
WireConnection;751;0;789;0
WireConnection;786;0;787;0
WireConnection;797;0;802;0
WireConnection;539;0;650;0
WireConnection;539;1;732;0
WireConnection;444;1;623;0
WireConnection;444;2;441;0
WireConnection;806;0;795;0
WireConnection;752;2;799;0
WireConnection;752;3;751;0
WireConnection;0;2;903;0
ASEEND*/
//CHKSM=87C929DF7EA976BFAAB567335152F3F25659E3A9