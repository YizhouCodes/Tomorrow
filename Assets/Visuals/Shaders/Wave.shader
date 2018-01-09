// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Wave"
{
	Properties
	{
		_WireColor("WireColor", Color) = (0,0,0,0)
		_WireWidth("WireWidth", Range( 0 , 2)) = 0
		_FillColor("FillColor", Color) = (0,0,0,0)
		_Speed("Speed", Range( 0 , 1)) = 0
		_Intensity("Intensity", Range( 0 , 10)) = 0
		_WireTreshold("WireTreshold", Range( 0 , 1)) = 0
		_Texture0("Texture 0", 2D) = "white" {}
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
		uniform float _Intensity;
		uniform sampler2D _Texture0;
		uniform float _Speed;
		uniform float4 _Texture0_ST;
		uniform float _WireTreshold;
		uniform float _WireWidth;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertexNormal = v.normal.xyz;
			float2 temp_cast_0 = (_Speed).xx;
			float2 uv_Texture0 = v.texcoord.xy * _Texture0_ST.xy + _Texture0_ST.zw;
			float2 panner63 = ( uv_Texture0 + _Time.y * temp_cast_0);
			float3 temp_output_36_0 = ( _Intensity * ( ase_vertexNormal * tex2Dlod( _Texture0, float4( panner63, 0, 0.0) ).r ) );
			v.vertex.xyz += temp_output_36_0;
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
			float2 temp_cast_3 = (_Speed).xx;
			float2 uv_Texture0 = i.uv_texcoord * _Texture0_ST.xy + _Texture0_ST.zw;
			float2 panner63 = ( uv_Texture0 + _Time.y * temp_cast_3);
			float3 temp_output_36_0 = ( _Intensity * ( ase_vertexNormal * tex2D( _Texture0, panner63 ).r ) );
			float temp_output_54_0 = max( ( ( length( temp_output_36_0 ) / length( ( _Intensity * ase_vertexNormal ) ) ) - _WireTreshold ) , 0.0 );
			float4 lerpResult48 = lerp( _FillColor , _WireColor , temp_output_54_0);
			float4 smoothstepResult16 = smoothstep( ( fwidth( i.vertexColor ) * ( _WireWidth + temp_output_54_0 ) ) , i.vertexColor , float4( float3(0,0,0) , 0.0 ));
			float temp_output_20_0 = max( max( smoothstepResult16.r , smoothstepResult16.g ) , smoothstepResult16.b );
			float4 lerpResult23 = lerp( _FillColor , lerpResult48 , temp_output_20_0);
			o.Albedo = lerpResult23.rgb;
			float4 _Color0 = float4(0,0,0,0);
			float4 lerpResult56 = lerp( _Color0 , _WireColor , temp_output_54_0);
			float4 lerpResult57 = lerp( _Color0 , lerpResult56 , temp_output_20_0);
			o.Emission = lerpResult57.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14201
0;549;1920;479;1129.1;470.0458;1.872843;True;True
Node;AmplifyShaderEditor.TexturePropertyNode;65;-1458.274,114.7998;Float;True;Property;_Texture0;Texture 0;6;0;Create;None;None;False;white;Auto;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;61;-1221.593,301.8386;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;27;-1262.127,414.3983;Float;False;Property;_Speed;Speed;3;0;Create;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;26;-1158.953,484.3438;Float;False;1;0;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;63;-935.3198,386.1151;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NormalVertexDataNode;35;-654.8401,223.4468;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;32;-759.9845,357.4625;Float;True;Property;_Noise;Noise;3;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;33;-757.8962,141.1273;Float;False;Property;_Intensity;Intensity;4;0;Create;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;-411.2004,321.2563;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-253.3084,299.1368;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT3;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;209.3641,273.1225;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT3;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LengthOpNode;58;574.7546,446.2038;Float;False;1;0;FLOAT3;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;50;346.6621,272.5358;Float;False;1;0;FLOAT3;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;59;560.8411,256.6341;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-204.8039,15.74182;Float;False;Property;_WireTreshold;WireTreshold;5;0;Create;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;53;452.8875,62.94059;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-1658.416,-379.5234;Float;False;Property;_WireWidth;WireWidth;1;0;Create;0;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;10;-1933.3,-427.9323;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMaxOpNode;54;663.8637,86.69589;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;60;-1168.596,-283.215;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FWidthOpNode;12;-1555.654,-507.5261;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PosVertexDataNode;37;-1463.02,-100.0527;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;17;-1394.608,-647.4739;Float;False;Constant;_Vector0;Vector 0;1;0;Create;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-1353.34,-482.2863;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SmoothstepOpNode;16;-1147.815,-460.652;Float;False;3;0;COLOR;0.0,0,0,0;False;1;COLOR;0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;38;-1263.6,-100.7392;Float;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DdxOpNode;40;-1046.597,-29.75893;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DdyOpNode;39;-1047.794,-96.1396;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;18;-972.1522,-461.2;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.CrossProductOpNode;41;-924.7916,-78.53853;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;21;-150.8356,-750.2736;Float;False;Property;_FillColor;FillColor;2;0;Create;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;22;-156.2439,-582.6083;Float;False;Property;_WireColor;WireColor;0;0;Create;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;55;-87.44035,-236.556;Float;False;Constant;_Color0;Color 0;7;0;Create;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMaxOpNode;19;-741.022,-461.6513;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;42;-779.2166,-75.17532;Float;False;1;0;FLOAT3;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;56;369.8396,-190.5864;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;48;357.5549,-515.0435;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldToTangentMatrix;45;-841.0261,-145.9024;Float;False;0;1;FLOAT3x3;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;20;-629.0806,-460.8425;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;57;669.0366,-249.3934;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;23;560.9177,-566.8559;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-633.1866,-100.039;Float;False;2;2;0;FLOAT3x3;0,0,0;False;1;FLOAT3;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1071.079,-211.4538;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Wave;False;False;False;False;False;False;True;True;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;False;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;False;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;61;2;65;0
WireConnection;63;0;61;0
WireConnection;63;2;27;0
WireConnection;63;1;26;0
WireConnection;32;0;65;0
WireConnection;32;1;63;0
WireConnection;34;0;35;0
WireConnection;34;1;32;1
WireConnection;36;0;33;0
WireConnection;36;1;34;0
WireConnection;49;0;33;0
WireConnection;49;1;35;0
WireConnection;58;0;36;0
WireConnection;50;0;49;0
WireConnection;59;0;58;0
WireConnection;59;1;50;0
WireConnection;53;0;59;0
WireConnection;53;1;47;0
WireConnection;54;0;53;0
WireConnection;60;0;11;0
WireConnection;60;1;54;0
WireConnection;12;0;10;0
WireConnection;15;0;12;0
WireConnection;15;1;60;0
WireConnection;16;0;17;0
WireConnection;16;1;15;0
WireConnection;16;2;10;0
WireConnection;38;0;37;0
WireConnection;40;0;38;0
WireConnection;39;0;38;0
WireConnection;18;0;16;0
WireConnection;41;0;39;0
WireConnection;41;1;40;0
WireConnection;19;0;18;0
WireConnection;19;1;18;1
WireConnection;42;0;41;0
WireConnection;56;0;55;0
WireConnection;56;1;22;0
WireConnection;56;2;54;0
WireConnection;48;0;21;0
WireConnection;48;1;22;0
WireConnection;48;2;54;0
WireConnection;20;0;19;0
WireConnection;20;1;18;2
WireConnection;57;0;55;0
WireConnection;57;1;56;0
WireConnection;57;2;20;0
WireConnection;23;0;21;0
WireConnection;23;1;48;0
WireConnection;23;2;20;0
WireConnection;43;0;45;0
WireConnection;43;1;42;0
WireConnection;0;0;23;0
WireConnection;0;1;43;0
WireConnection;0;2;57;0
WireConnection;0;11;36;0
ASEEND*/
//CHKSM=79C0D0E738AFE2173EBE6985837720B886F304E3