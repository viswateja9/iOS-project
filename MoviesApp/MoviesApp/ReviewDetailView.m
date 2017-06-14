//
//  ReviewDetailView.m
//  MoviesApp
//
//  Created by Bikkina, Venkata Viswa Teja on 12/7/15.
//  Copyright (c) 2015 Mobile_Application_Development. All rights reserved.
//

#import "ReviewDetailView.h"
#import "LoadingView.h"

@interface ReviewDetailView ()

@end

@implementation ReviewDetailView
@synthesize webView,url,loading,barTitle;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    barTitle=[barTitle stringByAppendingString:@" Review"];
    self.title=barTitle;
    loading=[self.storyboard instantiateViewControllerWithIdentifier:@"lv"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.view addSubview:loading.view];
    [self.view bringSubviewToFront:loading.view];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
   [loading.view removeFromSuperview];
}
@end
