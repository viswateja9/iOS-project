//
//  CombinedTheaterView.m
//  MoviesApp
//
//  Created by Bikkina, Venkata Viswa Teja on 11/11/15.
//  Copyright (c) 2015 Mobile_Application_Development. All rights reserved.
//

#import "CombinedTheaterView.h"
#import "LocationSettings.h"
@interface CombinedTheaterView ()

@end

@implementation CombinedTheaterView
{
    CLLocationManager *locationManager;
    NSString *latitude,*longitude,*zip;
}
@synthesize mapContainer,listContainer,mailButton,mapicon,listicon,someButton,uselocation;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mapicon = [UIImage imageNamed:@"gmap.png"];
    listicon = [UIImage imageNamed:@"list.png"];
    CGRect frameimg = CGRectMake(0, 0, mapicon.size.width, mapicon.size.height);
   someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:mapicon forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(flipViews)
         forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.leftBarButtonItem=mailbutton;
  
}
-(void)flipViews{
    
    UIView *fromView = nil;
    UIView *toView = nil;
    UIImage *setImage=nil;
    if ([someButton backgroundImageForState:UIControlStateNormal]==mapicon) {
        fromView = [self listContainer];
        toView = [self mapContainer];
        setImage=listicon;
    } else {
        fromView = [self mapContainer];
        toView = [self listContainer];
        setImage=mapicon;
    }
    
    [UIView transitionFromView:fromView
                        toView:toView
                      duration:0.75
                       options:UIViewAnimationOptionShowHideTransitionViews | UIViewAnimationOptionTransitionFlipFromLeft
                    completion:^(BOOL finished) {
                        if(finished)
                        {
                            [someButton setBackgroundImage:setImage forState:UIControlStateNormal];
                        }
                        
                    }];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"t2s"]) {
        uselocation=[[NSUserDefaults standardUserDefaults] boolForKey:@"switchValue"];
        if(!uselocation)
        {
            zip=[[NSUserDefaults standardUserDefaults] objectForKey:@"zipValue"];

            LocationSettings *ls=[segue destinationViewController];
            ls.temp=zip;
            
        }
        
        
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    
}
@end
