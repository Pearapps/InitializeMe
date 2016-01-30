//
//  PropertyParser.m
//  InitializeMe
//
//  Created by Kenneth Parker Ackerson on 10/27/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "PropertyParser.h"
#import "Property.h"
#import "NSArray+Extensions.h"

@interface PropertyParser ()

@property (nonatomic, copy, readonly) NSString *string;

@end

@implementation PropertyParser

- (instancetype)initWithString:(NSString *)string {
    self = [super init];
    
    _string = [string copy];
    
    return self;
}

- (NSArray <Property *> *)properties {
    return [[[self.string componentsSeparatedByString:@"\n"] transformedArrayWithBlock:^id(NSString *string) {
        return [[Property alloc] initWithPropertyString:string];
    }] filter:^BOOL(Property *property) {
        return [property isValid];
    }];
}

@end
