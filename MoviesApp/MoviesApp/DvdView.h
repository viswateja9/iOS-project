//
//  DvdView.h
//  MoviesApp
//
//  Created by chitrangadh reddy pisati on 10/28/15.
//  Copyright (c) 2015 Mobile_Application_Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DvdView : UIViewController
{
    NSArray *movies,*movies1,*movies2;
    
}

@property(retain,atomic) NSArray *movies,*movies1,*movies2;
@property (weak, nonatomic) IBOutlet UITableView *MoviesList;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
- (IBAction)choice:(id)sender;
- (IBAction)sort:(id)sender;

@end
