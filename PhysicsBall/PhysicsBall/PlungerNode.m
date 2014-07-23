#import "PlungerNode.h"

@interface PlungerNode ()
@property (nonatomic) CGFloat yTouchDelta;
@end

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

- (BOOL)isInContactWithBall:(PinballNode *)ball
{
    SKNode *stick = [self childNodeWithName:@"stick"];
    NSArray *contactedBodies = stick.physicsBody.allContactedBodies;
    return [contactedBodies containsObject:ball.physicsBody];
}

- (void)grabWithTouch:(UITouch *)touch
{
    CGPoint touchPoint = [touch locationInNode:self];
    SKNode *stick = [self childNodeWithName:@"stick"];
    
    self.yTouchDelta = stick.position.y - touchPoint.y;
}

- (void)translateToTouch:(UITouch *)touch
{
    CGPoint point = [touch locationInNode:self];
    SKNode *stick = [self childNodeWithName:@"stick"];
    
    CGFloat newY = point.y + self.yTouchDelta;
    CGFloat plungerHeight = self.size.height;
    
    CGFloat upperY = 0;
    CGFloat lowerY = upperY - plungerHeight + 30;
    
    if (newY > upperY) {
        newY = upperY;
    } else if (newY < lowerY) {
        newY = lowerY;
    }
    
    stick.position = CGPointMake(0, newY);    
}

@end