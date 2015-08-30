//
//  EmitterShader.m
//  GLParticle1
//
//  Created by 한상우 on 2015. 8. 21..
//  Copyright (c) 2015년 한상우. All rights reserved.
//

#import "EmitterShader.h"

#import "ShaderProcessor.h"

// Shaders
#include "Emitter.vsh"
#include "Emitter.fsh"

@implementation EmitterShader

- (void)loadShader
{
	// Program
	ShaderProcessor* shaderProcessor = [[ShaderProcessor alloc] init];
	self.program = [shaderProcessor BuildProgram:EmitterVS with:EmitterFS];
	
	// Attributes
	self.aTheta = glGetAttribLocation(self.program, "aTheta");
 
	// Uniforms
	self.uProjectionMatrix = glGetUniformLocation(self.program, "uProjectionMatrix");
	self.uK = glGetUniformLocation(self.program, "uK");
	
	self.uTime = glGetUniformLocation(self.program, "uTime");
	
}

@end
