//
//  PropertyParser.h
//  InitializeMe
//
//  Created by Kenneth Parker Ackerson on 10/27/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Property.h"

@interface PropertyParser : NSObject

- (instancetype)initWithString:(NSString *)string;

- (NSArray <Property *> *)properties;

@end
