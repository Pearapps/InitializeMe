//
//  ApplicationCoordinator.m
//  InitializeMe
//
//  Created by Kenny Ackerson on 10/30/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "ApplicationCoordinator.h"
#import "WarningsViewController.h"

@interface ApplicationCoordinator ()

@property (nonatomic) NSWindow *window;

@end

@implementation ApplicationCoordinator

- (void)displayWarnings {
    NSRect frame = NSMakeRect(300, 500, 500, 400);
    
    NSWindow *window = [[NSWindow alloc] initWithContentRect:frame styleMask:NSTitledWindowMask backing:NSBackingStoreBuffered defer:NO];
    NSViewController *viewController = [[WarningsViewController alloc] init];
    
    viewController.view.frame = frame;
    
    [window setContentViewController:viewController];
    
    [window makeKeyAndOrderFront:nil];
    self.window = window;
}

@end
