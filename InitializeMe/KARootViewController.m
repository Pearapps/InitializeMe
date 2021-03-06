//
//  KARootViewController.m
//  InitializeMe
//
//  Created by Kenneth Parker Ackerson on 10/27/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KARootViewController.h"
#import "KAInitializerWriterFactory.h"
#import "PropertyParser.h"
#import "KAPropertyWarningGenerator.h"
#import "ApplicationCoordinator.h"

@interface KARootViewController ()

@property (nonatomic) NSTextView *textField;
@property (nonatomic) NSTextView *displayView;
@property (nonatomic) NSButton *button;
@property (nonatomic) NSButton *pasteboardButton;
@property (nonatomic) NSVisualEffectView *vev;
@property (nonatomic) NSScrollView *scrollView;
@property (nonatomic, readonly) NSButton *warningButton;
@property (nonatomic, readonly) ApplicationCoordinator *applicationCoordinator;

@end

@implementation KARootViewController

- (instancetype)initWithApplicationCoordinator:(ApplicationCoordinator *)applicationCoordinator {
    self = [super init];
    
    if (self) {
        _applicationCoordinator = applicationCoordinator;
    }
    
    return self;
}

- (void)loadView {
    self.view = [[NSView alloc] init];
}

- (void)resize {
    self.view.bounds = CGRectMake(0, 0, self.view.window.frame.size.width, self.view.window.frame.size.height);
    self.vev.frame = self.view.bounds;
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat textWidth = width * 0.75;
    CGFloat textHeight = height * 0.2;
    
    self.scrollView.frame = NSMakeRect((width - (textWidth))/2, height - textHeight/2 - (width - (textWidth))/2, textWidth, textHeight);
    self.textField.frame = NSMakeRect((width - (textWidth))/2, height - textHeight/2 - (width - (textWidth))/2, textWidth, textHeight);
    [self.textField setMinSize:NSMakeSize(0.0, textHeight)];
    
    self.button.frame = NSMakeRect(CGRectGetWidth(self.scrollView.bounds), CGRectGetMinY(self.scrollView.frame) - CGRectGetHeight(self.scrollView.frame)/2, CGRectGetWidth(self.button.frame), CGRectGetHeight(self.button.frame));
    
    self.warningButton.frame = NSMakeRect((width - (textWidth))/2, CGRectGetMinY(self.scrollView.frame) - CGRectGetHeight(self.scrollView.frame)/2, CGRectGetWidth(self.warningButton.frame), CGRectGetHeight(self.warningButton.frame));

    textWidth = width * 0.95;

    self.displayView.frame = NSMakeRect((width - (textWidth))/2, CGRectGetMaxY(self.button.frame) - textHeight - CGRectGetHeight(self.button.frame) - 30, textWidth, textHeight);
    
    self.pasteboardButton.frame = NSMakeRect(CGRectGetWidth(self.displayView.bounds) - CGRectGetWidth(self.pasteboardButton.bounds), CGRectGetMinY(self.displayView.frame) - CGRectGetHeight(self.displayView.frame)/2 - 30, CGRectGetWidth(self.pasteboardButton.frame), CGRectGetHeight(self.pasteboardButton.frame));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.vev = [[NSVisualEffectView alloc] init];
    self.vev.blendingMode = NSVisualEffectBlendingModeBehindWindow;
    self.vev.material = NSVisualEffectMaterialUltraDark;
    self.vev.state = NSVisualEffectStateActive;
    [self.view addSubview:self.vev];
    
    self.scrollView = [[NSScrollView alloc] init];

    self.textField = [[NSTextView alloc] init];

    self.textField.backgroundColor = [NSColor colorWithWhite:0.5 alpha:0.2];
    self.textField.textColor = [NSColor whiteColor];
    self.textField.insertionPointColor = [NSColor whiteColor];
    self.textField.richText = NO;
    self.textField.allowsUndo = YES;

    [self.textField setMaxSize:NSMakeSize(FLT_MAX, FLT_MAX)];
    [self.textField setVerticallyResizable:YES];
    [self.textField setHorizontallyResizable:NO];
    [self.textField setAutoresizingMask:NSViewWidthSizable];
    [self.scrollView setDrawsBackground:NO];
    
    [self.scrollView setHasVerticalScroller:YES];
    [self.scrollView setHasHorizontalScroller:NO];
    
    [self.scrollView addSubview:self.textField];
    [self.scrollView setDocumentView:self.textField];

    [self.view addSubview:self.scrollView];
    
    NSButton *button = [[NSButton alloc] init];
    [button setTitle:@"Initialize!"];
    [button setTarget:self];
    [button setAction:@selector(buttonPressed)];
    button.bezelStyle = NSRoundedBezelStyle;
    [self.view addSubview:button];
    [button sizeToFit];
    self.button = button;
    
    button = [[NSButton alloc] init];
    [button setTitle:@"Copy"];
    [button setTarget:self];
    [button setAction:@selector(pasteboardButtonPressed)];
    button.bezelStyle = NSRoundedBezelStyle;
    [self.view addSubview:button];
    [button sizeToFit];
    button.hidden = YES;
    self.pasteboardButton = button;

    NSTextView *displayView = [[NSTextView alloc] init];
    [self.view addSubview:displayView];
    displayView.editable = NO;
    displayView.backgroundColor = [NSColor clearColor];
    displayView.textColor = [NSColor whiteColor];
    displayView.insertionPointColor = [NSColor whiteColor];
    self.displayView = displayView;
    
    button = [[NSButton alloc] init];
    [button setTarget:self];
    [button setAction:@selector(warnings)];
    button.bezelStyle = NSRoundedBezelStyle;
    [self.view addSubview:button];
    [button sizeToFit];
    button.hidden = YES;
    _warningButton = button;
}

- (void)warnings {
    [self.applicationCoordinator displayWarnings:[self propertyWarnings]];
}

- (void)pasteboardButtonPressed {
    [[NSPasteboard generalPasteboard] declareTypes:@[NSPasteboardTypeString] owner:nil];
    [[NSPasteboard generalPasteboard] setData:[self.displayView.string dataUsingEncoding:NSUTF8StringEncoding] forType:NSPasteboardTypeString];
}

- (NSArray <KAWarning *> *)propertyWarnings {
    NSArray <Property *> * properties = [[[PropertyParser alloc] initWithString:self.textField.string] properties];
    
    NSString *output = [[KAInitializerWriterFactory initializerWriterForProperties:properties] initializer];
    self.displayView.string = output;
    
    return [[[KAPropertyWarningGenerator alloc] initWithProperties:properties] warnings];
}

- (void)buttonPressed {
    NSArray <Property *> * properties = [[[PropertyParser alloc] initWithString:self.textField.string] properties];
    
    NSString *output = [[KAInitializerWriterFactory initializerWriterForProperties:properties] initializer];
    self.displayView.string = output;

    NSArray *warnings = [[[KAPropertyWarningGenerator alloc] initWithProperties:properties] warnings];
    self.warningButton.hidden = warnings.count == 0;
    
    [self.warningButton setTitle:[[NSString alloc] initWithFormat:@"%ld Warnings!", warnings.count]];
    [self.warningButton sizeToFit];
    
    self.pasteboardButton.hidden = NO;
    [self resize];
}

- (void)viewWillAppear {
    [super viewWillAppear];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self resize];
    });
}

- (void)viewDidLayout {
    [super viewDidLayout];
}

@end
