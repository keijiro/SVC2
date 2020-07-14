#include "Packages/jp.keijiro.noiseshader/Shader/SimplexNoise2D.hlsl"

void WallFx1_float
  (float x, float t1, float t2,
   float width, float3 color1, float3 color2,
   out float3 color)
{
    float2 np1 = float2(x, t1);
    float2 np2 = float2(x, t2);

    float n1 = abs(snoise(np1)) < width;
    float n2 = abs(snoise(np2)) < width;

    color = color1 * n1 + color2 * n2;
}
