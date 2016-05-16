//
//  MSAlertButtonModel.h
//  MSAlertView
//
//  Created by mesird on 5/10/16.
//  Copyright © 2016 mesird. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ButtonCallbackBlock)();

@interface MSAlertButtonModel : NSObject

@property (nonatomic, assign) BOOL                isCancelButton;
@property (nonatomic, copy)   NSString            *title;
@property (nonatomic, copy)   ButtonCallbackBlock callbackBlock;

- (instancetype)initWithTitle:(NSString *)title callbackBlock:(ButtonCallbackBlock)callbackBlock andIsCancelButton:(BOOL)isCancelButton;

@end
