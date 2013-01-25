//
//  DMMWindowController.h
//  ClamShell
//
//  Created by Delisa Mason on 1/24/13.
//  Copyright (c) 2013 Delisa Mason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMMWindowController : NSWindowController <NSTableViewDelegate, NSTableViewDataSource, NSTextFieldDelegate>

@property (nonatomic, weak) IBOutlet WebView *webView;
@property (nonatomic, weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSArrayController *arrayController;
@property (nonatomic, strong) NSArray *searchResults;
- (void) searchFor:(NSString *) searchText loadFirst: (BOOL) loadIt;
@end
