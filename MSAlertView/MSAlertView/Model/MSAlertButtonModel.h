//
//  MSAlertButtonModel.h
//  MSAlertView
//
//  Created by mesird on 5/10/16.
//  Copyright © 2016 mesird. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ButtonCallBackBlock)();

@interface MSAlertButtonModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) ButtonCallBackBlock callBackBlock;

@end
