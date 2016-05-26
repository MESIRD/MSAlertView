//
//  MSAlertInputModel.m
//  MSAlertView
//
//  Created by mesird on 5/10/16.
//  Copyright © 2016 mesird. All rights reserved.
//

#import "MSAlertInputModel.h"

@implementation MSAlertInputModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    if ( self = [super init]) {
        self.placeholder = dictionary[@"placeholder"];
        self.inputKey = dictionary[@"inputKey"];
        self.inputValue = dictionary[@"inputValue"];
    }
    return self;
}

@end
