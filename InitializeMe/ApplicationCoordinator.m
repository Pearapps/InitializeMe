//
//  ApplicationCoordinator.m
//  InitializeMe
//
//  Created by Kenny Ackerson on 10/30/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "ApplicationCoordinator.h"
#import "WarningsViewController.h"

@interface ApplicationCoordinator () <NSWindowDelegate>

@property (nonatomic) NSWindow *window;

@end

@implementation ApplicationCoordinator

- (void)displayWarnings:(NSArray *)warnings {
    NSRect frame = NSMakeRect(300, 500, 500, 400);
    
    NSWindow *window = [[NSWindow alloc] initWithContentRect:frame styleMask:NSTitledWindowMask | NSClosableWindowMask backing:NSBackingStoreBuffered defer:NO];
    NSViewController *viewController = [[WarningsViewController alloc] initWithWarnings:warnings];
    
    viewController.view.frame = frame;
    
    [window setContentViewController:viewController];
    
    [window makeKeyAndOrderFront:nil];
    self.window = window;
    self.window.delegate = self;
    window.title = @"Warnings";
    window.releasedWhenClosed = NO;
}

- (void)windowWillClose:(NSNotification *)notification {
    if ([notification.object isEqual:self.window]) {
        self.window.delegate = nil;
        self.window = nil;
    }
}

@end
