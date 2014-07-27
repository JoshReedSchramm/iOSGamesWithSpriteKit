#import "BumperNode.h"

@implementation BumperNode

+ (instancetype)bumperWithSize:(CGSize)size
{
    BumperNode *bumper = [self spriteNodeWithImageNamed:@"bumper"];
    bumper.size = size;
    
    bumper.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:size];
    bumper.physicsBody.dynamic = NO;
    bumper.physicsBody.restitution = 2;
    
    return bumper;
}

@end