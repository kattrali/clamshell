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

- (void) searchFor:(NSString *) searchText loadFirst:(BOOL)loadFirst
{
  if ([DMMTokenStore hasDataStoreFile]) {
    self.searchResults = [DMMTokenStore tokensWithText:searchText];
    if (loadFirst && self.searchResults.count > 0) {
      [self loadURLForIndex:0 intoView:self.webView];
    }
  } else {
    [self showDocSetMissingAlert];
  }
}

- (void) displayFirstResultFor: (NSString *) searchText atPoint:(CGPoint) origin
{
  if ([DMMTokenStore hasDataStoreFile]) {
    self.searchResults = [DMMTokenStore tokensWithText:searchText];
    [self.popoverContainerWindow setFrameOrigin:origin];
    [self.popoverContainerWindow setBackgroundColor:[NSColor clearColor]];
    if (![self.popoverContainerWindow isVisible]) {
      [self.popoverContainerWindow orderFrontRegardless];
    }
    NSView *anchorView = (NSView *) self.popoverContainerWindow.contentView;

    [self.popover showRelativeToRect:NSRectFromCGRect(CGRectMake(0, 0, 10, anchorView.frame.size.height)) ofView:anchorView preferredEdge:NSMaxYEdge];

    if (self.searchResults.count > 0) {
      [self loadURLForIndex:0 intoView:self.popover.webView];
    } else {
      [[self.popover.webView mainFrame] loadHTMLString:@"<big><em>No Results Found</em></big>" baseURL:nil];
    }
  } else {
    [self showDocSetMissingAlert];
  }
}

- (void) loadURLForIndex:(NSInteger) index intoView: (WebView *) view
{
  if (self.searchResults.count > index) {
    DMMSearchResult *item = (DMMSearchResult *)self.searchResults[index];
    NSURLRequest *req = [NSURLRequest requestWithURL:item.path];
    [[view mainFrame] loadRequest:req];
  }
}

#pragma mark Delegate Events

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
  if ([[notification name] isEqualToString:NSTableViewSelectionDidChangeNotification]) {
    [self loadURLForIndex:self.tableView.selectedRow intoView:self.webView];
  }
}

- (void)popoverDidClose:(NSNotification *)notification
{
  [self.popoverContainerWindow orderOut:self];
}

#pragma mark Error Handling

- (void) showDocSetMissingAlert
{
  NSAlert *alert = [NSAlert alertWithMessageText:@"No Documentation Set is currently loaded. Please install a set via the File menu." defaultButton:nil alternateButton:nil otherButton:nil informativeTextWithFormat:@""];
  [alert runModal];
}

@end
