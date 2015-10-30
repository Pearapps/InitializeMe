//
//  KAWarning.m
//  InitializeMe
//
//  Created by Kenny Ackerson on 10/29/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAWarning.h"

@implementation KAWarning

- (nonnull instancetype)initWithReason:(nonnull NSString *)reason warningLevel:(WarningLevel)warningLevel {
    NSParameterAssert(reason);
    self = [super init];
    
    if (self) {
        _reason = reason;
        _warningLevel = warningLevel;
    }
    
    return self;
}

@end
