//
//  KAWarning+Properties.h
//  InitializeMe
//
//  Created by Kenny Ackerson on 10/29/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Property.h"
#import "KAWarning.h"

@interface KAWarning (Properties)

+ (NSArray <KAWarning *> *)warningForProperty:(Property *)property;

@end
