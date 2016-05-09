//
//  MSAlertView.h
//  MSAlertView
//
//  Created by mesird on 5/10/16.
//  Copyright © 2016 mesird. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, AlertViewType) {
    AlertViewTypeInfo      = 1 << 0,    //display title with content and ok button
    AlertViewTypeSelection = 1 << 1,    //display title with ok and other buttons
    AlertViewTypeInput     = 1 << 2     //display title with input field and ok button
};

@class MSAlertView;
@protocol MSAlertViewDelegate <NSObject>

@optional
- (void)alertView:(MSAlertView *)alertView didPressedOnButton:(NSDictionary *)userInfo;

@end

@interface MSAlertView : UIView

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content andCancelButtonTitle:(NSString *)cancelButtonTitle;

- (void)show;

@end
