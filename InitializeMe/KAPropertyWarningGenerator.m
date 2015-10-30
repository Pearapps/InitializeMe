//
//  KAPropertyWarningGenerator.m
//  InitializeMe
//
//  Created by Kenny Ackerson on 10/29/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAPropertyWarningGenerator.h"
#import "NSArray+Extensions.h"

@interface KAPropertyWarningGenerator ()

@property (nonatomic, nonnull, copy, readonly) NSArray <Property *> *properties;

@end

@implementation KAPropertyWarningGenerator

- (nonnull instancetype)initWithProperties:(nonnull NSArray <Property *> *)properties {
    NSParameterAssert(properties);
    self = [super init];
    
    if (self) {
        _properties = [properties copy];
    }
    
    return self;
}

- (NSArray <KAWarning *> *)warnings {
    return [self.properties transformedArrayWithBlock:^id(Property *property) {
        return nil;
    }];
}

@end
