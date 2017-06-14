//
//  BoxOfficeView.m
//  MoviesApp
//
//  Created by chitrangadh reddy pisati on 10/24/15.
//  Copyright (c) 2015 Mobile_Application_Development. All rights reserved.
//

#import "BoxOfficeView.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailView.h"

@interface BoxOfficeView ()

@end

@implementation BoxOfficeView

@synthesize movies,moviedetail,movies1,segment,movies2,movies3,navigationBar,searchResults,search,sort,overlayView=_overlayView;
NSArray *tempMovies,*tempMovies1,*tempMovies2;

- (void)viewDidLoad {
    [super viewDidLoad];
   self.searchDisplayController.searchResultsTableView.rowHeight = self.MoviesList.rowHeight;
    _overlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 320, 480)];
    _overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=ws32mxpd653h5c8zqfvksxw9&page_limit=50";
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.movies = object[@"movies"];
        tempMovies=self.movies;
        [self.MoviesList reloadData];
     NSString *url1 = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/upcoming.json?page_limit=16&page=1&country=us&apikey=ws32mxpd653h5c8zqfvksxw9";
         
         
         NSURLRequest *request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:url1]];
         [NSURLConnection sendAsynchronousRequest:request1 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
         id object1 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
         self.movies1 = object1[@"movies"];
             tempMovies1=self.movies1;
             [self.MoviesList reloadData];
             NSString *url2 = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?limit=16&country=us&apikey=ws32mxpd653h5c8zqfvksxw9&limit=30";
             
             
             NSURLRequest *request2 = [NSURLRequest requestWithURL:[NSURL URLWithString:url2]];
             [NSURLConnection sendAsynchronousRequest:request2 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                 id object2 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                 self.movies2 = object2[@"movies"];
                 tempMovies2=self.movies2;
                 [self.MoviesList reloadData];
                 }];

         }];
    }];
    self.navigationController.navigationBar.shadowImage=nil;
    
}
//search bar methods
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSString *enteredtxt=searchText;
    enteredtxt=[enteredtxt stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *url=@"http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=ws32mxpd653h5c8zqfvksxw9&q=";
    url=[url stringByAppendingString:enteredtxt];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(data!=nil)
        {
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.movies3 = object[@"movies"];
        }
        [self.searchDisplayController.searchResultsTableView reloadData];
        //  movies3=nil;
    }];

}


-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    if(tableView==self.searchDisplayController.searchResultsTableView)
         return self.movies3.count;
    else{
    if(self.segment.selectedSegmentIndex==0)
    return self.movies.count;
    else if(self.segment.selectedSegmentIndex==1)
    return self.movies1.count;
    else if(self.segment.selectedSegmentIndex==2)
        return self.movies2.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell...
    static NSString *CellIdentifier = @"myCell";
    MovieCell *cell = [self.MoviesList dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if ( cell == nil )
    {
        cell = [[MovieCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    UIImage *image1 = [UIImage imageNamed: @"freshtomato.png"];
    UIImage *image2=[UIImage imageNamed:@"rottensmall.png"];
    UIImage *image3=[UIImage imageNamed:@"popcorn.png"];
    UIImage *image4=[UIImage imageNamed:@"spilledsmall.png"];
    if(tableView==self.searchDisplayController.searchResultsTableView)
    {
        int i=(int)indexPath.row;
            NSDictionary *movie3 = self.movies3[i];
       // NSLog(@"%@",movie3[@"title"]);
            NSString *run=movie3[@"runtime"];
            NSInteger runtime=run.intValue;
            NSInteger hours=runtime/60;
            NSInteger mins=runtime%60;
            
            cell.title.text = movie3[@"title"];
            cell.runtime.text=movie3[@"mpaa_rating"];
            cell.runtime.text=[cell.runtime.text stringByAppendingString:@", "];
            cell.runtime.text=[cell.runtime.text stringByAppendingString:[NSString stringWithFormat:@"%ld hr. %ld mins",(long)hours,(long)mins]];
            
            cell.Critics.text=[NSString stringWithFormat:@"%@%%", movie3[@"ratings"][@"critics_score"]];
            cell.Audience.text=[NSString stringWithFormat:@"%@%%", movie3[@"ratings"][@"audience_score"]];
            if([cell.Critics.text intValue]>60)
                [cell.userImage setImage:image1];
            else
                [cell.userImage setImage:image2];
            if([cell.Audience.text intValue]>60)
                [cell.criticImage setImage:image3];
            else
                [cell.criticImage setImage:image4];
            
            
            
            NSDictionary *posters = movie3[@"posters"];
            NSString *posterUrlString = posters[@"original"];
            [cell.posterView setImageWithURL:[NSURL URLWithString:posterUrlString]];
            
        

    }
    else{
    
    if((self.segment.selectedSegmentIndex==0)){
    NSDictionary *movie = self.movies[indexPath.row];
    NSString *run=movie[@"runtime"];
    NSInteger runtime=run.intValue;
   NSInteger hours=runtime/60;
    NSInteger mins=runtime%60;
    
    cell.title.text = movie[@"title"];
    cell.runtime.text=movie[@"mpaa_rating"];
    cell.runtime.text=[cell.runtime.text stringByAppendingString:@", "];
    cell.runtime.text=[cell.runtime.text stringByAppendingString:[NSString stringWithFormat:@"%ld hr. %ld mins",(long)hours,(long)mins]];
    
    cell.Critics.text=[NSString stringWithFormat:@"%@%%", movie[@"ratings"][@"critics_score"]];
    cell.Audience.text=[NSString stringWithFormat:@"%@%%", movie[@"ratings"][@"audience_score"]];
        if([cell.Critics.text intValue]>60)
            [cell.userImage setImage:image1];
        else
            [cell.userImage setImage:image2];
        if([cell.Audience.text intValue]>60)
            [cell.criticImage setImage:image3];
        else
            [cell.criticImage setImage:image4];
        
      

    NSDictionary *posters = movie[@"posters"];
    NSString *posterUrlString = posters[@"original"];
    [cell.posterView setImageWithURL:[NSURL URLWithString:posterUrlString]];
   }
    else if((self.segment.selectedSegmentIndex==1))
    {
        NSDictionary *movie1= self.movies1[indexPath.row];
        NSString *run1=movie1[@"runtime"];
        NSInteger runtime1=run1.intValue;
        NSInteger hours1=runtime1/60;
        NSInteger mins1=runtime1%60;
        
        cell.title.text = movie1[@"title"];
        cell.runtime.text=movie1[@"mpaa_rating"];
        cell.runtime.text=[cell.runtime.text stringByAppendingString:@", "];
        cell.runtime.text=[cell.runtime.text stringByAppendingString:[NSString stringWithFormat:@"%ld hr. %ld mins",(long)hours1,(long)mins1]];
        
        cell.Critics.text=[NSString stringWithFormat:@"%@%%", movie1[@"ratings"][@"critics_score"]];
        cell.Audience.text=[NSString stringWithFormat:@"%@%%", movie1[@"ratings"][@"audience_score"]];
        if([cell.Critics.text intValue]>60)
            [cell.userImage setImage:image1];
        else
            [cell.userImage setImage:image2];
        if([cell.Audience.text intValue]>60)
            [cell.criticImage setImage:image3];
        else
            [cell.criticImage setImage:image4];
        
        NSDictionary *posters1 = movie1[@"posters"];
        NSString *posterUrlString = posters1[@"original"];
        [cell.posterView setImageWithURL:[NSURL URLWithString:posterUrlString]];
        
    }
    else if((self.segment.selectedSegmentIndex==2))
    {
        NSDictionary *movie2= self.movies2[indexPath.row];
        NSString *run2=movie2[@"runtime"];
        NSInteger runtime2=run2.intValue;
        NSInteger hours2=runtime2/60;
        NSInteger mins2=runtime2%60;
        
        cell.title.text = movie2[@"title"];
        cell.runtime.text=movie2[@"mpaa_rating"];
        cell.runtime.text=[cell.runtime.text stringByAppendingString:@", "];
        cell.runtime.text=[cell.runtime.text stringByAppendingString:[NSString stringWithFormat:@"%ld hr. %ld mins",(long)hours2,(long)mins2]];
        
        cell.Critics.text=[NSString stringWithFormat:@"%@%%", movie2[@"ratings"][@"critics_score"]];
        cell.Audience.text=[NSString stringWithFormat:@"%@%%", movie2[@"ratings"][@"audience_score"]];
        if([cell.Critics.text intValue]>60)
            [cell.userImage setImage:image1];
        else
            [cell.userImage setImage:image2];
        if([cell.Audience.text intValue]>60)
            [cell.criticImage setImage:image3];
        else
            [cell.criticImage setImage:image4];
        
        NSDictionary *posters2 = movie2[@"posters"];
        NSString *posterUrlString = posters2[@"original"];
        [cell.posterView setImageWithURL:[NSURL URLWithString:posterUrlString]];
        
    }
    
    }
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Do some stuff when the row is selected
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"b2d"]) {
        MovieDetailView *md= [segue destinationViewController];
        
        if(self.searchDisplayController.isActive){
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            int i=(int)indexPath.row;
            md.moviepass=self.movies3[i];
            
            
        }
        else{
            NSIndexPath *indexPath = [self.MoviesList indexPathForSelectedRow];
        
        if(self.segment.selectedSegmentIndex==0)
              md.moviepass=self.movies[indexPath.row];
        else if(self.segment.selectedSegmentIndex==1)
            md.moviepass=self.movies1[indexPath.row];
        else if(self.segment.selectedSegmentIndex==2)
            md.moviepass=self.movies2[indexPath.row];

        }
    }
}




- (IBAction)choice:(id)sender {
    [self.MoviesList reloadData];
}
- (IBAction)sort:(id)sender {
    
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:nil
                                 message:nil
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* popular = [UIAlertAction
                         actionWithTitle:@"Popular"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             self.movies=tempMovies;
                             self.movies1=tempMovies1;
                             self.movies2=tempMovies2;
                             [self.MoviesList reloadData];
                             [view dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* tit = [UIAlertAction
                              actionWithTitle:@"Title"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  NSArray *descriptor = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
                                  movies=[movies sortedArrayUsingDescriptors:descriptor];
                                  movies1=[movies1 sortedArrayUsingDescriptors:descriptor];
                                  movies2=[movies2 sortedArrayUsingDescriptors:descriptor];

                                  [self.MoviesList reloadData];
                                  [view dismissViewControllerAnimated:YES completion:nil];
                                  
                              }];
    UIAlertAction* rating = [UIAlertAction
                              actionWithTitle:@"Rating"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  NSArray *descriptor = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"ratings.critics_score" ascending:NO]];
                                  movies=[movies sortedArrayUsingDescriptors:descriptor];
                                  movies1=[movies1 sortedArrayUsingDescriptors:descriptor];
                                  movies2=[movies2 sortedArrayUsingDescriptors:descriptor];
                                  
                                  [self.MoviesList reloadData];
                                  [view dismissViewControllerAnimated:YES completion:nil];
                                  
                              }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    
    [view addAction:popular];
    [view addAction:tit];
    [view addAction:rating];
    [view addAction:cancel];
    [self presentViewController:view animated:YES completion:nil];

}


@end
