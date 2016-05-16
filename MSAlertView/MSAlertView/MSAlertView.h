//
//  MSAlertView.h
//  MSAlertView
//
//  Created by mesird on 5/10/16.
//  Copyright © 2016 mesird. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MSAlertViewType) {
    MSAlertViewTypeInfo      = 0,    //display title with content and buttons
    MSAlertViewTypeInput     = 1     //display title with input field and buttons
};

@class MSAlertView;
@protocol MSAlertViewDelegate <NSObject>

@optional
- (void)alertView:(MSAlertView *)alertView didPressedOnButton:(NSDictionary *)userInfo;

@end

@interface MSAlertView : UIView

@property (nonatomic, weak) id<MSAlertViewDelegate> delegate;

- (instancetype)initWithDelegate:(id<MSAlertViewDelegate>)delegate title:(NSString *)title content:(NSString *)content cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

- (void)show;

@end
