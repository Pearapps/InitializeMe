//
//  KASwiftBuilderWriter.m
//  InitializeMe
//
//  Created by Kenneth Parker Ackerson on 1/23/16.
//  Copyright © 2016 Kenneth Parker Ackerson. All rights reserved.
//

#import "KASwiftBuilderWriter.h"

@interface KASwiftBuilderWriter ()

@property (nonatomic, readonly) NSArray <Property *> *properties;

@end

@implementation KASwiftBuilderWriter

- (instancetype)initWithProperties:(NSArray <Property *> *)properties {
    self = [super init];
    if (self) {
        _properties = properties;
    }
    return self;
}

- (nonnull NSString *)builderClass {
    NSString *builderClass = @"final class Builder {\n";
    
    for (Property *property in self.properties) {
        builderClass = [builderClass stringByAppendingFormat:@"\tprivate (set) var %@: %@?\n", property.variable, property.type];
    }
    
    builderClass = [builderClass stringByAppendingString:@"\n"];
    
    for (Property *property in self.properties) {
        builderClass = [builderClass stringByAppendingFormat:@"\tfunc set%@(%@: %@) -> Self {", [property.variable capitalizedString], property.variable, property.type];
        builderClass = [builderClass stringByAppendingString:@"\n"];
        builderClass = [builderClass stringByAppendingFormat:@"\t\tself.%@ = %@", property.variable, property.variable];
        builderClass = [builderClass stringByAppendingFormat:@"\n\t\treturn self"];
        builderClass = [builderClass stringByAppendingString:@"\n"];
        builderClass = [builderClass stringByAppendingString:@"\t}"];
        builderClass = [builderClass stringByAppendingString:@"\n"];
        builderClass = [builderClass stringByAppendingString:@"\n"];
    }
    
    
    return [builderClass stringByAppendingString:@"}"];
}

@end
