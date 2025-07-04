#ifndef SPLAT_PARALLAX_DEFINED
#define SPLAT_PARALLAX_DEFINED

float2 GetParallaxOffset(Texture2D tex, float height, float3 viewDir, float strength, float offset, float2 uv, int channel){
    float2 uvOffset = 0;
    float2 prevUVOffset = 0;
    float stepSize = 1.0/12.0;
    float stepHeight = 1;
    float2 uvDelta = viewDir.xy * (stepSize * strength);
    float surfaceHeight = clamp(height, 0, 0.999);
    
    float prevStepHeight = stepHeight;
    float prevSurfaceHeight = surfaceHeight;

    [unroll(12)]
    for (int j = 1; j <= 12 && stepHeight > surfaceHeight; j++){
        prevUVOffset = uvOffset;
        prevStepHeight = stepHeight;
        prevSurfaceHeight = surfaceHeight;
        uvOffset -= uvDelta;
        stepHeight -= stepSize;
        surfaceHeight = MOCHIE_SAMPLE_TEX2D_SAMPLER(tex, sampler_PackedMap0, uv+uvOffset)[channel] + offset;
    }

    [unroll(5)]
    for (int k = 0; k < 5; k++) {
        uvDelta *= 0.5;
        stepSize *= 0.5;

        if (stepHeight < surfaceHeight) {
            uvOffset += uvDelta;
            stepHeight += stepSize;
        }
        else {
            uvOffset -= uvDelta;
            stepHeight -= stepSize;
        }
        surfaceHeight = MOCHIE_SAMPLE_TEX2D_SAMPLER(tex, sampler_PackedMap0, uv+uvOffset)[channel] + offset;
    }

    return uvOffset;
}

void ApplyParallax(Texture2D tex, inout float2 uv, float3 viewDir, float height, float offset, int channel){
    float h = MOCHIE_SAMPLE_TEX2D_SAMPLER(tex, sampler_PackedMap0, uv)[channel];
    uv += GetParallaxOffset(tex, h, viewDir, height, offset, uv, channel);
}

#endif