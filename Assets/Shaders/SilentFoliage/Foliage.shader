// Foliage, by Silent

Shader "Silent/Foliage"
{
	Properties
	{
		[HeaderEx(Main Options)]
		_Color ("Tint Color", Color) = (1,1,1,1)
		_MainTex("Albedo Map", 2D) = "white" {}
		[Space]
        _Cutoff("Cutout", Range(0,1)) = 0.5
        _ClampCutoff("Transparency Threshold", Range(1, 0)) = 0.5
        [ToggleUI]_AlphaSharp("Sharp Transparency", Float) = 1.0

		[Space]
	    //_VanishingStart("Camera Fade Start", Range(0, 1)) = 0.0 // Pointless for foliage
	    _VanishingEnd("Camera Fade End", Range(0, 1)) = 0.1

	    [Space]
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("Cull Mode", Int) = 0
		[ToggleUI]_BackfaceNormals("Flip Backface Lighting", Float) = 0.0

		[HeaderEx(Normal Map)]
		[Normal][NoScaleOffset][SetKeyword(_NORMALMAP)]_BumpMap("Normal Map", 2D) = "bump" {}
		_BumpMapScale("Normal Map Scale", Float) = 1.0

		[HeaderEx(Specular)]
		[NoScaleOffset][SetKeyword(_METALLICGLOSSMAP)]_MetallicGlossMap("Specular or Metalness Map", 2D) = "white" {}
		[ToggleUI]_ConvertMetallic("Use Metallic Workflow", Float) = 0.0
		_Metallic("Specular Scale", Range(0, 1)) = 0
		_Smoothness("Smoothness Scale", Range(0, 1)) = 0

		[HeaderEx(Occlusion)]
		[NoScaleOffset][SetKeyword(_SUNDISK_NONE)]_OcclusionMap("Occlusion Map", 2D) = "white" {}
		[Enum(UV0, 0, UV1, 1, UV2, 2, UV3, 3)]_OcclusionUVSource("Occlusion UV Source", Float) = 0.0 
		_OcclusionStrength("Occlusion Scale", Range(0, 1)) = 1
		_VertexColorIntOcclusion("Vertex Colour Occlusion Intensity (G)", Range(0, 1)) = 0.0

		[HeaderEx(Emission)]
		[NoScaleOffset][SetKeyword(_EMISSION)]_EmissionMap("Emission Map", 2D) = "white" {}
        _EmissionColor("Emission Color", Color) = (0,0,0)
		[Gamma]_Emission("Emission Strength", Float) = 0

		[HeaderEx(Wrapped Lighting)]
		_ProbeTransmission("Light Probes Wrapping Factor", Range(0, 2)) = 1
		_WrappingFactor("Direct Light Wrapping Factor", Range(0.001, 1)) = 0.01
		[Gamma]_WrappingPowerFactor("Direct Light Wrapping Power Factor", Float) = 1

		[HeaderEx(Transmission)]
		_SSSCol ("Transmission Color", Color) = (1,1,1,1)
		[NoScaleOffset][SetKeyword(_SPECGLOSSMAP)]_TransmissionMap("Transmission Map", 2D) = "white" {}
		[Toggle]_ThicknessMapInvert("Invert Transmission", Range(0, 1)) = 1
		_SSSDist("Distortion", Range(0, 10)) = 1
		_SSSPow("Power", Range(0.01, 10)) = 1
		_SSSIntensity("Intensity", Range(0, 1)) = 1
		_SSSAmbient("Ambient", Range(0, 1)) = 0
		_SSSShadowStrength("Shadow Strength", Range(0, 1)) = 1

		[HeaderEx(Wind Properties)]
		[Toggle(BLOOM)]_DisableWind("Disable Wind", Float) = 0
		[Enum(Texture,0,Vertex Colour (R),1,UV Y position,2,Vertex Colour (A),3)]_WindSource("Wind Pinning Source", Float) = 2
		[NoScaleOffset]_WindTex("Wind Pinning Texture (R)", 2D) = "white" {}
		_WaveAndDistance("Wave and Distance Properties", Vector) = (1.0, 1.0, 1.0, 1.0)
		_WindTrembling("Wind Trembling Intensity", Range(0, 1)) = 0

		[HeaderEx(Hue Variation)]
        [Toggle(EFFECT_HUE_VARIATION)] _HueVariationToggle("Hue Variation", Float) = 0
        _HueVariationColor ("Hue Variation Color", Color) = (1.0,0.5,0.0,0.1)
        [Space]
		_VertexColorInt("Vertex Colour Intensity", Range(0, 1)) = 0.0
		_VertexAlphaInt("Vertex Alpha Intensity", Range(0, 1)) = 0.0

		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
		[HeaderEx(System)]
        [KeywordEnum(None, SH, RNM, MonoSH)] _Bakery ("Bakery Mode", Int) = 0
        [HideInInspector]_RNM0("RNM0", 2D) = "black" {}
        [HideInInspector]_RNM1("RNM1", 2D) = "black" {}
        [HideInInspector]_RNM2("RNM2", 2D) = "black" {}
        _ExposureOcclusion("Lightmap Occlusion Sensitivity", Range(0, 1)) = 0.2
        [Toggle(_LIGHTMAPSPECULAR)]_LightmapSpecular("Lightmap Specular", Range(0, 1)) = 1
        _LightmapSpecularMaxSmoothness("Lightmap Specular Max Smoothness", Range(0, 1)) = 0.9
        [Toggle(_VRCLV)]_VRCLV("VRC Light Volumes", Range(0, 1)) = 1
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0

        [NonModifiableTextureData][HideInInspector] _DFG("DFG", 2D) = "white" {}
        [NonModifiableTextureData][HideInInspector] _Noise("Dither Pattern", 2D) = "white" {}
	}

CGINCLUDE
    #pragma multi_compile_instancing
    #pragma multi_compile_fog

    #include "UnityCG.cginc"
    #include "Lighting.cginc"
    #include "AutoLight.cginc"
    #include "UnityPBSLighting.cginc"
    #include "UnityStandardUtils.cginc"

	// Note: FoliageIndirect depends on these when SHADER_API_D3D11 is defined
	#if defined(SHADER_API_D3D11)
    #include "SharedSamplingLib.hlsl"
    #include "SharedFilteringLib.hlsl"
    #endif

    #include "FoliageUtils.hlsl"
    #include "FoliageIndirect.hlsl"
    
ENDCG

CGINCLUDE
CBUFFER_START(UnityPerMaterial)
	uniform float4 _Color;
	uniform float _Metallic;
	uniform float _Smoothness;
	uniform sampler2D _MainTex;
	#if defined(_NORMALMAP)
	uniform sampler2D _BumpMap;
	uniform half _BumpMapScale;
	#endif
	#if defined(_METALLICGLOSSMAP)
	uniform sampler2D _MetallicGlossMap;
	#endif
	#if defined(_SPECGLOSSMAP)
	uniform sampler2D _TransmissionMap;
	#endif
	#if defined(_EMISSION)
	uniform sampler2D _EmissionMap;
	#endif
	#if defined(_SUNDISK_NONE)
	uniform sampler2D _OcclusionMap;
	#endif
	#if defined(EFFECT_HUE_VARIATION)
	uniform float4 _HueVariationColor;
	#endif
	uniform sampler2D _WindTex;
	uniform float4 _MainTex_ST; 
	uniform float _Cutoff;
	uniform float _ClampCutoff;
	uniform float _AlphaSharp;
	uniform half _ConvertMetallic;

	uniform half _Emission;
	uniform half3 _EmissionColor;

	uniform half _OcclusionStrength;
	uniform half _OcclusionUVSource;

	uniform half _ThicknessMapInvert;
	uniform half _SSSDist;
	uniform half _SSSPow;
	uniform half _SSSIntensity;
	uniform half _SSSAmbient;
	uniform half _SSSShadowStrength;
	uniform half3 _SSSCol;

	uniform float _VertexColorInt;
	uniform float _VertexColorIntOcclusion;
	uniform float _VertexAlphaInt;
	uniform float _ProbeTransmission;
	uniform float _WrappingFactor;
	uniform float _WrappingPowerFactor;
	uniform float _WindSource;
	uniform float _BackfaceNormals;

	// Vanishing start not needed but kept just in case.
	uniform float _VanishingStart;
	uniform float _VanishingEnd;

	uniform float _ExposureOcclusion;
	uniform float _LightmapSpecularMaxSmoothness;

    // wind speed, wave size, wind amount, max sqr distance
	uniform float4 _WaveAndDistance;    
	uniform float _WindTrembling;

	uniform sampler2D _DFG;
CBUFFER_END

SSSParams getSSSParams(float attenuation, float flipBackfaceNormal)
{
	SSSParams params = (SSSParams)0;
	params.distortion = _SSSDist;
	params.power = _SSSPow;
	params.scale = _SSSIntensity;
	params.ambient = _SSSAmbient;
	params.shadowStrength = _SSSShadowStrength;
	params.lightAttenuation = attenuation;
	// Flip distortion on backfaces
	params.distortion *= (2 * flipBackfaceNormal - 1);
	return params;
}

float getWindPinning(appdata_full v)
{
	switch (_WindSource)
	{
		// Select wave intensity from texture. (single-channel)
		case 0: return tex2Dlod(_WindTex, float4(v.texcoord * _MainTex_ST.xy + _MainTex_ST.zw, 0, 0)).r;
		case 1: return v.color.r;
		case 2: return v.texcoord.y;
		case 3: return v.color.a;
	}
	return 0;
}

void vertexDataFunc( inout appdata_full v )
{
	float4 worldPosition = mul(unity_ObjectToWorld, v.vertex); // get world space position of vertex
	float4 worldCentre = mul(unity_ObjectToWorld, float4(0,0,0,1)); // get centre

	// Clamp normals to 0..1
	v.normal.xyz = normalize(v.normal.xyz);
	v.tangent.xyz = normalize(v.tangent.xyz);

	#if !defined(BLOOM)
	float waveFac = getWindPinning(v);
	float4 waveParams = _WaveAndDistance;

	float3 waveOffset = WaveGrass(worldPosition, waveParams, waveFac);
	float3 trembleOffset = TrembleGrass(v.vertex, v.normal, waveFac * _WindTrembling);
	worldPosition.xyz += waveOffset + trembleOffset;
	v.normal.xyz  = normalize(v.normal.xyz + waveOffset + trembleOffset);
	v.tangent.xyz = normalize(v.tangent.xyz + waveOffset + trembleOffset);
	#endif

	v.vertex = mul(unity_WorldToObject, worldPosition); // reproject position into object space
}

inline half4 VertexGIForward(appdata_full v, float3 posWorld, half3 normalWorld)
{
    half4 ambientOrLightmapUV = 0;
    // Static lightmaps
    #ifdef LIGHTMAP_ON
        ambientOrLightmapUV.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
        ambientOrLightmapUV.zw = 0;
    // Sample light probe for Dynamic objects only (no static or dynamic lightmaps)
    #elif UNITY_SHOULD_SAMPLE_SH
        #ifdef VERTEXLIGHT_ON
            // Approximated illumination from non-important point lights
            ambientOrLightmapUV.rgb = Shade4PointLights (
                unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
                unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
                unity_4LightAtten0, posWorld, normalWorld);
        #endif

        ambientOrLightmapUV.rgb = ShadeSHPerVertex (normalWorld, ambientOrLightmapUV.rgb);
    #endif

    #ifdef DYNAMICLIGHTMAP_ON
        ambientOrLightmapUV.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
    #endif

    return ambientOrLightmapUV;
}

struct v2f
{
    UNITY_VERTEX_INPUT_INSTANCE_ID
    UNITY_VERTEX_OUTPUT_STEREO
	#ifndef UNITY_PASS_SHADOWCASTER
	    float4 pos : SV_POSITION;
	    float3 normal : NORMAL;
	    #if defined(_NORMALMAP)
	        float3 tangent : TANGENT;
	        float3 bitangent : BITANGENT;
	    #endif
	    float4 wPosAndHue : TEXCOORD0;
	    UNITY_SHADOW_COORDS(3)
	    UNITY_FOG_COORDS(4)
    #else
	    V2F_SHADOW_CASTER;
	#endif
	// Main UV (xy) and depth (w))
	float4 uv : TEXCOORD1;
	// Occlusion UV (xy)
	float4 uv2 : TEXCOORD2;
	float4 color : COLOR;
	float4 ambientOrLightmapUV : LIGHTMAP;
};

v2f vert(appdata_full v)
{
	v2f o;
	UNITY_INITIALIZE_OUTPUT(v2f, o);
	UNITY_SETUP_INSTANCE_ID(v);
    UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
	vertexDataFunc(v);

	#ifdef UNITY_PASS_SHADOWCASTER
	    TRANSFER_SHADOW_CASTER_NOPOS(o, o.pos);
	#else
	    float3 wPos = mul(unity_ObjectToWorld, v.vertex);
	    o.wPosAndHue.xyz = wPos;
	    o.pos = UnityWorldToClipPos(wPos);
	    o.normal = UnityObjectToWorldNormal(v.normal);
	    #if defined(_NORMALMAP)
	    	o.tangent = UnityObjectToWorldDir(v.tangent.xyz);
	        half sign = v.tangent.w * unity_WorldTransformParams.w;
	    	o.bitangent = cross(o.normal, o.tangent) * sign; 
	    #endif
    
	    o.ambientOrLightmapUV = VertexGIForward(v, wPos, o.normal);
    
	    #if defined(EFFECT_HUE_VARIATION)
	        float3 rootPos = float3(unity_ObjectToWorld[0].w, unity_ObjectToWorld[1].w, unity_ObjectToWorld[2].w);
	        float hueVariationAmount = frac(rootPos.x + rootPos.y + rootPos.z);
	        o.wPosAndHue.w = saturate(hueVariationAmount * _HueVariationColor.a);
        #endif

	    UNITY_TRANSFER_SHADOW(o, v.texcoord1.xy);
        UNITY_TRANSFER_FOG(o,o.pos); 
	#endif
	o.uv.xy = TRANSFORM_TEX(v.texcoord.xy, _MainTex);
	o.uv2.xy =  (_OcclusionUVSource == 0) 
	? o.uv.xy
	: (_OcclusionUVSource == 1) 
	? v.texcoord1
	: (_OcclusionUVSource == 2) 
	? v.texcoord2
	: v.texcoord3;
    COMPUTE_EYEDEPTH(o.uv.w);
	o.color = v.color;

	UNITY_TRANSFER_INSTANCE_ID(v, o);
	return o;
}

// Dithering function for vanishing/LOD
// Not affected by cutout
float applyAlphaDithering(float alpha, float2 pos)
{
    // Get the number of MSAA samples present
    #if (SHADER_TARGET > 40)
        half samplecount = GetRenderTargetSampleCount();
    #else
        half samplecount = 1;
    #endif

    // Offset by time
    pos += (_SinTime.x%4);

#if 0
    float mask = (noiseSwitched(pos));
#else
    float mask = (T(RDitherPattern(pos)));
#endif
    const float width = 1 / (samplecount);
    alpha = alpha - (mask * (1-(alpha)) * width);
    return alpha;
}

float applyAlphaDitheringCutoff(float alpha, float2 pos)
{
    // Get the number of MSAA samples present
    #if (SHADER_TARGET > 40)
        half samplecount = GetRenderTargetSampleCount();
    #else
        half samplecount = 1;
    #endif

    // Offset by time
    pos += (_SinTime.x%4);

    alpha = (1+_Cutoff) * alpha - _Cutoff;
    alpha = saturate(alpha + alpha*_ClampCutoff);

#if 1
    float mask = (noiseSwitched(pos));
#else
    float mask = (T(RDitherPattern(pos)));
#endif

    const float width = 1 / (samplecount);
    alpha = alpha - (mask * (1-(alpha)) * width);
    return alpha;
}

float applyAlphaSharpenCutoff(float alpha)
{
	return ((alpha - _Cutoff) / max(fwidth(alpha), 0.0001) + _ClampCutoff);
}

inline void applyAlphaClip(inout float alpha, float2 pos, bool sharpen)
{
    // Switch between dithered alpha and sharp-edge alpha.
    if (!sharpen) {
    	alpha = applyAlphaDitheringCutoff(alpha, pos);
    }
    else {
        alpha = applyAlphaSharpenCutoff(alpha);
    }
    // If 0, remove now.
    clip (alpha - 0.001);
}

float getVanishingFactor (float closeDist) {
    // Add near clip plane to start/end so that (0, 0.1) looks right
    _VanishingStart += _ProjectionParams.y;
    _VanishingEnd += _ProjectionParams.y;
    float vanishing = saturate(smootherstep(_VanishingStart, _VanishingEnd, closeDist));
    return vanishing;
}
	
half4 BRDF_New_PBS (half3 diffColor, half3 specColor, 
	half oneMinusReflectivity, half smoothness, half occlusion,
	half3 transmission, SSSParams sssData,
    float3 normal, float3 viewDir,
    UnityLight light, UnityIndirect gi, float attenuation)
{
    float perceptualRoughness = SmoothnessToPerceptualRoughness (smoothness);
    float roughness = PerceptualRoughnessToRoughness(perceptualRoughness);
    float reflectance = 0.2;

    float nv = abs(dot(normal, viewDir)) + 1e-5;

	gi.specular *= SpecularAO_Lagarde(nv, occlusion, 1 - smoothness);
	gi.diffuse *= gtaoMultiBounce(occlusion, diffColor);

    half3 f0 = 0.16 * (1-oneMinusReflectivity) + specColor;

    float2 dfg = tex2Dlod(_DFG, float4(float2(nv, perceptualRoughness), 0, 0));
    float3 energyCompensation = 1.0 + f0 * (1.0 / dfg.y - 1.0);

    half clampedRoughness = max(roughness, 0.002);

    float3 halfDir = Unity_SafeNormalize (float3(light.dir) + viewDir);

    float nl = saturate(dot(normal, light.dir));
    float nh = saturate(dot(normal, halfDir));

    half lv = saturate(dot(light.dir, viewDir));
    half lh = saturate(dot(light.dir, halfDir));

    // Diffuse term
    half diffuseTerm = DisneyDiffuse(nv, nl, lh, perceptualRoughness) * nl * attenuation;

	diffuseTerm *= computeMicroShadowing(saturate(dot(normal, light.dir)), occlusion);

    // Diffuse wrapping
    diffuseTerm = pow(saturate((diffuseTerm + _WrappingFactor) /
     (1.0f + _WrappingFactor)), _WrappingPowerFactor) * (_WrappingPowerFactor + 1) / 
    (2 * (1 + _WrappingFactor));

	float3 sssLighting = getSubsurfaceScatteringLight(sssData, light.dir, 
	normal, viewDir, transmission) ;

    float3 reflDir = reflect(-viewDir, normal);
    float horizon = min(1 + dot(reflDir, normal), 1);

    float specularTerm = 0;

    half3 F = F_Schlick(lh, f0);
    half D = D_GGX(nh, clampedRoughness);
    half V = V_SmithGGXCorrelated(nv, nl, clampedRoughness);

    F *= energyCompensation;

    specularTerm = max(0, (D * V) * F) * UNITY_PI * nl * attenuation;

#if defined(_SPECULARHIGHLIGHTS_OFF)
    specularTerm = 0.0;
#endif

    // To provide true Lambert lighting, we need to be able to kill specular completely.
    specularTerm *= any(specColor) ? 1.0 : 0.0;

    half3 color =   diffColor * (gi.diffuse + light.color * diffuseTerm + _LightColor0 * sssLighting)
                    + specularTerm * light.color
                    + gi.specular * lerp(dfg.xxx, dfg.yyy, f0);

    return half4(color, 1);
}


#if (SHADER_TARGET > 40)
	#define USE_COVERAGE_OUTPUT
#endif

// UNITY_SHADER_NO_UPGRADE

#ifndef UNITY_PASS_SHADOWCASTER
float4 frag(v2f i
	, bool isFacing : SV_IsFrontFace
    #ifdef USE_COVERAGE_OUTPUT
	, out uint cov : SV_Coverage
	#endif
	) : SV_TARGET
{
	UNITY_SETUP_INSTANCE_ID(i);
	SurfaceOutputStandardSpecular o;

	float2 uv = i.uv;
	float2 occlusionUV = i.uv2.xy;
	float3 worldPos = i.wPosAndHue.xyz;

	// This is a float in case MSAA doesn't like it. Flip if true. 
	const float flipBackfaceNormal = !isFacing * _BackfaceNormals;

	#if defined(_NORMALMAP)
        if (flipBackfaceNormal) 
        {
            i.normal = -i.normal;
            i.tangent = -i.tangent;
            i.bitangent = -i.bitangent;
        }
        	
        float3x3 tangentToWorld;
        tangentToWorld[0] = i.tangent.xyz;
        tangentToWorld[1] = i.bitangent.xyz;
        tangentToWorld[2] = i.normal.xyz;    
        tangentToWorld = transpose(tangentToWorld);

		float3 normalTangent = UnpackScaleNormal(tex2D (_BumpMap, uv.xy), _BumpMapScale);
        o.Normal = normalize(mul(tangentToWorld, normalTangent));
	#else
        if (flipBackfaceNormal) 
        {
            i.normal = -i.normal;
        }
        	    
		o.Normal = normalize(i.normal);
	#endif

	float4 vertexCol = lerp(1.0, saturate(i.color), float4(_VertexColorInt.xxx, _VertexAlphaInt));
	float4 texCol = tex2D(_MainTex, uv) * _Color * vertexCol;

	o.Albedo = texCol.rgb;
	o.Alpha = texCol.a;

    #ifdef EFFECT_HUE_VARIATION
        half3 shiftedColor = lerp(o.Albedo, _HueVariationColor.rgb, i.wPosAndHue.w);

        half maxBase = max(o.Albedo.r, max(o.Albedo.g, o.Albedo.b));
        half newMaxBase = max(shiftedColor.r, max(shiftedColor.g, shiftedColor.b));
        maxBase /= newMaxBase;
        maxBase = maxBase * 0.5f + 0.5f;
        shiftedColor.rgb *= maxBase;

        o.Albedo = saturate(shiftedColor);
    #endif

    float vanishing = getVanishingFactor(i.uv.w);
	#if defined(LOD_FADE_CROSSFADE)
		vanishing *= abs(unity_LODFade.x);
	#endif
    vanishing = applyAlphaDithering(vanishing, i.pos.xy);

	applyAlphaClip(o.Alpha, i.pos.xy, _AlphaSharp);

	o.Alpha *= vanishing;

	o.Occlusion = 1.0;
	#if defined(_SUNDISK_NONE)
	o.Occlusion *= tex2D(_OcclusionMap, occlusionUV).g;
	#endif
	// Treat areas of darker vertex colour as occluded
	float vertexColOcclusion = LerpOneTo(i.color.g, _VertexColorIntOcclusion);
	o.Occlusion *= vertexColOcclusion;
	o.Occlusion = LerpOneTo(o.Occlusion, _OcclusionStrength);

	UNITY_LIGHT_ATTENUATION(attenuation, i, worldPos.xyz);

	#if !defined(UNITY_PASS_SHADOWCASTER) 
		correctedScreenShadowsForMSAA(i._ShadowCoord, attenuation);
	#endif

	float oneMinusReflectivity;
	float smoothness = _Smoothness;

	#if defined(_METALLICGLOSSMAP)
		float4 sg = tex2D(_MetallicGlossMap, uv);
		o.Specular = sg * _Metallic;
		smoothness *= sg.a;
		o.Albedo = (_ConvertMetallic > 0)
		? DiffuseAndSpecularFromMetallic(
			o.Albedo, sg.r * _Metallic, o.Specular, oneMinusReflectivity)
		: EnergyConservationBetweenDiffuseAndSpecular(
			o.Albedo, o.Specular, oneMinusReflectivity);
	#else
		o.Specular = _Metallic;
		o.Albedo = (_ConvertMetallic > 0)
		? DiffuseAndSpecularFromMetallic(
			o.Albedo, _Metallic, o.Specular, oneMinusReflectivity)
		: EnergyConservationBetweenDiffuseAndSpecular(
			o.Albedo, o.Specular, oneMinusReflectivity);
	#endif
	
	float perceptualRoughness = SmoothnessToPerceptualRoughness(smoothness);
	perceptualRoughness = IsotropicNDFFiltering(i.normal, perceptualRoughness);
	smoothness = (1-perceptualRoughness);

	SSSParams sssData = getSSSParams(attenuation, flipBackfaceNormal);

	#if defined(_SPECGLOSSMAP)
		float3 transmission = tex2D(_TransmissionMap, uv);
		transmission = _ThicknessMapInvert ? 1.0 - transmission : transmission;
	#else
		float3 transmission = _ThicknessMapInvert ? 0:1;
	#endif
	transmission *= _SSSCol;

	float3 viewDir = normalize(_WorldSpaceCameraPos - worldPos);
	UnityLight light;
	light.dir = normalize(UnityWorldSpaceLightDir(worldPos));

	light.color = _LightColor0.rgb;
	UnityIndirect indirectLight;

	indirectLight.diffuse = indirectLight.specular = 0;

	// Read baked light data with modified versions of Unity's functions 
	UnityGIInput giInput;
    giInput.light = light;
    giInput.worldPos = worldPos.xyz;
    giInput.worldViewDir = viewDir;
    giInput.atten = attenuation;
	giInput.ambient = 0;
    #if (defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON))
        giInput.lightmapUV = i.ambientOrLightmapUV;
        giInput.ambient = 0;
    #else
        giInput.lightmapUV = 0;
        giInput.ambient = i.ambientOrLightmapUV;
    #endif

    half bakedAtten = 1.0;
    UnityGI baseGI = UnityGI_Base_local(giInput, bakedAtten, o.Occlusion, 
		flipBackfaceNormal? 1-o.Normal : o.Normal, smoothness, transmission, _ExposureOcclusion, _LightmapSpecularMaxSmoothness,
		_ProbeTransmission, sssData);
    indirectLight = baseGI.indirect;

    #if !defined(UNITY_PASS_FORWARDADD)
    light = baseGI.light;
    attenuation *= bakedAtten;
    #endif

	float3 reflectionDir = reflect(-viewDir, o.Normal);

    // Gather Unity GI data
    UnityGIInput unityData = InitialiseUnityGIInput(worldPos.xyz, viewDir);
	#if defined(_GLOSSYREFLECTIONS_OFF)
	// indirectLight.specular = 0; // Would overwrite specular from lightmap
	#else
	indirectLight.specular += UnityGI_prefilteredRadiance(unityData, 
		perceptualRoughness, reflectionDir);
	#endif

	// Remove specular on backfaces
	o.Specular *= isFacing? 1.0 : 0.0;

	float3 col = BRDF_New_PBS(
		o.Albedo, o.Specular,
		oneMinusReflectivity, smoothness, o.Occlusion,
		transmission, sssData,
		o.Normal, viewDir,
		light, indirectLight, attenuation
	);

    #if !defined(UNITY_PASS_FORWARDADD)
    #if defined(_EMISSION)
    float3 emission = tex2D(_EmissionMap, uv) * _EmissionColor * _Emission;
	col += emission;
	#else
	col += _Emission * _EmissionColor;
	#endif
	#endif

	UNITY_APPLY_FOG(i.fogCoord, col); 

    #ifdef USE_COVERAGE_OUTPUT
    // Get the amount of MSAA samples enabled
    uint samplecount = GetRenderTargetSampleCount();

    // center out the steps
    o.Alpha = saturate(o.Alpha) * samplecount + 0.5;

    // Shift and subtract to get the needed amount of positive bits
    cov = (1u << (uint)(o.Alpha)) - 1u;

    // Output 1 as alpha, otherwise result would be a^2
	o.Alpha = 1;
	#endif

	#ifdef UNITY_PASS_FORWARDADD
	return float4(col, 1.0);
	#else
	return float4(col, o.Alpha);
	#endif
}
#else
float4 frag(v2f i) : SV_Target
{    
	float alpha = _Color.a;
	if (_Cutoff > 0)
		alpha *= tex2D(_MainTex, i.uv).a;

    float vanishing = getVanishingFactor(i.uv.w);
	
    vanishing = applyAlphaDithering(vanishing, i.pos.xy);

    // Only apply for the depth pass, not the actual shadowcaster.
	if (!dot(unity_LightShadowBias, 1)) alpha *= vanishing;

	applyAlphaClip(alpha, i.pos.xy, _AlphaSharp);
	if (!dot(unity_LightShadowBias, 1)) clip(vanishing);

	SHADOW_CASTER_FRAGMENT(i)
}
#endif
	ENDCG

	SubShader
	{
		// PC
		LOD 300
		Tags{ "RenderType" = "TreeLeaf"  "Queue" = "AlphaTest+0" }

		Cull [_CullMode]
		AlphaToMask On
		Pass
		{
			Name "FORWARD"
			Tags { "LightMode" = "ForwardBase" }
			CGPROGRAM

			#pragma target 5.0
            #pragma exclude_renderers gles gles3 metal 
			#pragma shader_feature_local _NORMALMAP
			#pragma shader_feature _EMISSION
			#pragma shader_feature_local _METALLICGLOSSMAP // specular
			#pragma shader_feature_local _SPECGLOSSMAP // transmission
			#pragma shader_feature_local _SUNDISK_NONE // occlusion
			#pragma shader_feature_local BLOOM // waving leaves
			#pragma shader_feature_local EFFECT_HUE_VARIATION // hue shift

			#pragma multi_compile _ LOD_FADE_CROSSFADE // LOD fading
			
			#pragma shader_feature_local _SPECULARHIGHLIGHTS_OFF
			#pragma shader_feature_local _GLOSSYREFLECTIONS_OFF
			
            #pragma shader_feature_local _LIGHTMAPSPECULAR
            #pragma shader_feature_local _ _BAKERY_RNM _BAKERY_SH _BAKERY_MONOSH
            #pragma shader_feature_local _VRCLV

			#ifndef UNITY_PASS_FORWARDBASE
			#define UNITY_PASS_FORWARDBASE
			#endif

			#pragma multi_compile_fwdbase

			#pragma vertex vert
			#pragma fragment frag

			ENDCG
		}

		Pass
		{
			Name "FORWARD_DELTA"
			Tags { "LightMode" = "ForwardAdd" }
			ZWrite Off
            ZTest LEqual
			Blend One One
            Fog { Color (0,0,0,0) } // in additive pass fog should be black
			CGPROGRAM
			#pragma target 5.0
            #pragma exclude_renderers gles gles3 metal
			#pragma shader_feature_local _NORMALMAP
			#pragma shader_feature_local _METALLICGLOSSMAP // specular
			#pragma shader_feature_local _SPECGLOSSMAP // transmission
			#pragma shader_feature_local _SUNDISK_NONE // occlusion
			#pragma shader_feature_local BLOOM // waving leaves
			#pragma shader_feature_local EFFECT_HUE_VARIATION // hue shift

			#pragma multi_compile _ LOD_FADE_CROSSFADE // LOD fading
			
			#ifndef UNITY_PASS_FORWARDADD
			#define UNITY_PASS_FORWARDADD
			#endif

			#pragma multi_compile_fwdadd_fullshadows

			#pragma vertex vert
			#pragma fragment frag
			ENDCG
		}

		Pass
		{
			Name "ShadowCaster"
			Tags{ "RenderType" = "TreeLeaf"  "Queue" = "AlphaTest+0" "LightMode" = "ShadowCaster" }
			ZWrite On
			ZTest LEqual
			AlphaToMask Off
			CGPROGRAM
			#pragma target 5.0
            #pragma exclude_renderers gles gles3 metal
			// #pragma shader_feature_local _METALLICGLOSSMAP // specular
			// #pragma shader_feature_local _SPECGLOSSMAP // transmission
			#pragma shader_feature_local BLOOM // waving leaves

			#pragma multi_compile _ LOD_FADE_CROSSFADE // LOD fading

			#ifndef UNITY_PASS_SHADOWCASTER
			#define UNITY_PASS_SHADOWCASTER
			#endif

			#pragma multi_compile_shadowcaster

			#pragma vertex vert
			#pragma fragment frag
			ENDCG
		}

		// UsePass "Standard/META"

		// Deferred fallback for baking
		// UsePass "Standard/DEFERRED"
	}

	SubShader
	{
		// Quest
		LOD 150
		Tags{ "RenderType" = "TreeLeaf"  "Queue" = "AlphaTest+0" }

		Cull [_CullMode]
		AlphaToMask On
		Pass
		{
			Name "FORWARD"
			Tags { "LightMode" = "ForwardBase" }
			CGPROGRAM

			#pragma target 4.0
            #pragma exclude_renderers d3d11
			#pragma shader_feature_local _NORMALMAP
			#pragma shader_feature _EMISSION
			#pragma shader_feature_local _METALLICGLOSSMAP // specular
			#pragma shader_feature_local _SPECGLOSSMAP // transmission
			#pragma shader_feature_local _SUNDISK_NONE // occlusion
			#pragma shader_feature_local BLOOM // waving leaves
			#pragma shader_feature_local EFFECT_HUE_VARIATION // hue shift

			#pragma multi_compile _ LOD_FADE_CROSSFADE // LOD fading
			
			#pragma shader_feature_local _SPECULARHIGHLIGHTS_OFF
			#pragma shader_feature_local _GLOSSYREFLECTIONS_OFF

            #pragma skip_variants SHADOWS_SOFT DIRLIGHTMAP_COMBINED
            #pragma shader_feature_local _LIGHTMAPSPECULAR
            #pragma shader_feature_local _ _BAKERY_RNM _BAKERY_SH _BAKERY_MONOSH
            #pragma shader_feature_local _VRCLV

			#ifndef UNITY_PASS_FORWARDBASE
			#define UNITY_PASS_FORWARDBASE
			#endif

			#define TARGET_MOBILE

			#pragma multi_compile_fwdbase

			#pragma vertex vert
			#pragma fragment frag

			ENDCG
		}

		Pass
		{
			Name "FORWARD_DELTA"
			Tags { "LightMode" = "ForwardAdd" }
			ZWrite Off
            ZTest LEqual
			Blend One One
            Fog { Color (0,0,0,0) } // in additive pass fog should be black
			CGPROGRAM
			#pragma target 4.0
            #pragma exclude_renderers d3d11
			#pragma shader_feature_local _NORMALMAP
			#pragma shader_feature_local _METALLICGLOSSMAP // specular
			#pragma shader_feature_local _SPECGLOSSMAP // transmission
			#pragma shader_feature_local _SUNDISK_NONE // occlusion
			#pragma shader_feature_local BLOOM // waving leaves
			#pragma shader_feature_local EFFECT_HUE_VARIATION // hue shift

			#pragma multi_compile _ LOD_FADE_CROSSFADE // LOD fading

            #pragma skip_variants SHADOWS_SOFT
			
			#ifndef UNITY_PASS_FORWARDADD
			#define UNITY_PASS_FORWARDADD
			#endif

			#define TARGET_MOBILE

			#pragma multi_compile_fwdadd_fullshadows

			#pragma vertex vert
			#pragma fragment frag
			ENDCG
		}

		Pass
		{
			Name "ShadowCaster"
			Tags{ "RenderType" = "TreeLeaf"  "Queue" = "AlphaTest+0" "LightMode" = "ShadowCaster" }
			ZWrite On
			ZTest LEqual
			AlphaToMask Off
			CGPROGRAM
			#pragma target 4.0
            #pragma exclude_renderers d3d11
			// #pragma shader_feature_local _METALLICGLOSSMAP // specular
			// #pragma shader_feature_local _SPECGLOSSMAP // transmission
			#pragma shader_feature_local BLOOM // waving leaves

			#pragma multi_compile _ LOD_FADE_CROSSFADE // LOD fading

            #pragma skip_variants SHADOWS_SOFT

			#ifndef UNITY_PASS_SHADOWCASTER
			#define UNITY_PASS_SHADOWCASTER
			#endif

			#define TARGET_MOBILE

			#pragma multi_compile_shadowcaster

			#pragma vertex vert
			#pragma fragment frag
			ENDCG
		}

		// UsePass "Standard/META"

		// Deferred fallback for baking
		// UsePass "Standard/DEFERRED" 
	}
CustomEditor "SilentCrispyFoliage.Unity.CrispyFoliageInspector"
}
