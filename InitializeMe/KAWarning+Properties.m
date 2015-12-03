//
//  KAWarning+Properties.m
//  InitializeMe
//
//  Created by Kenny Ackerson on 10/29/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAWarning+Properties.h"
#import "NSArray+Extensions.h"

@implementation KAWarning (Properties)

+ (NSArray <KAWarning *> *)warningForProperty:(Property *)property {
    NSMutableArray <KAWarning *>*warnings = [NSMutableArray new];
    
    if (![property.qualifiers containsObject:@"copy"] && [@[@"NSString", @"NSArray", @"NSDictionary"] anyObjectPassTest:^BOOL(NSString *object) {
        return [property.type containsString:object]; }]) {
        [warnings addObject:[[KAWarning alloc] initWithReason:@"You should add copy to this property." warningLevel:WarningLevelMedium property:property]];
    }
    
    if (![property.qualifiers containsObject:@"readonly"]) {
        [warnings addObject:[[KAWarning alloc] initWithReason:@"Property is mutable." warningLevel:WarningLevelLow property:property]];
    }
    
    if (![property.qualifiers containsObject:@"nonatomic"]) {
        [warnings addObject:[[KAWarning alloc] initWithReason:@"Property is atomic." warningLevel:WarningLevelLow property:property]];
    }
    
    return [warnings copy];
}

@end
