#import "BonusSpinnerNode.h"
#import "CategoriesMask.h"

@implementation BonusSpinnerNode

+ (instancetype)bonusSpinnerNode
{
    BonusSpinnerNode *spinner = [self spriteNodeWithImageNamed:@"bonus-spinner"];
    spinner.size = CGSizeMake(6, 40);
    spinner.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:spinner.size];
    spinner.physicsBody.affectedByGravity = NO;
    spinner.physicsBody.angularDamping = 0.8;
    spinner.physicsBody.categoryBitMask = CategoryBonusSpinner;
    spinner.physicsBody.contactTestBitMask = CategoryBall;
    spinner.physicsBody.collisionBitMask = 0;
    
    return spinner;
}

- (void)spin
{
    [self.physicsBody applyAngularImpulse:0.003];
}

- (BOOL)stillSpinning
{
    return self.physicsBody.angularVelocity > 0.9;
}

@end