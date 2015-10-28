//
//  AppDelegate.m
//  InitializeMe
//
//  Created by Kenneth Parker Ackerson on 10/27/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "AppDelegate.h"
#import "KARootViewController.h"

@interface AppDelegate () <NSWindowDelegate>

@property (strong) NSWindow *window;

@property (nonatomic) KARootViewController *viewController;

@end

@implementation AppDelegate

- (void)applicationWillFinishLaunching:(NSNotification *)notification
{


}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.viewController = [[KARootViewController alloc] init];
    
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
