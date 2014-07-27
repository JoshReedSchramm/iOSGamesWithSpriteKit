#import "PaddleNode.h"

@interface PaddleNode()
@property (nonatomic) PaddleSide paddleSide;
@end

CGFloat const PaddleWidth = 120;
CGFloat const PaddleHeight = 20;

@implementation PaddleNode

+ (instancetype)paddleForSide:(PaddleSide)paddleSide
{
    PaddleNode* paddle = [PaddleNode node];
    paddle.paddleSide = paddleSide;
    
    SKSpriteNode *bar = [SKSpriteNode spriteNodeWithImageNamed:@"paddle-box"];
    bar.name = @"bar";
    bar.size = CGSizeMake(PaddleWidth, PaddleHeight);
    [paddle addChild:bar];
    
    SKSpriteNode *anchor = [SKSpriteNode spriteNodeWithImageNamed:@"paddle-anchor"];
    anchor.name = @"anchor";
    anchor.size = CGSizeMake(PaddleHeight, PaddleHeight);
    [paddle addChild:anchor];
    
    if (paddle.paddleSide == PaddleRightSide)
    {
        bar.position = CGPointMake(0-PaddleWidth/2, 0);
        anchor.position = CGPointMake(bar.position.x + bar.size.width/2, 0);
    } else {
        bar.position = CGPointMake(PaddleWidth/2, 0);
        anchor.position = CGPointMake(bar.position.x - bar.size.width/2, 0);
    }
    
    CGFloat anchorRadius = anchor.size.width / 2;
    anchor.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:anchorRadius];
    anchor.physicsBody.dynamic = NO;
    
    bar.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bar.size];
    bar.physicsBody.mass = 0.05;
    bar.physicsBody.restitution = 0.1;
    bar.physicsBody.angularDamping = 0;
    bar.physicsBody.friction = 0.02;
    
    
    return paddle;
}

- (void)createPinJointInWorld
{
    NSAssert(self.scene, @"Can only create joint when placed in scene.");
    
    SKNode *bar = [self childNodeWithName:@"bar"];
    SKNode *anchor = [self childNodeWithName:@"anchor"];
    
    CGPoint positionInScene = [self convertPoint:anchor.position toNode:self.scene];
    SKPhysicsJointPin *pin = [SKPhysicsJointPin jointWithBodyA:bar.physicsBody
                                                         bodyB:anchor.physicsBody
                                                        anchor:positionInScene];
    
    pin.shouldEnableLimits = YES;
    pin.lowerAngleLimit = -0.5;
    pin.upperAngleLimit = 0.5;
    
    [self.scene.physicsWorld addJoint:pin];
}


@end