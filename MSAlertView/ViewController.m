//
//  ViewController.m
//  MSAlertView
//
//  Created by mesird on 5/10/16.
//  Copyright © 2016 mesird. All rights reserved.
//

#import "ViewController.h"
#import "MSAlertViewHeader.h"

@interface ViewController () <MSAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MSAlertView *alertView = [[MSAlertView alloc] initWithDelegate:self title:@"Information" content:@"This is a simple paragraph" cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - MS Alert View Delegate
- (void)alertView:(MSAlertView *)alertView didPressedOnButton:(NSDictionary *)userInfo {
    
}

@end
