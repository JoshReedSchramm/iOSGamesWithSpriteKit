#import <SpriteKit/SpriteKit.h>

@interface SKEmitterNode (Extensions)
+ (SKEmitterNode *)rcw_nodeWithFile:(NSString *)filename;
- (void)rcw_dieOutInDuration:(NSTimeInterval)duration;
@end