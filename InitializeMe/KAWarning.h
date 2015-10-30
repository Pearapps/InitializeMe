//
//  KAWarning.h
//  InitializeMe
//
//  Created by Kenny Ackerson on 10/29/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, WarningLevel) {
    WarningLevelLow,
    WarningLevelMedium,
    WarningLevelHigh
};

@interface KAWarning : NSObject

@property (nonatomic, readonly, copy, nonnull) NSString *reason;
@property (nonatomic, readonly) WarningLevel warningLevel;

- (nonnull instancetype)initWithReason:(nonnull NSString *)reason warningLevel:(WarningLevel)warningLevel;

@end
