//
//  KAWarningTests.m
//  InitializeMe
//
//  Created by Kenny Ackerson on 10/30/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KAPropertyWarningGenerator.h"

@interface KAWarningTests : XCTestCase

@end

@implementation KAWarningTests

- (void)testWarningsAreGenerated {

    KAPropertyWarningGenerator *propertyWarningGenerator = [[KAPropertyWarningGenerator alloc] initWithProperties:@[
                                                                                                                    [[Property alloc] initWithPropertyString:@"@property id itme;"],
                                                                                                                    ]];
    
    XCTAssert([propertyWarningGenerator warnings].count > 0);
}

@end
