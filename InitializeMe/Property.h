//
//  Property.h
//  InitializeMe
//
//  Created by Kenneth Parker Ackerson on 10/27/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PropertyType){
    PropertyTypeSwift = 1,
    PropertyTypeObjectiveC = 2,
};

typedef NS_ENUM(NSUInteger, NullabilityType) {
    NullabilityTypeNone = 1,
    NullabilityTypeNullable = 2,
    NullabilityTypeNonnull = 3
};

@interface Property : NSObject

@property (nonatomic, readonly) NSString *variableName;

- (instancetype)initWithPropertyString:(NSString *)propertyString;

@property (nonatomic, readonly) PropertyType propertyType;

@property (nonatomic, readonly) NSArray <NSString *> *qualifiers;
@property (nonatomic, readonly) NSString *type;

@property (nonatomic, readonly) NSString *variable;
@property (nonatomic, readonly) BOOL hasPointer;

@property (nonatomic, readonly) NullabilityType nullabilityType;

@property (nonatomic, readonly) NSString *angleBracketString;

- (BOOL)isCopied;

- (BOOL)isValid;

@end
