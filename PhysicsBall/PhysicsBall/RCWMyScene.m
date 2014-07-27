 /***
 * Excerpted from "Build iOS Games with Sprite Kit",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/pssprite for more book information.
***/
#import "RCWMyScene.h"
#import "PinballNode.h"
#import "PlungerNode.h"
#import "TableNode.h"
#import "PaddleNode.h"
#import "HUDNode.h"

@interface RCWMyScene() <SKPhysicsContactDelegate>

@property (nonatomic, weak) UITouch *plungerTouch;
@property (nonatomic, weak) UITouch *leftPaddleTouch;
@property (nonatomic, weak) UITouch *rightPaddleTouch;

@end

@implementation RCWMyScene

- (id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        [self setUpScene];
    }
    return self;
}

- (void)setUpScene
{
    self.backgroundColor = [SKColor whiteColor];
    
    self.physicsWorld.gravity = CGVectorMake(0, -3.8);
    
    self.physicsWorld.contactDelegate = self;
    
    TableNode *table = [TableNode table];
    table.name = @"table";
    table.position = CGPointMake(0, 0);
    [self addChild:table];
    
    [table loadLayoutNamed:@"layout"];
    
    PlungerNode *plunger = [PlungerNode plunger];
    plunger.name = @"plunger";
    plunger.position = CGPointMake(self.size.width  - plunger.size.width/ 2 - 4, plunger.size.height / 2);
    [table addChild:plunger];
    
    PinballNode *ball = [PinballNode ball];
    ball.name = @"ball";
    ball.position = CGPointMake(plunger.position.x, plunger.position.y + plunger.size.height);
    [table addChild:ball];
    
    PaddleNode *leftPaddle = [PaddleNode paddleForSide:PaddleLeftSide];
    leftPaddle.name = @"leftPaddle";
    leftPaddle.position = CGPointMake(9, 100);
    [table addChild:leftPaddle];
    
    [leftPaddle createPinJointInWorld];
    
    PaddleNode *rightPaddle = [PaddleNode paddleForSide:PaddleRightSide];
    rightPaddle.name = @"rightPaddle";
    rightPaddle.position = CGPointMake(plunger.position.x - plunger.size.width - 1, 100);
    [table addChild:rightPaddle];
    
    [rightPaddle createPinJointInWorld];
    
    HUDNode *hud = [HUDNode hud];
    hud.name = @"hud";
    hud.position = CGPointMake(self.size.width / 2, self.size.height / 2);
    [self addChild:hud];
    [hud layoutForScene];    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    PinballNode *ball = (id)[self childNodeWithName:@"//ball"];
    PlungerNode *plunger = (id)[self childNodeWithName:@"//plunger"];
    
    if (self.plungerTouch == nil && [plunger isInContactWithBall:ball]) {
        UITouch *touch = [touches anyObject];
        self.plungerTouch = touch;
        [plunger grabWithTouch:touch holdingBall:ball inWorld:self.physicsWorld];
    } else {
        for (UITouch *touch in touches) {
            CGPoint where = [touch locationInNode:self];
            if (where.x < self.size.width / 2) {
                self.leftPaddleTouch = touch;
            } else {
                self.rightPaddleTouch = touch;
            }
        }
    }
}

- (void)didSimulatePhysics
{
    TableNode *table = (id)[self childNodeWithName:@"table"];
    PinballNode *ball = (id)[table childNodeWithName:@"ball"];
    PlungerNode *plunger = (id)[table childNodeWithName:@"plunger"];

    if (self.plungerTouch) {
        [plunger translateToTouch:self.plungerTouch];
    }
    
    [table followPositionOfBall:ball];
    
    if (ball.position.y < -500)
    {
        ball.position = CGPointMake(plunger.position.x, plunger.position.y + plunger.size.height);
        ball.physicsBody.velocity = CGVectorMake(0, 0);
        ball.physicsBody.angularVelocity = 0;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches containsObject:self.plungerTouch]) {
        PlungerNode *plunger = (id)[self childNodeWithName:@"//plunger"];
        [plunger letGoAndLaunchBall:self.physicsWorld];
    }
}

- (void)update:(NSTimeInterval)currentTime
{
    if (self.leftPaddleTouch) {
        PaddleNode *leftPaddle = (id)[self childNodeWithName:@"//leftPaddle"];
        [leftPaddle flip];
    }
    if (self.rightPaddleTouch) {
        PaddleNode *rightPaddle = (id)[self childNodeWithName:@"//rightPaddle"];
        [rightPaddle flip];
    }
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    NSLog(@"In -didBeginContact:");
    NSLog(@"bodyA: %@", contact.bodyA);
    NSLog(@"bodyB: %@", contact.bodyB);
}

@end
