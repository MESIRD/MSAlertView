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
            self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:228.0f green:228.0f blue:228.0f alpha:1.0f], NSFontAttributeName:[UIFont systemFontOfSize:12.0f]}];
        }
        self.borderStyle = UITextBorderStyleNone;
        self.backgroundColor = COLOR_OF_RGBA(249.0f, 249.0f, 249.0f, 1.0f);
        self.font = [UIFont systemFontOfSize:12.0f];
        self.textColor = COLOR_OF_RGBA(128.0f, 128.0f, 128.0f, 1.0f);
    }
    return self;
}

@end
