//
//  ActivityIndicator.h
//  MoviesApp
//
//  Created by chitrangadh reddy pisati on 11/18/15.
//  Copyright (c) 2015 Mobile_Application_Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ActivityIndicator : UIView
{
    float dotRadius;
    int stepNumber;
    BOOL isAnimating;
    CGRect firstPoint, secondPoint, thirdPoint, fourthPoint;
    CALayer *firstDot, *secondDot, *thirdDot;
    NSTimer *timer;
}

@property (nonatomic) BOOL hidesWhenStopped;
@property (nonatomic) UIColor *color;

-(void)startAnimating;
-(void)stopAnimating;
-(BOOL)isAnimating;


@end