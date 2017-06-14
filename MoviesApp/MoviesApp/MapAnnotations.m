//
//  MapAnnotations.m
//  MoviesApp
//
//  Created by chitrangadh reddy pisati on 11/13/15.
//  Copyright (c) 2015 Mobile_Application_Development. All rights reserved.
//

#import "MapAnnotations.h"
@implementation MapAnnotations
@synthesize thename,theaddress,theCoordinate;


- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        if ([name isKindOfClass:[NSString class]]) {
            self.thename = name;
        } else {
            self.thename = @"Unknown charge";
        }
        self.theaddress = address;
        self.theCoordinate = coordinate;
    }
    return self;
}

- (NSString *)title {
    return thename;
}

- (NSString *)subtitle {
    return theaddress;
}

- (CLLocationCoordinate2D)coordinate {
    return theCoordinate;
}

- (MKMapItem*)mapItem {
    
    MKPlacemark *placemark = [[MKPlacemark alloc]
                              initWithCoordinate:self.coordinate
                              addressDictionary:nil];
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name = self.title;
    
    return mapItem;
}
@end
