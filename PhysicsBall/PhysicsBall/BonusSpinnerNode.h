#import <SpriteKit/SpriteKit.h>

@interface BonusSpinnerNode : SKSpriteNode

+ (instancetype)bonusSpinnerNode;
- (void)spin;

@property (nonatomic, readonly) BOOL stillSpinning;

@end