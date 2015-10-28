//
//  InitializeMeTests.m
//  InitializeMeTests
//
//  Created by Kenneth Parker Ackerson on 10/27/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KAInitializerWriterFactory.h"
#import "PropertyParser.h"

@interface InitializeMeTests : XCTestCase

@end

@implementation InitializeMeTests

- (void)testBasicOneNullabilityAndOneNot {
    
    NSString *expectedOutput = @"- (nonnull instancetype)initWithWindow:(nonnull NSWindow *)window ello:(NSWindow *)ello {\n"
    "\tself = [super init];\n"
    "\tNSParameterAssert(window);\n"
    "\n"
    "\t_window = window;\n"
    "\t_ello = [ello copy];\n"
    "\n"
    "\treturn self;\n"
    "}";
    
    NSString *input = @"@property (nonatomic, weak, nonnull) NSWindow *window;\n@property (weak, copy) NSWindow *ello;";
    
    id properties = [[[PropertyParser alloc] initWithString:input] properties];
    
    
    [properties makeObjectsPerformSelector:@selector(parse)];
    

    NSString *output = [[KAInitializerWriterFactory initializerWriterForProperties:properties] initializer];
    
    XCTAssert([output isEqualToString:expectedOutput]);
}

- (void)testProtocols {
    NSString *expectedOutput = @"- (nonnull instancetype)initWithChain:(id <Chain>)chain {\n"
    "\tself = [super init];\n"
    "\tNSParameterAssert(chain);\n"
    "\n"
    "\t_chain = chain;\n"
    "\n"
    "\treturn self;\n"
    "}";
    
    NSString *input = @"@property (nonatomic, weak, nonnull) id <Chain> chain;";
    
    id properties = [[[PropertyParser alloc] initWithString:input] properties];
    
    [properties makeObjectsPerformSelector:@selector(parse)];
    
    NSString *output = [[KAInitializerWriterFactory initializerWriterForProperties:properties] initializer];
    
    XCTAssert([output isEqualToString:expectedOutput]);
}

- (void)testingGenerics {
    NSString *expectedOutput = @"- (nonnull instancetype)initWithWindow:(nonnull NSArray <NSArray <NSString *>*> *)window {\n"
    "\tself = [super init];\n"
    "\tNSParameterAssert(window);\n"
    "\n"
    "\t_window = window;\n"
    "\n"
    "\treturn self;\n"
    "}";
    
    NSString *input = @"@property (nonatomic, nonnull) NSArray <NSArray <NSString *>*> *window;";
    
    id properties = [[[PropertyParser alloc] initWithString:input] properties];
    
    [properties makeObjectsPerformSelector:@selector(parse)];
    
    NSString *output = [[KAInitializerWriterFactory initializerWriterForProperties:properties] initializer];
    
    XCTAssert([output isEqualToString:expectedOutput]);
}

@end
