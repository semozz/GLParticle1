//
//  EmitterTemplate.h
//  GLParticle1
//
//  Created by 한상우 on 2015. 8. 21..
//  Copyright (c) 2015년 한상우. All rights reserved.
//

#ifndef __GLParticle1__EmitterTemplate__
#define __GLParticle1__EmitterTemplate__

#include <stdio.h>

#define NUM_PARTICLES 360

typedef struct Particle
{
	float theta;
}
Particle;

typedef struct Emitter
{
	Particle particles[NUM_PARTICLES];
	int k;
}
Emitter;

Emitter emitter = {0.0f};

#endif /* defined(__GLParticle1__EmitterTemplate__) */
