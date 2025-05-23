Shader "Custom/ToothShader"
{
    Properties
    {
        _MainTex("Texture", 2D) = "White" {}
        _TexScale("Texture Scale", Float)  = 1
    }

    SubShader
    {
        Tags {"Render Type" = "Opaque"}
        LOD 600

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 4.0

        sampler2D _MainTex;
        float _TexScale;

        struct Input {
            float3 worldPos;
            float3 worldNormal;
        };

        void surf(Input IN, inout SurfaceOutputStandard o) {
            float3 scaledWorldPos = IN.worldPos / _TexScale;
            float3 pWeight = abs(IN.worldNormal);
            pWeight /= pWeight.x + pWeight.y + pWeight.z;

            float3 xP = tex2D(_MainTex, scaledWorldPos.yz) * pWeight.x;
            float3 yP = tex2D(_MainTex, scaledWorldPos.xz) * pWeight.y;
            float3 zP = tex2D(_MainTex, scaledWorldPos.xy) * pWeight.z;

            o.Albedo = xP + yP + zP;
        }

        ENDCG
    }

    Fallback "Diffuse"
}
