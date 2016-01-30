//
//  NSObject_Extension.m
//  Phoenix
//
//  Created by Kenneth Parker Ackerson on 1/30/16.
//  Copyright © 2016 Kenneth Parker Ackerson. All rights reserved.
//


#import "NSObject_Extension.h"
#import "Phoenix.h"

@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin {
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[Phoenix alloc] initWithBundle:plugin];
        });
    }
}

@end
