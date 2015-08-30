//
//  MainViewController.h
//  GLParticle1
//
//  Created by 한상우 on 2015. 8. 21..
//  Copyright (c) 2015년 한상우. All rights reserved.
//

#import <GLKit/GLKit.h>

#import "EmitterShader.h"
#import "SnowShader.h"

@interface MainViewController : GLKViewController

@property (strong) EmitterShader* emitterShader;
@property (strong) SnowShader* snowShader;

- (void)drawDefaultEmitter:(GLKView*) view;
- (void)drawSnowEmitter:(GLKView*) view;

@end
