/***
 * Excerpted from "Build iOS Games with Sprite Kit",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/pssprite for more book information.
***/
#import "RCWPlungerNode.h"

@interface RCWPlungerNode ()
@property (nonatomic) CGFloat yTouchDelta;
@end

@implementation RCWPlungerNode

+ (instancetype)plunger
{
    RCWPlungerNode *plunger = [self node];
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

- (BOOL)isInContactWithBall:(RCWPinballNode *)ball
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

- (void)letGoAndLaunchBall
{
    SKNode *stick = [self childNodeWithName:@"stick"];
    SKAction *move = [SKAction moveToY:0 duration:0.02];
    [stick runAction:move];
}

@end
