//
//  GameScene.h
//  SpaceRun
//

//  Copyright (c) 2014 Greenfield Consulting. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene

@property (nonatomic, copy) dispatch_block_t endGameCallback;
@property (nonatomic) BOOL easyMode;

@end
