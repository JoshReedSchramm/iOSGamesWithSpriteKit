//
//  OpeningScene.m
//  SpaceRun
//
//  Created by Josh Schramm on 7/5/14.
//  Copyright (c) 2014 Greenfield Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OpeningScene.h"
#import "StarField.h"

@interface OpeningScene()
@property (nonatomic, strong) UIView *slantedView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@end

@implementation OpeningScene

- (void)didMoveToView:(SKView *)view
{
    self.backgroundColor = [SKColor blackColor];
    StarField *starField = [StarField node];
    [self addChild:starField];
    
    self.slantedView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.slantedView.opaque = NO;
    self.slantedView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.slantedView];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/500.0;
    transform = CATransform3DRotate(transform, 45.0f * M_PI / 180.0f, 1.0f, 0.0f, 0.0f);
    [self.slantedView.layer setTransform:transform];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectInset(self.view.bounds, 30, 0)];
    self.textView.opaque = NO;
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.textColor = [UIColor yellowColor];
    self.textView.font = [UIFont fontWithName:@"AvenirNext-Medium" size:20];
    self.textView.text = @"A distress call comes in from thousands of light years away. The colony is in jeopardy and needs your help. Enemy ships and a meteor shower threaten the work of the galaxy's greatest scientific minds.\n\n Will you be able to reach them in time to save the research?\n\n Or has the galazy lost it's only hope?";
    self.textView.userInteractionEnabled = NO;
    self.textView.center = CGPointMake(self.size.width / 2 + 15, self.size.height + (self.size.height / 2));
    [self.slantedView addSubview:self.textView];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = @[(id)[[UIColor clearColor] CGColor],
                        (id)[[UIColor whiteColor] CGColor]];
    gradient.startPoint = CGPointMake(0.5, 0.0);
    gradient.endPoint = CGPointMake(0.5, 0.20);
    [self.slantedView.layer setMask:gradient];
    
    [UIView animateWithDuration:20 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.textView.center = CGPointMake(self.size.width / 2, 0 - (self.size.height / 2));
    } completion:^(BOOL finished){
        if (finished) {
            [self endScene];
        }
    }];
    
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endScene)];
    [self.view addGestureRecognizer:self.tapGesture];
}

- (void)endScene
{
    [UIView animateWithDuration:0.3 animations:^{
        self.textView.alpha = 0;
    } completion:^(BOOL finished){
        [self.textView.layer removeAllAnimations];
        NSAssert(self.sceneEndCallback, @"Scene end callback not set.");
        self.sceneEndCallback();
    }];
}

- (void)willMoveFromView:(SKView *)view
{
    [self.view removeGestureRecognizer:self.tapGesture];
    self.tapGesture = nil;
    
    [self.slantedView removeFromSuperview];
    self.slantedView = nil;
    self.textView = nil;
}

@end