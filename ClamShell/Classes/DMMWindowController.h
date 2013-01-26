//
//  DMMWindowController.h
//  ClamShell
//
//  Created by Delisa Mason on 1/24/13.
//  Copyright (c) 2013 Delisa Mason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMMPopover.h"
@interface DMMWindowController : NSWindowController <NSTableViewDelegate, NSTableViewDataSource, NSTextFieldDelegate, NSPopoverDelegate>

@property (nonatomic, weak) IBOutlet WebView *webView;
@property (nonatomic, weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSArrayController *arrayController;
@property (nonatomic, strong) NSArray *searchResults;
@property (weak) IBOutlet DMMPopover *popover;
@property (unsafe_unretained) IBOutlet NSPanel *popoverContainerWindow;

- (void) searchFor:(NSString *) searchText loadFirst: (BOOL) loadFirst;
- (void) displayFirstResultFor: (NSString *) searchText atPoint:(CGPoint) origin;
@end
