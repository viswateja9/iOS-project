//
//  SynopsisDetailView.m
//  MoviesApp
//
//  Created by chitrangadh reddy pisati on 10/28/15.
//  Copyright (c) 2015 Mobile_Application_Development. All rights reserved.
//

#import "SynopsisDetailView.h"

@interface SynopsisDetailView ()

@end

@implementation SynopsisDetailView

@synthesize moviepass,synopsis;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 17;
    synopsis.text=moviepass[@"synopsis"];

    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
