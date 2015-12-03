//
//  KARootViewController.h
//  InitializeMe
//
//  Created by Kenneth Parker Ackerson on 10/27/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class ApplicationCoordinator;

@interface KARootViewController : NSViewController

- (instancetype)initWithApplicationCoordinator:(ApplicationCoordinator *)applicationCoordinator;

- (void)resize;

@end
