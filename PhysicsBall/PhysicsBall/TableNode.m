#import "TableNode.h"
#import "BumperNode.h"
#import "TargetNode.h"
#import "BonusSpinnerNode.h"

@implementation TableNode

+ (instancetype)table
{
    TableNode *table = [self node];
    
    SKShapeNode *bounds = [SKShapeNode node];
    bounds.strokeColor = [SKColor blackColor];
    [table addChild:bounds];
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(0.5, -10)];
    [bezierPath addCurveToPoint:CGPointMake(1, 700)
                  controlPoint1:CGPointMake(0.5, -10)
                  controlPoint2:CGPointMake(1, 620)];
    [bezierPath addCurveToPoint:CGPointMake(160.5, 880)
                  controlPoint1:CGPointMake(1, 780)
                  controlPoint2:CGPointMake(45.86, 880)];
    [bezierPath addCurveToPoint:CGPointMake(319, 700)
                  controlPoint1:CGPointMake(275.14, 880)
                  controlPoint2:CGPointMake(319, 780)];
    [bezierPath addCurveToPoint:CGPointMake(319.5, -10)
                  controlPoint1:CGPointMake(319, 620)
                  controlPoint2:CGPointMake(319.5, -10)];
    
    bounds.path = bezierPath.CGPath;
    
    bounds.physicsBody = [SKPhysicsBody bodyWithEdgeChainFromPath:bezierPath.CGPath];
    
    return table;
}

- (void)followPositionOfBall:(PinballNode *)ball
{
    CGRect frame = [self calculateAccumulatedFrame];
    CGFloat sceneHeight = self.scene.size.height;
    CGFloat cameraY = ball.position.y - sceneHeight/2;
    
    CGFloat maxY = frame.size.height - sceneHeight;
    CGFloat minY = 0;
    
    if (cameraY < minY) {
        cameraY = minY;
    } else if (cameraY > maxY) {
        cameraY = maxY;
    }
    
    self.position = CGPointMake(0, 0-cameraY);
}

- (void)loadLayoutNamed:(NSString *)name
{
    NSURL *layoutPath = [[NSBundle mainBundle] URLForResource:name withExtension:@"plist"];
    NSDictionary *layout = [NSDictionary dictionaryWithContentsOfURL:layoutPath];
    
    for (NSDictionary *bumperConfig in layout[@"bumpers"])
    {
        CGSize size = CGSizeMake([bumperConfig[@"width"] floatValue], [bumperConfig[@"height"] floatValue]);
        CGPoint position = CGPointMake([bumperConfig[@"x"] floatValue], [bumperConfig[@"y"] floatValue]);
        BumperNode *bumper = [BumperNode bumperWithSize:size];
        bumper.position = position;
        bumper.zRotation = [bumperConfig[@"degrees"] floatValue] * M_PI / 180;
        [self addChild:bumper];
    }
    
    for (NSDictionary *targetConfig in layout[@"targets"])
    {
        CGFloat radius = [targetConfig[@"radius"] floatValue];
        CGPoint position = CGPointMake([targetConfig[@"x"] floatValue], [targetConfig[@"y"] floatValue]);
        TargetNode *target = [TargetNode targetWithRadius:radius];
        target.position = position;
        target.pointValue = [targetConfig[@"pointValue"] floatValue];
        [self addChild:target];
    }
    
    NSDictionary *spinnerConfig = layout[@"bonusSpinner"];
    BonusSpinnerNode *spinner = [BonusSpinnerNode bonusSpinnerNode];
    spinner.name = @"name";
    spinner.position = CGPointMake([spinnerConfig[@"x"] floatValue], [spinnerConfig[@"y"] floatValue]);
    [self addChild:spinner];
}

@end