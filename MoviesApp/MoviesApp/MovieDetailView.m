//
//  MovieDetailView.m
//  MoviesApp
//
//  Created by Bikkina, Venkata Viswa Teja on 10/25/15.
//  Copyright (c) 2015 Mobile_Application_Development. All rights reserved.
//

#import "MovieDetailView.h"
#import "MediaPlayer/MediaPlayer.h"
#import "UIImageView+AFNetworking.h"
#import "MovieBasicInfo.h"
#import "SynopsisDetailView.h"
#import "ReviewCell.h"
#import "ReviewDetailView.h"

@interface MovieDetailView ()
{

}

@end


@implementation MovieDetailView

@synthesize controller,loading;
@synthesize webView;
@synthesize moviepass,moviedetail,tmdbid;
@synthesize utubekey,key,allreviews,genres;
ReviewCell *cell1;
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title=moviepass[@"title"];
    
    
    //get movie details from tmdb using imdb id
    NSString *url = @"http://api.themoviedb.org/3/movie/tt#######?api_key=8ac1334ea6ba3cc05a8d0ae5535cd02e";
    if(moviepass[@"alternate_ids"][@"imdb"] != nil)
    url=[url stringByReplacingOccurrencesOfString:@"#######" withString:moviepass[@"alternate_ids"][@"imdb"]];
    else
        url=[url stringByReplacingOccurrencesOfString:@"#######" withString:@"1111111"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.tmdbid=object[@"id"];
  
         NSString *newid=[NSString stringWithFormat:@"%@",tmdbid];
        NSString *tmdbtrailer=@"http://api.themoviedb.org/3/movie/";
        tmdbtrailer=[tmdbtrailer stringByAppendingString:newid];
        tmdbtrailer=[tmdbtrailer stringByAppendingString:@"/videos?api_key=8ac1334ea6ba3cc05a8d0ae5535cd02e"];
    
     
        NSURLRequest *request2 = [NSURLRequest requestWithURL:[NSURL URLWithString:tmdbtrailer]];
        [NSURLConnection sendAsynchronousRequest:request2 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            id object2 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.utubekey=object2[@"results"];
            if([utubekey count]>0)
            key=utubekey[0];
            //imdb.text=key[@"key"];
            NSString *reviews=@"http://api.rottentomatoes.com/api/public/v1.0/movies/";
            reviews=[reviews stringByAppendingString:moviepass[@"id"]];
            reviews=[reviews stringByAppendingString:@"/reviews.json?apikey=ws32mxpd653h5c8zqfvksxw9"];
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:reviews]];
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                allreviews=object[@"reviews"];
                 [self.detailTable reloadData];
            }];
            
            
        }];
    }];
    
    
 //   }


        // Do any additional setup after loading the view.
    webView.delegate = self;
    webView.scrollView.scrollEnabled = NO;
    webView.layer.cornerRadius = 5.0;
    webView.clipsToBounds = YES;
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*- (IBAction)playTrailer:(id)sender {
   
    //Working utube code
    if(key==nil)
        [playtrailer setTitle:@"Not available" forState:UIControlStateNormal];
    else{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectNull];
    [webView sizeThatFits:CGSizeZero];
    [self.webView setAllowsInlineMediaPlayback:NO];
    [self.webView setMediaPlaybackRequiresUserAction:NO];
    
    
    [self.view addSubview:self.webView];
    
    NSString* embedHTML = [NSString stringWithFormat:@"\
                           <html>\
                           <body style='margin:0px;padding:0px;'>\
                           <script type='text/javascript' src='http://www.youtube.com/iframe_api'></script>\
                           <script type='text/javascript'>\
                           function onYouTubeIframeAPIReady()\
                           {\
                           ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})\
                           }\
                           function onPlayerReady(a)\
                           { \
                           a.target.playVideo(); \
                           }\
                           </script>\
                           <iframe id='playerId' type='text/html' width='%d' height='%d' src='http://www.youtube.com/embed/%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'>\
                           </body>\
                           </html>", 300, 200, key[@"key"]];
    [self.webView loadHTMLString:embedHTML baseURL:[[NSBundle mainBundle] resourceURL]];
    
    }
}*/

-(void) viewWillAppear:(BOOL)animated
{
    MovieBasicInfo *cell;
    //populate trailer link
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
  
    //populate critics,audience
    

    //populate year,rating,runtime
   
    
    //populate synopsis(movie info)
    
    
    //populate third cell(rating,runtime,genre,release
    
    //genre


 
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
   
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    if(section==5)
    {
        return self.allreviews.count;
    }
   else
        return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell...
    //UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil
    if(indexPath.section==0)
    {
        
        
        cell1=[tableView dequeueReusableCellWithIdentifier:@"firstCell"];
        cell1. mname.text=moviepass[@"title"];
        NSDictionary *posters = moviepass[@"posters"];
        NSString *posterUrlString = posters[@"original"];
        [cell1.posterView setImageWithURL:[NSURL URLWithString:posterUrlString]];
        cell1.playtrailer.layer.borderColor = [UIColor colorWithRed:0/255.0 green:161/225.0 blue:0/255.0 alpha:1.0].CGColor;
        cell1.playtrailer.layer.cornerRadius = 15.0f;
        cell1.criticScore.text=[NSString stringWithFormat:@"%@%%", moviepass[@"ratings"][@"critics_score"]];
        cell1.userScore.text=[NSString stringWithFormat:@"%@%%", moviepass[@"ratings"][@"audience_score"]];
        UIImage *image1 = [UIImage imageNamed: @"freshtomato.png"];
        UIImage *image2=[UIImage imageNamed:@"rottensmall.png"];
        UIImage *image3=[UIImage imageNamed:@"popcorn.png"];
        UIImage *image4=[UIImage imageNamed:@"spilledsmall.png"];
        
        if([cell1.criticScore.text intValue]>60)
            [cell1.criticImage setImage:image1];
        else
            [cell1.criticImage setImage:image2];
        if([cell1.userScore.text intValue]>60)
            [cell1.userImage setImage:image3];
        else
            [cell1.userImage setImage:image4];
        
        NSString *run=moviepass[@"runtime"];
        NSInteger runtim=run.intValue;
        NSInteger hours=runtim/60;
        NSInteger mins=runtim%60;
        NSString *year=[NSString stringWithFormat:@"%@",moviepass[@"year"]];
        cell1.imdb.text=year;
        cell1.imdb.text=[cell1.imdb.text stringByAppendingString:@" ,"];
        cell1.imdb.text=[cell1.imdb.text stringByAppendingString:moviepass[@"mpaa_rating"]];
        cell1.imdb.text=[cell1.imdb.text stringByAppendingString:@", "];
        cell1.imdb.text=[cell1.imdb.text stringByAppendingString:[NSString stringWithFormat:@"%ld hr. %ld mins",(long)hours,(long)mins]];
        
        [cell1.playtrailer addTarget:self action:@selector(youtubeTrailer) forControlEvents:UIControlEventTouchUpInside];
        
        
        return cell1;

    }
    else if (indexPath.section==1)
    {
         ReviewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"secondCell"];
        if(([moviepass[@"synopsis"] isEqual:@""]))
        {
            cell.synopsis.text=@"Synopsis not available";
            cell.synopsis.numberOfLines=1;
        }
        else{
        cell.synopsis.text=moviepass[@"synopsis"];
        cell.synopsis.numberOfLines=4;
        }
        return cell;

    }
    else if (indexPath.section==2)
    {
      ReviewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"thirdCell"];
        cell.mpaa.text=moviepass[@"mpaa_rating"];
        NSString *run=moviepass[@"runtime"];
        NSInteger runtim=run.intValue;
        NSInteger hours=runtim/60;
        NSInteger mins=runtim%60;
        cell.duration.text=[NSString stringWithFormat:@"%ld hr. %ld mins",(long)hours,(long)mins];
       cell.date.text=moviepass[@"release_dates"][@"theater"];
        NSString *movieinfo=@"http://api.rottentomatoes.com/api/public/v1.0/movies/";
        movieinfo=[movieinfo stringByAppendingString:moviepass[@"id"]];
        movieinfo=[movieinfo stringByAppendingString:@".json?apikey=ws32mxpd653h5c8zqfvksxw9"];
        NSURLRequest *request3 = [NSURLRequest requestWithURL:[NSURL URLWithString:movieinfo]];
        [NSURLConnection sendAsynchronousRequest:request3 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            id object3 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            moviedetail=object3;
            genres=object3[@"genres"];
            cell.genre.text=@"";
            for (int i=0; i<[genres count]; i++) {
                cell.genre.text=[cell.genre.text stringByAppendingString:genres[i]];
                if(i!=([genres count]-1))
                    cell.genre.text=[cell.genre.text stringByAppendingString:@", "];
            }
            
        }];
        
        //cast
               return cell;
    }
  else if(indexPath.section==3)
    {
        ReviewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"fourthCell"];
        NSArray *cast=moviepass[@"abridged_cast"];
        cell.starcast.text=@"";
        for (int i=0; i<[cast count]; i++) {
            NSDictionary *names=cast[i];
           
            
            cell.starcast.text=[cell.starcast.text stringByAppendingString:names[@"name"]];
            if(i!=([cast count]-1))
                cell.starcast.text=[cell.starcast.text stringByAppendingString:@", "];
            names=nil;
        }
        
        return cell;
    }
  else if(indexPath.section==4)
    {
     ReviewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"fifthCell"];
   
        
        cell.director.text=@"";
        NSString *movieinfo=@"http://api.rottentomatoes.com/api/public/v1.0/movies/";
        movieinfo=[movieinfo stringByAppendingString:moviepass[@"id"]];
        movieinfo=[movieinfo stringByAppendingString:@".json?apikey=ws32mxpd653h5c8zqfvksxw9"];
        NSURLRequest *request3 = [NSURLRequest requestWithURL:[NSURL URLWithString:movieinfo]];
        [NSURLConnection sendAsynchronousRequest:request3 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            id object3 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            moviedetail=object3;
            NSArray *directors=moviedetail[@"abridged_directors"];
            for (int i=0; i<[directors count]; i++) {
                NSDictionary *dnames=directors[i];
                //NSLog(@"names %@",names[@"name"]);
                
                cell.director.text=[cell.director.text stringByAppendingString:dnames[@"name"]];
                if(i!=([directors count]-1))
                    cell.director.text=[cell.director.text stringByAppendingString:@", "];
                dnames=nil;
            }

            
        }];

        
        return cell;
    }
    
    else if(indexPath.section==5)
    {
        ReviewCell *cell;
        cell=[tableView dequeueReusableCellWithIdentifier:@"sixthCell" forIndexPath:indexPath];
       /* NSString *reviews=@"http://api.rottentomatoes.com/api/public/v1.0/movies/";
        reviews=[reviews stringByAppendingString:moviepass[@"id"]];
        reviews=[reviews stringByAppendingString:@"/reviews.json?apikey=ws32mxpd653h5c8zqfvksxw9"];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:reviews]];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            allreviews=object[@"reviews"];*/
            NSDictionary *review=self.allreviews[indexPath.row];
           NSString *temp=review[@"critic"];
            temp=[temp stringByAppendingString:@", "];
            temp=[temp stringByAppendingString:review[@"publication"]];
            cell.name.text=temp;
            cell.text.text=review[@"quote"];
            UIImage *image1=[UIImage imageNamed:@"freshtomato.png"];
            UIImage *image2=[UIImage imageNamed:@"rottensmall.png"];
            if([review[@"freshness"] isEqual:@"fresh"])
                cell.criticImg.image=image1;
            else
                cell.criticImg.image=image2;
          
        
        
  return cell;
        
    }
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Do some stuff when the row is selected
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0)
    return 125;
    else if(indexPath.section==1)
        return 90;
    else if(indexPath.section==2)
        return 85;
    else if(indexPath.section==3)
        return 70;
    else if(indexPath.section==4)
        return 50;
    else if(indexPath.section==5)
        return 70;
    return 0;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section==5)
        return @"Reviews";
    else
        return nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"m2s"]) {
        SynopsisDetailView *sv= [segue destinationViewController];
        sv.moviepass=moviepass;
        
        
    }
    else if([[segue identifier] isEqualToString:@"m2r"])
    {
        ReviewDetailView *rv=[segue destinationViewController];
         NSIndexPath *indexPath = [self.detailTable indexPathForSelectedRow];
        NSDictionary *rev=self.allreviews[indexPath.row];
        rv.url=rev[@"links"][@"review"];
        rv.barTitle=moviepass[@"title"];
    }
}

-(void)youtubeTrailer
{
    loading=[self.storyboard instantiateViewControllerWithIdentifier:@"lv"];
    if(key!=nil){
        [self.view addSubview:loading.view];
        [self.view bringSubviewToFront:loading.view];
        self.webView = [[UIWebView alloc] initWithFrame:CGRectNull];
        [webView sizeThatFits:CGSizeZero];
        [self.webView setAllowsInlineMediaPlayback:NO];
        [self.webView setMediaPlaybackRequiresUserAction:NO];
        
        [loading.view removeFromSuperview];
        [self.view addSubview:self.webView];
        
        NSString* embedHTML = [NSString stringWithFormat:@"\
                               <html>\
                               <body style='margin:0px;padding:0px;'>\
                               <script type='text/javascript' src='http://www.youtube.com/iframe_api'></script>\
                               <script type='text/javascript'>\
                               function onYouTubeIframeAPIReady()\
                               {\
                               ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})\
                               }\
                               function onPlayerReady(a)\
                               { \
                               a.target.playVideo(); \
                               }\
                               </script>\
                               <iframe id='playerId' type='text/html' width='%d' height='%d' src='http://www.youtube.com/embed/%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'>\
                               </body>\
                               </html>", 300, 200, key[@"key"]];
        [self.webView loadHTMLString:embedHTML baseURL:[[NSBundle mainBundle] resourceURL]];
        
        
    }
    else
        [cell1.playtrailer setTitle:@"Not available" forState:UIControlStateNormal];
    
}

@end
