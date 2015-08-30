#import <GLKit/GLKit.h>

@interface EmitterShader : NSObject

// Program Handle
@property (readwrite) GLint program;

// Attribute Handles
@property (readwrite) GLint aTheta;

// Uniform Handles
@property (readwrite) GLint uProjectionMatrix;
@property (readwrite) GLint uK;

@property (readwrite) GLint uTime;

// Methods
- (void)loadShader;

@end