// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Wave2"
{
	Properties
	{
		_WireColor("WireColor", Color) = (0,0,0,0)
		_WireWidth("WireWidth", Range( 0 , 2)) = 0
		_FillColor("FillColor", Color) = (0,0,0,0)
		_Intensity("Intensity", Range( 0 , 10)) = 0
		_Texture0("Texture 0", 2D) = "white" {}
		_Speed("Speed", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha noshadow nolightmap  nodynlightmap vertex:vertexDataFunc 
		struct Input
		{
			float3 worldNormal;
			INTERNAL_DATA
			float3 worldPos;
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform float4 _FillColor;
		uniform float4 _WireColor;
		uniform sampler2D _Texture0;
		uniform float4 _Texture0_ST;
		uniform float _Speed;
		uniform float _WireWidth;
		uniform float _Intensity;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertexNormal = v.normal.xyz;
			float2 uv_Texture0 = v.texcoord * _Texture0_ST.xy + _Texture0_ST.zw;
			float4 temp_output_34_0 = ( float4( ase_vertexNormal , 0.0 ) * sin( ( ( tex2Dlod( _Texture0, float4( uv_Texture0, 0, 0.0) ) * UNITY_PI ) + ( ( _Speed * _Time.y ) * UNITY_PI ) ) ) );
			v.vertex.xyz += ( _Intensity * temp_output_34_0 ).rgb;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3x3 ase_worldToTangent = float3x3( ase_worldTangent, ase_worldBitangent, ase_worldNormal );
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float4 transform38 = mul(unity_ObjectToWorld,float4( ase_vertex3Pos , 0.0 ));
			float3 normalizeResult42 = normalize( cross( ddy( transform38 ).xyz , ddx( transform38 ).xyz ) );
			o.Normal = mul( ase_worldToTangent, normalizeResult42 );
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			float2 uv_Texture0 = i.uv_texcoord * _Texture0_ST.xy + _Texture0_ST.zw;
			float4 temp_output_34_0 = ( float4( ase_vertexNormal , 0.0 ) * sin( ( ( tex2D( _Texture0, uv_Texture0 ) * UNITY_PI ) + ( ( _Speed * _Time.y ) * UNITY_PI ) ) ) );
			float4 lerpResult91 = lerp( _FillColor , _WireColor , min( ( length( temp_output_34_0 ) - length( ase_vertexNormal ) ) , 0.0 ));
			float4 smoothstepResult16 = smoothstep( ( fwidth( i.vertexColor ) * _WireWidth ) , i.vertexColor , float4( float3(0,0,0) , 0.0 ));
			float4 lerpResult48 = lerp( _FillColor , lerpResult91 , max( max( smoothstepResult16.r , smoothstepResult16.g ) , smoothstepResult16.b ));
			o.Emission = lerpResult48.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14201
0;363;1366;343;1102.167;503.3238;2.50064;True;False
Node;AmplifyShaderEditor.RangedFloatNode;89;-843.3897,196.378;Float;False;Property;_Speed;Speed;5;0;Create;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;78;-1601.232,290.8366;Float;True;Property;_Texture0;Texture 0;4;0;Create;cd460ee4ac5c1e746b7a734cc7cc64dd;cd460ee4ac5c1e746b7a734cc7cc64dd;False;white;Auto;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleTimeNode;80;-978.5355,303.4913;Float;False;1;0;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;86;-1071.941,600.0022;Float;False;1;0;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;79;-1231.667,412.9274;Float;True;Property;_TextureSample0;Texture Sample 0;3;0;Create;cd460ee4ac5c1e746b7a734cc7cc64dd;cd460ee4ac5c1e746b7a734cc7cc64dd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;90;-705.8969,270.9505;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;87;-656.5882,397.6965;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;85;-758.2976,564.3274;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;10;-765.0458,-123.6992;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;81;-539.9158,514.4595;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-490.161,-75.29031;Float;False;Property;_WireWidth;WireWidth;1;0;Create;0;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.FWidthOpNode;12;-387.3992,-203.2931;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.NormalVertexDataNode;35;-411.7198,220.2894;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SinOpNode;82;-272.4053,549.9064;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector3Node;17;-226.3537,-343.2409;Float;False;Constant;_Vector0;Vector 0;1;0;Create;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PosVertexDataNode;37;-465.6623,-595.2402;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-185.0856,-178.0532;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;-137.43,375.5171;Float;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;38;-266.2425,-595.9268;Float;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;16;20.43961,-156.4189;Float;False;3;0;COLOR;0.0,0,0,0;False;1;COLOR;0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LengthOpNode;95;35.54042,126.5035;Float;False;1;0;FLOAT3;0.0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;92;119.6269,209.1082;Float;False;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;18;196.1027,-156.9669;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DdyOpNode;39;-50.43604,-591.3271;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DdxOpNode;40;-49.23917,-524.9465;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;94;316.0134,104.3752;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CrossProductOpNode;41;72.56613,-573.7261;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;22;293.5735,-331.109;Float;False;Property;_WireColor;WireColor;0;0;Create;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;21;303.4859,-498.7742;Float;False;Property;_FillColor;FillColor;2;0;Create;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMinOpNode;96;494.4238,36.19138;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;19;427.2331,-157.4182;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldToTangentMatrix;45;156.3314,-641.09;Float;False;0;1;FLOAT3x3;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;20;539.174,-156.6094;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;91;791.65,-103.4474;Float;False;3;0;COLOR;0.0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-507.5739,79.35946;Float;False;Property;_Intensity;Intensity;3;0;Create;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;42;218.1409,-570.3629;Float;False;1;0;FLOAT3;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;82.78589,368.9076;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;48;938.8173,-256.5024;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;364.1711,-595.2266;Float;False;2;2;0;FLOAT3x3;0,0,0;False;1;FLOAT3;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1749.253,-213.9438;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Wave2;False;False;False;False;False;False;True;True;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;False;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;False;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;79;0;78;0
WireConnection;90;0;89;0
WireConnection;90;1;80;0
WireConnection;87;0;90;0
WireConnection;87;1;86;0
WireConnection;85;0;79;0
WireConnection;85;1;86;0
WireConnection;81;0;85;0
WireConnection;81;1;87;0
WireConnection;12;0;10;0
WireConnection;82;0;81;0
WireConnection;15;0;12;0
WireConnection;15;1;11;0
WireConnection;34;0;35;0
WireConnection;34;1;82;0
WireConnection;38;0;37;0
WireConnection;16;0;17;0
WireConnection;16;1;15;0
WireConnection;16;2;10;0
WireConnection;95;0;35;0
WireConnection;92;0;34;0
WireConnection;18;0;16;0
WireConnection;39;0;38;0
WireConnection;40;0;38;0
WireConnection;94;0;92;0
WireConnection;94;1;95;0
WireConnection;41;0;39;0
WireConnection;41;1;40;0
WireConnection;96;0;94;0
WireConnection;19;0;18;0
WireConnection;19;1;18;1
WireConnection;20;0;19;0
WireConnection;20;1;18;2
WireConnection;91;0;21;0
WireConnection;91;1;22;0
WireConnection;91;2;96;0
WireConnection;42;0;41;0
WireConnection;36;0;33;0
WireConnection;36;1;34;0
WireConnection;48;0;21;0
WireConnection;48;1;91;0
WireConnection;48;2;20;0
WireConnection;43;0;45;0
WireConnection;43;1;42;0
WireConnection;0;1;43;0
WireConnection;0;2;48;0
WireConnection;0;11;36;0
ASEEND*/
//CHKSM=8CDB702C748EEEE24A3BDF369C8353EE70971FD1