#import "BumperNode.h"
#import "CategoriesMask.h"

@implementation BumperNode

+ (instancetype)bumperWithSize:(CGSize)size
{
    BumperNode *bumper = [self spriteNodeWithImageNamed:@"bumper"];
    bumper.size = size;
    
    bumper.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:size];
    bumper.physicsBody.categoryBitMask = CategoryBumper;
    bumper.physicsBody.contactTestBitMask = CategoryBall;
    bumper.physicsBody.dynamic = NO;
    bumper.physicsBody.restitution = 2;
    
    return bumper;
}

@end