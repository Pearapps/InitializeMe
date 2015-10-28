//
//  NSArray+Extensions.m
//  InitializeMe
//
//  Created by Kenneth Parker Ackerson on 10/27/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "NSArray+Extensions.h"

@implementation NSArray (Extensions)

- (NSArray *)transformedArrayWithBlock:(id (^)(id))block {
    NSMutableArray *returnArray = [NSMutableArray new];
    for (id object in self) {
        id transformedValue = block(object);
        if (transformedValue) { [returnArray addObject:transformedValue]; }
    }
    return [returnArray copy];
}

- (NSArray *)filter:(BOOL (^)(id))block {
    return [self transformedArrayWithBlock:^id(id obj) {
        if (block(obj)) {
            return obj;
        }
        return nil;
    }];
}

@end
