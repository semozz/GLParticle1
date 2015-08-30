//
//  SnowShader.m
//  GLParticle1
//
//  Created by 한상우 on 2015. 8. 21..
//  Copyright (c) 2015년 한상우. All rights reserved.
//

#import "SnowShader.h"

#import "ShaderProcessor.h"

// Shaders
#define STRINGIFY(A) #A
#include "snow.vsh"
#include "snow.fsh"

@implementation SnowShader

- (void)loadShader
{
	// Program
	ShaderProcessor* shaderProcessor = [[ShaderProcessor alloc] init];
	self.program = [shaderProcessor BuildProgram:SnowVS with:SnowFS];
	
	// Attributes
    self.aPosition = glGetAttribLocation(self.program, "aPosition");
    self.aPointSize = glGetAttribLocation(self.program, "a_PointSize");
    self.aAlpha = glGetAttribLocation(self.program, "aAlpha");
    self.aWeight = glGetAttribLocation(self.program, "aWeight");
    
    // Uniforms
	self.uProjectionMatrix = glGetUniformLocation(self.program, "uProjectionMatrix");
    self.uTime = glGetUniformLocation(self.program, "uTime");
    self.uGravity = glGetUniformLocation(self.program, "uGravity");
    self.uScreenSize = glGetUniformLocation(self.program, "uScreenSize");
}

@end
