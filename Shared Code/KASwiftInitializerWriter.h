//
//  KASwiftInitializerWriter.h
//  InitializeMe
//
//  Created by Kenneth Parker Ackerson on 1/23/16.
//  Copyright © 2016 Kenneth Parker Ackerson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Property.h"
#import "KAInitializerWriterFactory.h"

@interface KASwiftInitializerWriter : NSObject <KAInitializerWriter>

- (instancetype)initWithProperties:(NSArray <Property *> *)properties;

@end
