//
//  OpeningScene.h
//  SpaceRun
//
//  Created by Josh Schramm on 7/5/14.
//  Copyright (c) 2014 Greenfield Consulting. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface OpeningScene : SKScene
@property (nonatomic, copy) dispatch_block_t sceneEndCallback;
@end

