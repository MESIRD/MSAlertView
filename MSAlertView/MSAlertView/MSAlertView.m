//
//  MSAlertView.m
//  MSAlertView
//
//  Created by mesird on 5/10/16.
//  Copyright © 2016 mesird. All rights reserved.
//

#import "MSAlertView.h"
#import "MSAlertInputField.h"
#import "MSAlertInputModel.h"
#import "MSAlertButtonModel.h"

@interface MSAlertView()
{
    
}

// widgets
@property (nonatomic, strong) UIView  *titleView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView                              *contentView;
@property (nonatomic, strong) UITextView                          *contentTextView;
@property (nonatomic, strong) NSMutableArray<MSAlertInputField *> *inputFieldArray;

@property (nonatomic, strong) UIView         *bottomView;
@property (nonatomic, strong) NSMutableArray *buttonArray;


// data sources
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSMutableArray<MSAlertInputModel *>  *inputModels;
@property (nonatomic, strong) NSMutableArray<MSAlertButtonModel *> *buttonModels;

@end

@implementation MSAlertView

static const CGFloat kLeftMargin = 30.0f;
static const CGFloat kRightMargin = kLeftMargin;

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content andCancelButtonTitle:(NSString *)cancelButtonTitle {
    if ( self = [super init]) {
        
        
        
    }
    return self;
}


@end
