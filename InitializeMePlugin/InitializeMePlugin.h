//
//  InitializeMePlugin.h
//  InitializeMePlugin
//
//  Created by Kenneth Parker Ackerson on 1/30/16.
//  Copyright © 2016 Kenneth Parker Ackerson. All rights reserved.
//

#import <AppKit/AppKit.h>

@class InitializeMePlugin;

static InitializeMePlugin *sharedPlugin;

@interface InitializeMePlugin : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end