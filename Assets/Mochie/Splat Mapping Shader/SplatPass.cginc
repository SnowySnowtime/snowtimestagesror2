#ifndef SPLAT_PASS_DEFINED
#define SPLAT_PASS_DEFINED

v2f vert (appdata v){
    v2f o = (v2f)0;
    UNITY_SETUP_INSTANCE_ID(v);
    UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
    o.pos = UnityObjectToClipPos(v.vertex);
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
    #if defined(LIGHTMAP_ON) || LTCGI_ENABLED
        o.lightmapUV.xy = v.uv1 * unity_LightmapST.xy + unity_LightmapST.zw;
    #endif
    #if defined(DYNAMICLIGHTMAP_ON)
        o.lightmapUV.zw = v.uv2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
    #endif
    #if AREALIT_ENABLED
        o.areaLitOcclusionUV = TRANSFORM_TEX(SelectOcclusionUVSet(v, _AreaLitOcclusionUVSet), _AreaLitOcclusion);
    #endif

    o.worldPos = mul(unity_ObjectToWorld, v.vertex);
    o.normal = UnityObjectToWorldNormal(v.normal);
    o.tangent.xyz = UnityObjectToWorldDir(v.tangent.xyz);
    o.tangent.w = v.tangent.w;

    #if defined(_SSR_ON)
        o.grabUV = ComputeGrabScreenPos(o.pos);
    #endif
    
    #if defined(UNITY_PASS_FORWARDBASE)
        o.vertexLightOn = false;
        #if defined(VERTEXLIGHT_ON)
            o.vertexLightOn = true;
        #endif
    #endif
    UNITY_TRANSFER_SHADOW(o, v.uv1);
    UNITY_TRANSFER_FOG(o,o.pos);
    return o;
}

float4 frag (v2f i) : SV_Target {

    InputData id = (InputData)0;
    SampleData sd = (SampleData)0;

    if (_LayerBlendSource == 1){
        if (_LayerBlendMaskBicubic == 1){
            float blendWidth, blendHeight;
            _LayerBlendMask.GetDimensions(blendWidth, blendHeight);
            float4 blendMaskTexelSize = float4(blendWidth, blendHeight, 1.0/blendWidth, 1.0/blendHeight);
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
    float facingAngle = abs(dot(i.normal, float3(0,1,0)));
    #if defined(_RAIN_ON)
        float rainThreshAngle = _RainThresholdSize * 0.5;
        float rainThreshold = smoothstep(_RainThreshold - rainThreshAngle, _RainThreshold + rainThreshAngle, facingAngle);
        float3 rainNormal = GetRipplesNormal(i.rawUV, _RainScale, _RainStrength * rainThreshold * 1000, _RainSpeed, _RainSize, _RainDensity);
        float3 rainPuddleNormal = GetRipplesNormal(i.rawUV, _RainScale, _RainStrength * rainThreshold, _RainSpeed, _RainPuddleSize, _RainPuddleDensity);
    #endif
    float puddleThreshAngle = 0.1 * 0.5;
    float puddleThreshold = smoothstep(0.93 - 0.05, 0.93 + 0.05, facingAngle); // keeping math here so I can remember what these values used to be when they were properties

    // Really ugly but this avoids the base texture samples
    // as long as they would be covered by another texture set,
    // and as long height blending isn't enabled anywhere (this happens a lot)
    #if !defined(_HEIGHT_BLENDING_ON)
        #if defined(_LAYER_1_ON)
        i.color.r = linearstep(_BlendThresholdMin1, _BlendThresholdMax1, i.color.r);
        if (i.color.r < 1){
        #endif

        #if defined(_LAYER_2_ON)
        i.color.g = linearstep(_BlendThresholdMin2, _BlendThresholdMax2, i.color.g);
        if (i.color.g < 1){
        #endif

        #if defined(_LAYER_3_ON)
        i.color.b = linearstep(_BlendThresholdMin3, _BlendThresholdMax3, i.color.b);
        if (i.color.b < 1){
        #endif
    #endif
    
    #if defined(_STOCHASTIC_0_ON)
        StochasticUV(sd, i.uv0);
        baseColor = StochasticSample(_BaseColor0, sd, sampler_BaseColor0) * _Color0;
        float4 packed0 = StochasticSample(_PackedMap0, sd, sampler_PackedMap0);
        normalMap = UnpackScaleNormal(StochasticSample(_Normal0, sd, sampler_Normal0), _NormalStrength0 * 1.5);
    #else
        #if defined(_PARALLAX_0_ON)
            ApplyParallax(_PackedMap0, i.uv0, tangentViewDir, _Height0, _HeightOffset0, _HeightChannel0);
        #endif
        baseColor = MOCHIE_SAMPLE_TEX2D_SAMPLER(_BaseColor0, sampler_BaseColor0, i.uv0) * _Color0;
        float4 packed0 = MOCHIE_SAMPLE_TEX2D_SAMPLER(_PackedMap0, sampler_PackedMap0, i.uv0);
        #if defined(_PARALLAX_0_ON)
            float puddleBlend0 = 1;
            if (_PuddleHeightBlend0 == 1){
                puddleBlend0 = linearstep(_PuddleBlendMin0, _PuddleBlendMax0, packed0[_HeightChannel0]);
                puddleBlend0 = lerp(1, puddleBlend0, puddleThreshold);
                _NormalStrength0 *= puddleBlend0;
                _Roughness0 *= puddleBlend0;
                _Occlusion0 *= puddleBlend0;
                baseColor *= lerp(_PuddleTint0, 1, puddleBlend0);
            }
        #endif
        normalMap = UnpackScaleNormal(MOCHIE_SAMPLE_TEX2D_SAMPLER(_Normal0, sampler_Normal0, i.uv0), _NormalStrength0);
    #endif
    #if defined(_RAIN_ON)
        #if defined(_PARALLAX_0_ON) && !defined(_STOCHASTIC_0_ON)
            if (_RainLayer0 == 1){
                puddleBlend0 = saturate(puddleBlend0 * 5);
                float3 blendedRainNormals0 = BlendNormals(normalMap, lerp(rainPuddleNormal, rainNormal, puddleBlend0));
                normalMap = blendedRainNormals0;
            }
        #else
            if (_RainLayer0 == 1){
                normalMap = BlendNormals(normalMap, rainNormal);
            }
        #endif
    #endif
    id.occlusion = lerp(1, packed0[_OcclusionChannel0], _Occlusion0);
    id.roughness = packed0[_RoughnessChannel0] * _Roughness0;
    id.metallic = packed0[_MetallicChannel0] * _Metallic0;
    if (_SmoothnessMode0 == 1) id.roughness = 1-id.roughness;
    #if defined(_PARALLAX_0_ON) && !defined(_STOCHASTIC_0_ON)
        id.height = packed0[_HeightChannel0];
    #endif

    #if !defined(_HEIGHT_BLENDING_ON)
        #if defined(_LAYER_3_ON)
        }
        #endif

        #if defined(_LAYER_2_ON)
        }
        #endif

        #if defined(_LAYER_1_ON)
        }
        #endif
    #endif

    #if defined(_LAYER_1_ON)
        #if defined(_HEIGHT_BLENDING_ON)
            i.color.r = linearstep(_BlendThresholdMin1, _BlendThresholdMax1, i.color.r);
        #endif
        if (i.color.r > 0){
            #if defined(_STOCHASTIC_1_ON)
                StochasticUV(sd, i.uv1);
                float4 baseColor1 = StochasticSample(_BaseColor1, sd, sampler_BaseColor0) * _Color1;
                float4 packed1 = StochasticSample(_PackedMap1, sd, sampler_PackedMap0);
                float3 normal1 = UnpackScaleNormal(StochasticSample(_Normal1, sd, sampler_Normal0), _NormalStrength1 * 1.5);
            #else
                #if defined(_PARALLAX_1_ON)
                    ApplyParallax(_PackedMap1, i.uv1, tangentViewDir, _Height1, _HeightOffset1, _HeightChannel1);
                #endif
                float4 baseColor1 = MOCHIE_SAMPLE_TEX2D_SAMPLER(_BaseColor1, sampler_BaseColor0, i.uv1) * _Color1;
                float4 packed1 = MOCHIE_SAMPLE_TEX2D_SAMPLER(_PackedMap1, sampler_PackedMap0, i.uv1);
                #if defined(_PARALLAX_1_ON)
                    float puddleBlend1 = 1;
                    if (_PuddleHeightBlend1 == 1){
                        puddleBlend1 = linearstep(_PuddleBlendMin1, _PuddleBlendMax1, packed1[_HeightChannel1]);
                        puddleBlend1 = lerp(1, puddleBlend1, puddleThreshold);
                        _NormalStrength1 *= puddleBlend1;
                        _Roughness1 *= puddleBlend1;
                        _Occlusion1 *= puddleBlend1;
                        baseColor1 *= lerp(_PuddleTint1, 1, puddleBlend1);
                    }
                #endif
                float3 normal1 = UnpackScaleNormal(MOCHIE_SAMPLE_TEX2D_SAMPLER(_Normal1, sampler_Normal0, i.uv1), _NormalStrength1);
            #endif
            #if defined(_RAIN_ON)
                #if defined(_PARALLAX_1_ON) && !defined(_STOCHASTIC_1_ON)
                    if (_RainLayer1 == 1){
                        puddleBlend1 = saturate(puddleBlend1 * 5);
                        float3 blendedRainNormals1 = BlendNormals(normal1, lerp(rainPuddleNormal, rainNormal, puddleBlend1));
                        normal1 = blendedRainNormals1;
                    }
                #else
                    if (_RainLayer1 == 1){
                        normal1 = BlendNormals(normal1, rainNormal);
                    }
                #endif
            #endif
            float packed1Rough = packed1[_RoughnessChannel1] * _Roughness1;
            if (_SmoothnessMode1 == 1) packed1Rough = 1-packed1Rough;
            #if defined(_PARALLAX_1_ON) && !defined(_STOCHASTIC_1_ON)
                id.height = lerp(id.height, packed1[_HeightChannel1], i.color.r);
                if (_HeightBlend1 == 1){
                    if (_HeightBlendEdges1 == 1){
                        float edgeMask1 = saturate(pow(i.color.r, _EdgePower1));
                        i.color.r *= lerp(linearstep(_HeightBlendMin1, _HeightBlendMax1, id.height), i.color.r, edgeMask1);
                    }
                    else {
                        i.color.r *= linearstep(_HeightBlendMin1, _HeightBlendMax1, id.height);
                    }
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
        #if defined(_HEIGHT_BLENDING_ON)
            i.color.g = linearstep(_BlendThresholdMin2, _BlendThresholdMax2, i.color.g);
        #endif
        if (i.color.g > 0){
            #if defined(_STOCHASTIC_2_ON)
                StochasticUV(sd, i.uv2);
                float4 baseColor2 = StochasticSample(_BaseColor2, sd, sampler_BaseColor0) * _Color2;
                float4 packed2 = StochasticSample(_PackedMap2, sd, sampler_PackedMap0);
                float3 normal2 = UnpackScaleNormal(StochasticSample(_Normal2, sd, sampler_Normal0), _NormalStrength2 * 1.5);
            #else
                #if defined(_PARALLAX_2_ON)
                    ApplyParallax(_PackedMap2, i.uv2, tangentViewDir, _Height2, _HeightOffset2, _HeightChannel2);
                #endif
                float4 baseColor2 = MOCHIE_SAMPLE_TEX2D_SAMPLER(_BaseColor2, sampler_BaseColor0, i.uv2) * _Color2;
                float4 packed2 = MOCHIE_SAMPLE_TEX2D_SAMPLER(_PackedMap2, sampler_PackedMap0, i.uv2);
                #if defined(_PARALLAX_2_ON)
                    float puddleBlend2 = 1;
                    if (_PuddleHeightBlend2 == 1){
                        puddleBlend2 = linearstep(_PuddleBlendMin2, _PuddleBlendMax2, packed2[_HeightChannel2]);
                        puddleBlend2 = lerp(1, puddleBlend2, puddleThreshold);
                        _NormalStrength2 *= puddleBlend2;
                        _Roughness2 *= puddleBlend2;
                        _Occlusion2 *= puddleBlend2;
                        baseColor2 *= lerp(_PuddleTint2, 1, puddleBlend2);
                    }
                #endif
                float3 normal2 = UnpackScaleNormal(MOCHIE_SAMPLE_TEX2D_SAMPLER(_Normal2, sampler_Normal0, i.uv2), _NormalStrength2);
            #endif
            #if defined(_RAIN_ON)
                #if defined(_PARALLAX_2_ON) && !defined(_STOCHASTIC_2_ON)
                    if (_RainLayer2 == 1){
                        puddleBlend2 = saturate(puddleBlend2 * 5);
                        float3 blendedRainNormals2 = BlendNormals(normal2, lerp(rainPuddleNormal, rainNormal, puddleBlend2));
                        normal2 = blendedRainNormals2;
                    }
                #else
                    if (_RainLayer2 == 1){
                        normal2 = BlendNormals(normal2, rainNormal);
                    }
                #endif
            #endif
            float packed2Rough = packed2[_RoughnessChannel2] * _Roughness2;
            if (_SmoothnessMode2 == 1) packed2Rough = 1-packed2Rough;
            float heightLerp2 = 1;
            #if defined(_PARALLAX_2_ON) && !defined(_STOCHASTIC_2_ON)
                id.height = lerp(id.height, packed2[_HeightChannel2], i.color.g);
                if (_HeightBlend2 == 1){
                    if (_HeightBlendEdges2 == 1){
                        float edgeMask2 = saturate(pow(i.color.g, _EdgePower2));
                        i.color.g *= lerp(linearstep(_HeightBlendMin2, _HeightBlendMax2, id.height), i.color.g, edgeMask2);
                    }
                    else {
                        i.color.g *= linearstep(_HeightBlendMin2, _HeightBlendMax2, id.height);
                    }
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
        #if defined(_HEIGHT_BLENDING_ON)
            i.color.b = linearstep(_BlendThresholdMin3, _BlendThresholdMax3, i.color.b);
        #endif
        if (i.color.b > 0){
            #if defined(_STOCHASTIC_3_ON)
                StochasticUV(sd, i.uv3);
                float4 baseColor3 = StochasticSample(_BaseColor3, sd, sampler_BaseColor0) * _Color3;
                float4 packed3 = StochasticSample(_PackedMap3, sd, sampler_PackedMap0);
                float3 normal3 = UnpackScaleNormal(StochasticSample(_Normal3, sd, sampler_Normal0), _NormalStrength3 * 1.5);
            #else
                #if defined(_PARALLAX_3_ON)
                    ApplyParallax(_PackedMap3, i.uv3, tangentViewDir, _Height3, _HeightOffset3, _HeightChannel3);
                #endif
                float4 baseColor3 = MOCHIE_SAMPLE_TEX2D_SAMPLER(_BaseColor3, sampler_BaseColor0, i.uv3) * _Color3;
                float4 packed3 = MOCHIE_SAMPLE_TEX2D_SAMPLER(_PackedMap3, sampler_PackedMap0, i.uv3);
                #if defined(_PARALLAX_3_ON)
                    float puddleBlend3 = 1;
                    if (_PuddleHeightBlend3 == 1){
                        puddleBlend3 = linearstep(_PuddleBlendMin3, _PuddleBlendMax3, packed3[_HeightChannel3]);
                        puddleBlend3 = lerp(1, puddleBlend3, puddleThreshold);
                        _NormalStrength3 *= puddleBlend3;
                        _Roughness3 *= puddleBlend3;
                        _Occlusion3 *= puddleBlend3;
                        baseColor3 *= lerp(_PuddleTint3, 1, puddleBlend3);
                    }
                #endif
                float3 normal3 = UnpackScaleNormal(MOCHIE_SAMPLE_TEX2D_SAMPLER(_Normal3, sampler_Normal0, i.uv3), _NormalStrength3);
            #endif
            #if defined(_RAIN_ON)
                #if defined(_PARALLAX_3_ON) && !defined(_STOCHASTIC_3_ON)
                    if (_RainLayer3 == 1){
                        puddleBlend3 = saturate(puddleBlend3 * 5);
                        float3 blendedRainNormals3 = BlendNormals(normal3, lerp(rainPuddleNormal, rainNormal, puddleBlend3));
                        normal3 = blendedRainNormals3;
                    }
                #else
                    if (_RainLayer3 == 1){
                        normal3 = BlendNormals(normal3, rainNormal);
                    }
                #endif
            #endif
            float packed3Rough = packed3[_RoughnessChannel3] * _Roughness3;
            if (_SmoothnessMode3 == 1) packed3Rough = 1-packed3Rough;
            #if defined(_PARALLAX_3_ON) && !defined(_STOCHASTIC_3_ON)
                id.height = lerp(id.height, packed3[_HeightChannel3], i.color.b);
                if (_HeightBlend3 == 1){
                    if (_HeightBlendEdges3 == 1){
                        float edgeMask3 = saturate(pow(i.color.b, _EdgePower3));
                        i.color.b *= lerp(linearstep(_HeightBlendMin3, _HeightBlendMax3, id.height), i.color.b, edgeMask3);
                    }
                    else {
                        i.color.b *= linearstep(_HeightBlendMin3, _HeightBlendMax3, id.height);
                    }
                }
            #endif
            baseColor = lerp(baseColor, baseColor3, i.color.b);
            normalMap = lerp(normalMap, normal3, i.color.b);
            id.occlusion = lerp(id.occlusion, lerp(1, packed3[_OcclusionChannel3], _Occlusion3), i.color.b);
            id.roughness = lerp(id.roughness, packed3Rough, i.color.b);
            id.metallic = lerp(id.metallic, packed3[_MetallicChannel3] * _Metallic3, i.color.b);
        }
    #endif

    id.albedo = baseColor;
    id.diffuse = id.albedo;
    id.normalTS = normalMap;
    id.vNormal = i.normal;
    id.normal = Unity_SafeNormalize(mul(normalMap, tangentToWorld));

    #if AREALIT_ENABLED
        float4 alOcclusion = MOCHIE_SAMPLE_TEX2D(_AreaLitOcclusion, i.areaLitOcclusionUV);
        AreaLightFragInput ai;
        ai.pos = i.worldPos;
        ai.normal = id.normal;
        ai.view = -viewDir;
        ai.roughness = id.roughness * _AreaLitRoughnessMult;
        ai.occlusion = float4(id.occlusion.xxx, 1) * alOcclusion;
        ai.screenPos = i.pos.xy;
        half4 diffTerm, specTerm;
        if (_AreaLitStrength > 0){
            ShadeAreaLights(ai, diffTerm, specTerm, true, !IsSpecularOff(), IsStereo());
        }
        else {
            diffTerm = 0;
            specTerm = 0;
        }
    #endif

    UNITY_LIGHT_ATTENUATION(atten, i, i.worldPos);
    atten = FadeShadows(i.worldPos, atten);

    LightingData ld = (LightingData)0;
    InitializeLightingData(ld, id, i, viewDir, tangentViewDir, atten);
    id.diffuse.rgb *= ld.lightCol;
    
    #if LTCGI_ENABLED
        diffLight = 0;
        reflLight = 0;
        if (_LTCGIStrength > 0){
            LTCGI_Contribution(
                i.worldPos,
                id.normal,
                viewDir,
                id.roughness * _LTCGIRoughness,
                (i.lightmapUV.xy - unity_LightmapST.zw) / unity_LightmapST.xy,
                diffLight
                #if defined(_REFLECTIONS_ON)
                    , reflLight
                #endif
            );
            ld.reflectionCol += reflLight * _LTCGIStrength;
            id.diffuse.rgb += (id.albedo.rgb * diffLight) * _LTCGIStrength * id.occlusion;
        }
    #endif

    CalculateBRDF(ld, id, i);
    id.diffuse.rgb += ld.reflectionCol + ld.specHighlightCol;
    
    #if AREALIT_ENABLED
        float3 areaLitColor = id.albedo * diffTerm + specularTint * specTerm;
        if (_SpecularOcclusionToggle == 1 && _AreaLitSpecularOcclusion == 1)
            areaLitColor *= specularOcclusion;
        id.diffuse.rgb += areaLitColor * _AreaLitStrength;
    #endif

    float4 diffuse = id.diffuse;

    UNITY_APPLY_FOG(i.fogCoord, diffuse);

    #if defined(_DEBUGMODE_ON)
        diffuse = _DebugVertexColors == 1 ? i.color : 0;
        diffuse = _DebugBaseColor == 1 ? diffuse + id.albedo : diffuse;
        diffuse = _DebugNormals == 1 ? diffuse + float4(id.normalTS, 1) : diffuse;
        diffuse = _DebugRoughness == 1 ? diffuse + float4(id.roughness.xxx, 1) : diffuse;
        diffuse = _DebugMetallic == 1 ? diffuse + float4(id.metallic.xxx, 1) : diffuse;
        diffuse = _DebugOcclusion == 1 ? diffuse + float4(id.occlusion.xxx, 1) : diffuse;
        diffuse = _DebugHeight == 1 ? diffuse + float4(id.height.xxx, 1) : diffuse;
        diffuse = _DebugAtten == 1 ? diffuse + float4(atten.xxx * ld.NdotL, 1) : diffuse;
        #if defined(_REFLECTIONS_ON)
            diffuse = _DebugReflections == 1 ? diffuse + float4(ld.reflectionCol, 1) : diffuse;
        #endif
        #if defined(_SPECULAR_HIGHLIGHTS_ON)
            diffuse = _DebugSpecular == 1 ? diffuse + float4(ld.specHighlightCol, 1) : diffuse;
        #endif
        #if defined(_RAIN_ON)
            diffuse = _DebugRainThreshold == 1 ? diffuse + float4(rainThreshold.xxx, 1) : diffuse;
        #endif
        // diffuse = _DebugPuddleThreshold == 1 ? diffuse + float4(puddleThreshold.xxx, 1) : diffuse;
    #endif
    
    return diffuse;
}

#endif