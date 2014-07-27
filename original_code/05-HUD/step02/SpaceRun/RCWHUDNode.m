/***
 * Excerpted from "Build iOS Games with Sprite Kit",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/pssprite for more book information.
***/
#import "RCWHUDNode.h"

@interface RCWHUDNode ()
@end

@implementation RCWHUDNode

- (instancetype)init
{
    if (self = [super init]) {
        SKNode *scoreGroup = [SKNode node];
        scoreGroup.name = @"scoreGroup";

        SKLabelNode *scoreTitle =
            [SKLabelNode labelNodeWithFontNamed:@"AvenirNext-Medium"];
        scoreTitle.fontSize = 12;
        scoreTitle.fontColor = [SKColor whiteColor];
        scoreTitle.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        scoreTitle.verticalAlignmentMode = SKLabelVerticalAlignmentModeBottom;
        scoreTitle.text = @"SCORE";
        scoreTitle.position = CGPointMake(0, 4);
        [scoreGroup addChild:scoreTitle];

        // ...

        SKLabelNode *scoreValue =
            [SKLabelNode labelNodeWithFontNamed:@"AvenirNext-Bold"];
        scoreValue.fontSize = 20;
        scoreValue.fontColor = [SKColor whiteColor];
        scoreValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        scoreValue.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
        scoreValue.name = @"scoreValue";
        scoreValue.text = @"0";
        scoreValue.position = CGPointMake(0, -4);
        [scoreGroup addChild:scoreValue];

        [self addChild:scoreGroup];


        SKNode *elapsedGroup = [SKNode node];
        elapsedGroup.name = @"elapsedGroup";

        SKLabelNode *elapsedTitle =
            [SKLabelNode labelNodeWithFontNamed:@"AvenirNext-Medium"];
        elapsedTitle.fontSize = 12;
        elapsedTitle.fontColor = [SKColor whiteColor];
        elapsedTitle.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        elapsedTitle.verticalAlignmentMode = SKLabelVerticalAlignmentModeBottom;
        elapsedTitle.text = @"TIME";
        elapsedTitle.position = CGPointMake(0, 4);
        [elapsedGroup addChild:elapsedTitle];

        SKLabelNode *elapsedValue =
            [SKLabelNode labelNodeWithFontNamed:@"AvenirNext-Bold"];
        elapsedValue.fontSize = 20;
        elapsedValue.fontColor = [SKColor whiteColor];
        elapsedValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        elapsedValue.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
        elapsedValue.name = @"elapsedValue";
        elapsedValue.text = @"0.0s";
        elapsedValue.position = CGPointMake(0, -4);
        [elapsedGroup addChild:elapsedValue];

        [self addChild:elapsedGroup];
    }
    return self;
}

- (void)layoutForScene
{
    NSAssert(self.scene, @"Cannot be called unless added to a scene");

    CGSize sceneSize = self.scene.size;

    CGSize groupSize = CGSizeZero;

    SKNode *scoreGroup = [self childNodeWithName:@"scoreGroup"];
    groupSize = [scoreGroup calculateAccumulatedFrame].size;
    scoreGroup.position = CGPointMake(0 - sceneSize.width/2 + 20,
                                      sceneSize.height/2 - groupSize.height);

    SKNode *elapsedGroup = [self childNodeWithName:@"elapsedGroup"];
    groupSize = [elapsedGroup calculateAccumulatedFrame].size;
    elapsedGroup.position = CGPointMake(sceneSize.width/2 - 20,
                                        sceneSize.height/2 - groupSize.height);
}

@end
