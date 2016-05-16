//
//  MSAlertButtonModel.m
//  MSAlertView
//
//  Created by mesird on 5/10/16.
//  Copyright © 2016 mesird. All rights reserved.
//

#import "MSAlertButtonModel.h"

@implementation MSAlertButtonModel

- (instancetype)initWithTitle:(NSString *)title callbackBlock:(ButtonCallbackBlock)callbackBlock andIsCancelButton:(BOOL)isCancelButton {
    
    if ( self = [super init]) {
        self.title = title;
        self.callbackBlock = callbackBlock;
        self.isCancelButton = isCancelButton;
    }
    return self;
}

@end
