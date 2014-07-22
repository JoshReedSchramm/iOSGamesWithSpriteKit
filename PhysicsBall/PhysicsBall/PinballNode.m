#import "PinballNode.h"

@implementation PinballNode

+ (instancetype)ball {
    CGFloat sideSize = 20;
    PinballNode *node = [self spriteNodeWithImageNamed:@"pinball.png"];
    
    node.size = CGSizeMake(sideSize, sideSize);
    
    node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:sideSize/2];
    node.physicsBody.restitution = 0.2;
    
    return node;
}

@end