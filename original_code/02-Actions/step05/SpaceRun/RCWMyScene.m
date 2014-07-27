/***
 * Excerpted from "Build iOS Games with Sprite Kit",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/pssprite for more book information.
***/
#import "RCWMyScene.h"

@interface RCWMyScene ()
@property (nonatomic, weak) UITouch *shipTouch;
@property (nonatomic) NSTimeInterval lastUpdateTime;
@property (nonatomic) NSTimeInterval lastShotFireTime;
@end

@implementation RCWMyScene

- (id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor blackColor];

        NSString *name = @"Spaceship.png";
        SKSpriteNode *ship = [SKSpriteNode spriteNodeWithImageNamed:name];
        ship.position = CGPointMake(size.width/2, size.height/2);
        ship.size = CGSizeMake(40, 40);
        ship.name = @"ship";
        [self addChild:ship];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.shipTouch = [touches anyObject];
}

- (void)update:(NSTimeInterval)currentTime
{
    if (self.lastUpdateTime == 0) {
        self.lastUpdateTime = currentTime;
    }
    NSTimeInterval timeDelta = currentTime - self.lastUpdateTime;

    if (self.shipTouch) {
        [self moveShipTowardPoint:[self.shipTouch locationInNode:self]
                      byTimeDelta:timeDelta];

        if (currentTime - self.lastShotFireTime > 0.5) {
            [self shoot];
            self.lastShotFireTime = currentTime;
        }
    }

    if (arc4random_uniform(1000) <= 15) {
        [self dropThing];
    }

    [self checkCollisions];

    self.lastUpdateTime = currentTime;
}

- (void)moveShipTowardPoint:(CGPoint)point byTimeDelta:(NSTimeInterval)timeDelta
{
    CGFloat shipSpeed = 130; // points per second
    SKNode *ship = [self childNodeWithName:@"ship"];
    CGFloat distanceLeft = sqrt(pow(ship.position.x - point.x, 2) +
                                pow(ship.position.y - point.y, 2));

    if (distanceLeft > 4) {
        CGFloat distanceToTravel = timeDelta * shipSpeed;

        CGFloat angle = atan2(point.x - ship.position.x,
                              point.y - ship.position.y);
        CGFloat yOffset = distanceToTravel * cos(angle);
        CGFloat xOffset = distanceToTravel * sin(angle);

        ship.position = CGPointMake(ship.position.x + xOffset,
                                    ship.position.y + yOffset);
    }
}

- (void)shoot
{
    SKNode *ship = [self childNodeWithName:@"ship"];

    SKSpriteNode *photon = [SKSpriteNode spriteNodeWithImageNamed:@"photon"];
    photon.name = @"photon";
    photon.position = ship.position;
    [self addChild:photon];

    SKAction *fly = [SKAction moveByX:0
                                    y:self.size.height+photon.size.height
                             duration:0.5];
    SKAction *remove = [SKAction removeFromParent];
    SKAction *fireAndRemove = [SKAction sequence:@[fly, remove]];
    [photon runAction:fireAndRemove];
}

- (void)dropThing {
    u_int32_t dice = arc4random_uniform(100);
    if (dice < 15) {
        [self dropEnemyShip];
    } else {
        [self dropAsteroid];
    }
}

- (void)dropAsteroid
{
    CGFloat sideSize = 15 + arc4random_uniform(30);
    CGFloat maxX = self.size.width;
    CGFloat quarterX = maxX / 4;
    CGFloat startX = arc4random_uniform(maxX + (quarterX * 2)) - quarterX;
    CGFloat startY = self.size.height + sideSize;
    CGFloat endX = arc4random_uniform(maxX);
    CGFloat endY = 0 - sideSize;

    SKSpriteNode *asteroid = [SKSpriteNode spriteNodeWithImageNamed:@"asteroid"];
    asteroid.size = CGSizeMake(sideSize, sideSize);
    asteroid.position = CGPointMake(startX, startY);
    asteroid.name = @"obstacle";
    [self addChild:asteroid];

    SKAction *move = [SKAction moveTo:CGPointMake(endX, endY)
                             duration:3+arc4random_uniform(4)];
    SKAction *remove = [SKAction removeFromParent];
    SKAction *travelAndRemove = [SKAction sequence:@[move, remove]];

    SKAction *spin = [SKAction rotateByAngle:3 duration:arc4random_uniform(2) + 1];
    SKAction *spinForever = [SKAction repeatActionForever:spin];

    SKAction *all = [SKAction group:@[spinForever, travelAndRemove]];
    [asteroid runAction:all];
}

- (void)dropEnemyShip {
    CGFloat sideSize = 30;
    CGFloat startX = arc4random_uniform(self.size.width-40) + 20;
    CGFloat startY = self.size.height + sideSize;

    SKSpriteNode *enemy = [SKSpriteNode spriteNodeWithImageNamed:@"enemy"];
    enemy.size = CGSizeMake(sideSize, sideSize);
    enemy.position = CGPointMake(startX, startY);
    enemy.name = @"obstacle";
    [self addChild:enemy];

    // ...

    CGPathRef shipPath = [self buildEnemyShipMovementPath];

    SKAction *followPath = [SKAction followPath:shipPath
                                       asOffset:YES
                                   orientToPath:YES
                                       duration:7];

    SKAction *remove = [SKAction removeFromParent];

    SKAction *all = [SKAction sequence:@[followPath, remove]];
    [enemy runAction:all];
}

- (CGPathRef)buildEnemyShipMovementPath
{
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(0.5, -0.5)];
    [bezierPath addCurveToPoint: CGPointMake(-2.5, -59.5)
                  controlPoint1: CGPointMake(0.5, -0.5)
                  controlPoint2: CGPointMake(4.55, -29.48)];
    [bezierPath addCurveToPoint: CGPointMake(-27.5, -154.5)
                  controlPoint1: CGPointMake(-9.55, -89.52)
                  controlPoint2: CGPointMake(-43.32, -115.43)];
    [bezierPath addCurveToPoint: CGPointMake(30.5, -243.5)
                  controlPoint1: CGPointMake(-11.68, -193.57)
                  controlPoint2: CGPointMake(17.28, -186.95)];
    [bezierPath addCurveToPoint: CGPointMake(-52.5, -379.5)
                  controlPoint1: CGPointMake(43.72, -300.05)
                  controlPoint2: CGPointMake(-47.71, -335.76)];
    [bezierPath addCurveToPoint: CGPointMake(54.5, -449.5)
                  controlPoint1: CGPointMake(-57.29, -423.24)
                  controlPoint2: CGPointMake(-8.14, -482.45)];
    [bezierPath addCurveToPoint: CGPointMake(-5.5, -348.5)
                  controlPoint1: CGPointMake(117.14, -416.55)
                  controlPoint2: CGPointMake(52.25, -308.62)];
    [bezierPath addCurveToPoint: CGPointMake(10.5, -494.5)
                  controlPoint1: CGPointMake(-63.25, -388.38)
                  controlPoint2: CGPointMake(-14.48, -457.43)];
    [bezierPath addCurveToPoint: CGPointMake(0.5, -559.5)
                  controlPoint1: CGPointMake(23.74, -514.16)
                  controlPoint2: CGPointMake(6.93, -537.57)];
    [bezierPath addCurveToPoint: CGPointMake(-2.5, -644.5)
                  controlPoint1: CGPointMake(-5.2, -578.93)
                  controlPoint2: CGPointMake(-2.5, -644.5)];

    return bezierPath.CGPath;
}

- (void)checkCollisions
{
    SKNode *ship = [self childNodeWithName:@"ship"];

    [self
     enumerateChildNodesWithName:@"obstacle"
     usingBlock:^(SKNode *obstacle, BOOL *stop) {
        if ([ship intersectsNode:obstacle]) {
            self.shipTouch = nil;
            [ship removeFromParent];
            [obstacle removeFromParent];
        }

        [self
         enumerateChildNodesWithName:@"photon"
         usingBlock:^(SKNode *photon, BOOL *stop) {
            if ([photon intersectsNode:obstacle]) {
                [photon removeFromParent];
                [obstacle removeFromParent];
                *stop = YES;
            }
        }];
    }];
}

@end
