//
//  InitializeMePlugin.m
//  InitializeMePlugin
//
//  Created by Kenneth Parker Ackerson on 1/30/16.
//  Copyright © 2016 Kenneth Parker Ackerson. All rights reserved.
//

#import "InitializeMePlugin.h"
#import "Property.h"
#import "PropertyParser.h"
#import "KAInitializerWriterFactory.h"

@interface InitializeMePlugin()

@property (nonatomic, strong, readwrite) NSBundle *bundle;

@property (nonatomic) NSString *currentlySelectedText;

@end

@implementation InitializeMePlugin

+ (instancetype)sharedPlugin {
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin {
    if (self = [super init]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSelection:) name:@"DVTSourceExpressionSelectedExpressionDidChangeNotification" object:nil];
        
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didApplicationFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
        
    }
    return self;
}

- (void)handleSelection:(NSNotification *)notification {
    @try {
        NSTextView *textView = [notification.object textView];
        self.currentlySelectedText = [[textView string] substringWithRange:[textView selectedRange]];
    }
    @catch (NSException *exception) {
        
    }
}

- (void)didApplicationFinishLaunchingNotification:(NSNotification*)noti {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    
    // Create menu items, initialize UI, etc.
    // Sample Menu Item:
    NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
    if (menuItem) {
        [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
        NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Make Initializer And Copy" action:@selector(doMenuAction) keyEquivalent:@""];

        [actionMenuItem setKeyEquivalentModifierMask: NSShiftKeyMask | NSCommandKeyMask];
        [actionMenuItem setKeyEquivalent:@"x"];
        
        [actionMenuItem setTarget:self];
        [[menuItem submenu] addItem:actionMenuItem];
    }
}

- (void)doMenuAction {
    const PropertyParser *parser = [[PropertyParser alloc] initWithString:self.currentlySelectedText];
    NSArray <Property *> *properties = [parser properties];
    
    
    
    const id <KAInitializerWriter> writer = [KAInitializerWriterFactory initializerWriterForProperties:properties];
    
    NSString *initializer = [writer initializer];
    
    
    
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    [pasteboard clearContents];
    [pasteboard writeObjects:@[initializer]];
    
    

}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
