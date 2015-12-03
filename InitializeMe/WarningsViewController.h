//
//  WarningsViewController.h
//  InitializeMe
//
//  Created by Kenny Ackerson on 10/30/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class KAWarning;
@interface WarningsViewController : NSViewController

- (nonnull instancetype)initWithWarnings:(nonnull NSArray <KAWarning *> *)warnings;

@end
