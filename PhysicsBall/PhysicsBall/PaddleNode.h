#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSInteger, PaddleSide) {
    PaddleLeftSide,
    PaddleRightSide
};

@interface PaddleNode : SKNode

+ (instancetype)paddleForSide:(PaddleSide)paddleSide;
- (void)createPinJointInWorld;
- (void)flip;

@end