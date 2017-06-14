//
//  ReviewDetailView.h
//  MoviesApp
//
//  Created by Bikkina, Venkata Viswa Teja on 12/7/15.
//  Copyright (c) 2015 Mobile_Application_Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewDetailView : UIViewController<UIWebViewDelegate>
@property NSString *url,*barTitle;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property UIViewController *loading;

@end
