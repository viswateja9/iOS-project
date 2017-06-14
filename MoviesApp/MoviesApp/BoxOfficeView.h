//
//  BoxOfficeView.h
//  MoviesApp
//
//  Created by chitrangadh reddy pisati on 10/24/15.
//  Copyright (c) 2015 Mobile_Application_Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoxOfficeView : UIViewController<UITableViewDataSource,UITableViewDataSource,UISearchBarDelegate,UIActionSheetDelegate,UISearchDisplayDelegate>
{
    NSArray *movies,*movies1,*movies2,*movies3;
    NSDictionary *moviedetail;
}


@property(nonatomic, retain) UIView *overlayView;
@property(retain,atomic) NSArray *movies,*movies1,*movies2,*movies3;
@property (weak, nonatomic) IBOutlet UITableView *MoviesList;
@property(nonatomic) NSDictionary *moviedetail;
@property (strong,nonatomic) NSMutableArray *searchResults;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@property (weak, nonatomic) IBOutlet UISearchBar *search;

- (IBAction)choice:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;
- (IBAction)sort:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sort;

@end
