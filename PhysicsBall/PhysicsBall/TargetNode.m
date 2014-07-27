#import "TargetNode.h"
#import "CategoriesMask.h"

@implementation TargetNode

+ (instancetype)targetWithRadius:(CGFloat)radius
{
    TargetNode *target = [self spriteNodeWithImageNamed:@"target"];
    target.size = CGSizeMake(radius * 2, radius * 2);
    target.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
    target.physicsBody.categoryBitMask = CategoryTarget;
    target.physicsBody.contactTestBitMask = CategoryBall;
    target.physicsBody.dynamic = NO;
    target.physicsBody.restitution = 2;
    
    return target;
}

@end