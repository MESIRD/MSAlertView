//
//  MSAlertView.m
//  MSAlertView
//
//  Created by mesird on 5/10/16.
//  Copyright © 2016 mesird. All rights reserved.
//

#import "MSAlertView.h"

@interface MSAlertView()
{
    
}

// widgets
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;


// data sources
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSMutableArray *inputs;
@property (nonatomic, strong) NSMutableArray *buttons;

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
