//
//  SnowEffect.h
//  GLParticle1
//
//  Created by 한상우 on 2015. 8. 21..
//  Copyright (c) 2015년 한상우. All rights reserved.
//

#ifndef GLParticle1_SnowEffect_h
#define GLParticle1_SnowEffect_h

#define SNOW_NUM 100

typedef struct Vector2f
{
    float x;
    float y;
} Vector2f;

typedef struct Vector3f
{
    float x;
    float y;
    float z;
}Vector3f;

typedef struct Vertext
{
    Vector3f position;
    Vector2f uv;
}Vertex;

typedef struct SnowFlake
{
    Vector2f position;
    float pointSize;
    float alpha;
    float weight;

}SnowFlake;

typedef struct SnowEmitter
{
	SnowFlake snowflakes[SNOW_NUM];
}SnowEmitter;

SnowEmitter snowEmitter;

#endif
