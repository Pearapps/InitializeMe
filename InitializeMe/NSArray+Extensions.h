//
//  NSArray+Extensions.h
//  InitializeMe
//
//  Created by Kenneth Parker Ackerson on 10/27/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray<ObjectType> (Extensions)

- (NSArray *)transformedArrayWithBlock:(id (^)(ObjectType))block;

- (NSArray *)filter:(BOOL (^)(ObjectType))block;

+ (NSArray <ObjectType> *)flattenArray:(NSArray<NSArray<ObjectType> *> *)array;

@end
