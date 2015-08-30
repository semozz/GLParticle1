//
//  ShaderProcessor.h
//  GLParticle1
//
//  Created by 한상우 on 2015. 8. 21..
//  Copyright (c) 2015년 한상우. All rights reserved.
//

#import <GLKit/GLKit.h>

#define STRINGIFY(A) #A

@interface ShaderProcessor : NSObject

- (GLuint)BuildProgram:(const char*)vertextShaderSource with:(const char*)fragmentShaderSource;
- (GLuint)BuildShader:(const char*)source with:(GLenum)shaderType;

@end
