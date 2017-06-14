//
//  mapView.m
//  MoviesApp
//
//  Created by Bikkina, Venkata Viswa Teja on 11/11/15.
//  Copyright (c) 2015 Mobile_Application_Development. All rights reserved.
//

#import "mapView.h"
#import "MapAnnotations.h"

@interface mapView ()

@end
#define METERS_PER_MILE 1609.344
@implementation mapView

@synthesize uselocation,loading;
NSString *latitude,*longitude,*zip,*ziplat,*ziplong;
 CLLocationManager *locationManager;
NSArray *points;
- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager=[[CLLocationManager alloc] init];
    
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [locationManager requestWhenInUseAuthorization];
    }

    _map.delegate=self;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    // NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocationCoordinate2D zoomLocation;
    CLLocation *currentLocation = newLocation;
    if (currentLocation != nil) {
        longitude= [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        latitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }
    
    zoomLocation.latitude = latitude.doubleValue;
    zoomLocation.longitude= longitude.doubleValue;
 
    double miles = 60.0;
    double scalingFactor = ABS( (cos(2 * M_PI * zoomLocation.latitude / 360.0) ));
    
    MKCoordinateSpan span;
    
    span.latitudeDelta = miles/69.0;
    span.longitudeDelta = miles/(scalingFactor * 69.0);
    
    MKCoordinateRegion region;
    region.span = span;
    region.center = zoomLocation;
    
    [_map setRegion:region animated:YES];
    
    
    for (id<MKAnnotation> annotation in _map.annotations) {
        [_map removeAnnotation:annotation];
    }
    NSString *url = @"https://maps.googleapis.com/maps/api/place/search/json?location=";
    if(latitude!=nil&&longitude!=nil){
        url=[url stringByAppendingString:latitude];
        url=[url stringByAppendingString:@","];
        url=[url stringByAppendingString:longitude];
        url=[url stringByAppendingString:@"&radius=50000&type=movie_theater&sensor=false&key=AIzaSyA3D1XvMFv9q5-tKbT4p6KTGFSm0gLGvlM"];
        // NSLog(@"%@",url);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            points=object[@"results"];
            sleep(2);
            NSString *nextpage=object[@"next_page_token"];
            NSString *url3 = @"https://maps.googleapis.com/maps/api/place/search/json?pagetoken=";
            url3=[url3 stringByAppendingString:nextpage];
            url3=[url3 stringByAppendingString:@"&key=AIzaSyA3D1XvMFv9q5-tKbT4p6KTGFSm0gLGvlM"];
            NSURLRequest *request3 = [NSURLRequest requestWithURL:[NSURL URLWithString:url3]];
            [NSURLConnection sendAsynchronousRequest:request3 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                id object3 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSArray *temp1=object3[@"results"];
                points=[points arrayByAddingObjectsFromArray:temp1];
                for(NSDictionary *each in points)
                {
                    NSNumber *iLat=each[@"geometry"][@"location"][@"lat"];
                    NSNumber *iLong=each[@"geometry"][@"location"][@"lng"];
                    NSString *iName=each[@"name"];
                    NSString *iAddress=each[@"vicinity"];
                    CLLocationCoordinate2D coordinate;
                    coordinate.latitude = iLat.doubleValue;
                    coordinate.longitude = iLong.doubleValue;
                    MapAnnotations *annotation = [[MapAnnotations alloc] initWithName:iName address:iAddress coordinate:coordinate] ;
                    [_map addAnnotation:(id)annotation];
                }
             
             /*   MapAnnotations *annotation = [[MapAnnotations alloc] initWithName:@"Current Location" address:@"" coordinate:zoomLocation] ;
                [_map addAnnotation:(id)annotation];*/
                [loading.view removeFromSuperview];
                
            }];
        
            
        }];
    }
    
    
    [locationManager stopUpdatingLocation];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    bool check=[[NSUserDefaults standardUserDefaults] boolForKey:@"fromSettings"];
    if(check){
        loading=[self.storyboard instantiateViewControllerWithIdentifier:@"lv"];
        
        [self.view addSubview:loading.view];
        [self.view bringSubviewToFront:loading.view];

    uselocation=[[NSUserDefaults standardUserDefaults] boolForKey:@"switchValue"];
    
    if(uselocation){
        [locationManager startUpdatingLocation];
    }
    else
    {
        
       
        zip=[[NSUserDefaults standardUserDefaults] objectForKey:@"zipValue"];
        if(zip!=nil&&![zip isEqual:@""]){
            CLGeocoder *geocoder = [[CLGeocoder alloc] init];
            [geocoder geocodeAddressString:zip completionHandler:^(NSArray *placemarks, NSError *error) {
                //Error checking
                CLLocationCoordinate2D zoomLocation;
                CLPlacemark *placemark = [placemarks objectAtIndex:0];
                CLLocation *loc=placemark.location;
                CLLocationCoordinate2D coordinate=loc.coordinate;
                ziplat=[NSString stringWithFormat:@"%.8f",coordinate.latitude];
                ziplong=[NSString stringWithFormat:@"%.8f",coordinate.longitude];
                zoomLocation.latitude = ziplat.doubleValue;
                zoomLocation.longitude= ziplong.doubleValue;
                
                double miles = 50.0;
                double scalingFactor = ABS( (cos(2 * M_PI * zoomLocation.latitude / 360.0) ));
                
                MKCoordinateSpan span;
                
                span.latitudeDelta = miles/69.0;
                span.longitudeDelta = miles/(scalingFactor * 69.0);
                
                MKCoordinateRegion region;
                region.span = span;
                region.center = zoomLocation;
            //    NSLog(@"lat--%f",zoomLocation.latitude);
              //  NSLog(@"long--%f",zoomLocation.longitude);
                
                [_map setRegion:region animated:YES];
                
                
                for (id<MKAnnotation> annotation in _map.annotations) {
                    [_map removeAnnotation:annotation];
                }
                NSString *url = @"https://maps.googleapis.com/maps/api/place/search/json?location=";
                if(ziplat!=nil&&ziplong!=nil){
                    url=[url stringByAppendingString:ziplat];
                    url=[url stringByAppendingString:@","];
                    url=[url stringByAppendingString:ziplong];
                    url=[url stringByAppendingString:@"&radius=50000&type=movie_theater&sensor=false&key=AIzaSyA3D1XvMFv9q5-tKbT4p6KTGFSm0gLGvlM"];
                    // NSLog(@"%@",url);
                    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
                    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                        points=object[@"results"];
                        sleep(2);
                        NSString *nextpage=object[@"next_page_token"];
                        NSString *url3 = @"https://maps.googleapis.com/maps/api/place/search/json?pagetoken=";
                        url3=[url3 stringByAppendingString:nextpage];
                        url3=[url3 stringByAppendingString:@"&key=AIzaSyA3D1XvMFv9q5-tKbT4p6KTGFSm0gLGvlM"];
                        NSURLRequest *request3 = [NSURLRequest requestWithURL:[NSURL URLWithString:url3]];
                        [NSURLConnection sendAsynchronousRequest:request3 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                            id object3 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                            NSArray *temp1=object3[@"results"];
                            points=[points arrayByAddingObjectsFromArray:temp1];
                        for(NSDictionary *each in points)
                        {
                            NSNumber *iLat=each[@"geometry"][@"location"][@"lat"];
                            NSNumber *iLong=each[@"geometry"][@"location"][@"lng"];
                            NSString *iName=each[@"name"];
                            NSString *iAddress=each[@"vicinity"];
                            CLLocationCoordinate2D coordinate;
                            coordinate.latitude = iLat.doubleValue;
                            coordinate.longitude = iLong.doubleValue;
                            MapAnnotations *annotation = [[MapAnnotations alloc] initWithName:iName address:iAddress coordinate:coordinate] ;
                            [_map addAnnotation:(id)annotation];
                        }
                        [loading.view removeFromSuperview];
                    }];
                    }];
                }
            }];
        }
        

    }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[MapAnnotations class]]) {
        
        MKAnnotationView *annotationView = (MKAnnotationView *) [_map dequeueReusableAnnotationViewWithIdentifier:identifier];
        annotationView=nil;
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
      annotationView.image = [UIImage imageNamed:@"pin.png"];
         //   NSLog(@"%d",(int)uselocation);
            if(uselocation){
                UIButton *detailButton=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [detailButton setImage:[UIImage imageNamed:@"car.png"] forState:UIControlStateNormal];
                annotationView.rightCalloutAccessoryView =detailButton;
              
            }

          //  }
            
          
        }
        else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    MapAnnotations *location = (MapAnnotations*)view.annotation;
        NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
    [location.mapItem openInMapsWithLaunchOptions:launchOptions];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
