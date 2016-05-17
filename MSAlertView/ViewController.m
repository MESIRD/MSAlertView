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
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, screenSize.width, 100)];
    button.backgroundColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
    [button setTitle:@"Alert!" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tapOnButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapOnButton:(UIButton *)sender {
    
    MSAlertView *alertView = [[MSAlertView alloc] initWithDelegate:self title:@"Information" content:@"This is a simple paragraph" cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alertView show];
}

#pragma mark - MS Alert View Delegate
- (void)alertView:(MSAlertView *)alertView didPressedOnButton:(NSDictionary *)userInfo {
    NSLog(@"pressed!");
}

@end
