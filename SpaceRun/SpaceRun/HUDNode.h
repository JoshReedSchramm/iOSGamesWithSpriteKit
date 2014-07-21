//
//  HUDNode.h
//  SpaceRun
//
//  Created by Josh Schramm on 7/5/14.
//  Copyright (c) 2014 Greenfield Consulting. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface HUDNode : SKNode
- (void)layoutForScene;

- (void)addPoints:(NSInteger)points;
- (void)startGame;
- (void)endGame;

- (void)showPowerupTimer:(NSTimeInterval) time;

@property (nonatomic) NSTimeInterval elapsedTime;
@property (nonatomic) NSInteger score;
@end