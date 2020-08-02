#ifdef _WALLFX_TYPE1

#include "Packages/jp.keijiro.noiseshader/Shader/SimplexNoise2D.hlsl"

float3 WallFx(float2 uv)
{
    const float freq = _Param1;
    const float speed = _Param2;
    const float width = _Param3;

    float x = uv.x * freq;
    float t1 = _LocalTime * speed;
    float t2 = -10 - t1;

    float2 np1 = float2(x, t1);
    float2 np2 = float2(x, t2);

    float n1 = abs(snoise(np1)) < width;
    float n2 = abs(snoise(np2)) < width;

    return lerp(_Color1.rgb * n1, _Color2.rgb, n2);
}

#endif

#ifdef _WALLFX_TYPE2

#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

float3 WallFx(float2 uv)
{
    uint seed = uv.y * _Param1 * 2;
    float width = (Hash(seed    ) / 2 + 0.5) * _Param2;
    float speed = (Hash(seed + 1) / 2 + 0.5) * _Param3;

    float x = uv.x;
    uint sel = x / width + (_LocalTime + 10) * speed;
    float hue = Hash(sel * 2);
    float val = Hash(sel * 2 + 1);

    val = smoothstep(0.5, 1, val);

    return HsvToRgb(float3(hue, 1, val));
}

#endif

#ifdef _WALLFX_TYPE3

#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

float3 WallFx(float2 uv)
{
    float2 p = (uv - 0.5) * float2(1, 0.5) * 0.7;
    float t = _LocalTime;

    float r = 0.3 * t;
    float2x2 rot = float2x2(cos(r), sin(r), -sin(r), cos(r));

    for (int i = 0; i < 8; i++)
    {
        float2 ofs1 = sin(t * float2(0.84, 0.34)) * 0.1;
        float2 ofs2 = sin(t * float2(0.23, 0.53)) * 0.1;
        p = mul(rot, (p + ofs1) / dot(p, p + ofs2));
    }

    return saturate(p.xyy * float3(1, 0.5, 1));
}

#endif

#ifdef _WALLFX_TYPE4

#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

float3 WallFx(float2 uv)
{
    float2 p = (uv - 0.5) * float2(2, 0.5) * _Param1;
    float t = _LocalTime;

    float r = _Param2 * t;
    float2x2 rot = float2x2(cos(r), sin(r), -sin(r), cos(r));

    for (int i = 0; i < 8; i++)
    {
        float2 ofs1 = sin(t * float2(0.84, 0.34)) * _Param3;
        float2 ofs2 = sin(t * float2(0.23, 0.53)) * _Param4;
        p = mul(rot, (p + ofs1) / dot(p, p + ofs2));
    }

    float3 c1 = p.x * _Color1.rgb;
    float3 c2 = p.y * _Color2.rgb;
    return saturate(max(c1, 0) + max(c2, 0));
}

#endif
