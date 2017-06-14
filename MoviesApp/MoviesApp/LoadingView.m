//
//  LoadingView.m
//  MoviesApp
//
//  Created by chitrangadh reddy pisati on 11/17/15.
//  Copyright (c) 2015 Mobile_Application_Development. All rights reserved.
//

#import "LoadingView.h"
#import "ActivityIndicator.h"

@implementation LoadingView

@synthesize ai;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
  /*ActivityIndicator *activityIndicator = [[ActivityIndicator alloc] initWithFrame:CGRectMake(60, 40, 200, 200)];
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];*/
    ai.image=[UIImage animatedImageNamed:@"dia-" duration:2.0f];
}


@end
