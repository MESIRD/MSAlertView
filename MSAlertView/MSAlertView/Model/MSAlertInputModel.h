//
//  MSAlertInputModel.h
//  MSAlertView
//
//  Created by mesird on 5/10/16.
//  Copyright © 2016 mesird. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSAlertInputModel : NSObject

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *inputValue;
@property (nonatomic, copy) NSString *inputKey;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
