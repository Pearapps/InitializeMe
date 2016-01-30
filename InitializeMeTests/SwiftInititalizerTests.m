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

- (void)testOneProperty {
    NSString *expectedOutput = @"init(window: NSWindow) {\n"
    "\tself.window = window\n"
    "}";
    
    NSString *input = @"let window: NSWindow";
    
    id properties = [[[PropertyParser alloc] initWithString:input] properties];
    
    [properties makeObjectsPerformSelector:@selector(parse)];
    
    NSString *output = [[KAInitializerWriterFactory initializerWriterForProperties:properties] initializer];
    
    XCTAssert([output isEqualToString:expectedOutput]);
}

- (void)testOneFunctionProperty {
    NSString *expectedOutput = @"init(function: () -> ()) {\n"
    "\tself.function = function\n"
    "}";
    
    NSString *input = @"let function: () -> ()";
    
    id properties = [[[PropertyParser alloc] initWithString:input] properties];
    
    [properties makeObjectsPerformSelector:@selector(parse)];
    
    NSString *output = [[KAInitializerWriterFactory initializerWriterForProperties:properties] initializer];
    
    XCTAssert([output isEqualToString:expectedOutput]);
}

- (void)testTwoFunctionProperty {
    NSString *expectedOutput = @"init(function: () -> (), otherFunction: String -> Array<Int>) {\n"
    "\tself.function = function\n"
    "\tself.otherFunction = otherFunction\n"
    "}";
    
    NSString *input = @"let function: () -> ()\nlet otherFunction: String -> Array<Int>";
    
    id properties = [[[PropertyParser alloc] initWithString:input] properties];
    
    [properties makeObjectsPerformSelector:@selector(parse)];
    
    NSString *output = [[KAInitializerWriterFactory initializerWriterForProperties:properties] initializer];
    
    XCTAssert([output isEqualToString:expectedOutput]);
}

- (void)testOnePropertyGenericProperty {
    NSString *expectedOutput = @"init(array: Array<String>) {\n"
    "\tself.array = array\n"
    "}";
    
    NSString *input = @"let array: Array<String>";
    
    id properties = [[[PropertyParser alloc] initWithString:input] properties];
    
    [properties makeObjectsPerformSelector:@selector(parse)];
    
    NSString *output = [[KAInitializerWriterFactory initializerWriterForProperties:properties] initializer];
    
    XCTAssert([output isEqualToString:expectedOutput]);
}

- (void)testSpecialDictionarySyntaxOneProperty {
    NSString *expectedOutput = @"init(array: [String]) {\n"
    "\tself.array = array\n"
    "}";
    
    NSString *input = @"let array: [String]";
    
    id properties = [[[PropertyParser alloc] initWithString:input] properties];
    
    [properties makeObjectsPerformSelector:@selector(parse)];
    
    NSString *output = [[KAInitializerWriterFactory initializerWriterForProperties:properties] initializer];
    
    XCTAssert([output isEqualToString:expectedOutput]);
}

- (void)testTwoProperties {
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

- (void)testTwoPropertiesOneOptional {
    NSString *expectedOutput = @"init(window: NSWindow?, ello: NSWindow) {\n"
    "\tself.window = window\n"
    "\tself.ello = ello\n"
    "}";
    
    NSString *input = @"let window: NSWindow?\nlet ello: NSWindow";
    
    id properties = [[[PropertyParser alloc] initWithString:input] properties];
    
    [properties makeObjectsPerformSelector:@selector(parse)];
    
    NSString *output = [[KAInitializerWriterFactory initializerWriterForProperties:properties] initializer];
    
    XCTAssert([output isEqualToString:expectedOutput]);
}

@end