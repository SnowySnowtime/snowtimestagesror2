// By Mochie#8794

Shader "Mochie/Splat Mapping"{
    Properties{

		[Enum(Vertex Color,0, Mask Texture,1)]_LayerBlendSource("Layer Blending Source", Int) = 0
		_LayerBlendMask("Mask (RGBA)", 2D) = "white" {}
		[ToggleUI]_LayerBlendMaskBicubic("Bicubic", Int) = 0

		// Base Layer
		[Toggle(_STOCHASTIC_0_ON)]_ToggleStochastic0("Stochastic Sampling", Int) = 0
		[Toggle(_PARALLAX_0_ON)]_ToggleParallax0("Parallax", Int) = 0
		_Color0("Color", Color) = (1,1,1,1)
        _BaseColor0("Base Color", 2D) = "white" {}
		[NoScaleOffset]_Normal0("Normal", 2D) = "bump" {}
		[NoScaleOffset]_PackedMap0("Packed Map (ARMH)", 2D) = "white" {}
		_NormalStrength0("Normal Strength", Range(0,2)) = 1
		_Roughness0("Roughness", Range(0,1)) = 1
		_Metallic0("Metallic", Range(0,1)) = 1
		_Occlusion0("Occlusion", Range(0,1)) = 1
		_Height0("Height", Range(0,0.1)) = 0.01
		_HeightOffset0("Height Offset", Range(-2,2)) = 0
		[Enum(Off,0, On,1)]_SmoothnessMode0("Smoothness", Int) = 0
		[Enum(Red,0, Green,1, Blue,2, Alpha,3)]_RoughnessChannel0("Roughness Channel", Int) = 1
		[Enum(Red,0, Green,1, Blue,2, Alpha,3)]_MetallicChannel0("Metallic Channel", Int) = 2
		[Enum(Red,0, Green,1, Blue,2, Alpha,3)]_OcclusionChannel0("Occlusion Channel", Int) = 0
		[Enum(Red,0, Green,1, Blue,2, Alpha,3)]_HeightChannel0("Height Channel", Int) = 3
		[Enum(UV0,0, UV1,1, UV2,2, UV3,3, UV4,4)]_Layer0UVSet("Layer 0 UV Set", Int) = 0
		[ToggleUI]_PuddleHeightBlend0("Puddle Height Blend", Int) = 0
		[ToggleUI]_PuddleRainMask0("Puddle Rain Mask", Int) = 0
		_PuddleBlendMin0("Puddle Blend Min", Float) = 0.5
		_PuddleBlendMax0("Puddle Blend Max", Float) = 0.6
		_PuddleTint0("Puddle Tint 0", Range(0,1)) = 0.7

		// Layer 1
		[Toggle(_LAYER_1_ON)]_ToggleLayer1("Enable", Int) = 0
		[Toggle(_STOCHASTIC_1_ON)]_ToggleStochastic1("Stochastic Sampling", Int) = 0
		[Toggle(_PARALLAX_1_ON)]_ToggleParallax1("Parallax", Int) = 0
		_Color1("Color", Color) = (1,1,1,1)
        _BaseColor1("Base Color", 2D) = "white" {}
		[NoScaleOffset]_Normal1("Normal", 2D) = "bump" {}
		[NoScaleOffset]_PackedMap1("Packed Map (ARMH)", 2D) = "white" {}
		_NormalStrength1("Normal Strength", Range(0,2)) = 1
		_Roughness1("Roughness", Range(0,1)) = 1
		_Metallic1("Metallic", Range(0,1)) = 1
		_Occlusion1("Occlusion", Range(0,1)) = 1
		_Height1("Height", Range(0,0.1)) = 0.01
		_HeightOffset1("Height Offset", Range(-2,2)) = 0
		[ToggleUI]_HeightBlend1("Height Blend", Int) = 0
		_HeightBlendMin1("Height Blend Min", Float) = 0.45
		_HeightBlendMax1("Hieght Blend Max", Float) = 0.55
		[Enum(Off,0, On,1)]_SmoothnessMode1("Smoothness", Int) = 0
		[Enum(Red,0, Green,1, Blue,2, Alpha,3)]_RoughnessChannel1("Roughness Channel", Int) = 1
		[Enum(Red,0, Green,1, Blue,2, Alpha,3)]_MetallicChannel1("Metallic Channel", Int) = 2
		[Enum(Red,0, Green,1, Blue,2, Alpha,3)]_OcclusionChannel1("Occlusion Channel", Int) = 0
		[Enum(Red,0, Green,1, Blue,2, Alpha,3)]_HeightChannel1("Height Channel", Int) = 3
		_BlendThresholdMin1("Blend Threshold Min", Float) = 0
		_BlendThresholdMax1("Blend Threshold Max", Float) = 1
		[Enum(UV0,0, UV1,1, UV2,2, UV3,3, UV4,4)]_Layer1UVSet("Layer 1 UV Set", Int) = 0
		[ToggleUI]_PuddleHeightBlend1("Puddle Height Blend", Int) = 0
		[ToggleUI]_PuddleRainMask1("Puddle Rain Mask", Int) = 0
		_PuddleBlendMin1("Puddle Blend Min", Float) = 0.5
		_PuddleBlendMax1("Puddle Blend Max", Float) = 0.6
		_PuddleTint1("Puddle Tint 1", Range(0,1)) = 0.7
		[ToggleUI]_HeightBlendEdges1("Layer Blend Edges", Int) = 0
		_EdgePower1("Edge Power", Float) = 5

		// Layer 2
		[Toggle(_LAYER_2_ON)]_ToggleLayer2("Enable", Int) = 0
		[Toggle(_STOCHASTIC_2_ON)]_ToggleStochastic2("Stochastic Sampling", Int) = 0
		[Toggle(_PARALLAX_2_ON)]_ToggleParallax2("Parallax", Int) = 0
		_Color2("Color", Color) = (1,1,1,1)
        _BaseColor2("Base Color", 2D) = "white" {}
		[NoScaleOffset]_Normal2("Normal", 2D) = "bump" {}
		[NoScaleOffset]_PackedMap2("Packed Map (ARMH)", 2D) = "white" {}
		_NormalStrength2("Normal Strength", Range(0,2)) = 1
		_Roughness2("Roughness", Range(0,1)) = 1
		_Metallic2("Metallic", Range(0,1)) = 1
		_Occlusion2("Occlusion", Range(0,1)) = 1
		_Height2("Height", Range(0,0.1)) = 0.01
		_HeightOffset2("Height Offset", Range(-2,2)) = 0
		[ToggleUI]_HeightBlend2("Height Blend", Int) = 0
		_HeightBlendMin2("Height Blend Min", Float) = 0.45
		_HeightBlendMax2("Hieght Blend Max", Float) = 0.55
		[Enum(Off,0, On,1)]_SmoothnessMode2("Smoothness", Int) = 0
		[Enum(Red,0, Green,1, Blue,2, Alpha,3)]_RoughnessChannel2("Roughness Channel", Int) = 1
		[Enum(Red,0, Green,1, Blue,2, Alpha,3)]_MetallicChannel2("Metallic Channel", Int) = 2
		[Enum(Red,0, Green,1, Blue,2, Alpha,3)]_OcclusionChannel2("Occlusion Channel", Int) = 0
		[Enum(Red,0, Green,1, Blue,2, Alpha,3)]_HeightChannel2("Height Channel", Int) = 3
		_BlendThresholdMin2("Blend Threshold Min", Float) = 0
		_BlendThresholdMax2("Blend Threshold Max", Float) = 1
		[Enum(UV0,0, UV1,1, UV2,2, UV3,3, UV4,4)]_Layer2UVSet("Layer 2 UV Set", Int) = 0
		[ToggleUI]_PuddleHeightBlend2("Puddle Height Blend", Int) = 0
		[ToggleUI]_PuddleRainMask2("Puddle Rain Mask", Int) = 0
		_PuddleBlendMin2("Puddle Blend Min", Float) = 0.5
		_PuddleBlendMax2("Puddle Blend Max", Float) = 0.6
		_PuddleTint2("Puddle Tint 2", Range(0,1)) = 0.7
		[ToggleUI]_HeightBlendEdges2("Layer Blend Edges", Int) = 0
		_EdgePower2("Edge Power", Float) = 5

		// Layer 3
		[Toggle(_LAYER_3_ON)]_ToggleLayer3("Enable", Int) = 0
		[Toggle(_STOCHASTIC_3_ON)]_ToggleStochastic3("Stochastic Sampling", Int) = 0
		[Toggle(_PARALLAX_3_ON)]_ToggleParallax3("Parallax", Int) = 0
		_Color3("Color", Color) = (1,1,1,1)
        _BaseColor3("Base Color", 2D) = "white" {}
		[NoScaleOffset]_Normal3("Normal", 2D) = "bump" {}
		[NoScaleOffset]_PackedMap3("Packed Map (ARMH)", 2D) = "white" {}
		_NormalStrength3("Normal Strength", Range(0,2)) = 1
		_Roughness3("Roughness", Range(0,1)) = 1
		_Metallic3("Metallic", Range(0,1)) = 1
		_Occlusion3("Occlusion", Range(0,1)) = 1
		_Height3("Height", Range(0,0.1)) = 0.01
		_HeightOffset3("Height Offset", Range(-2,2)) = 0
		[ToggleUI]_HeightBlend3("Height Blend", Int) = 0
		_HeightBlendMin3("Height Blend Min", Float) = 0.45
		_HeightBlendMax3("Hieght Blend Max", Float) = 0.55
		[Enum(Off,0, On,1)]_SmoothnessMode3("Smoothness", Int) = 0
		[Enum(Red,0, Green,1, Blue,2, Alpha,3)]_RoughnessChannel3("Roughness Channel", Int) = 1
		[Enum(Red,0, Green,1, Blue,2, Alpha,3)]_MetallicChannel3("Metallic Channel", Int) = 2
		[Enum(Red,0, Green,1, Blue,2, Alpha,3)]_OcclusionChannel3("Occlusion Channel", Int) = 0
		[Enum(Red,0, Green,1, Blue,2, Alpha,3)]_HeightChannel3("Height Channel", Int) = 3
		_BlendThresholdMin3("Blend Threshold Min", Float) = 0
		_BlendThresholdMax3("Blend Threshold Max", Float) = 1
		[Enum(UV0,0, UV1,1, UV2,2, UV3,3, UV4,4)]_Layer3UVSet("Layer 3 UV Set", Int) = 0
		[ToggleUI]_PuddleHeightBlend3("Puddle Height Blend", Int) = 0
		[ToggleUI]_PuddleRainMask3("Puddle Rain Mask", Int) = 0
		_PuddleBlendMin3("Puddle Blend Min", Float) = 0.5
		_PuddleBlendMax3("Puddle Blend Max", Float) = 0.6
		_PuddleTint3("Puddle Tint 3", Range(0,1)) = 0.7
		[ToggleUI]_HeightBlendEdges3("Layer Blend Edges", Int) = 0
		_EdgePower3("Edge Power", Float) = 5

		// Specularity
		[ToggleUI]_ReflectionsToggle("Reflections", Int) = 1
		[ToggleUI]_SpecularHighlightsToggle("Specular Highlights", Int) = 1
		_ReflectionStrength("Reflection Strength", Float) = 1
		_SpecularHighlightStrength("Specular Strength", Float) = 1
		[ToggleUI]_FresnelToggle("Fresnel", Int) = 1
		_FresnelStrength("Fresnel Strength", Float) = 1
		[ToggleUI]_SpecularOcclusionToggle("Specular Occlusion", Int) = 0
		_SpecularOcclusionStrength("Specular Occlusion Strength", Float) = 1
		_SpecularOcclusionContrast("Contrast", Float) = 1
		_SpecularOcclusionBrightness("Brightness", Float) = 100
		_SpecularOcclusionHDR("HDR", Float) = 1
		_SpecularOcclusionTint("Tint", Color) = (1,1,1,1)
		[ToggleUI]_SSRToggle("Screenspace Reflections", Int) = 0
		_SSRStrength("SSR Strength", Float) = 1
		_SSREdgeFade("Edge Fade", Range(0,1)) = 0.1
		_SSRHeight("SSR Height", Range(0.1, 0.5)) = 0.2

		// Rain
		[Toggle(_RAIN_ON)]_RainToggle("Enable", Int) = 0
		[ToggleUI]_RainLayer0("Layer 0 (Base)", Int) = 0
		[ToggleUI]_RainLayer1("Layer 1 (R)", Int) = 0
		[ToggleUI]_RainLayer2("Layer 2 (G)", Int) = 0
		[ToggleUI]_RainLayer3("Layer 3 (B)", Int) = 0
		_RainScale("Ripple Scale", float) = 100
		_RainSpeed("Ripple Speed", float) = 15
		_RainStrength("Ripple Strength", float) = 1
		_RainDensity("Ripple Density", float) = 0.65
		_RainSize("Ripple Size", Range(1,10)) = 1
		_RainPuddleDensity("Ripple Puddle Density", Float) = 1
		_RainPuddleSize("Ripple Puddle Size", Range(1,10)) = 5
		_RainThreshold("Angle Threshold", Range(0,1)) = 0.9
		_RainThresholdSize("Angle Threshold Blend", Range(0,1)) = 0.02
		_PuddleThreshold("Angle Threshold", Range(0,1)) = 0.93
		_PuddleThresholdSize("Angle Threshold Blend", Range(0,1)) = 0.1

		// Lightmapping stuff
		[Toggle(BAKERY_LMSPEC)] _BAKERY_LMSPEC ("Lightmap Specular", Float) = 0
		[Toggle(BAKERY_SHNONLINEAR)] _BAKERY_SHNONLINEAR ("Non-Linear SH", Float) = 0
		[Toggle(_BICUBIC_SAMPLING_ON)]_BicubicSampling("Bicubic Sampling", Int) = 1
		[Enum(None, 0, SH, 1, RNM, 2, MONOSH, 3)] _BakeryMode ("Bakery Mode", Int) = 0
		[ToggleUI]_IgnoreRealtimeGI("Ignore Realtime GI", Int) = 0
		_RNM0("RNM0", 2D) = "black" {}
		_RNM1("RNM1", 2D) = "black" {}
		_RNM2("RNM2", 2D) = "black" {}

		// AreaLit
		[Toggle(_AREALIT_ON)]_AreaLitToggle("Enable", Int) = 0
		_AreaLitStrength("Strength", Float) = 1
		_AreaLitRoughnessMult("Roughness Multiplier", Float) = 1
		[ToggleUI]_AreaLitSpecularOcclusion("Apply Specular Occlusion", Int) = 0
		[NoScaleOffset]_LightMesh("Light Mesh", 2D) = "black" {}
		[NoScaleOffset]_LightTex0("Light Texture 0", 2D) = "white" {}
		[NoScaleOffset]_LightTex1("Light Texture 1", 2D) = "black" {}
		[NoScaleOffset]_LightTex2("Light Texture 2", 2D) = "black" {}
		[NoScaleOffset]_LightTex3("Light Texture 3", 2DArray) = "black" {}
		[ToggleOff]_OpaqueLights("Opaque Lights", Float) = 1.0
		_AreaLitOcclusion("Occlusion", 2D) = "white" {}
		[Enum(UV0,0,UV1,1, UV2,2, UV3,3, UV4,4, UV1_LightmapST,5)]_AreaLitOcclusionUVSet("UV Set for occlusion map", Float) = 0
		
		// LTCGI
		[Toggle(LTCGI)]_LTCGI("LTCGI", Int) = 0
    	[Toggle(LTCGI_DIFFUSE_OFF)]_LTCGI_DIFFUSE_OFF("LTCGI Disable Diffuse", Int) = 0
		[Toggle(LTCGI_SPECULAR_OFF)]_LTCGI_SPECULAR_OFF("LTCGI Disable Specular", Int) = 0
		_LTCGI_mat("LTC Mat", 2D) = "black" {}
        _LTCGI_amp("LTC Amp", 2D) = "black" {}
		_LTCGIStrength("LTCGI Strength", Float) = 1
		_LTCGIRoughness("LTCGI Roughness", Float) = 1

		// Debug
		[Toggle(_DEBUGMODE_ON)]_DebugMode("Enable", Int) = 0
		[ToggleUI]_DebugVertexColors("Vertex Colors", Int) = 1
		[ToggleUI]_DebugBaseColor("Base Color", Int) = 0
		[ToggleUI]_DebugNormals("Normals", Int) = 0
		[ToggleUI]_DebugRoughness("Roughness", Int) = 0
		[ToggleUI]_DebugMetallic("Metallic", Int) = 0
		[ToggleUI]_DebugOcclusion("Occlusion", Int) = 0
		[ToggleUI]_DebugHeight("Parallax", Int) = 0
		[ToggleUI]_DebugAtten("Attenuation", Int) = 0
		[ToggleUI]_DebugReflections("Reflections", Int) = 0
		[ToggleUI]_DebugSpecular("Specular Highlights", Int) = 0
		[ToggleUI]_DebugRainThreshold("Rain Angle Mask", Int) = 0
		[ToggleUI]_DebugPuddleThreshold("Puddle Angle Mask", Int) = 0

		[HideInInspector]_NoiseTexSSR("SSR Noise Tex", 2D) = "black"
    }

    SubShader {
        Tags {
			"RenderType"="Opaque" 
			"Queue"="Geometry"
			"DisableBatching"="True"
			"LTCGI"="_LTCGI"
		}
		
		GrabPass {
			Tags {"LightMode"="Always"}
			"_SplatGrab"
		}

        Pass {
			NAME "FORWARD"
			Tags {"LightMode"="ForwardBase"}

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
			#pragma shader_feature_local _STOCHASTIC_0_ON
			#pragma shader_feature_local _PARALLAX_0_ON
			#pragma shader_feature_local _LAYER_1_ON
			#pragma shader_feature_local _STOCHASTIC_1_ON
			#pragma shader_feature_local _PARALLAX_1_ON
			#pragma shader_feature_local _LAYER_2_ON
			#pragma shader_feature_local _STOCHASTIC_2_ON
			#pragma shader_feature_local _PARALLAX_2_ON
			#pragma shader_feature_local _LAYER_3_ON
			#pragma shader_feature_local _STOCHASTIC_3_ON
			#pragma shader_feature_local _PARALLAX_3_ON
			#pragma shader_feature_local _SPECULAR_HIGHLIGHTS_ON
			#pragma shader_feature_local _REFLECTIONS_ON
			#pragma shader_feature_local _DEBUGMODE_ON
			#pragma shader_feature_local _BICUBIC_SAMPLING_ON
			#pragma shader_feature_local _HEIGHT_BLENDING_ON
			#pragma shader_feature_local _RAIN_ON
			#pragma shader_feature_local _AREALIT_ON
			#pragma shader_feature_local _OPAQUELIGHTS_OFF
			#pragma shader_feature_local _SSR_ON
			#pragma shader_feature_local LTCGI
			#pragma shader_feature_local LTCGI_DIFFUSE_OFF
			#pragma shader_feature_local LTCGI_SPECULAR_OFF
			#pragma shader_feature_local BAKERY_LMSPEC
			#pragma shader_feature_local BAKERY_SHNONLINEAR
			#pragma shader_feature_local _ BAKERY_SH BAKERY_RNM BAKERY_MONOSH
            #pragma multi_compile_fog
			#pragma multi_compile_fwdbase
			#pragma multi_compile_instancing
			#pragma target 5.0
			#include "SplatDefines.cginc"
            ENDCG
        }

        Pass {
			NAME "FORWARD_DELTA"
			Tags {"LightMode"="ForwardAdd"}
			Blend One One
			Fog {Color (0,0,0,0)}
            ZWrite Off

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
			#pragma shader_feature_local _STOCHASTIC_0_ON
			#pragma shader_feature_local _PARALLAX_0_ON
			#pragma shader_feature_local _LAYER_1_ON
			#pragma shader_feature_local _STOCHASTIC_1_ON
			#pragma shader_feature_local _PARALLAX_1_ON
			#pragma shader_feature_local _LAYER_2_ON
			#pragma shader_feature_local _STOCHASTIC_2_ON
			#pragma shader_feature_local _PARALLAX_2_ON
			#pragma shader_feature_local _LAYER_3_ON
			#pragma shader_feature_local _STOCHASTIC_3_ON
			#pragma shader_feature_local _PARALLAX_3_ON
			#pragma shader_feature_local _SPECULAR_HIGHLIGHTS_ON
			#pragma shader_feature_local _DEBUGMODE_ON
			#pragma shader_feature_local _HEIGHT_BLENDING_ON
            #pragma multi_compile_fog
			#pragma multi_compile_fwdadd_fullshadows
			#pragma multi_compile_instancing
			#pragma target 5.0
			#include "SplatDefines.cginc"
            ENDCG
        }

		Pass {
			NAME "ShadowCaster"
			Tags {"LightMode"="ShadowCaster"}
			ZWrite On
			ZTest LEqual

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_shadowcaster
			#pragma multi_compile_instancing
			#include "UnityPBSLighting.cginc"

			struct appdata {
				float4 vertex : POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct v2f {
				float4 pos : SV_POSITION;
				UNITY_VERTEX_OUTPUT_STEREO
			};

			v2f vert(appdata v){
				v2f o = (v2f)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				o.pos = UnityObjectToClipPos(v.vertex);
				TRANSFER_SHADOW_CASTER(o)
				return o;
			}

			float4 frag (v2f i) : SV_Target {
				return 0;
			}
			ENDCG
		}
	
		Pass {
			Name "META"
			Tags {"LightMode"="Meta"}
			Cull Off

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma shader_feature_local _STOCHASTIC_0_ON
			#pragma shader_feature_local _PARALLAX_0_ON
			#pragma shader_feature_local _LAYER_1_ON
			#pragma shader_feature_local _STOCHASTIC_1_ON
			#pragma shader_feature_local _PARALLAX_1_ON
			#pragma shader_feature_local _LAYER_2_ON
			#pragma shader_feature_local _STOCHASTIC_2_ON
			#pragma shader_feature_local _PARALLAX_2_ON
			#pragma shader_feature_local _LAYER_3_ON
			#pragma shader_feature_local _STOCHASTIC_3_ON
			#pragma shader_feature_local _PARALLAX_3_ON
			#pragma shader_feature_local _HEIGHT_BLENDING_ON
			// #pragma shader_feature_local _AREALIT_ON
			#pragma shader_feature EDITOR_VISUALIZATION
			#include "SplatDefines.cginc"
			ENDCG
        }
    }
	CustomEditor "SplatEditor"
}
