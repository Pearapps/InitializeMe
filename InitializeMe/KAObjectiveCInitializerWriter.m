//
//  KAObjectiveCInitializerWriter.m
//  InitializeMe
//
//  Created by Kenneth Parker Ackerson on 10/27/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAObjectiveCInitializerWriter.h"

@interface KAObjectiveCInitializerWriter ()

@property (nonatomic, readonly) NSArray <Property *> *properties;

@end

@implementation KAObjectiveCInitializerWriter

- (instancetype)initWithProperties:(NSArray <Property *> *)properties {
    self = [super init];
    if (self) {
        _properties = properties;
    }
    return self;
}


- (BOOL)deduceIfUsingNullabilityQualifiers:(NSArray <Property *> *)properties {
    for (Property *property in properties) {
        if (property.nullabilityType != NullabilityTypeNone) {
            return YES;
        }
    }
    
    return NO;
}

- (NSString *)upcaseString:(NSString *)string {
    if (string.length > 0) {
        NSString *substring = [string substringFromIndex:1];
        NSString *first = [string substringToIndex:1];
        return [[first uppercaseString] stringByAppendingString:substring];
    }
    
    return string;
}

- (NSString *)initializer {
    NSMutableString *initializerString = [NSMutableString stringWithString:@""];

    if (![self deduceIfUsingNullabilityQualifiers:self.properties]) {
        [initializerString appendString:@"- (instancetype)init"];
    }
    else {
        [initializerString appendString:@"- (nonnull instancetype)init"];
    }
    
    if (self.properties.count > 0) {
        [initializerString appendString:@"With"];
    }
    
    [self.properties enumerateObjectsUsingBlock:^(Property * _Nonnull property, NSUInteger idx, BOOL * _Nonnull stop) {
        if (property.propertyType != PropertyTypeObjectiveC && property.propertyType != PropertyTypeSwift) {
            return ;
        }
        
        if (idx > 0) {
            [initializerString appendString:property.variable];
        }
        else {
            [initializerString appendString:[self upcaseString:property.variable]];
        }
        [initializerString appendString:@":"];
        [initializerString appendString:@"("];
        
        if ((property.nullabilityType != NullabilityTypeNone)) {
            [initializerString appendFormat:(property.nullabilityType == NullabilityTypeNonnull) ? @"nonnull " : @"nullable "];
        }
        
        [initializerString appendString:property.type];
        
        if (property.angleBracketString) {
            [initializerString appendString:@" "];
            [initializerString appendString:property.angleBracketString];
        }
        
        if (property.hasPointer) {
            [initializerString appendString:@"*"];
        }
        
        [initializerString appendString:@")"];
        [initializerString appendString:property.variable];
        
        [initializerString appendString:@" "];
    }];
    
    [initializerString appendString:@"{\n"];
    for (Property *property in self.properties) {
        if (property.nullabilityType == NullabilityTypeNonnull) {
            [initializerString appendFormat:@"\tNSParameterAssert(%@);\n", property.variable];
        }
    }
    
    [initializerString appendString:@"\tself = [super init];\n"];
    [initializerString appendString:@"\n"];

    [initializerString appendString:@"\tif (self) {\n"];
    

    for (Property *property in self.properties) {
        if ([property isCopied]) {
            [initializerString appendFormat:@"\t\t_%@ = [%@ copy];\n", property.variable, property.variable];
        }
        else {
            [initializerString appendFormat:@"\t\t_%@ = %@;\n", property.variable, property.variable];
        }
    }
    
    [initializerString appendString:@"\t}\n"];
    [initializerString appendString:@"\n"];

    [initializerString appendString:@"\treturn self;\n"];
    [initializerString appendString:@"}"];
    
    return [initializerString copy];
}

@end
