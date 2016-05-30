//
//  Phoenix.m
//  Phoenix
//
//  Created by Kenneth Parker Ackerson on 1/30/16.
//  Copyright © 2016 Kenneth Parker Ackerson. All rights reserved.
//

#import "Phoenix.h"
#import "Property.h"
#import "PropertyParser.h"
#import "KAInitializerWriterFactory.h"
#import "KATimeEstimator.h"

@interface Phoenix()

@property (nonatomic) NSBundle *bundle;
@property (nonatomic) NSString *currentlySelectedText;

@end

@implementation Phoenix

+ (instancetype)sharedPlugin {
    return sharedPlugin;
}

- (instancetype)initWithBundle:(NSBundle *)plugin {
    self = [super init];
    if (self) {
        
        self.bundle = plugin;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSelection:)
                                                     name:@"DVTSourceExpressionSelectedExpressionDidChangeNotification"
                                                   object:nil];
        
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
        
        NSMenuItem *secondsActionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Phoenix stats" action:@selector(seconds) keyEquivalent:@""];
        
        [secondsActionMenuItem setTarget:self];
        [[menuItem submenu] addItem:secondsActionMenuItem];
    }
}

- (void)seconds {
    NSAlert *alert = [[NSAlert alloc] init];
    
    const NSInteger seconds = [[NSUserDefaults standardUserDefaults] integerForKey:@"seconds_saved"];
    
    NSString *displayString = [NSString stringWithFormat:@"Time saved: %ld seconds", seconds];
    
    // This is super shitty code /shrug
    
    if (seconds > 60) {
        displayString = [NSString stringWithFormat:@"Time saved: %0.2f minutes", seconds / 60.0];
    }
    
    if (seconds > 60 * 60) {
        displayString = [NSString stringWithFormat:@"Time saved: %0.2f hours", (seconds / 60.0) / 60];
    }
    
    if (seconds > 60 * 60 * 24) {
        displayString = [NSString stringWithFormat:@"Time saved: %0.2f day", ((seconds / 60.0) / 60) / 24];
    }
    
    [alert setMessageText:displayString];
    [alert runModal];
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
    
    KATimeEstimator *timeEstimator = [[KATimeEstimator alloc] initWithNumberOfProperties:properties.count];
    
    const NSInteger currentSeconds = [[NSUserDefaults standardUserDefaults] integerForKey:@"seconds_saved"];
    
    const NSInteger seconds = [timeEstimator estimatedSecondsSaved];
    
    [[NSUserDefaults standardUserDefaults] setInteger:currentSeconds + seconds forKey:@"seconds_saved"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
