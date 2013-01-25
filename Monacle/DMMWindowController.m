//
//  DMMWindowController.m
//  Monacle
//
//  Created by Delisa Mason on 1/24/13.
//  Copyright (c) 2013 Delisa Mason. All rights reserved.
//

#import "DMMWindowController.h"
#import "DMMTokenStore.h"
#import "DMMAppDelegate.h"

@interface DMMWindowController()

@property (nonatomic, strong) NSArray *searchResults;

@end

@implementation DMMWindowController

- (id) initWithWebview: (WebView *) webView outlineView: (NSOutlineView *) outlineView
{
  self = [super init];
  if (self) {
    self.searchResults = @[];
    
    self.webView = webView;
    self.outlineView = outlineView;
    self.outlineView.dataSource = self;
    self.outlineView.delegate   = self;
  }
  return self;
}

- (void) searchFor:(NSString *) searchText loadFirst:(BOOL) loadIt
{
  if ([DMMTokenStore hasDataStoreFile]) {
    @synchronized(self.outlineView) {
      [self.outlineView selectRowIndexes:nil byExtendingSelection:NO];
      self.searchResults = [DMMTokenStore tokensWithText:searchText];
      [self.outlineView reloadData];
      if (loadIt && self.searchResults.count > 0) {
        [self loadURLForIndex:0];
      }
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
  } else {
    self.searchResults = @[];
    @synchronized(self.outlineView) {
      [self.outlineView selectRowIndexes:nil byExtendingSelection:NO];
      [self.outlineView reloadData];
    }
  }
}

#pragma mark - Outline View Data Source
- (NSInteger) outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
  return item == nil ? self.searchResults.count : 0;
}

- (BOOL) outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
  return NO;
}

- (id) outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item
{
  return item == nil? self.searchResults[index] : nil;
}

- (id) outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item
{
  return [((DMMSearchResult *) item) displayText];
//  return @"₠ NSOutlineViewDelegate";
}

#pragma mark Outline View Delegate

- (CGFloat) outlineView:(NSOutlineView *)outlineView heightOfRowByItem:(id)item
{
  return 40.f;
}

- (void) outlineViewSelectionDidChange:(NSNotification *)notification
{
  [self loadURLForIndex:self.outlineView.selectedRow];
}

@end
