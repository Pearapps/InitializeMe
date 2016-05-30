//
//  KATimeEstimator.m
//  Phoenix
//
//  Created by Kenneth Parker Ackerson on 5/29/16.
//  Copyright © 2016 Kenneth Ackerson. All rights reserved.
//

#import "KATimeEstimator.h"

@interface KATimeEstimator ()

@property (nonatomic, readonly) NSInteger numberOfProperties;

@end

@implementation KATimeEstimator

- (instancetype)initWithNumberOfProperties:(NSInteger)numberOfProperties {
    self = [super init];
    
    if (self) {
        _numberOfProperties = numberOfProperties;
    }
    
    return self;
}

- (NSInteger)estimatedSecondsSaved {
    return self.numberOfProperties * 4; // 4 seconds per property - probably low, but this is just estimated.
}

@end
