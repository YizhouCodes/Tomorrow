// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "NoShadowsFogFade"
{
	Properties
	{
		_Speed("Speed", Vector) = (0,0,0,0)
		_Texture0("Texture 0", 2D) = "white" {}
		_Fade("Fade", Range( 0 , 1)) = 0
		_Color0("Color 0", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		GrabPass{ }
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow 
		struct Input
		{
			float4 screenPos;
			float2 uv_texcoord;
		};

		uniform float4 _Color0;
		uniform sampler2D _GrabTexture;
		uniform sampler2D _Texture0;
		uniform float2 _Speed;
		uniform float4 _Texture0_ST;
		uniform float _Fade;


		inline float4 ASE_ComputeGrabScreenPos( float4 pos )
		{
			#if UNITY_UV_STARTS_AT_TOP
			float scale = -1.0;
			#else
			float scale = 1.0;
			#endif
			float4 o = pos;
			o.y = pos.w * 0.5f;
			o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
			return o;
		}


		inline fixed4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return fixed4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 screenColor3 = tex2Dproj( _GrabTexture, UNITY_PROJ_COORD( ase_grabScreenPos ) );
			float2 uv_Texture0 = i.uv_texcoord * _Texture0_ST.xy + _Texture0_ST.zw;
			float2 panner7 = ( uv_Texture0 + 1.0 * _Time.y * _Speed);
			float lerpResult6 = lerp( 0.0 , tex2D( _Texture0, panner7 ).r , max( ( uv_Texture0.y - _Fade ) , 0.0 ));
			float4 lerpResult36 = lerp( _Color0 , screenColor3 , lerpResult6);
			o.Emission = lerpResult36.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14201
0;445;1920;583;2446.844;896.5778;2.822734;True;True
Node;AmplifyShaderEditor.TexturePropertyNode;8;-1737.122,-28.8246;Float;True;Property;_Texture0;Texture 0;1;0;Create;None;None;False;white;Auto;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-1459.752,207.8808;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;25;-967.7818,590.1321;Float;False;Property;_Fade;Fade;2;0;Create;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;10;-1386.237,329.8996;Float;False;Property;_Speed;Speed;0;0;Create;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.BreakToComponentsNode;13;-1062.059,295.1842;Float;True;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleSubtractOpNode;27;-752.2601,343.2467;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;7;-1059.02,138.2748;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,1;False;1;FLOAT;1.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;2;-759.2106,94.46109;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMaxOpNode;28;-492.7883,338.2166;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenColorNode;3;-479.0306,-499.9717;Float;False;Global;_GrabScreen0;Grab Screen 0;1;0;Create;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;6;-206.7213,-234.349;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0;False;2;FLOAT;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;35;-501.5783,-736.9769;Float;False;Property;_Color0;Color 0;3;0;Create;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;36;55.82048,-445.673;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;526.1472,-245.5484;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;NoShadowsFogFade;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;Back;0;0;False;0;0;Transparent;0.5;True;False;0;False;Transparent;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;False;2;SrcAlpha;OneMinusSrcAlpha;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;9;2;8;0
WireConnection;13;0;9;0
WireConnection;27;0;13;1
WireConnection;27;1;25;0
WireConnection;7;0;9;0
WireConnection;7;2;10;0
WireConnection;2;0;8;0
WireConnection;2;1;7;0
WireConnection;28;0;27;0
WireConnection;6;1;2;1
WireConnection;6;2;28;0
WireConnection;36;0;35;0
WireConnection;36;1;3;0
WireConnection;36;2;6;0
WireConnection;0;2;36;0
ASEEND*/
//CHKSM=34AB22ED32C29A683B5F3E151079B26730A1FB49