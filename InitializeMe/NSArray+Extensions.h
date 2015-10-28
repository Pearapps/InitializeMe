//
//  NSArray+Extensions.h
//  InitializeMe
//
//  Created by Kenneth Parker Ackerson on 10/27/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extensions)

- (NSArray *)transformedArrayWithBlock:(id (^)(id))block;

- (NSArray *)filter:(BOOL (^)(id))block;

@end
