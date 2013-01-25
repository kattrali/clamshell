//
//  DMMWindowController.m
//  ClamShell
//
//  Created by Delisa Mason on 1/24/13.
//  Copyright (c) 2013 Delisa Mason. All rights reserved.
//

#import "DMMWindowController.h"
#import "DMMTokenStore.h"
#import "DMMAppDelegate.h"

@implementation DMMWindowController

- (void) awakeFromNib
{
  self.searchResults = @[];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewSelectionDidChange:) name:nil object:self.tableView];
}

- (void) searchFor:(NSString *) searchText loadFirst:(BOOL) loadIt
{
  if ([DMMTokenStore hasDataStoreFile]) {
    self.searchResults = [DMMTokenStore tokensWithText:searchText];
    if (loadIt && self.searchResults.count > 0) {
      [self loadURLForIndex:0];
    }
  } else {
    NSAlert *alert = [NSAlert alertWithMessageText:@"No Documentation Set is currently loaded. Please install a set via the File menu." defaultButton:nil alternateButton:nil otherButton:nil informativeTextWithFormat:@""];
    [alert runModal];
  }
}

- (void) loadURLForIndex:(NSInteger) index
{
  if (self.searchResults.count > index) {
    DMMSearchResult *item = (DMMSearchResult *)self.searchResults[index];
    NSURL *root = [((DMMAppDelegate *)[[NSApplication sharedApplication] delegate]) docSetDirectory];
    NSString *itemPath = [NSString stringWithFormat:@"Contents/Resources/Documents/%@", item.path];
    NSURL *url = [NSURL URLWithString:itemPath relativeToURL:root];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [[self.webView mainFrame] loadRequest:request];
  }
}

-(void)controlTextDidChange:(NSNotification *)notification
{
  NSSearchField *field = (NSSearchField *)notification.object;
  NSString * searchText = [field stringValue];
  if ([searchText length] > 0) {
    [self searchFor:searchText loadFirst:NO];
  }
}

- (void) tableViewSelectionDidChange:(NSNotification *)notification
{
  [self loadURLForIndex:self.tableView.selectedRow];
}
@end
