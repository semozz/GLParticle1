//
//  MainViewController.m
//  GLParticle1
//
//  Created by 한상우 on 2015. 8. 21..
//  Copyright (c) 2015년 한상우. All rights reserved.
//

#import "MainViewController.h"
#import "EmitterTemplate.h"
#import "SnowEffect.h"

@implementation MainViewController
{
	int drawType;
	
	float _timeCurrent;
	float _timeMax;
	int _timeDirection;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	//Set up context
	EAGLContext* context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
	[EAGLContext setCurrentContext:context];
	
	//Set up view
	GLKView* view = (GLKView*)self.view;
	view.context = context;
	
	drawType = 1;
	
	_timeCurrent = 0.0f;
	_timeMax = 3.0f;
	_timeDirection = 1;

	switch(drawType)
	{
	case 0:
		{
			// Load Particle System
			[self loadParticles];
			[self loadEmitter];
			
			//Load Shader
			[self loadShader];
		}
		break;
	case 1:
		{
			[self loadSnowParticles:view];
			[self loadSnowEmitter:view];
            
            [self loadSnowShader];
		}
		break;
	}
	
	
}

#pragma mark - GLKViewDelegate
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
	//Set the background color
	glClearColor(0.30f, 0.74f, 0.20f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT);
	
	
	switch(drawType)
	{
		case 0:
			[self drawDefaultEmitter:view];
			break;
		case 1:
			[self drawSnowEmitter:view];
			break;
	}
	
}

- (void)drawDefaultEmitter:(GLKView*) view
{
	float aspectRatio = view.frame.size.width / view.frame.size.height;
	GLKMatrix4 projectionMatrix = GLKMatrix4MakeScale(1.0f, aspectRatio, 1.0f);
	
	glUniformMatrix4fv(self.emitterShader.uProjectionMatrix, 1, 0, projectionMatrix.m);
	glUniform1f(self.emitterShader.uK, emitter.k);
	glUniform1f(self.emitterShader.uTime, (_timeCurrent / _timeMax));
	
	glEnableVertexAttribArray(self.emitterShader.aTheta);
	glVertexAttribPointer(self.emitterShader.aTheta, 1, GL_FLOAT, GL_FALSE, sizeof(Particle), (void*)(offsetof(Particle, theta)));
	
	glDrawArrays(GL_POINTS, 0, NUM_PARTICLES);
	glDisableVertexAttribArray(self.emitterShader.aTheta);
}

- (void)loadParticles
{
	for (int i = 0; i < NUM_PARTICLES; ++i)
	{
		emitter.particles[i].theta = GLKMathDegreesToRadians(i);
	}
	
	//Create vertex Buffer Object(VBO)
	GLuint particleBuffer = 0;
	glGenBuffers(1, &particleBuffer);
	glBindBuffer(GL_ARRAY_BUFFER, particleBuffer);
	glBufferData(GL_ARRAY_BUFFER, sizeof(emitter.particles), emitter.particles, GL_STATIC_DRAW);
	
}

- (void)loadEmitter
{
	emitter.k = 4.0f;
}

#pragma mark - Load Shader
- (void)loadShader
{
	self.emitterShader = [[EmitterShader alloc] init];
	[self.emitterShader loadShader];
	glUseProgram(self.emitterShader.program);
}

- (void)update
{
	switch(drawType)
	{
		case 0:
		{
			if (_timeCurrent > _timeMax)
				_timeDirection = -1;
			else if (_timeCurrent < 0.0f)
				_timeDirection = 1;
		}
			break;
		case 1:
		{
			
		}
			break;
	}
	_timeCurrent += _timeDirection * self.timeSinceLastUpdate;
}


- (void)drawSnowEmitter:(GLKView*) view
{
    float aspectRatio = view.frame.size.width / view.frame.size.height;
    GLKMatrix4 projectionMatrix = GLKMatrix4MakeScale(1.0f, aspectRatio, 1.0f);
    
    glUniformMatrix4fv(self.snowShader.uProjectionMatrix, 1, 0, projectionMatrix.m);
    glUniform1f(self.snowShader.uTime, (_timeCurrent / _timeMax));
	glUniform1f(self.snowShader.uGravity, 9.8f);
	glUniform2f(self.snowShader.uScreenSize, view.frame.size.width, view.frame.size.height);
    
    glEnableVertexAttribArray(self.snowShader.aPosition);
    glVertexAttribPointer(self.snowShader.aPosition, 2, GL_FLOAT, GL_FALSE, sizeof(SnowFlake), (void*)(offsetof(SnowFlake, position)));

    glEnableVertexAttribArray(self.snowShader.aPointSize);
    glVertexAttribPointer(self.snowShader.aPointSize, 1, GL_FLOAT, GL_FALSE, sizeof(SnowFlake), (void*)(offsetof(SnowFlake, pointSize)));

    glEnableVertexAttribArray(self.snowShader.aAlpha);
    glVertexAttribPointer(self.snowShader.aAlpha, 1, GL_FLOAT, GL_FALSE, sizeof(SnowFlake), (void*)(offsetof(SnowFlake, alpha)));
	
	glEnableVertexAttribArray(self.snowShader.aWeight);
	glVertexAttribPointer(self.snowShader.aWeight, 1, GL_FLOAT, GL_FALSE, sizeof(SnowFlake), (void*)(offsetof(SnowFlake, weight)));

    glDrawArrays(GL_POINTS, 0, SNOW_NUM);
    glDisableVertexAttribArray(self.snowShader.aPosition);
    glDisableVertexAttribArray(self.snowShader.aPointSize);
    glDisableVertexAttribArray(self.snowShader.aAlpha);
	glDisableVertexAttribArray(self.snowShader.aWeight);
}

#define BUFFER_OFFSET(i) ((char *)NULL + (i))

- (void)loadSnowParticles:(GLKView*) view
{
	CGSize viewSize = view.frame.size;
	CGSize halfSize = {viewSize.width * 0.5f, viewSize.height * 0.5f};
	
    for (int i = 0; i < SNOW_NUM; ++i)
	{
        float tempx = ((float)(rand() % (int)viewSize.width) - halfSize.width) / viewSize.width;
        float tempy = ((float)(rand() % (int)viewSize.height) - halfSize.height) / viewSize.height;
        snowEmitter.snowflakes[i].position.x = tempx;// % view.frame.size.width;
        snowEmitter.snowflakes[i].position.y = tempy;
		
		float tempWeight = ((float)(rand() % 100)) * 0.01f;
		NSLog(@"Weight : %f", tempWeight);
		snowEmitter.snowflakes[i].weight = tempWeight;

		float alpha = (float)(100 + rand() % 255) / 255.0f;
		//NSLog(@"Alpha value : %f", alpha);
        snowEmitter.snowflakes[i].alpha = alpha;
		
		float pointSize = 10.0f + (rand() % 10);
		//NSLog(@"Point Size : %f", pointSize);
		snowEmitter.snowflakes[i].pointSize = pointSize;
	}

    //Create vertex Buffer Object(VBO)
	GLuint particleBuffer = 0;
	glGenBuffers(1, &particleBuffer);
	glBindBuffer(GL_ARRAY_BUFFER, particleBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(snowEmitter.snowflakes), snowEmitter.snowflakes, GL_STATIC_DRAW);

}

- (void)loadSnowEmitter:(GLKView*) view
{
	//emitter.k = 4.0f;
}

#pragma mark - Load Shader
- (void)loadSnowShader
{
	self.snowShader = [[SnowShader alloc] init];
	[self.snowShader loadShader];
	glUseProgram(self.snowShader.program);
}

@end
