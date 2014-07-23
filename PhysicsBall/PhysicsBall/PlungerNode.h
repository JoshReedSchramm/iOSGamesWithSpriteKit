#import <SpriteKit/SpriteKit.h>
#import "PinballNode.h"

@interface PlungerNode : SKNode

@property (nonatomic) CGSize size;
+ (instancetype)plunger;

- (BOOL)isInContactWithBall:(PinballNode *)ball;
- (void)grabWithTouch:(UITouch *)touch;
- (void)translateToTouch:(UITouch *)touch;
- (void)letGoAndLaunchBall;

@end