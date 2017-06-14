//
//  LocationSettings.h
//  MoviesApp
//
//  Created by Bikkina, Venkata Viswa Teja on 11/10/15.
//  Copyright (c) 2015 Mobile_Application_Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationSettings : UIViewController<UITextFieldDelegate>

- (IBAction)useLocation:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *zip;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;
@property BOOL switchstate;
@property NSString *temp;
@property UIBarButtonItem *bb;
@property (weak, nonatomic) IBOutlet UILabel *searchLabel;
@end
