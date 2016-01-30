//
//  KAInitializerWriterFactory.m
//  InitializeMe
//
//  Created by Kenneth Parker Ackerson on 10/27/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAInitializerWriterFactory.h"
#import "KAObjectiveCInitializerWriter.h"
#import "KASwiftInitializerWriter.h"

@implementation KAInitializerWriterFactory

+ (id <KAInitializerWriter>)initializerWriterForProperties:(NSArray <Property *> *)properties {
    Property *property = [properties firstObject];
    
    if (property.propertyType == PropertyTypeObjectiveC) {
        return [[KAObjectiveCInitializerWriter alloc] initWithProperties:properties];
    }
    else if (property.propertyType == PropertyTypeSwift) {
        return [[KASwiftInitializerWriter alloc] initWithProperties:properties];
    }
    
    return nil;
}

@end
