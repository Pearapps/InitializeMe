//
//  WarningsViewController.m
//  InitializeMe
//
//  Created by Kenny Ackerson on 10/30/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "WarningsViewController.h"

@interface WarningsViewController () <NSTableViewDataSource>

@property (nonatomic) NSVisualEffectView *vev;

@property (nonatomic) NSTableView *tableView;

@end

@implementation WarningsViewController

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
    [self.view addSubview:self.tableView];
    
}

- (nullable id)tableView:(NSTableView *)tableView objectValueForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row {
    return @"hi";
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return 10;
}


- (void)viewDidLayout {
    [super viewDidLayout];
    self.vev.frame = self.view.bounds;
}

- (void)dealloc {
    
}

@end
