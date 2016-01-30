//
//  Property.m
//  InitializeMe
//
//  Created by Kenneth Parker Ackerson on 10/27/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "Property.h"
#import "NSArray+Extensions.h"

@implementation Property

- (instancetype)initWithPropertyString:(NSString *)propertyString {
    self = [super init];
    
    _propertyString = [propertyString copy];
    
    [self parse];
    
    return self;
}

static inline BOOL isRangeValid(NSRange range) {
    return range.location != NSNotFound;
}

- (void)parse {
    if ([self.propertyString containsString:@"@property"]) {
        _propertyType = PropertyTypeObjectiveC;
    }
    else if ([self.propertyString containsString:@"let "] || [self.propertyString containsString:@"var "]) {
        _propertyType = PropertyTypeSwift;
    }
    
    if (_propertyType == PropertyTypeObjectiveC) {
        NSRange range = [self.propertyString rangeOfString:@"("];

        if (isRangeValid(range)) {

            NSString *substring = [self.propertyString substringFromIndex:range.location];
            NSRange endRange = [substring rangeOfString:@")"];

            if (isRangeValid(endRange)) {
                substring = [substring substringToIndex:endRange.location + 1];
                NSArray *array = [[[[substring stringByReplacingOccurrencesOfString:@")" withString:@""] stringByReplacingOccurrencesOfString:@"(" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] componentsSeparatedByString:@","];
                _qualifiers = array;
            }
        }
        
        BOOL hasQualifiers = self.qualifiers != nil;
        
        NSRange endOfQualifiers = ^NSRange {
            if (!hasQualifiers) {
                return [self.propertyString rangeOfString:@" "];
            }
            else {
                return [self.propertyString rangeOfString:@") "];
            }
        }();

        if (isRangeValid(endOfQualifiers)) {
            NSString *substringOfRange = [[[self.propertyString substringFromIndex:endOfQualifiers.location] stringByReplacingOccurrencesOfString:@") " withString:@""] stringByReplacingOccurrencesOfString:@";" withString:@""];
            
            if (!hasQualifiers) {
                substringOfRange = [substringOfRange substringFromIndex:1];
            }
            
            NSRange range = [substringOfRange rangeOfString:@"*" options:NSBackwardsSearch];
            NSRange rangeEndingOfAngleBracket = [substringOfRange rangeOfString:@">" options:NSBackwardsSearch];
                        
            if ([substringOfRange containsString:@"*"] && (!isRangeValid(rangeEndingOfAngleBracket) || range.location > rangeEndingOfAngleBracket.location)) {
                _hasPointer = YES;
            }
                
            if (_hasPointer) {
                _variable = [substringOfRange substringFromIndex:range.location + 1];
                _type = [substringOfRange substringToIndex:range.location];
            }
            else {
                NSArray *beforeAndAfter = [substringOfRange componentsSeparatedByString:@" "];
                _type = [beforeAndAfter firstObject];
                _variable = [beforeAndAfter lastObject];
                
                NSMutableString *string = [[NSMutableString alloc] init];
                for (NSInteger i = 1; i < beforeAndAfter.count - 1; i++) {
                    NSString *internal = beforeAndAfter[i];
                    [string appendString:internal];
                }
                
                if (beforeAndAfter.count > 2) {
                    _angleBracketString = string;
                }
            }
        }
        
        if ([self.qualifiers containsObject:@"nonnull"]) {
            _nullabilityType = NullabilityTypeNonnull;
        }
        else if ([self.qualifiers containsObject:@"nullable"]) {
            _nullabilityType = NullabilityTypeNullable;
        }
        else {
            _nullabilityType = NullabilityTypeNone;
        }
    }
    else if (_propertyType == PropertyTypeSwift) {
        
        BOOL knowsType = [self.propertyString containsString:@":"];
        
        if (knowsType) {
            NSString *type = [[self.propertyString substringFromIndex:[self.propertyString rangeOfString:@":"].location + 1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            NSString *name = [[[[[[self.propertyString substringToIndex:[self.propertyString rangeOfString:@":"].location] stringByReplacingOccurrencesOfString:@"lazy " withString:@""] stringByReplacingOccurrencesOfString:@"let " withString:@""] stringByReplacingOccurrencesOfString:@"var " withString:@""] stringByReplacingOccurrencesOfString:@"private " withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                        
            _variable = name;
            _type = type;
        }
        
    }
}

- (BOOL)isValid {
    return self.propertyType == PropertyTypeSwift || self.propertyType == PropertyTypeObjectiveC;
}

- (BOOL)isCopied {
    return [self.qualifiers containsObject:@"copy"];
}

@end
