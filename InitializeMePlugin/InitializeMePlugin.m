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

@property (nonatomic) NSBundle *bundle;
@property (nonatomic) NSString *currentlySelectedText;

@end

@implementation InitializeMePlugin

+ (instancetype)sharedPlugin {
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin {
    self = [super init];
    if (self) {
        
        self.bundle = plugin;

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSelection:) name:@"DVTSourceExpressionSelectedExpressionDidChangeNotification" object:nil];
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
        NSLog(@"InitializeMe - %@", exception);
    }
}

- (void)didApplicationFinishLaunchingNotification:(NSNotification *)noti {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    
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
    
    if (properties.count == 0) {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"You did not select any properties!"];
        [alert runModal];
        return;
    }
    
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
