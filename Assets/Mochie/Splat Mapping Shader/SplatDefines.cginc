#ifndef SPLAT_DEFINES_DEFINED
#define SPLAT_DEFINES_DEFINED

#include "UnityCG.cginc"
#include "UnityPBSLighting.cginc"
#include "AutoLight.cginc"
#include "../Common/Utilities.cginc"
#include "../Common/Color.cginc"
#include "../Common/Sampling.cginc"

#define LTCGI_ENABLED defined(LTCGI)
#define AREALIT_ENABBLED defined(_AREALIT_ON) && !defined(SHADER_API_MOBILE)

#if AREALIT_ENABLED
	#include "../../AreaLit/Shader/Lighting.hlsl"
#endif

#if LTCGI_ENABLED
	#include "Packages/at.pimaker.ltcgi/Shaders/LTCGI.cginc"
#endif

#if defined(SHADOWS_DEPTH) && !defined(SPOT)
	#define SHADOW_COORDS(idx1) unityShadowCoord2 _ShadowCoord : TEXCOORD##idx1;
#endif

int _LayerBlendSource, _LayerBlendMaskBicubic;
Texture2D _LayerBlendMask;
SamplerState sampler_LayerBlendMask;
float4 _LayerBlendMask_ST;

// Outputs
float3 specularTint;
float3 specularOcclusion;
float3 diffLight;
float3 reflLight;

MOCHIE_DECLARE_TEX2D(_BaseColor0);
MOCHIE_DECLARE_TEX2D(_PackedMap0);
MOCHIE_DECLARE_TEX2D(_Normal0);
float4 _BaseColor0_ST;
float4 _Color0;
float _PuddleTint0;
float _NormalStrength0;
float _Metallic0;
float _Roughness0;
float _Occlusion0;
float _PuddleBlendMin0;
float _PuddleBlendMax0;
int _SmoothnessMode0;
int _RoughnessChannel0;
int _MetallicChannel0;
int _OcclusionChannel0;
int _Layer0UVSet;
int _PuddleHeightBlend0;
int _PuddleRainMask0;
#if defined(_PARALLAX_0_ON)
    float _Height0;
    float _HeightOffset0;
    int _HeightChannel0;
#endif

#if defined(_LAYER_1_ON)
    MOCHIE_DECLARE_TEX2D_NOSAMPLER(_BaseColor1);
    MOCHIE_DECLARE_TEX2D_NOSAMPLER(_PackedMap1);
    MOCHIE_DECLARE_TEX2D_NOSAMPLER(_Normal1);
    float4 _BaseColor1_ST;
    float4 _Color1;
    float _PuddleTint1;
    float _NormalStrength1;
    float _Metallic1;
    float _Roughness1;
    float _Occlusion1;
    float _BlendThresholdMin1;
    float _BlendThresholdMax1;
    float _PuddleBlendMin1;
    float _PuddleBlendMax1;
    float _EdgePower1;
    int _SmoothnessMode1;
    int _RoughnessChannel1;
    int _MetallicChannel1;
    int _OcclusionChannel1;
    int _Layer1UVSet;
    int _PuddleHeightBlend1;
    int _PuddleRainMask1;
    int _HeightBlendEdges1;
    #if defined(_PARALLAX_1_ON)
        float _Height1;
        float _HeightOffset1;
        float _HeightBlendMin1;
        float _HeightBlendMax1;
        int _HeightChannel1;
        int _HeightBlend1;
    #endif
#endif

#if defined(_LAYER_2_ON)
    MOCHIE_DECLARE_TEX2D_NOSAMPLER(_BaseColor2);
    MOCHIE_DECLARE_TEX2D_NOSAMPLER(_PackedMap2);
    MOCHIE_DECLARE_TEX2D_NOSAMPLER(_Normal2);
    float4 _BaseColor2_ST;
    float4 _Color2;
    float _PuddleTint2;
    float _NormalStrength2;
    float _Metallic2;
    float _Roughness2;
    float _Occlusion2;
    float _BlendThresholdMin2;
    float _BlendThresholdMax2;
    float _PuddleBlendMin2;
    float _PuddleBlendMax2;
    float _EdgePower2;
    int _SmoothnessMode2;
    int _RoughnessChannel2;
    int _MetallicChannel2;
    int _OcclusionChannel2;
    int _Layer2UVSet;
    int _PuddleHeightBlend2;
    int _PuddleRainMask2;
    int _HeightBlendEdges2;
    #if defined(_PARALLAX_2_ON)
        float _Height2;
        float _HeightOffset2;
        float _HeightBlendMin2;
        float _HeightBlendMax2;
        int _HeightChannel2;
        int _HeightBlend2;
    #endif
#endif

#if defined(_LAYER_3_ON)
    MOCHIE_DECLARE_TEX2D_NOSAMPLER(_BaseColor3);
    MOCHIE_DECLARE_TEX2D_NOSAMPLER(_PackedMap3);
    MOCHIE_DECLARE_TEX2D_NOSAMPLER(_Normal3);
    float4 _BaseColor3_ST;
    float4 _Color3;
    float _PuddleTint3;
    float _NormalStrength3;
    float _Metallic3;
    float _Roughness3;
    float _Occlusion3;
    float _BlendThresholdMin3;
    float _BlendThresholdMax3;
    float _PuddleBlendMin3;
    float _PuddleBlendMax3;
    float _EdgePower3;
    int _SmoothnessMode3;
    int _RoughnessChannel3;
    int _MetallicChannel3;
    int _OcclusionChannel3;
    int _Layer3UVSet;
    int _PuddleHeightBlend3;
    int _PuddleRainMask3;
    int _HeightBlendEdges3;
    #if defined(_PARALLAX_3_ON)
        float _Height3;
        float _HeightOffset3;
        float _HeightBlendMin3;
        float _HeightBlendMax3;
        int _HeightChannel3;
        int _HeightBlend3;
    #endif
#endif

#if defined(_DEBUGMODE_ON)
    int _DebugBaseColor;
    int _DebugNormals;
    int _DebugRoughness;
    int _DebugMetallic;
    int _DebugOcclusion;
    int _DebugHeight;
    int _DebugVertexColors;
    int _DebugAtten;
    #if defined(_REFLECTIONS_ON)
        int _DebugReflections;
    #endif
    #if defined(_SPECULAR_HIGHLIGHTS_ON)
        int _DebugSpecular;
    #endif
    #if defined(_RAIN_ON)
        int _DebugRainThreshold;
    #endif
    int _DebugPuddleThreshold;
#endif

#if defined(_RAIN_ON)
    int _RainLayer0;
    int _RainLayer1;
    int _RainLayer2;
    int _RainLayer3;
    float _RainScale;
    float _RainSpeed;
    float _RainStrength;
    float _RainDensity;
    float _RainSize;
    float _RainThreshold;
    float _RainThresholdSize;
    float _RainPuddleDensity;
    float _RainPuddleSize;
#endif

#if defined(_AREALIT_ON) && !defined(SHADER_API_MOBILE)
    MOCHIE_DECLARE_TEX2D(_AreaLitOcclusion);
    float4 _AreaLitOcclusion_ST;
    int _AreaLitOcclusionUVSet;
    int _AreaLitToggle;
    int _AreaLitSpecularOcclusion;
    float _AreaLitStrength;
    float _AreaLitRoughnessMult;
    float _OpaqueLights;
#endif

#if defined(LTCGI)
    float _LTCGIStrength;
    float _LTCGIRoughness;
#endif

float _PuddleThreshold;
float _PuddleThresholdSize;

float _ReflectionStrength;
float _SpecularHighlightStrength;
float _FresnelStrength;
float _SpecularOcclusionStrength;
float _SpecularOcclusionContrast;
float _SpecularOcclusionBrightness;
float _SpecularOcclusionHDR;
float3 _SpecularOcclusionTint;
int _SpecularOcclusionToggle;
int _FresnelToggle;
int _IgnoreRealtimeGI;

int _SSRToggle;
MOCHIE_DECLARE_TEX2D_SCREENSPACE(_CameraDepthTexture);
MOCHIE_DECLARE_TEX2D_SCREENSPACE(_SplatGrab);
sampler2D _NoiseTexSSR;
float4 _CameraDepthTexture_TexelSize;
float4 _SplatGrab_TexelSize;
float4 _NoiseTexSSR_TexelSize;
float _SSRStrength;
float _SSRHeight;
float _SSREdgeFade;

struct SampleData {
    float3 uvA;
    float3 uvB;
    float3 uvC;
    float2 dx;
    float2 dy;
};

struct LightingData {
    float3 reflectionCol;
    float3 specHighlightCol;
    float3 directCol;
    float3 indirectCol;
    float3 lightCol;
    float3 lightDir;
    float3 viewDir;
    float2 screenUV;
    float atten;
    float NdotL;
    float VNdotL;
    float omr;
    float3 lmSpec;
    bool isRealtime;
};

struct InputData {
    float4 albedo;
    float4 diffuse;
    float3 normal;
    float3 normalTS;
    float3 vNormal;
    float roughness;
    float metallic;
    float occlusion;
    float height;
};

struct appdata {
    float4 vertex : POSITION;
    float4 uv : TEXCOORD0;
    float4 uv1 : TEXCOORD1;
    float4 uv2 : TEXCOORD2;
    float4 uv3 : TEXCOORD3;
    float4 uv4 : TEXCOORD4;
    float3 normal : NORMAL;
    float4 tangent : TANGENT;
    float4 color : COLOR;
    UNITY_VERTEX_INPUT_INSTANCE_ID
};

struct v2f {
    float4 pos : SV_POSITION;
    float2 uv0 : TEXCOORD0;
    #if defined(_LAYER_1_ON)
        float2 uv1 : TEXCOORD1;
    #endif
    #if defined(_LAYER_2_ON)
        float2 uv2 : TEXCOORD2;
    #endif
    #if defined(_LAYER_3_ON)
        float2 uv3 : TEXCOORD3;
    #endif
    float3 normal : TEXCOORD4;
    float4 tangent : TEXCOORD5;
    float3 worldPos : TEXCOORD6;
    float4 color : TEXCOORD7;
    #if defined(UNITY_PASS_FORWARDBASE)
        float4 lightmapUV : TEXCOORD8;
        bool vertexLightOn : TEXCOORD9;
    #endif
    #if AREALIT_ENABLED
        float2 areaLitOcclusionUV : TEXCOORD10;
    #endif
    float4 rawUV : TEXCOORD11;
    float4 grabUV : TEXCOORD12;
    UNITY_SHADOW_COORDS(13)
    UNITY_FOG_COORDS(14)
    UNITY_VERTEX_OUTPUT_STEREO
};

struct v2f_meta {
    float4 pos : SV_POSITION;
    float2 uv0 : TEXCOORD0;
    #if defined(_LAYER_1_ON)
        float2 uv1 : TEXCOORD1;
    #endif
    #if defined(_LAYER_2_ON)
        float2 uv2 : TEXCOORD2;
    #endif
    #if defined(_LAYER_3_ON)
        float2 uv3 : TEXCOORD3;
    #endif
    float3 normal : TEXCOORD4;
    float4 tangent : TEXCOORD5;
    float3 worldPos : TEXCOORD6;
    float4 color : TEXCOORD7;
    #ifdef EDITOR_VISUALIZATION
        float2 vizUV    : TEXCOORD8;
        float4 lightCoord   : TEXCOORD9;
    #endif
    // #if AREALIT_ENABLED
    //     float4 areaLitOcclusionUV : TEXCOORD10;
    // #endif
    float4 rawUV : TEXCOORD10;
};

#include "SplatSampling.cginc"
#include "SplatParallax.cginc"
#if defined(UNITY_PASS_META)
    #include "SplatMetaPass.cginc"
#else
    #include "SplatLighting.cginc"
    #include "SplatSSR.cginc"
    #include "SplatBRDF.cginc"
    #include "SplatPass.cginc"
#endif

#endif