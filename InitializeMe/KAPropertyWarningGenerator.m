//
//  KAPropertyWarningGenerator.m
//  InitializeMe
//
//  Created by Kenny Ackerson on 10/29/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAPropertyWarningGenerator.h"
#import "NSArray+Extensions.h"
#import "KAWarning+Properties.h"

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
    if (self.properties.firstObject) {
        if (self.properties.firstObject.propertyType == PropertyTypeSwift) {
            return @[];
        }
    }
    
    return [NSArray flattenArray:[self.properties transformedArrayWithBlock:^id(Property *property) {
        return [KAWarning warningForProperty:property];
    }]];
}

@end
