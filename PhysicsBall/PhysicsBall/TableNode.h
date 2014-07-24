#import <SpriteKit/SpriteKit.h>
#import "PinballNode.h"

@interface TableNode : SKNode

+ (instancetype)table;

- (void)followPositionOfBall:(PinballNode *)ball;

@end