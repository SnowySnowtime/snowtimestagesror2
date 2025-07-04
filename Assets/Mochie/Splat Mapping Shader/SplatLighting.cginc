#ifndef SPLAT_LIGHTING_DEFINED
#define SPLAT_LIGHTING_DEFINED

#include "SplatBakery.cginc"

float FadeShadows (float3 worldPos, float atten) {
    #if HANDLE_SHADOWS_BLENDING_IN_GI
        float viewZ = dot(_WorldSpaceCameraPos - worldPos, UNITY_MATRIX_V[2].xyz);
        float shadowFadeDistance = UnityComputeShadowFadeDistance(worldPos, viewZ);
        float shadowFade = UnityComputeShadowFade(shadowFadeDistance);
        atten = saturate(atten + shadowFade);
    #endif
    return atten;
}

void GetIndirectLighting(float3 viewDir, InputData id, float4 lightmapUV, float3 normal, inout float3 indirectCol, inout float3 lmSpec, float3 tangentViewDir, float atten) {
	indirectCol = 0;
    lmSpec = 0;
    #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
        #if defined(_BICUBIC_SAMPLING_ON)
            indirectCol = DecodeLightmap(SampleLightmapBicubic(lightmapUV));
            #if defined(DIRLIGHTMAP_COMBINED) || defined(BAKERY_MONOSH)
                float4 lightmapDir = SampleLightmapDirBicubic(lightmapUV);
            #endif
        #else
            indirectCol = DecodeLightmap(UNITY_SAMPLE_TEX2D(unity_Lightmap, lightmapUV));
            #if defined(DIRLIGHTMAP_COMBINED) || defined(BAKERY_MONOSH)
                float4 lightmapDir = UNITY_SAMPLE_TEX2D_SAMPLER(unity_LightmapInd, unity_Lightmap, lightmapUV);
            #endif
        #endif

        #if defined(BAKERY_MONOSH)
            BakeryMonoSH(indirectCol, lmSpec, lightmapDir, normal, viewDir, id.roughness);
        #elif defined(BAKERY_RNM)
            BakeryRNMLightmapAndSpecular(indirectCol, lightmapUV, lmSpec, id.normalTS, tangentViewDir, viewDir, id.roughness);
        #elif defined(BAKERY_SH)
            BakerySHLightmapAndSpecular(indirectCol, lightmapUV, lmSpec, normal, viewDir, id.roughness);
        #else
            #if defined(DIRLIGHTMAP_COMBINED)
                indirectCol = DecodeDirectionalLightmap(indirectCol, lightmapDir, normal);
            #endif
        #endif

        #if defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN)
            indirectCol = SubtractMainLightWithRealtimeAttenuationFromLightmap(indirectCol, atten, 0, normal);
        #endif

        #if defined(DYNAMICLIGHTMAP_ON)
            if (_IgnoreRealtimeGI != 1){
                #if defined(_BICUBIC_SAMPLING_ON)
                    float4 realtimeColorTex = SampleDynamicLightmapBicubic(lightmapUV.zw);
                #else
                    float4 realtimeColorTex = UNITY_SAMPLE_TEX2D(unity_DynamicLightmap, lightmapUV.zw);
                #endif
                float3 realtimeColor = DecodeRealtimeLightmap(realtimeColorTex);
                #if defined(DIRLIGHTMAP_COMBINED)
                    #if defined(_BICUBIC_SAMPLING_ON)
                        float4 realtimeDirTex = SampleDynamicLightmapDirBicubic(lightmapUV.zw);
                    #else
                        float4 realtimeDirTex = UNITY_SAMPLE_TEX2D_SAMPLER(unity_DynamicDirectionality, unity_DynamicLightmap, lightmapUV.zw);
                    #endif
                    indirectCol += DecodeDirectionalLightmap(realtimeColor, realtimeDirTex, normal);
                #else
                    indirectCol += realtimeColor;
                #endif
            }
        #endif
    #else
        indirectCol = ShadeSH9(float4(normal, 1));
    #endif
}

float3 Shade4PointLightsNoPopIn(
    float4 lightPosX, float4 lightPosY, float4 lightPosZ,
    float3 lightColor0, float3 lightColor1, float3 lightColor2, float3 lightColor3,
    float4 lightAttenSq,
    float3 pos, float3 normal)
{
    float4 toLightX = lightPosX - pos.x;
    float4 toLightY = lightPosY - pos.y;
    float4 toLightZ = lightPosZ - pos.z;

    float4 lengthSq = 0;
    lengthSq += toLightX * toLightX;
    lengthSq += toLightY * toLightY;
    lengthSq += toLightZ * toLightZ;

    lengthSq = max(lengthSq, 0.000001);

    float4 ndotl = 0;
    ndotl += toLightX * normal.x;
    ndotl += toLightY * normal.y;
    ndotl += toLightZ * normal.z;

    float4 corr = rsqrt(lengthSq);
    ndotl = max (float4(0,0,0,0), ndotl * corr);

    float4 atten = 1.0 / (1.0 + lengthSq * lightAttenSq);
    atten = linearstep(float4(0.05,0.05,0.05,0.05), float4(1,1,1,1), atten);
    float4 diff = ndotl * atten;

    float3 col = 0;
    col += lightColor0 * diff.x;
    col += lightColor1 * diff.y;
    col += lightColor2 * diff.z;
    col += lightColor3 * diff.w;
    return col;
}

float3 GetVertexLightColor(InputData id, v2f i){
    float3 vLightCol = 0;
    #if defined(UNITY_PASS_FORWARDBASE)
        if (i.vertexLightOn){
            vLightCol = Shade4PointLightsNoPopIn(unity_4LightPosX0, unity_4LightPosY0, 
                unity_4LightPosZ0, unity_LightColor[0].rgb, 
                unity_LightColor[1].rgb, unity_LightColor[2].rgb, 
                unity_LightColor[3].rgb, unity_4LightAtten0, 
                i.worldPos, id.normal
            );
        }
    #endif
    return vLightCol;
}

void InitializeLightingData(inout LightingData ld, InputData id, v2f i, float3 viewDir, float3 tangentViewDir, float atten){

    float omr = unity_ColorSpaceDielectricSpec.a - id.metallic * unity_ColorSpaceDielectricSpec.a;
    float3 lightDir = Unity_SafeNormalize(UnityWorldSpaceLightDir(i.worldPos));
    float NdotL = saturate(dot(id.normal, lightDir));
    float VNdotL = saturate(dot(id.vNormal, lightDir));
    bool isRealtime = any(_WorldSpaceLightPos0.xyz);

    if (!isRealtime){
        VNdotL = 1;
    }

    float3 directCol = (_LightColor0 * atten * NdotL) + GetVertexLightColor(id, i);
    float3 indirectCol = 0;
    
    #if defined(UNITY_PASS_FORWARDBASE)
        GetIndirectLighting(viewDir, id, i.lightmapUV, id.normal, indirectCol, ld.lmSpec, tangentViewDir, atten);
    #endif
    
    ld.lightCol = (directCol + (indirectCol * id.occlusion)) * omr;
    ld.directCol = directCol;
    ld.indirectCol = indirectCol;
    ld.lightDir = lightDir;
    ld.viewDir = viewDir;
    ld.NdotL = NdotL;
    ld.VNdotL = VNdotL;
    ld.atten = atten;
    ld.omr = omr;
    ld.isRealtime = isRealtime;
}

#endif