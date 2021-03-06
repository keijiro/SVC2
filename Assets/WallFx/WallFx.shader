﻿Shader "Hidden/WallFx"
{
    SubShader
    {
        Cull Off ZWrite Off ZTest Always
        Pass
        {
            HLSLPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment
            #define _WALLFX_TYPE1
            #include "Common.hlsl"
            #include "WallFx.hlsl"
            ENDHLSL
        }
        Pass
        {
            HLSLPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment
            #define _WALLFX_TYPE2
            #include "Common.hlsl"
            #include "WallFx.hlsl"
            ENDHLSL
        }
        Pass
        {
            HLSLPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment
            #define _WALLFX_TYPE3
            #include "Common.hlsl"
            #include "WallFx.hlsl"
            ENDHLSL
        }
        Pass
        {
            HLSLPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment
            #define _WALLFX_TYPE4
            #include "Common.hlsl"
            #include "WallFx.hlsl"
            ENDHLSL
        }
    }
}
