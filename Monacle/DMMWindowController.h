//
//  DMMWindowController.h
//  Monacle
//
//  Created by Delisa Mason on 1/24/13.
//  Copyright (c) 2013 Delisa Mason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMMWindowController : NSObject <NSOutlineViewDataSource, NSOutlineViewDelegate, NSTextFieldDelegate>

@property (nonatomic, weak) WebView *webView;
@property (nonatomic, weak) NSOutlineView *outlineView;

- (id) initWithWebview: (WebView *) webView outlineView: (NSOutlineView *) outlineView;
- (void) searchFor:(NSString *) searchText loadFirst: (BOOL) loadIt;
@end
