//
//  mapView.h
//  MoviesApp
//
//  Created by Bikkina, Venkata Viswa Teja on 11/11/15.
//  Copyright (c) 2015 Mobile_Application_Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface mapView : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
{
    
}
@property UIViewController *loading;
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property BOOL uselocation;
@end
