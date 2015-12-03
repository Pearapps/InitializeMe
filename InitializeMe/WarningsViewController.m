//
//  WarningsViewController.m
//  InitializeMe
//
//  Created by Kenny Ackerson on 10/30/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "WarningsViewController.h"
#import "KAWarning.h"

@interface WarningsViewController () <NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic) NSVisualEffectView *vev;

@property (nonatomic) NSTableView *tableView;

@property (nonatomic, nonnull, readonly) NSArray <KAWarning *> *warnings;

@end

@implementation WarningsViewController

- (nonnull instancetype)initWithWarnings:(nonnull NSArray <KAWarning *> *)warnings {
    NSParameterAssert(warnings);
    self = [super init];
    
    if (self) {
        _warnings = warnings;
    }
    
    return self;
}

- (void)loadView {
    self.view = [NSView new];
}

- (void)viewWillAppear {
    [super viewWillAppear];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.vev.frame = self.view.bounds;
        self.tableView.frame = self.view.bounds;
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.vev = [[NSVisualEffectView alloc] init];
    self.vev.blendingMode = NSVisualEffectBlendingModeBehindWindow;
    self.vev.material = NSVisualEffectMaterialUltraDark;
    self.vev.state = NSVisualEffectStateActive;
    [self.view addSubview:self.vev];

    self.tableView = [[NSTableView alloc] init];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.view addSubview:self.tableView];
    self.tableView.gridStyleMask = NSTableViewSolidHorizontalGridLineMask;
    [self.tableView addTableColumn:[[NSTableColumn alloc] initWithIdentifier:@"hi"]];
    self.tableView.backgroundColor = [NSColor clearColor];
    self.tableView.rowHeight = 40;
}

- (void)tableView:(NSTableView *)tableView willDisplayCell:(id)cell forTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row {
    [cell setTextColor:[NSColor whiteColor]];
    [cell setFont:[NSFont systemFontOfSize:15]];
}

- (nullable id)tableView:(NSTableView *)tableView objectValueForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row {
    return [self.warnings[row].reason stringByAppendingFormat:@" - %@", self.warnings[row].property.propertyString];
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.warnings.count;
}

- (void)viewDidLayout {
    [super viewDidLayout];
    self.vev.frame = self.view.bounds;
}

@end
