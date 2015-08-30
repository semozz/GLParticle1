// Fragment Shader

static const char* SnowFS = STRINGIFY
(
 precision mediump float;
 
	varying vec4 v_fragmentColor;
	varying vec2 v_texCoord;
	uniform sampler2D CC_Texture0;

	void main()
	{
		vec4 v4Color = vec4(0.6, 0.3, 0.5, 0.1);
        v4Color = v4Color * v_texCoord.x;
        gl_FragColor = v4Color;
	}
);
