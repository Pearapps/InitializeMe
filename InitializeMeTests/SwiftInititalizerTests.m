//
//  SwiftInititalizerTests.m
//  InitializeMe
//
//  Created by Kenneth Parker Ackerson on 1/30/16.
//  Copyright © 2016 Kenneth Parker Ackerson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KAInitializerWriterFactory.h"
#import "PropertyParser.h"

@interface SwiftInititalizerTests : XCTestCase

@end

@implementation SwiftInititalizerTests

- (void)testNoParenthesis {
    NSString *expectedOutput = @"init(window: NSWindow, ello: NSWindow) {\n"
    "\tself.window = window\n"
    "\tself.ello = ello\n"
    "}";
    
    NSString *input = @"let window: NSWindow\nlet ello: NSWindow";
    
    id properties = [[[PropertyParser alloc] initWithString:input] properties];
    
    [properties makeObjectsPerformSelector:@selector(parse)];
    
    NSString *output = [[KAInitializerWriterFactory initializerWriterForProperties:properties] initializer];
    
    XCTAssert([output isEqualToString:expectedOutput]);
}

@end