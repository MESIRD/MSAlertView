//
//  MSAlertInputField.m
//  MSAlertView
//
//  Created by mesird on 5/10/16.
//  Copyright © 2016 mesird. All rights reserved.
//

#import "MSAlertInputField.h"

@implementation MSAlertInputField

- (instancetype)initWithFrame:(CGRect)frame andPlaceholder:(NSString *)placeholder {
    
    if ( self = [super initWithFrame:frame]) {
        
        if ( placeholder && ![placeholder isEqualToString:@""]) {
            self.placeholder = placeholder;
        }
        self.borderStyle = UITextBorderStyleNone;
        self.backgroundColor = COLOR_OF_RGBA(249.0f, 249.0f, 249.0f, 1.0f);
        self.font = [UIFont systemFontOfSize:14.0f];
        self.textColor = COLOR_OF_RGBA(128.0f, 128.0f, 128.0f, 1.0f);
    }
    return self;
}


- (CGRect)editingRectForBounds:(CGRect)bounds {
    
    return CGRectMake(15.0f, CGRectGetMinY(bounds), CGRectGetWidth(bounds) - 15.0f * 2, CGRectGetHeight(bounds));
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    
    return CGRectMake(15.0f, CGRectGetMinY(bounds), CGRectGetWidth(bounds) - 15.0f * 2, CGRectGetHeight(bounds));
}

@end
