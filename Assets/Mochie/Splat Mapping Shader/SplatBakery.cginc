#ifndef SPLAT_BAKERY_INCLUDED
#define SPLAT_BAKERY_INCLUDED

Texture2D _RNM0, _RNM1, _RNM2;
SamplerState custom_bilinear_clamp_sampler;
float4 _RNM0_TexelSize;

#define GRAYSCALE float3(0.2125, 0.7154, 0.0721)

float shEvaluateDiffuseL1Geomerics(float L0, float3 L1, float3 n)
{
    // average energy
    float R0 = L0;
    
    // avg direction of incoming light
    float3 R1 = 0.5f * L1;
    
    // directional brightness
    float lenR1 = length(R1);
    
    // linear angle between normal and direction 0-1
    //float q = 0.5f * (1.0f + dot(R1 / lenR1, n));
    //float q = dot(R1 / lenR1, n) * 0.5 + 0.5;
    float q = dot(normalize(R1), n) * 0.5 + 0.5;
    q = saturate(q); // Thanks to ScruffyRuffles for the bug identity.
    
    // power for q
    // lerps from 1 (linear) to 3 (cubic) based on directionality
    float p = 1.0f + 2.0f * lenR1 / R0;
    
    // dynamic range constant
    // should vary between 4 (highly directional) and 0 (ambient)
    float a = (1.0f - lenR1 / R0) / (1.0f + lenR1 / R0);
    
    return R0 * (a + (1.0f - a) * (p + 1.0f) * pow(q, p));
}

void BakeryRNMLightmapAndSpecular(inout half3 lightMap, float2 lightmapUV, inout half3 directSpecular, float3 normalTS, float3 viewDirTS, float3 viewDir, half roughness)
{
    // normalTS.g *= -1; // might not be needed anymore
    float3 rnm0 = DecodeLightmap(_RNM0.SampleLevel(custom_bilinear_clamp_sampler, lightmapUV, 0));
    float3 rnm1 = DecodeLightmap(_RNM1.SampleLevel(custom_bilinear_clamp_sampler, lightmapUV, 0));
    float3 rnm2 = DecodeLightmap(_RNM2.SampleLevel(custom_bilinear_clamp_sampler, lightmapUV, 0));

    const float3 rnmBasis0 = float3(0.816496580927726f, 0.0f, 0.5773502691896258f);
    const float3 rnmBasis1 = float3(-0.4082482904638631f, 0.7071067811865475f, 0.5773502691896258f);
    const float3 rnmBasis2 = float3(-0.4082482904638631f, -0.7071067811865475f, 0.5773502691896258f);

    lightMap =    saturate(dot(rnmBasis0, normalTS)) * rnm0
                + saturate(dot(rnmBasis1, normalTS)) * rnm1
                + saturate(dot(rnmBasis2, normalTS)) * rnm2;

    #ifdef BAKERY_LMSPEC
        float3 viewDirT = -normalize(viewDirTS);
        float3 dominantDirT = rnmBasis0 * dot(rnm0, GRAYSCALE) +
                                rnmBasis1 * dot(rnm1, GRAYSCALE) +
                                rnmBasis2 * dot(rnm2, GRAYSCALE);

        float3 dominantDirTN = normalize(dominantDirT);
        half3 specColor = saturate(dot(rnmBasis0, dominantDirTN)) * rnm0 +
                            saturate(dot(rnmBasis1, dominantDirTN)) * rnm1 +
                            saturate(dot(rnmBasis2, dominantDirTN)) * rnm2;

        half3 halfDir = Unity_SafeNormalize(dominantDirTN - viewDirT);
        half NoH = saturate(dot(normalTS, halfDir));
        half spec = GGXTerm(NoH, roughness);
        directSpecular += spec * specColor;
    #endif
}

void BakerySHLightmapAndSpecular(inout half3 lightMap, float2 lightmapUV, inout half3 directSpecular, float3 normalWS, float3 viewDir, half roughness)
{
    half3 L0 = lightMap;
    float3 nL1x = _RNM0.SampleLevel(custom_bilinear_clamp_sampler, lightmapUV, 0) * 2.0 - 1.0;
    float3 nL1y = _RNM1.SampleLevel(custom_bilinear_clamp_sampler, lightmapUV, 0) * 2.0 - 1.0;
    float3 nL1z = _RNM2.SampleLevel(custom_bilinear_clamp_sampler, lightmapUV, 0) * 2.0 - 1.0;
    float3 L1x = nL1x * L0 * 2.0;
    float3 L1y = nL1y * L0 * 2.0;
    float3 L1z = nL1z * L0 * 2.0;

    #ifdef BAKERY_SHNONLINEAR
        float lumaL0 = dot(L0, float(1));
        float lumaL1x = dot(L1x, float(1));
        float lumaL1y = dot(L1y, float(1));
        float lumaL1z = dot(L1z, float(1));
        float lumaSH = shEvaluateDiffuseL1Geomerics(lumaL0, float3(lumaL1x, lumaL1y, lumaL1z), normalWS);

        lightMap = L0 + normalWS.x * L1x + normalWS.y * L1y + normalWS.z * L1z;
        float regularLumaSH = dot(lightMap, 1.0);
        lightMap *= lerp(1.0, lumaSH / regularLumaSH, saturate(regularLumaSH * 16.0));
    #else
        lightMap = L0 + normalWS.x * L1x + normalWS.y * L1y + normalWS.z * L1z;
    #endif

    #ifdef BAKERY_LMSPEC
        float3 dominantDir = float3(dot(nL1x, GRAYSCALE), dot(nL1y, GRAYSCALE), dot(nL1z, GRAYSCALE));
        float3 halfDir = Unity_SafeNormalize(normalize(dominantDir) + viewDir);
        half NoH = saturate(dot(normalWS, halfDir));
        half spec = GGXTerm(NoH, roughness);
        half3 sh = L0 + dominantDir.x * L1x + dominantDir.y * L1y + dominantDir.z * L1z;
        dominantDir = normalize(dominantDir);

        directSpecular += max(spec * sh, 0.0);
    #endif
}

void BakeryMonoSH(inout half3 diffuseColor, inout half3 specularColor, float3 dominantDir, float3 normalWorld, float3 viewDir, half roughness)
{
    half3 L0 = diffuseColor;

    float3 nL1 = dominantDir * 2 - 1;
    float3 L1x = nL1.x * L0 * 2;
    float3 L1y = nL1.y * L0 * 2;
    float3 L1z = nL1.z * L0 * 2;
    half3 sh;
#ifdef BAKERY_SHNONLINEAR
    float lumaL0 = dot(L0, 1);
    float lumaL1x = dot(L1x, 1);
    float lumaL1y = dot(L1y, 1);
    float lumaL1z = dot(L1z, 1);
    float lumaSH = shEvaluateDiffuseL1Geomerics(lumaL0, float3(lumaL1x, lumaL1y, lumaL1z), normalWorld);

    sh = L0 + normalWorld.x * L1x + normalWorld.y * L1y + normalWorld.z * L1z;
    float regularLumaSH = dot(sh, 1);
    //sh *= regularLumaSH < 0.001 ? 1 : (lumaSH / regularLumaSH);
    sh *= lerp(1, lumaSH / regularLumaSH, saturate(regularLumaSH*16));

    //sh.r = shEvaluateDiffuseL1Geomerics(L0.r, float3(L1x.r, L1y.r, L1z.r), normalWorld);
    //sh.g = shEvaluateDiffuseL1Geomerics(L0.g, float3(L1x.g, L1y.g, L1z.g), normalWorld);
    //sh.b = shEvaluateDiffuseL1Geomerics(L0.b, float3(L1x.b, L1y.b, L1z.b), normalWorld);

#else
    sh = L0 + normalWorld.x * L1x + normalWorld.y * L1y + normalWorld.z * L1z;
#endif

    diffuseColor = max(sh, 0.0);

    specularColor = 0;
    #ifdef BAKERY_LMSPEC
        dominantDir = nL1;
        float focus = saturate(length(dominantDir));
        half3 halfDir = Unity_SafeNormalize(normalize(dominantDir) + viewDir);
        half nh = saturate(dot(normalWorld, halfDir));
        half spec = GGXTerm(nh, roughness);

        sh = L0 + dominantDir.x * L1x + dominantDir.y * L1y + dominantDir.z * L1z;
        
        specularColor = max(spec * sh, 0.0);
    #endif
}


#endif