//
//  MovieDetailView.h
//  MoviesApp
//
//  Created by Bikkina, Venkata Viswa Teja on 10/25/15.
//  Copyright (c) 2015 Mobile_Application_Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaPlayer/MediaPlayer.h"
#import "LoadingView.h"

@interface MovieDetailView : UIViewController<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSDictionary *moviepass,*key,*moviedetail;
    NSString *tmdbid;
    NSArray *utubekey;
}

@property(strong,nonatomic) UIViewController *loading;
@property (weak, nonatomic) IBOutlet UITableView *detailTable;
@property (nonatomic, strong) MPMoviePlayerController *controller;
@property(nonatomic) NSDictionary *moviepass,*key,*moviedetail ;
@property(retain,atomic) NSString *tmdbid;
@property(retain,atomic) NSArray *utubekey,*allreviews,*genres;
-(void)youtubeTrailer;
@property (strong, nonatomic) IBOutlet UIWebView *webView;


@end
