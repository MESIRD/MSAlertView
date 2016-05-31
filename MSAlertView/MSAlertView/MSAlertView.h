//
//  MSAlertView.h
//  MSAlertView
//
//  Created by mesird on 5/10/16.
//  Copyright © 2016 mesird. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MSAlertView;
@protocol MSAlertViewDelegate <NSObject>

@optional
- (void)alertView:(MSAlertView *)alertView buttonPressedAtIndex:(NSInteger)index withInputValues:(NSArray *)inputValues;

@end

@class MSAlertInputField;
@interface MSAlertView : UIView

@property (nonatomic, weak) id<MSAlertViewDelegate> delegate;

- (instancetype)initWithDelegate:(id<MSAlertViewDelegate>)delegate title:(NSString *)title content:(NSString *)content cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (MSAlertInputField *)appendInputWithPlaceholder:(NSString *)placeholder delegate:(id)delegate encrypted:(BOOL)encrypted;

- (void)setAlertAdditionalMessage:(NSString *)message;

- (void)show;
- (void)hide;
- (void)errorShake;

- (NSInteger)indexOfInputField:(UITextField *)inputField;
- (UITextField *)inputFieldOfIndex:(NSInteger)index;

@end
