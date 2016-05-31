//
//  ViewController.m
//  MSAlertView
//
//  Created by mesird on 5/10/16.
//  Copyright © 2016 mesird. All rights reserved.
//

#import "ViewController.h"
#import "MSAlertViewHeader.h"

@interface ViewController () <MSAlertViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) MSAlertView *alertView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, screenSize.width, 100)];
    button1.tag = 1;
    button1.backgroundColor = [UIColor colorWithWhite:0.1f alpha:1.0f];
    [button1 setTitle:@"Alert With No Button" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(tapOnButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 120, screenSize.width, 100)];
    button2.tag = 2;
    button2.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    [button2 setTitle:@"Alert With Cancel Button" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(tapOnButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 220, screenSize.width, 100)];
    button3.tag = 3;
    button3.backgroundColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
    [button3 setTitle:@"Alert With Input Fields" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(tapOnButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapOnButton:(UIButton *)sender {
    
    if ( sender.tag == 1) {
         _alertView = [[MSAlertView alloc] initWithDelegate:self title:@"Information" content:@"This is a simple paragraph" cancelButtonTitle:nil otherButtonTitles:nil];
        [_alertView show];
    } else if ( sender.tag == 2) {
        _alertView = [[MSAlertView alloc] initWithDelegate:self title:@"Information" content:@"This is a simple paragraph" cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [_alertView show];
    } else if ( sender.tag == 3) {
        _alertView = [[MSAlertView alloc] initWithDelegate:self title:@"Information" content:@"This is a simple paragraph with a very long and nonsense words in it!!!" cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit", nil];
        [_alertView appendInputWithPlaceholder:@"account"  delegate:self encrypted:NO];
        [_alertView appendInputWithPlaceholder:@"password" delegate:self encrypted:YES];
        [_alertView show];
    }
}

#pragma mark - MS Alert View Delegate

- (void)alertView:(MSAlertView *)alertView buttonPressedAtIndex:(NSInteger)index withInputValues:(NSArray *)inputValues {
    
    if ( index != 0 && ![inputValues[1] isEqualToString:@"123"]) {
        [alertView setAlertAdditionalMessage:@"wrong password"];
        [alertView errorShake];
        return;
    }
    
    [alertView hide];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ( [string isEqualToString:@"\n"]) {
        NSInteger index = [_alertView indexOfInputField:textField];
        if ( index == 1) {
            if ( [textField canResignFirstResponder]) {
                [textField resignFirstResponder];
            }
        } else {
            UITextField *nextTextField = [_alertView inputFieldOfIndex:index + 1];
            if ( [nextTextField canBecomeFirstResponder]) {
                [nextTextField becomeFirstResponder];
            }
        }
        return NO;
    }
    return YES;
}

@end
