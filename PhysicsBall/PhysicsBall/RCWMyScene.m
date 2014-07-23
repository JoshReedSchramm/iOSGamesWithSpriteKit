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

@interface RCWMyScene()

@property (nonatomic, weak) UITouch *plungerTouch;

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
    
    PinballNode *ball = [PinballNode ball];
    ball.name = @"ball";
    ball.position = CGPointMake(self.size.width / 2, self.size.height / 2);
    [self addChild:ball];
    
    PlungerNode *plunger = [PlungerNode plunger];
    plunger.name = @"plunger";
    plunger.position = CGPointMake(self.size.width / 2, self.size.height / 2 - 140);
    [self addChild:plunger];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    PinballNode *ball = (id)[self childNodeWithName:@"ball"];
    PlungerNode *plunger = (id)[self childNodeWithName:@"plunger"];
    
    if (self.plungerTouch == nil && [plunger isInContactWithBall:ball]) {
        UITouch *touch = [touches anyObject];
        self.plungerTouch = touch;
        [plunger grabWithTouch:touch holdingBall:ball inWorld:self.physicsWorld];
    }
}

- (void)didSimulatePhysics
{
    if (self.plungerTouch) {
        PlungerNode *plunger = (id)[self childNodeWithName:@"plunger"];
        [plunger translateToTouch:self.plungerTouch];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches containsObject:self.plungerTouch]) {
        PlungerNode *plunger = (id)[self childNodeWithName:@"plunger"];
        [plunger letGoAndLaunchBall:self.physicsWorld];
    }
}

@end
