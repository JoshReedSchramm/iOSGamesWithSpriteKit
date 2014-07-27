#import "PinballNode.h"
#import "CategoriesMask.h"

@implementation PinballNode

+ (instancetype)ball {
    CGFloat sideSize = 20;
    PinballNode *node = [self spriteNodeWithImageNamed:@"pinball.png"];
    
    node.size = CGSizeMake(sideSize, sideSize);
    
    node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:sideSize/2];
    node.physicsBody.categoryBitMask = CategoryBall;
    node.physicsBody.restitution = 0.2;
    node.physicsBody.friction = 0.01;
    node.physicsBody.angularDamping = 0.5;
    
    return node;
}

@end