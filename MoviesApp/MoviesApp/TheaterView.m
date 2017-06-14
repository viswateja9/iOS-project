//
//  TheaterView.m
//  MoviesApp
//
//  Created by chitrangadh reddy pisati on 10/24/15.
//  Copyright (c) 2015 Mobile_Application_Development. All rights reserved.
//

#import "TheaterView.h"
#import "LocationSettings.h"
@implementation TheaterView
{
    CLLocationManager *locationManager;
}

@synthesize theaters,theaterTable,uselocation,latitude,longitude,alltheaters,fivemiles,fivetoten,morethanten,lessthanfifty,lessthanfive,lessthanten,zip,ziplat,ziplong,loading;

-(void)viewDidLoad{
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"switchValue"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"fromSettings"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    locationManager=[[CLLocationManager alloc] init];
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [locationManager requestWhenInUseAuthorization];
    }
   // UIView * loading = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    
   }

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
   // NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
  // NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    if (currentLocation != nil) {
        longitude= [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        latitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }
    [locationManager stopUpdatingLocation];
    
    NSString *url = @"https://maps.googleapis.com/maps/api/place/search/json?location=";
    
    url=[url stringByAppendingString:latitude];
    url=[url stringByAppendingString:@","];
    url=[url stringByAppendingString:longitude];
    url=[url stringByAppendingString:@"&radius=8100&type=movie_theater&sensor=false&key=AIzaSyA3D1XvMFv9q5-tKbT4p6KTGFSm0gLGvlM"];
   // NSLog(@"%@",url);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
     //   NSLog(@"%@",object);
        self.lessthanfive=object[@"results"];
        //NSLog(@"less than5-%lu",(unsigned long)lessthanfive.count);
        //second req
        NSString *url1 = @"https://maps.googleapis.com/maps/api/place/search/json?location=";
        url1=[url1 stringByAppendingString:latitude];
        url1=[url1 stringByAppendingString:@","];
        url1=[url1 stringByAppendingString:longitude];
        url1=[url1 stringByAppendingString:@"&radius=16000&type=movie_theater&sensor=false&key=AIzaSyA3D1XvMFv9q5-tKbT4p6KTGFSm0gLGvlM"];
        NSURLRequest *request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:url1]];
        [NSURLConnection sendAsynchronousRequest:request1 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            id object1 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            //   NSLog(@"%@",object);
            self.lessthanten=object1[@"results"];
         //   NSLog(@"less than ten--%lu",(unsigned long)self.lessthanten.count);
            //third req
            NSString *url2 = @"https://maps.googleapis.com/maps/api/place/search/json?location=";
            
            url2=[url2 stringByAppendingString:latitude];
            url2=[url2 stringByAppendingString:@","];
            url2=[url2 stringByAppendingString:longitude];
            url2=[url2 stringByAppendingString:@"&radius=500000&type=movie_theater&sensor=false&key=AIzaSyA3D1XvMFv9q5-tKbT4p6KTGFSm0gLGvlM"];
            NSURLRequest *request2 = [NSURLRequest requestWithURL:[NSURL URLWithString:url2]];
            [NSURLConnection sendAsynchronousRequest:request2 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                id object2 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                NSArray *temp=object2[@"results"];
                sleep(2);
                                NSString *nextpage=object2[@"next_page_token"];
                NSString *url3 = @"https://maps.googleapis.com/maps/api/place/search/json?pagetoken=";
                url3=[url3 stringByAppendingString:nextpage];
                url3=[url3 stringByAppendingString:@"&key=AIzaSyA3D1XvMFv9q5-tKbT4p6KTGFSm0gLGvlM"];
                NSURLRequest *request3 = [NSURLRequest requestWithURL:[NSURL URLWithString:url3]];
                [NSURLConnection sendAsynchronousRequest:request3 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                    id object3 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                   NSArray *temp1=object3[@"results"];
                    lessthanfifty=[temp arrayByAddingObjectsFromArray:temp1];
             NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT (SELF.vicinity IN %@)",[lessthanfive valueForKey:@"vicinity"]];
              fivetoten = [lessthanten filteredArrayUsingPredicate:predicate];
                 //  NSLog(@"five to ten--%lu",(unsigned long)fivetoten.count);
                NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"NOT (SELF.vicinity IN %@)",[lessthanten valueForKey:@"vicinity"]];
               morethanten = [lessthanfifty filteredArrayUsingPredicate:predicate1];

             //  NSLog(@"more than ten--%lu",(unsigned long)morethanten.count);
        
                  [loading.view removeFromSuperview];
                  // NSLog(@"Removed subview");
                  loading=nil;
        [self.theaterTable reloadData];
                }];
            }];
            
        }];
    }];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
 
    switch (section) {
        case 0:
            return lessthanfive.count;
            break;
        case 1:
            return fivetoten.count;
            break;
        case 2:
            return morethanten.count;
            break;
        default:
            return 1;
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"WITHIN 5 MILES";
            break;
        case 1:
            return @"WITHIN 10 MILES";
            break;
        case 2:
            return @"FARTHER THAN 10 MILES";
            break;
        default:
            return @"";
            break;
    }
    
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath section]==0&&[indexPath row] == 1){
        //end of loading
        //for example [activityIndicator stopAnimating];
       // NSLog(@"%ld",(long)indexPath.row);
        
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    UITableViewCell *cell = [theaterTable dequeueReusableCellWithIdentifier:@"myCell"];
    NSDictionary *theater;
    switch (indexPath.section) {
        case 0:
            theater=lessthanfive[indexPath.row];
            cell.detailTextLabel.text=theater[@"vicinity"];
            cell.textLabel.text=theater[@"name"];
            return cell;
            break;
        case 1:
            theater=fivetoten[indexPath.row];
            cell.detailTextLabel.text=theater[@"vicinity"];
            cell.textLabel.text=theater[@"name"];
            return cell;
            break;
        case 2:
            theater=morethanten[indexPath.row];
            cell.detailTextLabel.text=theater[@"vicinity"];
            cell.textLabel.text=theater[@"name"];
            return cell;
            break;
            
        default:
            return cell;
            break;
            
    }
    
   
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Do some stuff when the row is selected
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"t2s"]) {
        if(!uselocation)
        {
            LocationSettings *ls=[segue destinationViewController];
            ls.zip.text=zip;
        }
        
    
   }
}


-(void)viewWillAppear:(BOOL)animated {
    bool check=[[NSUserDefaults standardUserDefaults] boolForKey:@"fromSettings"];
    if(check){
        loading=[self.storyboard instantiateViewControllerWithIdentifier:@"lv"];

        [self.view addSubview:loading.view];
        [self.view bringSubviewToFront:loading.view];
      //  NSLog(@"added subview");
    uselocation=[[NSUserDefaults standardUserDefaults] boolForKey:@"switchValue"];
    if(uselocation)
    {
     [locationManager startUpdatingLocation];
        [self.theaterTable reloadData];
        theaterTable.hidden=false;
    }
    else
    {
        zip=[[NSUserDefaults standardUserDefaults] objectForKey:@"zipValue"];
        if(zip!=nil&&![zip isEqual:@""]){
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder geocodeAddressString:zip completionHandler:^(NSArray *placemarks, NSError *error) {
            //Error checking
            
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            CLLocation *loc=placemark.location;
            CLLocationCoordinate2D coordinate=loc.coordinate;
            ziplat=[NSString stringWithFormat:@"%.8f",coordinate.latitude];
           ziplong=[NSString stringWithFormat:@"%.8f",coordinate.longitude];
            [self theatersByZip];
            [self.theaterTable reloadData];
        }];
        }
        else
            [loading.view removeFromSuperview];
      // theaterTable.hidden=true;
    }
    }
}
-(void)theatersByZip
{
    [locationManager stopUpdatingLocation];
    NSString *url = @"https://maps.googleapis.com/maps/api/place/search/json?location=";
    
    url=[url stringByAppendingString:ziplat];
    url=[url stringByAppendingString:@","];
    url=[url stringByAppendingString:ziplong];
    url=[url stringByAppendingString:@"&radius=8100&type=movie_theater&sensor=false&key=AIzaSyA3D1XvMFv9q5-tKbT4p6KTGFSm0gLGvlM"];
    // NSLog(@"%@",url);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        //   NSLog(@"%@",object);
        self.lessthanfive=object[@"results"];
       // NSLog(@"less than5-%lu",(unsigned long)lessthanfive.count);
        //second req
        NSString *url1 = @"https://maps.googleapis.com/maps/api/place/search/json?location=";
        url1=[url1 stringByAppendingString:ziplat];
        url1=[url1 stringByAppendingString:@","];
        url1=[url1 stringByAppendingString:ziplong];
        url1=[url1 stringByAppendingString:@"&radius=16000&type=movie_theater&sensor=false&key=AIzaSyA3D1XvMFv9q5-tKbT4p6KTGFSm0gLGvlM"];
        NSURLRequest *request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:url1]];
        [NSURLConnection sendAsynchronousRequest:request1 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            id object1 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            //   NSLog(@"%@",object);
            self.lessthanten=object1[@"results"];
          //  NSLog(@"less than ten--%lu",(unsigned long)self.lessthanten.count);
            //third req
            NSString *url2 = @"https://maps.googleapis.com/maps/api/place/search/json?location=";
            
            url2=[url2 stringByAppendingString:ziplat];
            url2=[url2 stringByAppendingString:@","];
            url2=[url2 stringByAppendingString:ziplong];
            url2=[url2 stringByAppendingString:@"&radius=500000&type=movie_theater&sensor=false&key=AIzaSyA3D1XvMFv9q5-tKbT4p6KTGFSm0gLGvlM"];
            NSURLRequest *request2 = [NSURLRequest requestWithURL:[NSURL URLWithString:url2]];
            [NSURLConnection sendAsynchronousRequest:request2 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                id object2 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                NSArray *temp=object2[@"results"];
                sleep(2);
                NSString *nextpage=object2[@"next_page_token"];
                NSString *url3 = @"https://maps.googleapis.com/maps/api/place/search/json?pagetoken=";
                url3=[url3 stringByAppendingString:nextpage];
                url3=[url3 stringByAppendingString:@"&key=AIzaSyA3D1XvMFv9q5-tKbT4p6KTGFSm0gLGvlM"];
                NSURLRequest *request3 = [NSURLRequest requestWithURL:[NSURL URLWithString:url3]];
                [NSURLConnection sendAsynchronousRequest:request3 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                    id object3 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    NSArray *temp1=object3[@"results"];
                    lessthanfifty=[temp arrayByAddingObjectsFromArray:temp1];
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT (SELF.vicinity IN %@)",[lessthanfive valueForKey:@"vicinity"]];
                    fivetoten = [lessthanten filteredArrayUsingPredicate:predicate];
                  //  NSLog(@"five to ten--%lu",(unsigned long)fivetoten.count);
                    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"NOT (SELF.vicinity IN %@)",[lessthanten valueForKey:@"vicinity"]];
                    morethanten = [lessthanfifty filteredArrayUsingPredicate:predicate1];
                    
                  //  NSLog(@"more than ten--%lu",(unsigned long)morethanten.count);
                    [loading.view removeFromSuperview];
                    loading=nil;
                  [self.theaterTable reloadData];
                   
                }];
            }];
            
        }];
    }];
    
    

    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"fromSettings"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}




@end
