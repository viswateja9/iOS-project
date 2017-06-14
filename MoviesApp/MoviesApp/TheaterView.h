//
//  TheaterView.h
//  MoviesApp
//
//  Created by chitrangadh reddy pisati on 10/24/15.
//  Copyright (c) 2015 Mobile_Application_Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LoadingView.h"

@interface TheaterView : UIViewController<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
{
    NSArray *theaters,*alltheaters,*fivemiles,*fivetoten,*morethanten,*lessthanfive,*lessthanten,*lessthanfifty;
   BOOL uselocation;
}

@property (weak, nonatomic) IBOutlet UITableView *theaterTable;

@property(strong,nonatomic) UIViewController *loading;
@property NSString *latitude,*longitude,*ziplat,*ziplong,*zip;

@property(retain,atomic) NSArray *theaters;
@property(retain,atomic) NSArray *alltheaters,*fivemiles,*fivetoten,*morethanten,*lessthanfive,*lessthanten,*lessthanfifty;
@property BOOL uselocation;

@end
