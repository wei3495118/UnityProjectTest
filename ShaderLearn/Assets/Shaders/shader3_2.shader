﻿Shader "custom/Shader3_2"
{
	Properties
	{
		_MainTex ("Splat Map", 2D) = "white" {}
		[NoScaleOffset] _Texture1 ("Texture 1", 2D) = "white" {}
		[NoScaleOffset] _Texture2 ("Texture 2", 2D) = "white" {}
		[NoScaleOffset] _Texture3 ("Texture 3", 2D) = "white" {}
		[NoScaleOffset] _Texture4 ("Texture 4", 2D) = "white" {}
	}
	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			//#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct VertexData
			{
				float4 position  : POSITION;
				float2 uv : TEXCOORD0;
			};
			struct Interpolators {
			    float4 position : SV_POSITION;
			    float2 uv : TEXCOORD0;
			    float2 uvSplat : TEXCOORD1;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			sampler2D _Texture1, _Texture2, _Texture3, _Texture4;
			//float4 _MainTex_ST;
			
			Interpolators vert (VertexData v)
			{
				Interpolators o;
				o.position = UnityObjectToClipPos(v.position);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uvSplat = v.uv ;
				return o;
			}
			
			fixed4 frag (Interpolators i) : SV_Target
			{
				// sample the texture
				//fixed4 col = tex2D(_MainTex, i.uv);
			float4 splat = tex2D(_MainTex, i.uvSplat);
				//fixed4 col = tex2D(_Texture1, i.uv)*splat.r  + tex2D(_Texture2, i.uv);
			float4 col=	tex2D(_Texture1, i.uv) * splat.r +tex2D(_Texture2, i.uv) * splat.g +    tex2D(_Texture3, i.uv) * splat.b +    tex2D(_Texture4, i.uv) * (1 - splat.r - splat.g - splat.b);
				return col;
			}
			ENDCG
		}
	}
}
