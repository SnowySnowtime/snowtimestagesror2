#ifndef SPLAT_SAMPLING_DEFINED
#define SPLAT_SAMPLING_DEFINED

#ifndef TEXTURE2D_ARGS
#define TEXTURE2D_ARGS(textureName, samplerName) Texture2D textureName, SamplerState samplerName
#define TEXTURE2D_PARAM(textureName, samplerName) textureName, samplerName
#define SAMPLE_TEXTURE2D(textureName, samplerName, coord2) textureName.Sample(samplerName, coord2)
#endif

float4 SampleTexture2DBicubicFilter(TEXTURE2D_ARGS(tex, smp), float2 coord, float4 texSize){
    coord = coord * texSize.xy - 0.5;
    float fx = frac(coord.x);
    float fy = frac(coord.y);
    coord.x -= fx;
    coord.y -= fy;

    float4 xcubic = cubic(fx);
    float4 ycubic = cubic(fy);

    float4 c = float4(coord.x - 0.5, coord.x + 1.5, coord.y - 0.5, coord.y + 1.5);
    float4 s = float4(xcubic.x + xcubic.y, xcubic.z + xcubic.w, ycubic.x + ycubic.y, ycubic.z + ycubic.w);
    float4 offset = c + float4(xcubic.y, xcubic.w, ycubic.y, ycubic.w) / s;

    float4 sample0 = SAMPLE_TEXTURE2D(tex, smp, float2(offset.x, offset.z) * texSize.zw);
    float4 sample1 = SAMPLE_TEXTURE2D(tex, smp, float2(offset.y, offset.z) * texSize.zw);
    float4 sample2 = SAMPLE_TEXTURE2D(tex, smp, float2(offset.x, offset.w) * texSize.zw);
    float4 sample3 = SAMPLE_TEXTURE2D(tex, smp, float2(offset.y, offset.w) * texSize.zw);

    float sx = s.x / (s.x + s.y);
    float sy = s.z / (s.z + s.w);

    return lerp(
        lerp(sample3, sample2, sx),
        lerp(sample1, sample0, sx), sy);
}

float4 SampleLightmapBicubic(float2 uv){
    #ifdef SHADER_API_D3D11
        float width, height;
        unity_Lightmap.GetDimensions(width, height);

        float4 unity_Lightmap_TexelSize = float4(width, height, 1.0/width, 1.0/height);

        return SampleTexture2DBicubicFilter(TEXTURE2D_PARAM(unity_Lightmap, samplerunity_Lightmap),
            uv, unity_Lightmap_TexelSize);
    #else
        return SAMPLE_TEXTURE2D(unity_Lightmap, samplerunity_Lightmap, uv);
    #endif
}

float4 SampleLightmapDirBicubic(float2 uv){
    #ifdef SHADER_API_D3D11
        float width, height;
        unity_LightmapInd.GetDimensions(width, height);

        float4 unity_LightmapInd_TexelSize = float4(width, height, 1.0/width, 1.0/height);

        return SampleTexture2DBicubicFilter(TEXTURE2D_PARAM(unity_LightmapInd, samplerunity_Lightmap),
            uv, unity_LightmapInd_TexelSize);
    #else
        return SAMPLE_TEXTURE2D(unity_LightmapInd, samplerunity_Lightmap, uv);
    #endif
}

float4 SampleDynamicLightmapBicubic(float2 uv){
    #ifdef SHADER_API_D3D11
        float width, height;
        unity_DynamicLightmap.GetDimensions(width, height);

        float4 unity_DynamicLightmap_TexelSize = float4(width, height, 1.0/width, 1.0/height);

        return SampleTexture2DBicubicFilter(TEXTURE2D_PARAM(unity_DynamicLightmap, samplerunity_DynamicLightmap),
            uv, unity_DynamicLightmap_TexelSize);
    #else
        return SAMPLE_TEXTURE2D(unity_DynamicLightmap, samplerunity_DynamicLightmap, uv);
    #endif
}

float4 SampleDynamicLightmapDirBicubic(float2 uv){
    #ifdef SHADER_API_D3D11
        float width, height;
        unity_DynamicDirectionality.GetDimensions(width, height);

        float4 unity_DynamicDirectionality_TexelSize = float4(width, height, 1.0/width, 1.0/height);

        return SampleTexture2DBicubicFilter(TEXTURE2D_PARAM(unity_DynamicDirectionality, samplerunity_DynamicLightmap),
            uv, unity_DynamicDirectionality_TexelSize);
    #else
        return SAMPLE_TEXTURE2D(unity_DynamicDirectionality, samplerunity_DynamicLightmap, uv);
    #endif
}

float2 SelectOcclusionUVSet(appdata v, int set){
	float2 uvs[] = {v.uv, v.uv1, v.uv2, v.uv3, v.uv4, v.uv1 * unity_LightmapST.xy + unity_LightmapST.zw};
	return uvs[set];
}

float4 SelectUVSet(appdata v, int set){
    float4 uvSets[5] = {v.uv, v.uv1, v.uv2, v.uv3, v.uv4};
    return uvSets[set];
}

void StochasticUV(inout SampleData sd, float2 uv){
    //skew the uv to create triangular grid
    float2 skewUV = mul(float2x2(1.0, 0.0, -0.57735027, 1.15470054), uv*3.464);

    //vertices on the triangular grid
    int2 vertID = int2(floor(skewUV));

    //barycentric coordinates of uv position
    float3 temp = float3(frac(skewUV),0);
    temp.z = 1.0 - temp.x - temp.y;
    
    //each vertex on the grid gets an according weight value
    int2 vertA, vertB, vertC;
    float weightA, weightB, weightC;

    //determine which triangle we're in
    if (temp.z > 0.0){
        sd.uvA.z = temp.z;
        sd.uvB.z = temp.y;
        sd.uvC.z = temp.x;
        vertA = vertID;
        vertB = vertID + int2(0, 1);
        vertC = vertID + int2(1, 0);
    }
    else {
        sd.uvA.z = -temp.z;
        sd.uvB.z = 1.0 - temp.y;
        sd.uvC.z = 1.0 - temp.x;
        vertA = vertID + int2(1, 1);
        vertB = vertID + int2(1, 0);
        vertC = vertID + int2(0, 1);
    }	

    //get derivatives to avoid triangular artifacts
    sd.dx = ddx(uv);
    sd.dy = ddy(uv);

    //offset uvs using magic numbers
    sd.uvA.xy = uv + frac(sin(fmod(float2(dot(vertA, float2(127.1, 311.7)), dot(vertA, float2(269.5, 183.3))), 3.14159)) * 43758.5453);
    sd.uvB.xy = uv + frac(sin(fmod(float2(dot(vertB, float2(127.1, 311.7)), dot(vertB, float2(269.5, 183.3))), 3.14159)) * 43758.5453);
    sd.uvC.xy = uv + frac(sin(fmod(float2(dot(vertC, float2(127.1, 311.7)), dot(vertC, float2(269.5, 183.3))), 3.14159)) * 43758.5453);
}

float4 StochasticSample(Texture2D tex, SampleData sd, SamplerState ss){
    float4 sampleA = MOCHIE_SAMPLE_TEX2D_SAMPLER_GRAD(tex, ss, sd.uvA.xy, sd.dx, sd.dy);
    float4 sampleB = MOCHIE_SAMPLE_TEX2D_SAMPLER_GRAD(tex, ss, sd.uvB.xy, sd.dx, sd.dy);
    float4 sampleC = MOCHIE_SAMPLE_TEX2D_SAMPLER_GRAD(tex, ss, sd.uvC.xy, sd.dx, sd.dy);
    return sampleA * sd.uvA.z + sampleB * sd.uvB.z + sampleC * sd.uvC.z;
}

#endif