#import <SpriteKit/SpriteKit.h>

@interface HUDNode : SKNode

@property (nonatomic) NSInteger score;
+ (instancetype)hud;
- (void)layoutForScene;
- (void)addPoints:(NSInteger) points;
@end