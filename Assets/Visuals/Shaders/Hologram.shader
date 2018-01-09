// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hologram"
{
	Properties
	{
		_Speed("Speed", Float) = 0
		_Lines("Lines", Float) = 0
		_BaseColor("BaseColor", Color) = (0,0,0,0)
		_Intensity("Intensity", Range( 0 , 1)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows noshadow 
		struct Input
		{
			float3 worldPos;
		};

		uniform float4 _BaseColor;
		uniform float _Lines;
		uniform float _Speed;
		uniform float _Intensity;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float temp_output_12_0 = ( mul( unity_ObjectToWorld, float4( ase_vertex3Pos , 0.0 ) ).xyz.y * _Lines );
			float mulTime14 = _Time.y * _Speed;
			float4 lerpResult72 = lerp( _BaseColor , ( _BaseColor * max( ( ( ( sin( ( temp_output_12_0 + mulTime14 ) ) + 1.0 ) / 2.0 ) + ( ( sin( ( mulTime14 + ( temp_output_12_0 / 2.0 ) ) ) + 1.0 ) / 4.0 ) ) , 0.5 ) ) , _Intensity);
			float4 transform51 = mul(unity_ObjectToWorld,float4( ase_vertex3Pos , 0.0 ));
			float3 normalizeResult56 = normalize( cross( ddy( transform51 ).xyz , ddx( transform51 ).xyz ) );
			float dotResult59 = dot( float3(0,1,0) , normalizeResult56 );
			float4 lerpResult63 = lerp( _BaseColor , lerpResult72 , (( dotResult59 > 0.99 ) ? 0.0 :  1.0 ));
			o.Emission = lerpResult63.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14201
0;383;1920;645;1675.932;533.3615;1.622383;True;True
Node;AmplifyShaderEditor.ObjectToWorldMatrixNode;8;-2328.496,7.063111;Float;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.PosVertexDataNode;1;-2317.324,73.90824;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-2123.747,8.902451;Float;False;2;2;0;FLOAT4x4;0.0;False;1;FLOAT3;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-2019.659,190.6284;Float;False;Property;_Lines;Lines;1;0;Create;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;10;-2002.995,8.83268;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-1761.717,6.847914;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-1547.904,37.94069;Float;False;Property;_Speed;Speed;0;0;Create;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;34;-1417.465,137.4938;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;2.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;14;-1417.009,41.14113;Float;False;1;0;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;13;-1222.598,-84.08303;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;-1222.999,4.562035;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;3;-1110.622,-84.65225;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;35;-1113.663,4.275496;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;50;-1104.171,445.6489;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;4;-1002.766,-84.20092;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;36;-1005.807,4.726828;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;51;-927.1125,444.9624;Float;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;5;-892.4046,-82.92253;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;2.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;37;-895.4455,6.005216;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;4.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DdyOpNode;52;-711.3065,449.562;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DdxOpNode;53;-711.973,512.2158;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;22;-511.4453,-27.73952;Float;False;2;2;0;FLOAT;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CrossProductOpNode;54;-588.3038,467.163;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;17;-516.6161,-193.3083;Float;False;Property;_BaseColor;BaseColor;2;0;Create;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMaxOpNode;70;-374.9539,-30.81744;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;58;-463.3204,327.0999;Float;False;Constant;_Vector0;Vector 0;3;0;Create;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NormalizeNode;56;-447.5952,466.7994;Float;False;1;0;FLOAT3;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;71;-361.8014,148.0396;Float;False;Property;_Intensity;Intensity;3;0;Create;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-217.2986,-57.50913;Float;False;2;2;0;COLOR;0.0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DotProductOpNode;59;-286.2084,379.1339;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;72;-25.96789,-51.51357;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCCompareGreater;61;-175.0708,378.4309;Float;False;4;0;FLOAT;0.0;False;1;FLOAT;0.99;False;2;FLOAT;0.0;False;3;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;63;235.3075,-137.614;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;562.8799,-360.6051;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Hologram;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;False;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexScale;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;9;0;8;0
WireConnection;9;1;1;0
WireConnection;10;0;9;0
WireConnection;12;0;10;1
WireConnection;12;1;11;0
WireConnection;34;0;12;0
WireConnection;14;0;16;0
WireConnection;13;0;12;0
WireConnection;13;1;14;0
WireConnection;30;0;14;0
WireConnection;30;1;34;0
WireConnection;3;0;13;0
WireConnection;35;0;30;0
WireConnection;4;0;3;0
WireConnection;36;0;35;0
WireConnection;51;0;50;0
WireConnection;5;0;4;0
WireConnection;37;0;36;0
WireConnection;52;0;51;0
WireConnection;53;0;51;0
WireConnection;22;0;5;0
WireConnection;22;1;37;0
WireConnection;54;0;52;0
WireConnection;54;1;53;0
WireConnection;70;0;22;0
WireConnection;56;0;54;0
WireConnection;23;0;17;0
WireConnection;23;1;70;0
WireConnection;59;0;58;0
WireConnection;59;1;56;0
WireConnection;72;0;17;0
WireConnection;72;1;23;0
WireConnection;72;2;71;0
WireConnection;61;0;59;0
WireConnection;63;0;17;0
WireConnection;63;1;72;0
WireConnection;63;2;61;0
WireConnection;0;2;63;0
ASEEND*/
//CHKSM=1EA4CE5C69C0EAF1F3B2AE572827ADED34842BC6