//
//  KASwiftBuilderWriter.h
//  InitializeMe
//
//  Created by Kenneth Parker Ackerson on 1/23/16.
//  Copyright © 2016 Kenneth Parker Ackerson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KABuilderWriter.h"
#import "Property.h"

@interface KASwiftBuilderWriter : NSObject <KABuilderWriter>

- (instancetype)initWithProperties:(NSArray <Property *> *)properties;

@end
