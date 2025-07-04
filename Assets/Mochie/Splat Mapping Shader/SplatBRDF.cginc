#ifndef SPLAT_BRDF_DEFINED
#define SPLAT_BRDF_DEFINED

float3 BoxProjection(float3 dir, float3 pos, float4 cubePos, float3 boxMin, float3 boxMax){
    #if UNITY_SPECCUBE_BOX_PROJECTION
        UNITY_BRANCH
        if (cubePos.w > 0){
            float3 factors = ((dir > 0 ? boxMax : boxMin) - pos) / dir;
            float scalar = min(min(factors.x, factors.y), factors.z);
            dir = dir * scalar + (pos - cubePos);
        }
    #endif
    return dir;
}

float3 GetWorldReflections(float3 reflDir, float3 worldPos, float roughness){
    float3 baseReflDir = reflDir;
    roughness *= 1.7-0.7*roughness;
    reflDir = BoxProjection(reflDir, worldPos, unity_SpecCube0_ProbePosition, unity_SpecCube0_BoxMin, unity_SpecCube0_BoxMax);
    float4 envSample0 = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflDir, roughness * UNITY_SPECCUBE_LOD_STEPS);
    float3 p0 = DecodeHDR(envSample0, unity_SpecCube0_HDR);
    float interpolator = unity_SpecCube0_BoxMin.w;
    UNITY_BRANCH
    if (interpolator < 0.99999){
        float3 refDirBlend = BoxProjection(baseReflDir, worldPos, unity_SpecCube1_ProbePosition, unity_SpecCube1_BoxMin, unity_SpecCube1_BoxMax);
        float4 envSample1 = UNITY_SAMPLE_TEXCUBE_SAMPLER_LOD(unity_SpecCube1, unity_SpecCube0, refDirBlend, roughness * UNITY_SPECCUBE_LOD_STEPS);
        float3 p1 = DecodeHDR(envSample1, unity_SpecCube1_HDR);
        p0 = lerp(p1, p0, interpolator);
    }
    return p0;
}

float SpecularTerm(float NdotL, float NdotV, float NdotH, float roughness){
    float visibilityTerm = 0;
    float rough = roughness;
    float rough2 = roughness * roughness;

    float lambdaV = NdotL * (NdotV * (1 - rough) + rough);
    float lambdaL = NdotV * (NdotL * (1 - rough) + rough);

    visibilityTerm = 0.5f / (lambdaV + lambdaL + 1e-5f);
    float d = (NdotH * rough2 - NdotH) * NdotH + 1.0f;
    float dotTerm = UNITY_INV_PI * rough2 / (d * d + 1e-7f);

    return max(0, visibilityTerm * dotTerm * UNITY_PI * NdotL);
}

void CalculateBRDF(inout LightingData ld, InputData id, v2f i){

    float roughSq = max(id.roughness * id.roughness, 0.003);
    float NdotV = abs(dot(id.normal, ld.viewDir));
    specularTint = lerp(unity_ColorSpaceDielectricSpec.rgb, id.albedo, id.metallic);

    float3 reflDir = reflect(-ld.viewDir, id.normal);
    float surfaceReduction = 1.0 / (roughSq*roughSq + 1.0);
    float grazingTerm = saturate((1-id.roughness) + (1-ld.omr));
    float3 fresnel = FresnelLerp(specularTint, grazingTerm, lerp(1, NdotV, _FresnelStrength*_FresnelToggle));
    #if defined(_REFLECTIONS_ON)
        float3 reflCol = GetWorldReflections(reflDir, i.worldPos, id.roughness);
        ld.reflectionCol += reflCol;
        #if defined(_SSR_ON)
            float4 ssr = GetSSR(i.worldPos, ld.viewDir, reflDir, id.normal, 1-id.roughness, id.albedo, id.metallic, i.grabUV);
            if (_SSREdgeFade == 0)
                ssr.a = ssr.a > 0 ? 1 : 0;
            ld.reflectionCol = lerp(ld.reflectionCol, ssr.rgb, ssr.a * saturate(_SSRStrength));
        #endif
        ld.reflectionCol *= fresnel * surfaceReduction * id.occlusion * _ReflectionStrength;
    #endif

    ld.reflectionCol += (ld.lmSpec * fresnel * surfaceReduction * UNITY_PI);

    #if defined(_SPECULAR_HIGHLIGHTS_ON)
        float3 halfVector = Unity_SafeNormalize(ld.lightDir + ld.viewDir);
        float NdotH = saturate(dot(id.normal, halfVector));
        float LdotH = saturate(dot(ld.lightDir, halfVector));
        float3 fresnelTerm = FresnelTerm(specularTint, LdotH);
        float specularTerm = SpecularTerm(ld.NdotL, NdotV, NdotH, roughSq);
        ld.specHighlightCol = ld.directCol * fresnelTerm * specularTerm * _SpecularHighlightStrength;
        #if defined(_SSR_ON)
            ld.specHighlightCol *= (1-ssr.a);
        #endif
    #endif

    #if defined(UNITY_PASS_FORWARDBASE)
        #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
            if (_SpecularOcclusionToggle == 1){
                float3 lightmap = ld.indirectCol;
                lightmap = GetContrast(lightmap, _SpecularOcclusionContrast);
                lightmap = lerp(lightmap, GetHDR(lightmap), _SpecularOcclusionHDR);
                lightmap *= _SpecularOcclusionBrightness;
                lightmap *= _SpecularOcclusionTint;
                #if defined(LTCGI)
                    lightmap += diffLight;
                #endif
                specularOcclusion = saturate(lerp(1, lightmap, _SpecularOcclusionStrength));
                ld.reflectionCol *= specularOcclusion;
                ld.specHighlightCol *= specularOcclusion;
            }
        #else
            if (_SpecularOcclusionToggle == 1){
                specularOcclusion = lerp(1, ld.atten * saturate((ld.VNdotL * ld.VNdotL) + ld.VNdotL), 0.9);
                specularOcclusion = saturate(lerp(1, specularOcclusion, _SpecularOcclusionToggle*_SpecularOcclusionStrength));
                ld.reflectionCol *= specularOcclusion;
            }
        #endif
    #endif
}

#endif