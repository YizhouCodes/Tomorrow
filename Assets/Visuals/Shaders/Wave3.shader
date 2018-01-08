// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Wave3"
{
	Properties
	{
		_WireColor("WireColor", Color) = (0,0,0,0)
		_WireWidth("WireWidth", Range( 0 , 2)) = 0
		_FillColor("FillColor", Color) = (0,0,0,0)
		_Intensity("Intensity", Float) = 0
		_Texture0("Texture 0", 2D) = "white" {}
		_Speed("Speed", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
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
			float4 temp_output_92_0 = ( float4( ase_vertexNormal , 0.0 ) * sin( ( ( tex2Dlod( _Texture0, float4( uv_Texture0, 0, 0.0) ) * UNITY_PI ) + ( ( _Speed * _Time.y ) * UNITY_PI ) ) ) );
			v.vertex.xyz += ( _Intensity * temp_output_92_0 ).rgb;
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
			float4 temp_output_92_0 = ( float4( ase_vertexNormal , 0.0 ) * sin( ( ( tex2D( _Texture0, uv_Texture0 ) * UNITY_PI ) + ( ( _Speed * _Time.y ) * UNITY_PI ) ) ) );
			float4 lerpResult48 = lerp( _FillColor , _WireColor , ( length( ase_vertexNormal ) - length( temp_output_92_0 ) ));
			float4 smoothstepResult16 = smoothstep( ( fwidth( i.vertexColor ) * _WireWidth ) , i.vertexColor , float4( float3(0,0,0) , 0.0 ));
			float4 lerpResult23 = lerp( _FillColor , lerpResult48 , max( max( smoothstepResult16.r , smoothstepResult16.g ) , smoothstepResult16.b ));
			o.Albedo = lerpResult23.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14201
0;363;1366;343;2824.932;196.3262;2.659429;True;False
Node;AmplifyShaderEditor.SimpleTimeNode;81;-1719.658,215.4315;Float;False;1;0;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;82;-2342.354,202.7769;Float;True;Property;_Texture0;Texture 0;4;0;Create;cd460ee4ac5c1e746b7a734cc7cc64dd;cd460ee4ac5c1e746b7a734cc7cc64dd;False;white;Auto;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;83;-1584.512,108.3183;Float;False;Property;_Speed;Speed;5;0;Create;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;-1447.019,182.8907;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;85;-1972.789,324.8676;Float;True;Property;_TextureSample0;Texture Sample 0;3;0;Create;cd460ee4ac5c1e746b7a734cc7cc64dd;cd460ee4ac5c1e746b7a734cc7cc64dd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PiNode;86;-1809.49,508.3688;Float;False;1;0;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;10;-1933.3,-427.9323;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;87;-1499.42,476.2676;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;88;-1397.71,309.6367;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;89;-1281.038,426.3997;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-1658.416,-379.5234;Float;False;Property;_WireWidth;WireWidth;1;0;Create;0;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.FWidthOpNode;12;-1555.654,-507.5261;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SinOpNode;90;-1013.528,461.8466;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector3Node;17;-1394.608,-647.4739;Float;False;Constant;_Vector0;Vector 0;1;0;Create;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NormalVertexDataNode;91;-1231.118,157.6161;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode;37;-912.2083,-872.2692;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-1353.34,-482.2863;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SmoothstepOpNode;16;-1147.815,-460.652;Float;False;3;0;COLOR;0.0,0,0,0;False;1;COLOR;0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;38;-712.7885,-872.9557;Float;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;92;-878.5523,287.4573;Float;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;18;-972.1522,-461.2;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DdyOpNode;39;-496.982,-868.3561;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LengthOpNode;80;-829.8599,-33.63586;Float;False;1;0;FLOAT3;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DdxOpNode;40;-495.7852,-801.9753;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LengthOpNode;93;-836.5911,172.7859;Float;False;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CrossProductOpNode;41;-373.9798,-850.755;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;19;-741.022,-461.6513;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;21;-150.8356,-750.2736;Float;False;Property;_FillColor;FillColor;2;0;Create;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;22;-156.2439,-582.6083;Float;False;Property;_WireColor;WireColor;0;0;Create;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;94;-623.405,29.03045;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;48;357.5549,-431.3391;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;95;-683.8683,140.3192;Float;False;Property;_Intensity;Intensity;3;0;Create;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;20;-629.0806,-460.8425;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldToTangentMatrix;45;-290.2143,-918.1189;Float;False;0;1;FLOAT3x3;0
Node;AmplifyShaderEditor.NormalizeNode;42;-228.4047,-847.3917;Float;False;1;0;FLOAT3;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-82.37469,-872.2555;Float;False;2;2;0;FLOAT3x3;0,0,0;False;1;FLOAT3;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;96;-339.9366,251.897;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;23;560.9177,-566.8559;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1071.079,-211.4538;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Wave3;False;False;False;False;False;False;True;True;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;False;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;False;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;84;0;83;0
WireConnection;84;1;81;0
WireConnection;85;0;82;0
WireConnection;87;0;85;0
WireConnection;87;1;86;0
WireConnection;88;0;84;0
WireConnection;88;1;86;0
WireConnection;89;0;87;0
WireConnection;89;1;88;0
WireConnection;12;0;10;0
WireConnection;90;0;89;0
WireConnection;15;0;12;0
WireConnection;15;1;11;0
WireConnection;16;0;17;0
WireConnection;16;1;15;0
WireConnection;16;2;10;0
WireConnection;38;0;37;0
WireConnection;92;0;91;0
WireConnection;92;1;90;0
WireConnection;18;0;16;0
WireConnection;39;0;38;0
WireConnection;80;0;91;0
WireConnection;40;0;38;0
WireConnection;93;0;92;0
WireConnection;41;0;39;0
WireConnection;41;1;40;0
WireConnection;19;0;18;0
WireConnection;19;1;18;1
WireConnection;94;0;80;0
WireConnection;94;1;93;0
WireConnection;48;0;21;0
WireConnection;48;1;22;0
WireConnection;48;2;94;0
WireConnection;20;0;19;0
WireConnection;20;1;18;2
WireConnection;42;0;41;0
WireConnection;43;0;45;0
WireConnection;43;1;42;0
WireConnection;96;0;95;0
WireConnection;96;1;92;0
WireConnection;23;0;21;0
WireConnection;23;1;48;0
WireConnection;23;2;20;0
WireConnection;0;0;23;0
WireConnection;0;1;43;0
WireConnection;0;11;96;0
ASEEND*/
//CHKSM=4FE598417F3132FC6DBF5D8978C4F0684186211B