#ifndef SPLAT_PASS_META_DEFINED
#define SPLAT_PASS_META_DEFINED

#include "UnityMetaPass.cginc"

v2f_meta vert (appdata v){
    v2f_meta o = (v2f_meta)0;

    o.pos = UnityMetaVertexPosition(v.vertex, v.uv1.xy, v.uv2.xy, unity_LightmapST, unity_DynamicLightmapST);
    o.color = v.color;
    o.rawUV = v.uv;
    
    o.uv0 = TRANSFORM_TEX(SelectUVSet(v, _Layer0UVSet), _BaseColor0);
    #if defined(_LAYER_1_ON)
        o.uv1 = TRANSFORM_TEX(SelectUVSet(v, _Layer1UVSet), _BaseColor1);
    #endif
    #if defined(_LAYER_2_ON)
        o.uv2 = TRANSFORM_TEX(SelectUVSet(v, _Layer2UVSet), _BaseColor2);
    #endif
    #if defined(_LAYER_3_ON)
        o.uv3 = TRANSFORM_TEX(SelectUVSet(v, _Layer3UVSet), _BaseColor3);
    #endif
    // #if AREALIT_ENABLED
    //     o.areaLitOcclusionUV = TRANSFORM_TEX(SelectOcclusionUVSet(v, _AreaLitOcclusionUVSet), _AreaLitOcclusion);
    // #endif

    o.worldPos = mul(unity_ObjectToWorld, v.vertex);
    o.normal = UnityObjectToWorldNormal(v.normal);
    o.tangent.xyz = UnityObjectToWorldDir(v.tangent.xyz);
    o.tangent.w = v.tangent.w;

	#ifdef EDITOR_VISUALIZATION
		o.vizUV = 0;
		o.lightCoord = 0;
		if (unity_VisualizationMode == EDITORVIZ_TEXTURE)
			o.vizUV = UnityMetaVizUV(unity_EditorViz_UVIndex, v.uv.xy, v.uv1.xy, v.uv2.xy, unity_EditorViz_Texture_ST);
		else if (unity_VisualizationMode == EDITORVIZ_SHOWLIGHTMASK)
		{
			o.vizUV = v.uv1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
			o.lightCoord = mul(unity_EditorViz_WorldToLight, mul(unity_ObjectToWorld, float4(v.vertex.xyz, 1)));
		}
	#endif
    return o;
}

float4 frag (v2f_meta i) : SV_Target {

    InputData id = (InputData)0;
    SampleData sd = (SampleData)0;

    if (_LayerBlendSource == 1){
        if (_LayerBlendMaskBicubic == 1){
            float width, height;
            _LayerBlendMask.GetDimensions(width, height);
            float4 blendMaskTexelSize = float4(width, height, 1.0/width, 1.0/height);
            i.color = SampleTexture2DBicubicFilter(TEXTURE2D_PARAM(_LayerBlendMask, sampler_LayerBlendMask), TRANSFORM_TEX(i.rawUV, _LayerBlendMask), blendMaskTexelSize);
        }
        else {
            i.color = _LayerBlendMask.Sample(sampler_LayerBlendMask, TRANSFORM_TEX(i.rawUV, _LayerBlendMask));
        }
    }

    i.normal = normalize(i.normal);
    float crossSign = (i.tangent.w > 0.0 ? 1.0 : -1.0) * unity_WorldTransformParams.w;
    float3 binormal = cross(i.normal.xyz, i.tangent.xyz) * crossSign;

    float3 viewDir = normalize(_WorldSpaceCameraPos.xyz - i.worldPos);
    float3x3 tangentToWorld = float3x3(i.tangent.xyz, binormal, i.normal.xyz);
    float3 tangentViewDir = normalize(mul(tangentToWorld, viewDir));
    tangentViewDir.xy /= (tangentViewDir.z + 0.42);

    float4 baseColor = 0;
    float3 normalMap = i.normal;
    #if defined(_STOCHASTIC_0_ON)
        StochasticUV(sd, i.uv0);
        baseColor = StochasticSample(_BaseColor0, sd, sampler_BaseColor0) * _Color0;
        float4 packed0 = StochasticSample(_PackedMap0, sd, sampler_PackedMap0);
        normalMap = UnpackScaleNormal(StochasticSample(_Normal0, sd, sampler_Normal0), _NormalStrength0 * 1.5);
    #else
        baseColor = MOCHIE_SAMPLE_TEX2D_SAMPLER(_BaseColor0, sampler_BaseColor0, i.uv0) * _Color0;
        float4 packed0 = MOCHIE_SAMPLE_TEX2D_SAMPLER(_PackedMap0, sampler_PackedMap0, i.uv0);
        normalMap = UnpackScaleNormal(MOCHIE_SAMPLE_TEX2D_SAMPLER(_Normal0, sampler_Normal0, i.uv0), _NormalStrength0);
    #endif
    id.occlusion = lerp(1, packed0[_OcclusionChannel0], _Occlusion0);
    id.roughness = packed0[_RoughnessChannel0] * _Roughness0;
    id.metallic = packed0[_MetallicChannel0] * _Metallic0;
    if (_SmoothnessMode0 == 1) id.roughness = 1-id.roughness;
    #if defined(_PARALLAX_0_ON) && !defined(_STOCHASTIC_0_ON)
        id.height = packed0[_HeightChannel0];
    #endif

    #if defined(_LAYER_1_ON)
        i.color.r = linearstep(_BlendThresholdMin1, _BlendThresholdMax1, i.color.r);
        if (i.color.r > 0){
            #if defined(_STOCHASTIC_1_ON)
                StochasticUV(sd, i.uv1);
                float4 baseColor1 = StochasticSample(_BaseColor1, sd, sampler_BaseColor0) * _Color1;
                float4 packed1 = StochasticSample(_PackedMap1, sd, sampler_PackedMap0);
                float3 normal1 = UnpackScaleNormal(StochasticSample(_Normal1, sd, sampler_Normal0), _NormalStrength1 * 1.5);
            #else
                float4 baseColor1 = MOCHIE_SAMPLE_TEX2D_SAMPLER(_BaseColor1, sampler_BaseColor0, i.uv1) * _Color1;
                float4 packed1 = MOCHIE_SAMPLE_TEX2D_SAMPLER(_PackedMap1, sampler_PackedMap0, i.uv1);
                float3 normal1 = UnpackScaleNormal(MOCHIE_SAMPLE_TEX2D_SAMPLER(_Normal1, sampler_Normal0, i.uv1), _NormalStrength1);
            #endif
            float packed1Rough = packed1[_RoughnessChannel1] * _Roughness1;
            if (_SmoothnessMode1 == 1) packed1Rough = 1-packed1Rough;
            #if defined(_PARALLAX_1_ON) && !defined(_STOCHASTIC_1_ON)
                id.height = lerp(id.height, packed1[_HeightChannel1], i.color.r);
                if (_HeightBlend1 == 1){
                    i.color.r *= linearstep(_HeightBlendMin1, _HeightBlendMax1, id.height);
                }
            #endif
            baseColor = lerp(baseColor, baseColor1, i.color.r);
            normalMap = lerp(normalMap, normal1, i.color.r);
            id.occlusion = lerp(id.occlusion, lerp(1, packed1[_OcclusionChannel1], _Occlusion1), i.color.r);
            id.roughness = lerp(id.roughness, packed1Rough, i.color.r);
            id.metallic = lerp(id.metallic, packed1[_MetallicChannel1] * _Metallic1, i.color.r);
        }
    #endif

    #if defined(_LAYER_2_ON)
        i.color.g = linearstep(_BlendThresholdMin2, _BlendThresholdMax2, i.color.g);
        if (i.color.g > 0){
            #if defined(_STOCHASTIC_2_ON)
                StochasticUV(sd, i.uv2);
                float4 baseColor2 = StochasticSample(_BaseColor2, sd, sampler_BaseColor0) * _Color2;
                float4 packed2 = StochasticSample(_PackedMap2, sd, sampler_PackedMap0);
                float3 normal2 = UnpackScaleNormal(StochasticSample(_Normal2, sd, sampler_Normal0), _NormalStrength2 * 1.5);
            #else
                float4 baseColor2 = MOCHIE_SAMPLE_TEX2D_SAMPLER(_BaseColor2, sampler_BaseColor0, i.uv2) * _Color2;
                float4 packed2 = MOCHIE_SAMPLE_TEX2D_SAMPLER(_PackedMap2, sampler_PackedMap0, i.uv2);
                float3 normal2 = UnpackScaleNormal(MOCHIE_SAMPLE_TEX2D_SAMPLER(_Normal2, sampler_Normal0, i.uv2), _NormalStrength2);
            #endif
            float packed2Rough = packed2[_RoughnessChannel2] * _Roughness2;
            if (_SmoothnessMode2 == 1) packed2Rough = 1-packed2Rough;
            #if defined(_PARALLAX_2_ON) && !defined(_STOCHASTIC_2_ON)
                id.height = lerp(id.height, packed2[_HeightChannel2], i.color.g);
                if (_HeightBlend2 == 1){
                    i.color.g *= linearstep(_HeightBlendMin2, _HeightBlendMax2, id.height);
                }
            #endif
            baseColor = lerp(baseColor, baseColor2, i.color.g);
            normalMap = lerp(normalMap, normal2, i.color.g);
            id.occlusion = lerp(id.occlusion, lerp(1, packed2[_OcclusionChannel2], _Occlusion2), i.color.g);
            id.roughness = lerp(id.roughness, packed2Rough, i.color.g);
            id.metallic = lerp(id.metallic, packed2[_MetallicChannel2] * _Metallic2, i.color.g);
        }
    #endif

    #if defined(_LAYER_3_ON)
        i.color.b = linearstep(_BlendThresholdMin3, _BlendThresholdMax3, i.color.b);
        if (i.color.b > 0){
            #if defined(_STOCHASTIC_3_ON)
                StochasticUV(sd, i.uv3);
                float4 baseColor3 = StochasticSample(_BaseColor3, sd, sampler_BaseColor0) * _Color3;
                float4 packed3 = StochasticSample(_PackedMap3, sd, sampler_PackedMap0);
                float3 normal3 = UnpackScaleNormal(StochasticSample(_Normal3, sd, sampler_Normal0), _NormalStrength3 * 1.5);
            #else
                float4 baseColor3 = MOCHIE_SAMPLE_TEX2D_SAMPLER(_BaseColor3, sampler_BaseColor0, i.uv3) * _Color3;
                float4 packed3 = MOCHIE_SAMPLE_TEX2D_SAMPLER(_PackedMap3, sampler_PackedMap0, i.uv3);
                float3 normal3 = UnpackScaleNormal(MOCHIE_SAMPLE_TEX2D_SAMPLER(_Normal3, sampler_Normal0, i.uv3), _NormalStrength3);
            #endif
            float packed3Rough = packed3[_RoughnessChannel3] * _Roughness3;
            if (_SmoothnessMode3 == 1) packed3Rough = 1-packed3Rough;
            #if defined(_PARALLAX_3_ON) && !defined(_STOCHASTIC_3_ON)
                id.height = lerp(id.height, packed3[_HeightChannel3], i.color.b);
                if (_HeightBlend3 == 1){
                    i.color.b *= linearstep(_HeightBlendMin3, _HeightBlendMax3, id.height);
                }
            #endif
            baseColor = lerp(baseColor, baseColor3, i.color.b);
            normalMap = lerp(normalMap, normal3, i.color.b);
            id.occlusion = lerp(id.occlusion, lerp(1, packed3[_OcclusionChannel3], _Occlusion3), i.color.b);
            id.roughness = lerp(id.roughness, packed3Rough, i.color.b);
            id.metallic = lerp(id.metallic, packed3[_MetallicChannel3] * _Metallic3, i.color.b);
        }
    #endif
    
    id.normal = Unity_SafeNormalize(mul(normalMap, tangentToWorld));
    float3 specularColor = lerp(unity_ColorSpaceDielectricSpec.rgb, id.albedo, id.metallic);

    // #if AREALIT_ENABLED
    //     float4 alOcclusion = MOCHIE_SAMPLE_TEX2D(_AreaLitOcclusion, i.areaLitOcclusionUV);
    //     AreaLightFragInput ai;
    //     ai.pos = i.worldPos;
    //     ai.normal = id.normal;
    //     ai.view = -viewDir;
    //     ai.roughness = id.roughness * _AreaLitRoughnessMult;
    //     ai.occlusion = float4(id.occlusion, 1) * alOcclusion;
    //     ai.screenPos = i.pos.xy;
    //     half4 diffTerm, specTerm;
    //     if (_AreaLitStrength > 0){
    //         ShadeAreaLights(ai, diffTerm, specTerm, true, !IsSpecularOff(), IsStereo());
    //     }
    //     else {
    //         diffTerm = 0;
    //         specTerm = 0;
    //     }
    // #endif

    UnityMetaInput o = (UnityMetaInput)0;
    #ifdef EDITOR_VISUALIZATION
        o.Albedo = baseColor;
        o.VizUV = i.vizUV;
        o.LightCoord = i.lightCoord;
    #else
        o.Albedo = baseColor + specularColor * ((id.roughness * id.roughness) * 0.5);
    #endif
    o.SpecularColor = specularColor;
    // #if defined(_AREALIT_ON) && !defined(SHADER_API_MOBILE)
    //     o.Emission = (baseColor + specularColor) * diffTerm;
    // #endif

    return UnityMetaFragment(o);
}

#endif