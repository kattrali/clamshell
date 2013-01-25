//
//  DMMAppDelegate.m
//  Monacle
//
//  Created by Delisa Mason on 1/23/13.
//  Copyright (c) 2013 Delisa Mason. All rights reserved.
//

#import "DMMAppDelegate.h"
#import "DMMWindowController.h"
#import "DMMURLParser.h"

#define DOCSET_DIR @"DocSet"

@implementation DMMAppDelegate

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  self.mainController = [[DMMWindowController alloc] initWithWebview:self.webView outlineView:self.outlineView];
  self.searchField.delegate = self.mainController;
  [[NSAppleEventManager sharedAppleEventManager] setEventHandler:self
andSelector:@selector(handleGetURLEvent:withReplyEvent:) forEventClass:kInternetEventClass andEventID:kAEGetURL];
}

- (IBAction)openDocument:(id)sender
{
  NSOpenPanel* openDlg = [NSOpenPanel openPanel];

  [openDlg setCanChooseFiles:YES];
  [openDlg setAllowsMultipleSelection:NO];
  [openDlg setCanChooseDirectories:NO];
  
  if ([openDlg runModal] == NSOKButton)
  {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSURL *fileURL = [openDlg URL];
    NSURL *target  = [self docSetDirectory];

    NSError *error;
    if ([manager fileExistsAtPath:[fileURL path]]) {
      if([manager fileExistsAtPath:[target path]]) {
        [manager removeItemAtPath:[target path] error:nil];
      }

      [manager copyItemAtURL:fileURL toURL:target error:&error];
      if (error) {
        NSLog(@"Could not copy (%@): %@",[fileURL path], [error localizedDescription]);
      }
    }
  }
}

- (NSURL *) docSetDirectory
{
  return [[self applicationFilesDirectory] URLByAppendingPathComponent:DOCSET_DIR];
}

// Returns the directory the application uses to store the Core Data store file. This code uses a directory named "Monacle" in the user's Application Support directory.
- (NSURL *)applicationFilesDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *appSupportURL = [[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    return [appSupportURL URLByAppendingPathComponent:@"Monacle"];
}

- (void)handleGetURLEvent:(NSAppleEventDescriptor *)event withReplyEvent:(NSAppleEventDescriptor *)replyEvent
{
  NSString* urlPath = [[event paramDescriptorForKeyword:keyDirectObject] stringValue];
  DMMURLParser *parser = [[DMMURLParser alloc] initWithURLString:urlPath];
  NSString *searchText = [parser valueForVariable:@"searchText"];
  [self.mainController searchFor:searchText loadFirst:YES];
}

@end
