#import "PlungerNode.h"

@implementation PlungerNode

+ (instancetype)plunger
{
    PlungerNode *plunger = [self node];
    plunger.size = CGSizeMake(20, 100);
    
    SKSpriteNode *stick = [SKSpriteNode spriteNodeWithImageNamed:@"plunger.png"];
    stick.name = @"stick";
    stick.size = plunger.size;
    stick.position = CGPointMake(0, 0);
    
    stick.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:plunger.size];
    stick.physicsBody.dynamic = NO;
    stick.physicsBody.restitution = 0;
    
    [plunger addChild:stick];

    return plunger;
}

@end