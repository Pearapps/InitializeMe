//
//  KASwiftInitializerWriter.m
//  InitializeMe
//
//  Created by Kenneth Parker Ackerson on 1/23/16.
//  Copyright © 2016 Kenneth Parker Ackerson. All rights reserved.
//

#import "KASwiftInitializerWriter.h"

@interface KASwiftInitializerWriter ()

@property (nonatomic, readonly) NSArray <Property *> *properties;

@end

@implementation KASwiftInitializerWriter

- (instancetype)initWithProperties:(NSArray <Property *> *)properties {
    self = [super init];
    if (self) {
        _properties = properties;
    }
    return self;
}

- (NSString *)initializer {
    NSString *inititalizer = @"init(";
    
    NSInteger i = 0;
    for (Property *property in self.properties) {
        inititalizer = [inititalizer stringByAppendingFormat:@"%@: %@", property.variable, property.type];
        
        if (i != self.properties.count -1) {
            inititalizer = [inititalizer stringByAppendingString:@", "];

        }
        
        i++;
    }
        
    inititalizer = [inititalizer stringByAppendingString:@") {\n"];

    for (Property *property in self.properties) {
        inititalizer = [inititalizer stringByAppendingFormat:@"\tself.%@ = %@\n", property.variable, property.variable];
    }
    
    return [inititalizer stringByAppendingString:@"}"];
}

@end
