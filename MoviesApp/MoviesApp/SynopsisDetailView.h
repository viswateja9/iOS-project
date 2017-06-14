//
//  SynopsisDetailView.h
//  MoviesApp
//
//  Created by chitrangadh reddy pisati on 10/28/15.
//  Copyright (c) 2015 Mobile_Application_Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SynopsisDetailView : UIViewController
{
    NSDictionary *moviepass;
}
@property(nonatomic) NSDictionary *moviepass;
@property (weak, nonatomic) IBOutlet UITextView *synopsis;



@end
