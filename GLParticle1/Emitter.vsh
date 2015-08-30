// Vertex Shader

static const char* EmitterVS = STRINGIFY
(
 
	// Attributes
	attribute float aTheta;

	// Uniforms
	uniform mat4 uProjectionMatrix;
	uniform float uK;
	uniform float uTime;

	void main(void)
	{
		float x = uTime * cos(uK*aTheta)*sin(aTheta);
		float y = uTime * cos(uK*aTheta)*cos(aTheta);

		gl_Position = uProjectionMatrix * vec4(x, y, 0.0, 1.0);
		gl_PointSize = 16.0;
	}

);