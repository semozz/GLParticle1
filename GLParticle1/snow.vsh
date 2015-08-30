// Vertex Shader

static const char* SnowVS = STRINGIFY
(
 precision mediump float;
 
    attribute vec2 aPosition;
    attribute float a_PointSize;
	attribute float aAlpha;
	attribute float aWeight;
 
	attribute vec4 color;

    uniform mat4 uProjectionMatrix;
	uniform float uTime;
	uniform float uGravity;
	uniform vec2 uScreenSize;
 
	varying vec4 v_fragmentColor;
	varying vec2 v_texCoord;
	varying float elapsedTime;
 
	void main()
	{
		elapsedTime += uTime;
		float yPos = aPosition.y - (elapsedTime * uGravity * aWeight);
		float xPos = aPosition.x + sin(uTime * aWeight) * 0.1;
        vec4 temp = vec4(xPos, yPos, 0.0, 1.0);
		
		vec4 resultPos = uProjectionMatrix * temp;
		
		//resultPos.y = 0.0;
		//resultPos.x = -1.0;
		
		gl_Position = resultPos;
        gl_PointSize = a_PointSize;

		//v_fragmentColor = vec4(1.0, 1.0, 1.0, 0.5);
		v_texCoord = vec2(aAlpha, aAlpha);
	}
);
