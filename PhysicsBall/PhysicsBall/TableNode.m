#import "TableNode.h"

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

@end