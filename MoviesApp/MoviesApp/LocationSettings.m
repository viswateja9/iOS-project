//
//  LocationSettings.m
//  MoviesApp
//
//  Created by Bikkina, Venkata Viswa Teja on 11/10/15.
//  Copyright (c) 2015 Mobile_Application_Development. All rights reserved.
//

#import "LocationSettings.h"
#import "TheaterView.h"

@interface LocationSettings ()

@end

@implementation LocationSettings

@synthesize mySwitch,switchstate,zip,temp,bb,searchLabel;
- (void)viewDidLoad {
    [super viewDidLoad];
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    bb=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            bb];
    [numberToolbar sizeToFit];
    bb.enabled=false;
    zip.inputAccessoryView = numberToolbar;
    switchstate = [[NSUserDefaults standardUserDefaults] boolForKey:@"switchValue"];
    if(switchstate){
        mySwitch.on=true;
        [zip setHidden:true];
        searchLabel.hidden=YES;
    }
    else
        mySwitch.on=false;
    
    if(temp!=nil)
        self.zip.text=temp;
}

-(void)cancelNumberPad{
    [zip resignFirstResponder];
    zip.text = @"";
}

-(void)doneWithNumberPad{
    [zip resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)useLocation:(id)sender {
    TheaterView *tv=[[TheaterView alloc] init];
    if(mySwitch.isOn)
    {
        tv.uselocation=true;
        [[NSUserDefaults standardUserDefaults] setBool:mySwitch.on forKey:@"switchValue"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        searchLabel.hidden=YES;
        [zip setHidden:true];
        [zip resignFirstResponder];
        
      
    }
    else
    {
        [zip becomeFirstResponder];
        bb.enabled=true;
        tv.uselocation=false;
        searchLabel.hidden=NO;
        [zip setHidden:false];
       
        [[NSUserDefaults standardUserDefaults] setBool:mySwitch.on forKey:@"switchValue"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[NSUserDefaults standardUserDefaults] setObject:zip.text forKey:@"zipValue"];
    [[NSUserDefaults standardUserDefaults] synchronize];
  }
-(void)viewWillAppear:(BOOL)animated
{
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"fromSettings"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
@end
