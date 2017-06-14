//
//  MapAnnotations.h
//  MoviesApp
//
//  Created by chitrangadh reddy pisati on 11/13/15.
//  Copyright (c) 2015 Mobile_Application_Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotations : NSObject
{
    
}
@property (nonatomic, copy) NSString *thename;
@property (nonatomic, copy) NSString *theaddress;
@property (nonatomic, assign) CLLocationCoordinate2D theCoordinate;
-(id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;
- (MKMapItem*)mapItem; 

@end
