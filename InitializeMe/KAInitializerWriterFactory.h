//
//  KAInitializerWriterFactory.h
//  InitializeMe
//
//  Created by Kenneth Parker Ackerson on 10/27/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Property.h"

@protocol KAInitializerWriter

- (NSString *)initializer;

@end

@interface KAInitializerWriterFactory : NSObject

+ (id <KAInitializerWriter>)initializerWriterForProperties:(NSArray <Property *> *)properties;

@end
