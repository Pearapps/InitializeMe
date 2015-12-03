//
//  KAPropertyWarningGenerator.h
//  InitializeMe
//
//  Created by Kenny Ackerson on 10/29/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KAWarning.h"
#import "Property.h"

@interface KAPropertyWarningGenerator : NSObject

- (nonnull instancetype)initWithProperties:(nonnull NSArray <Property *> *)properties;

- (nonnull NSArray <KAWarning *> *)warnings;

@end
