#if 1

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

    return _Color1.rgb * n1 + _Color2.rgb * n2;
}

#else

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
