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

@end
