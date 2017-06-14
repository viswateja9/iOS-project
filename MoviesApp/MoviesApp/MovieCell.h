//
//  MovieCell.h
//  MoviesApp
//
//  Created by chitrangadh reddy pisati on 10/24/15.
//  Copyright (c) 2015 Mobile_Application_Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell



@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *Critics;
@property (weak, nonatomic) IBOutlet UILabel *Audience;
@property (weak, nonatomic) IBOutlet UILabel *runtime;
@property (weak, nonatomic) IBOutlet UIImageView *criticImage;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@end
