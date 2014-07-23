#import <SpriteKit/SpriteKit.h>
#import "PinballNode.h"

@interface PlungerNode : SKNode

@property (nonatomic) CGSize size;
+ (instancetype)plunger;

- (BOOL)isInContactWithBall:(PinballNode *)ball;
- (void)grabWithTouch:(UITouch *)touch holdingBall:(PinballNode *)ball inWorld:(SKPhysicsWorld *)world;
- (void)translateToTouch:(UITouch *)touch;
- (void)letGoAndLaunchBall:(SKPhysicsWorld *)world;

@end