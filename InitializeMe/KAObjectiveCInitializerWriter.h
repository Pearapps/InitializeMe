//
//  KAObjectiveCInitializerWriter.h
//  InitializeMe
//
//  Created by Kenneth Parker Ackerson on 10/27/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Property.h"
#import "KAInitializerWriterFactory.h"

@interface KAObjectiveCInitializerWriter : NSObject <KAInitializerWriter>

- (instancetype)initWithProperties:(NSArray <Property *> *)properties;

@end
