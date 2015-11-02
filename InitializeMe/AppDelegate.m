//
//  AppDelegate.m
//  InitializeMe
//
//  Created by Kenneth Parker Ackerson on 10/27/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "AppDelegate.h"
#import "KARootViewController.h"
#import "ApplicationCoordinator.h"

@interface AppDelegate () <NSWindowDelegate>

@property (strong) NSWindow *window;

@property (nonatomic) KARootViewController *viewController;
@property (nonatomic, readonly) ApplicationCoordinator *applicationCoordinator;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    _applicationCoordinator = [[ApplicationCoordinator alloc] init];
    
    self.viewController = [[KARootViewController alloc] initWithApplicationCoordinator:_applicationCoordinator];
    
    NSRect frame = NSMakeRect(400, 500, 800, 700);
    self.window  = [[NSWindow alloc] initWithContentRect:frame styleMask:NSTitledWindowMask backing:NSBackingStoreBuffered defer:NO];
    self.window.delegate = self;
    
    self.viewController.view.frame = frame;
    
    [self.window setContentViewController:self.viewController];
    self.viewController.view.autoresizesSubviews = YES;
    
    [self.window makeKeyAndOrderFront:nil];
    
    self.window.title = @"InitializeMe";
    
}

- (void)windowDidResize:(NSNotification *)notification {
    [self.viewController resize];
}

@end
