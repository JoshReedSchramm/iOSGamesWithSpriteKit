#import <SpriteKit/SpriteKit.h>

@interface TargetNode : SKSpriteNode

+ (instancetype)targetWithRadius:(CGFloat)radius;
@property (nonatomic) NSInteger pointValue;

@end