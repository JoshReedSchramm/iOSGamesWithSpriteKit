//
//  GameOverNode.m
//  SpaceRun
//
//  Created by Josh Schramm on 7/5/14.
//  Copyright (c) 2014 Greenfield Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameOverNode.h"

@implementation GameOverNode

- (instancetype) init {
    if (self = [super init]) {
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext-Heavy"];
        label.fontColor = [SKColor whiteColor];
        label.fontSize = 32;
        label.text = @"Game Over";
        [self addChild:label];
        
        label.alpha = 0;
        label.xScale = 0.2;
        label.yScale = 0.2;
        
        SKAction *fadeIn = [SKAction fadeAlphaTo:1 duration:2];
        SKAction *scaleIn = [SKAction scaleTo:1 duration:2];
        SKAction *fadeAndScale = [SKAction group:@[fadeIn, scaleIn]];
        [label runAction:fadeAndScale];
        
        SKLabelNode *instructions = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext-Medium"];
        instructions.fontSize = 14;
        instructions.fontColor = [SKColor whiteColor];
        instructions.text = @"Tap to try again.";
        instructions.position = CGPointMake(0, -45);
        [self addChild:instructions];
        
        instructions.alpha = 0;
        SKAction *wait = [SKAction waitForDuration:4];
        SKAction *appear = [SKAction fadeAlphaTo:1 duration:0.2];
        SKAction *popUp = [SKAction scaleTo:1.1 duration:0.1];
        SKAction *dropDown = [SKAction scaleTo:1 duration:0.1];
        SKAction *pauseAndAppear = [SKAction sequence:@[wait, appear, popUp, dropDown]];
        [instructions runAction:pauseAndAppear];
    }
    return self;
}


@end