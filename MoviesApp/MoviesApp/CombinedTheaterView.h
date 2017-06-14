//
//  CombinedTheaterView.h
//  MoviesApp
//
//  Created by Bikkina, Venkata Viswa Teja on 11/11/15.
//  Copyright (c) 2015 Mobile_Application_Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CombinedTheaterView : UIViewController



@property (weak, nonatomic) IBOutlet UIView *listContainer;
@property (weak, nonatomic) IBOutlet UIView *mapContainer;
@property UIBarButtonItem *mailButton;
@property UIImage *mapicon;
@property UIImage *listicon;
@property UIButton *someButton;
@property BOOL uselocation;
@end
