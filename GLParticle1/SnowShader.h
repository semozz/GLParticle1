//
//  SnowShader.h
//  GLParticle1
//
//  Created by 한상우 on 2015. 8. 21..
//  Copyright (c) 2015년 한상우. All rights reserved.
//

#import <GLKit/GLKit.h>

@interface SnowShader : NSObject

// Program Handle
@property (readwrite) GLint program;

// Attribute
@property (readwrite) GLint aPosition;
@property (readwrite) GLint aPointSize;
@property (readwrite) GLint aAlpha;
@property (readwrite) GLint aWeight;

// Uniform
@property (readwrite) GLint uTime;
@property (readwrite) GLint uProjectionMatrix;
@property (readwrite) GLint uGravity;
@property (readwrite) GLint uScreenSize;

// Methods
- (void)loadShader;

@end
